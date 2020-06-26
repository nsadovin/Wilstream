using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Dynamic;
using System.IO;
using System.Net;
using System.Text;


/// <summary>
/// Сводное описание для Bitrix
/// </summary>
public class Bitrix24
{
    private bool IsTest = false;
    //Объявляем константы
    private string BX_ClientID = "local.5b854e83349ce8.82011363"; //Код приложения (client_id)
    private string BX_ClientSecret = "2ANBz4npC7YQ37DQ5TDnH9LU3RtzbEkQxC5u0VhS0dkq6Ur5G6"; //Ключ приложения (client_secret)
    private string BX_Portal = "https://medoradv.bitrix24.ru"; //Адрес портала\сайта в Битрикс24
    private string BX_OAuthSite = "https://oauth.bitrix.info"; //Этот адрес не изменяйте

    private string username = "call@ramedor.ru";
    private string password = "ra50me102dor";//ra50me102dor

    //Объявляем приватные служебные поля
    private string AccessToken;
    private string RefreshToken;
    private DateTime RefreshTime;
    private string Code;
    private string Cookie;
    private HttpContext httpContext;

    public Bitrix24(HttpContext _httpContext)
    {
        httpContext = _httpContext;
        if (IsTest) {
            BX_ClientID = "local.5b89b01721f813.77927726"; //Код приложения (client_id)
            BX_ClientSecret = "WoM3xrFZg4zkKXIarfw13XqPyqP118VGpy8EOSKCDvmHCiw5VK"; //Ключ приложения (client_secret)
            BX_Portal = "https://b24-k7jxw3.bitrix24.ru"; //Адрес портала\сайта в Битрикс24
            BX_OAuthSite = "https://oauth.bitrix.info"; //Этот адрес не изменяйте

            //Укажите Ваши логин и пароль пользователя (админа) вашего портала в Битрикс24, под которым будут выполнять REST запросы к Битрикс24.
            username = "vesdehodster@gmail.com";
            password = "azsxdcfv890";

        }
         
        Connect();
    }

    public Bitrix24(HttpContext _httpContext, string ClientID, string ClientSecret, string Portal, string OAuthSite, string UserName, string Password)
    {
        httpContext = _httpContext;
        BX_ClientID = ClientID;
        BX_ClientSecret = ClientSecret;
        BX_Portal = Portal;
        BX_OAuthSite = OAuthSite;
        username = UserName;
        password = Password;

        Connect();
    }



    //Создаем закрытый метод для начального подключения к Битрикс24
    private void Connect()
    {
        //Создаем HTTP подключение, здесь ничего не меняем
        string BX_URI = BX_Portal + "/oauth/authorize/?client_id=" + BX_ClientID;
        HttpWebRequest requestLogonBitrix24 = (HttpWebRequest)WebRequest.Create(BX_URI);

 
        //Настраиваем подключение, ничего не меняем
        string svcCredentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(username + ":" + password));
        requestLogonBitrix24.Headers.Add("Authorization", "Basic " + svcCredentials);
        requestLogonBitrix24.AllowAutoRedirect = false; // Это обязательное условие, чтобы нас автоматически не переадресовывали на другую страницу
        requestLogonBitrix24.Method = "POST";

        //Подключаемся (отправляем запрос)
        HttpWebResponse responseLogonBitrix24 = (HttpWebResponse)requestLogonBitrix24.GetResponse();

        //Проверяем что статус-код доджен быть 302, нам должны предложить переадресацию, иначе авторизация не требуется, мы и так авторизированы
        if (responseLogonBitrix24.StatusCode == HttpStatusCode.Found)
        {
            //Ничего не меняем, здесь получаем из заголовков ответа Куки и параметры адреса переадресации (из поля "Location") парамер Code
            Uri locationURI = new Uri(responseLogonBitrix24.Headers["Location"]);
            // Ловко парсим URL-адрес с помощью HttpUtility, подключите "System.Web" через пакеты NuGet
            var locationParams = System.Web.HttpUtility.ParseQueryString(locationURI.Query);
            Cookie = responseLogonBitrix24.Headers["Set-Cookie"];
            Code = locationParams["Code"];

            //Вызываем исключение, если Код мы не смогли получить, без него далее ни как.
            if (String.IsNullOrEmpty(Code))
            {
                throw new FormatException("CodeNotFound");
            }

            //Закрываем подключение
            responseLogonBitrix24.Close();

            //Если код успешно получили, то формируем новый HTTP запрос для получения Токенов авторизации
            string BX_OAuth_URI = BX_OAuthSite + "/oauth/token" + "/?" + "grant_type=authorization_code" + "&" +
            "client_id=" + BX_ClientID + "&" +
            "client_secret=" + BX_ClientSecret + "&" +
            "code=" + Code;
            
            SetToken(BX_OAuth_URI);
        }

    }

    //Закрытый метод для получения и записи Токенов авторизации
    private void SetToken(string BX_OAuth_URI)
    {
         try
        {
        //Формируем новый HTTP запрос для получения Токенов авторизации
        HttpWebRequest requestLogonBitrixOAuth = (HttpWebRequest)WebRequest.Create(BX_OAuth_URI);
        requestLogonBitrixOAuth.Method = "GET";
     //   requestLogonBitrixOAuth.Accept = "application/json";
      //  requestLogonBitrixOAuth.ContentType = "application/json";
        requestLogonBitrixOAuth.Headers["Cookie"] = Cookie; //Используем Куки полученный в предыдущем запросе авторизации
         
        
        //Подключаемся (отправляем запрос)
        HttpWebResponse responseLogonBitrixOAuth = (HttpWebResponse)requestLogonBitrixOAuth.GetResponse();

      

        //Если в ответ получаем статус-код отличный от 200, то это ошибка, вызываем исключение
        if (responseLogonBitrixOAuth.StatusCode != HttpStatusCode.OK)
        {
            throw new FormatException("ErrorLogonBitrixOAuth");
        }
        else
        {
            //Читаем тело ответа
            Stream dataStreamLogonBitrixOAuth = responseLogonBitrixOAuth.GetResponseStream();
            var readerLogonBitrixOAuth = new StreamReader(dataStreamLogonBitrixOAuth);
            string stringLogonBitrixOAuth = readerLogonBitrixOAuth.ReadToEnd();

            //Обязательно закрываем подключения и потоки
            readerLogonBitrixOAuth.Close();
            responseLogonBitrixOAuth.Close();

            //Ловко преобразуем тело ответа в формате JSON в .Net объект с помощью Newtonsoft.Json, не забудьте подключить Newtonsoft.Json через NuGet
            var converter = new ExpandoObjectConverter();
            dynamic objLogonBitrixOAuth = JsonConvert.DeserializeObject<ExpandoObject>(stringLogonBitrixOAuth, converter);

            //Записывем Токены авторизации в поля нашего класса из динамического объекта
            AccessToken = objLogonBitrixOAuth.access_token;
            RefreshToken = objLogonBitrixOAuth.refresh_token;
            RefreshTime = DateTime.Now.AddSeconds(objLogonBitrixOAuth.expires_in); //Добавляем к текущей дате количество секунд действия токена, обычно это плюс один час

            //Закрываем поток
            dataStreamLogonBitrixOAuth.Close();
        }

             }
        catch (WebException ex)
        {
            httpContext.Response.Write(ex.Message);
            httpContext.Response.End();
        }

    }

    public string GetNameProduct(string _ID)
    {
        var dataProduct = new
        {

            filter = new
            {
               ID = _ID
            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        };


        var contentTextProduct = JsonConvert.SerializeObject(dataProduct);
        string ProductListByJSON = SendCommand("crm.product.list",  "", contentTextProduct, "POST");
        var ProductList = JsonConvert.DeserializeObject<dynamic>(ProductListByJSON);
        foreach (var product in ProductList.result)
            return product.NAME.ToString();

            return "";
    }

    //Закрытый метод для обновления Токенов авторизации, если истекло время их действия
    private void RefreshTokens()
    {
         

        if (RefreshTime == DateTime.MinValue) // Если RefreshTime пустая
        {
            //Тогда вызываем авторизацию по полной программе
            Connect();
            return; //Тогда дальше не идём
        }

        //Проверяем, если истекло время действия Токена авторизации, то обновляем его
        if (RefreshTime.AddSeconds(-5) < DateTime.Now)
        {
            //Формируем новый HTTP запрос для обновления Токена авторизации, здесь Code уже не нужен
            string BX_OAuth_URI = BX_OAuthSite + "/oauth/token" + "/?" + "grant_type=refresh_token" + "&" +
            "client_id=" + BX_ClientID + "&" +
            "client_secret=" + BX_ClientSecret + "&" +
            "refresh_token=" + RefreshToken;

            SetToken(BX_OAuth_URI);
        }
    }

    public List<PRODUCT> productSeacrh = new List<PRODUCT>(); 
    public List<PRODUCT> ProductSeacrh {
        get { return productSeacrh; }
        set {  productSeacrh = value; }
    } 

    public Dictionary<string, string> PhoneTypes
    {
        get {
            return new Dictionary<string, string>()
            {
                { "WORK","Рабочий" },
                { "HOME","Домашний" },
                { "MOBILE","Мобильный" },
                { "OTHER","Другой" } 
            };
        }
    }

    
    public Dictionary<string, string> EmailTypes
    {
        get {
            return new Dictionary<string, string>()
            {
                { "WORK","Рабочий" },
                { "HOME","Частный" },
                { "MAILING","Для рассылок" },
                { "OTHER","Другой" } 
            };
        }
    }


    public class PRODUCT
    {
        public string NAME;
        public Int32 ID;
        public string PRODUCT_QUANTITY;
        public string PRODUCT_PRICE;

    }


    public List<int> FilterUserFields = null;



    public List<Userfield> Userfields
    {
        get
        {
            if (BX_Portal == "https://medoradv.bitrix24.ru")
                return new List<Userfield>()
            {
                 new Userfield() {
                        ID = 182,
                       ENTITY_ID = "CRM_LEAD" ,
                       NAME = "Направление",
                       FIELD_NAME = "UF_CRM_1423931279",
                       USER_TYPE_ID = USER_TYPE_ID.enumeration,
                       LIST = new List<UF_LIST>(){
                            new UF_LIST(){ ID = 19, SORT = 1, VALUE = "Выставочное оборудование" },
                            new UF_LIST(){ ID = 25, SORT = 2, VALUE = "Дизайн, креатив, продакшн" },
                            new UF_LIST(){ ID = 29, SORT = 3, VALUE = "Комплексные рекламные услуги" },
                            new UF_LIST(){ ID = 21, SORT = 4, VALUE = "Полиграфия" },
                            new UF_LIST(){ ID = 15, SORT = 5, VALUE = "Производство наружной рекламы" },
                            new UF_LIST(){ ID = 27, SORT = 6, VALUE = "Промоодежда" },
                            new UF_LIST(){ ID = 13, SORT = 7, VALUE = "Размещение наружной рекламы" },
                            new UF_LIST(){ ID = 5, SORT = 8, VALUE = "Реклама в Интернете" },
                            new UF_LIST(){ ID = 3, SORT = 9, VALUE = "Реклама в СМИ" },
                            new UF_LIST(){ ID = 11, SORT = 10, VALUE = "Реклама на транспорте" },
                            new UF_LIST(){ ID = 23, SORT = 11, VALUE = "Сувенирная продукция" },
                            new UF_LIST(){ ID = 17, SORT = 12, VALUE = "Электронная рассылка" },
                            new UF_LIST(){ ID = 30, SORT = 13, VALUE = "Франшиза" },
                            new UF_LIST(){ ID = 1, SORT = 14, VALUE = "BTL" },
                            new UF_LIST(){ ID = 7, SORT = 15, VALUE = "Indoor-реклама (Жилые дома)" },
                            new UF_LIST(){ ID = 9, SORT = 16, VALUE = "Indoor-реклама (Коммерческие объекты)" },
                            new UF_LIST(){ ID = 506, SORT = 17, VALUE = "Широкоформатная и Интерьерная печать" },
                       }
                 },
                 new Userfield() {
                       ID = 181,
                       ENTITY_ID = "CRM_LEAD" ,
                       NAME = "Сайт-источник заявки",
                       FIELD_NAME = "UF_CRM_1444310247",
                       USER_TYPE_ID = USER_TYPE_ID.enumeration,
                       LIST = new List<UF_LIST>(){
                           new UF_LIST(){ ID = 128, SORT = 1, VALUE = "201.mosreklama.net и мелкие сайты" },
                           new UF_LIST(){ ID = 508, SORT = 2, VALUE = "205.караван рекламы" },
                           new UF_LIST(){ ID = 130, SORT = 3, VALUE = "202.standbuilding.ru" },
                           new UF_LIST(){ ID = 136, SORT = 4, VALUE = "206.roslifts.ru" },
                           new UF_LIST(){ ID = 140, SORT = 5, VALUE = "205.moslift.net" },
                           new UF_LIST(){ ID = 142, SORT = 6, VALUE = "207.mos-lift.ru" },
                           new UF_LIST(){ ID = 134, SORT = 7, VALUE = "203.mosidea.ru" },
                           new UF_LIST(){ ID = 144, SORT = 8, VALUE = "- Заявка не с сайта - " },
                           new UF_LIST(){ ID = 622, SORT = 9, VALUE = "заявки сайт airmg.net" }
                       }
                 }
            };
            else
            {
                var dataListUsers = new
                {

                    sort = "ID"
                };

                var Userfields = new List<Bitrix24.Userfield>();

                var userfieldsJson = SendCommand("crm.lead.userfield.list", "", "", "GET");
                var userfields = JsonConvert.DeserializeObject<dynamic>(userfieldsJson).result;



                foreach (dynamic _userfield in userfields)
                {
                    if (FilterUserFields!=null)
                    {
                        if (!FilterUserFields.Contains(Convert.ToInt32(_userfield.ID))) continue;
                    }
                    var userfieldJson = SendCommand("crm.lead.userfield.get", "ID="+ _userfield.ID, "", "GET");
                    var userfield = JsonConvert.DeserializeObject<dynamic>(userfieldJson).result;
                    Userfields.Add(new Bitrix24.Userfield()
                    {
                        ID = userfield.ID,
                        ENTITY_ID = userfield.ENTITY_ID,
                        NAME = userfield.EDIT_FORM_LABEL.ru,
                        FIELD_NAME = userfield.FIELD_NAME,
                        USER_TYPE_ID = userfield.USER_TYPE_ID ,
                        MULTIPLE = userfield.MULTIPLE,
                        LIST = new List<Bitrix24.UF_LIST>()
                    });
                    if(userfield.LIST!=null)
                    foreach (var keyvalue in userfield.LIST)
                    {
                        var listic = keyvalue.ToString();
                        var li = JsonConvert.DeserializeObject<Bitrix24.UF_LIST>(listic);
                        Userfields[Userfields.Count-1].LIST.Add(li);
                    };
                }

                return Userfields;

                //var userfieldJson = SendCommand("crm.lead.userfield.get", "ID=190", "", "GET");
                //var userfield = JsonConvert.DeserializeObject<dynamic>(userfieldJson).result;

                // Userfields = new List<Bitrix24.Userfield>() {
                //    new Bitrix24.Userfield() {
                //        ID = userfield.ID,
                //       ENTITY_ID = userfield.ENTITY_ID ,
                //       NAME = userfield.EDIT_FORM_LABEL.ru,
                //       FIELD_NAME = userfield.FIELD_NAME,
                //       USER_TYPE_ID = Bitrix24.USER_TYPE_ID.enumeration ,
                //       LIST = new List<Bitrix24.UF_LIST>()
                // },
                //};

                //        foreach (var keyvalue in userfield.LIST)
                //        {
                //            var listic = keyvalue.ToString();
                //            var li = JsonConvert.DeserializeObject<Bitrix24.UF_LIST>(listic);
                //            Userfields[0].LIST.Add(li);
                //        }

                //  userfieldJson = SendCommand("crm.lead.userfield.get", "ID=192", "", "GET");
                //  userfield = JsonConvert.DeserializeObject<dynamic>(userfieldJson).result;

                //  Userfields.Add( 
                //    new Bitrix24.Userfield() {
                //        ID = userfield.ID,
                //       ENTITY_ID = userfield.ENTITY_ID ,
                //       NAME = userfield.EDIT_FORM_LABEL.ru,
                //       FIELD_NAME = userfield.FIELD_NAME,
                //       USER_TYPE_ID = Bitrix24.USER_TYPE_ID.enumeration ,
                //       LIST = new List<Bitrix24.UF_LIST>()
                 
                //});

                //foreach (var keyvalue in userfield.LIST)
                //{
                //    var listic = keyvalue.ToString();
                //    var li = JsonConvert.DeserializeObject<Bitrix24.UF_LIST>(listic);
                //    Userfields[1].LIST.Add(li);
                //}
                //userfieldJson = SendCommand("crm.lead.userfield.get", "ID=194", "", "GET");
                //userfield = JsonConvert.DeserializeObject<dynamic>(userfieldJson).result;

                //Userfields.Add(
                //  new Bitrix24.Userfield()
                //  {
                //      ID = userfield.ID,
                //      ENTITY_ID = userfield.ENTITY_ID,
                //      NAME = userfield.EDIT_FORM_LABEL.ru,
                //      FIELD_NAME = userfield.FIELD_NAME,
                //      USER_TYPE_ID = Bitrix24.USER_TYPE_ID.enumeration,
                //      LIST = new List<Bitrix24.UF_LIST>()

                //  });

                //foreach (var keyvalue in userfield.LIST)
                //{
                //    var listic = keyvalue.ToString();
                //    var li = JsonConvert.DeserializeObject<Bitrix24.UF_LIST>(listic);
                //    Userfields[2].LIST.Add(li);
                //}

                //return Userfields;
            }    ;
        }
    }



    public class UF_LIST
    {
        public int ID;
        public int SORT;
        public string VALUE;
        public string DEF;
    }
    public class Userfield
    {
         
            public int ID;
            public string NAME;
            public string ENTITY_ID;
            public string FIELD_NAME;
            public USER_TYPE_ID USER_TYPE_ID;
            public MULTIPLE MULTIPLE;
            public List<UF_LIST> LIST;
     
    }


    public enum MULTIPLE
    {
        Y
        , N
    }

    public enum USER_TYPE_ID
    {
        enumeration
        ,file
        ,@string
        ,boolean
        , datetime
        , date 
        , @double
        , crm_status
    }

    //Открытый метод для отправки REST-запросов в Битрикс24
    public string SendCommand(string Command, string Params = "", string Body = "", string Method = "POST")
    {
        //Проверяем и обновлем Токены авторизации
        RefreshTokens();

        //Проверяем возможное указание параметров
        string BX_REST_URI = "";
        if (String.IsNullOrEmpty(Params))
            BX_REST_URI = BX_Portal + "/rest/" + Command + "?auth=" + AccessToken;
        else
            BX_REST_URI = BX_Portal + "/rest/" + Command + "?auth=" + AccessToken + "&" + Params;

        //Создаем новое HTTP подключение для отправки REST-запроса в Битрикс24
        HttpWebRequest requestBitrixREST = (HttpWebRequest)WebRequest.Create(BX_REST_URI);
        requestBitrixREST.Method = Method;
        requestBitrixREST.Headers["Cookie"] = Cookie; //Используем Куки полученный в запросе авторизации
        if (Method == "POST")
        {
            //Готовим тело запроса и вставляем его в тело POST-запроса
            byte[] byteArrayBody = Encoding.UTF8.GetBytes(Body);
            requestBitrixREST.ContentType = "application/json";
            requestBitrixREST.ContentLength = byteArrayBody.Length;
            Stream dataBodyStream = requestBitrixREST.GetRequestStream();
            dataBodyStream.Write(byteArrayBody, 0, byteArrayBody.Length);
            dataBodyStream.Close();
        }

        //Отправляем данные в Битрикс24
        HttpWebResponse responseBitrixREST = (HttpWebResponse)requestBitrixREST.GetResponse();

        

        //Читаем тело ответа от Битрикс24
        Stream dataStreamBitrixREST = responseBitrixREST.GetResponseStream();
        var readerBitrixREST = new StreamReader(dataStreamBitrixREST);
        string stringBitrixREST = readerBitrixREST.ReadToEnd();

        //Закрываем все подключения и потоки
        readerBitrixREST.Close();
        dataStreamBitrixREST.Close();
        responseBitrixREST.Close();

        //Возвращаем строку ответа в формате JSON
        return stringBitrixREST;
    }

}