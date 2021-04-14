<%@ WebHandler Language="C#" Class="ModultronGetLeads" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using System.Threading;

public class ModultronGetLeads : IHttpHandler {
    //33
    private static HttpContext _context  ;


    private readonly Bitrix24 BX24 = new Bitrix24(HttpContext.Current, "local.5f3d8221baf308.35921081", "iPSI4mQS8HftaCZDUMvNFkJ4E4wXxdFkMVSTeaS7rgfEUIerQ5", "https://modultron.bitrix24.ru", "https://oauth.bitrix.info", "callcenter@banya.one", "ZauAEt7a");






    public void ProcessRequest (HttpContext context) {
        _context = context;


        var dataListLids = new
        {
            sort = new { ID = "desc" }
        };

        //string Leads = BX24.SendCommand("crm.lead.list", "FILTER[STATUS_ID]=NEW&"+String.Join("&",FilterSOURCE_IDs.Select(r=>"FILTER[SOURCE_ID]<>"+r)), JsonConvert.SerializeObject(dataListLids), "POST");
        //string deals = BX24.SendCommand("crm.deal.list", "SELECT[]=CONTACT_ID&SELECT[]=ID&FILTER[ASSIGNED_BY_ID]=2887&FILTER[>DATE_CREATE]="+DateTime.Now.AddHours(-100).ToString("yyyy-MM-ddTHH:mm:ss")+"&ORDER[ID]=ASC", JsonConvert.SerializeObject(dataListLids), "POST");


        var start = "0";
        dynamic dealsJson;
        do
        {
            string deals = BX24.SendCommand("crm.deal.list",
                $"SELECT[]=CONTACT_ID&SELECT[]=ID&SELECT[]=TITLE&SELECT[]=BEGINDATE&FILTER[ASSIGNED_BY_ID]=2887&start={start}&ORDER[ID]=ASC",
                JsonConvert.SerializeObject(dataListLids), "POST");

            dealsJson = JsonConvert.DeserializeObject<dynamic>(deals);
            if (dealsJson.total == 0) return;
            start = dealsJson.next;
            HandlerDeals(dealsJson);
            Thread.Sleep(1000);
        } while (dealsJson.next != null);


        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }

    private void HandlerDeals(dynamic dealsJson)
    {
        foreach (var deal in dealsJson.result)
        {
            if (deal.CONTACT_ID != null)
            {
                try
                {
                    var contact = BX24.SendCommand("crm.contact.get", "id=" + deal.CONTACT_ID, "", "POST");
                    var contactByJson = JsonConvert.DeserializeObject<dynamic>(contact);
                    if (contactByJson.result.PHONE != null)
                    {
                        DateTime begindate;
                        DateTime.TryParse(deal.BEGINDATE.ToString(), out begindate);
                        AddToDataBase(Convert.ToString(contactByJson.result.NAME),
                            Convert.ToString(contactByJson.result.PHONE[0].VALUE), (int) deal.ID, deal.TITLE.ToString(),
                            DateTime.TryParse(deal.BEGINDATE.ToString(), out begindate) ? (DateTime?) begindate : null);
                    }
                    
                    Thread.Sleep(50);
                }
                catch (Exception ex)
                {
                    _context.Response.Write(ex);
                }
            }
        }
    }

    private void AddToDataBase(string nameContact, string phone,int idDeal, string title, DateTime? begindate) {
        try
        {

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var sqlStr = "IF not exists(select * from [dbo].[WS_Modultron] with(nolock) where IdDeal = "+idDeal.ToString()+") "+
                         " INSERT INTO  [dbo].[WS_Modultron]   (Name, Phone, IdDeal, Title, BeginDate) "+
                         "Values ( '"+nameContact+"', oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + phone + "'), "+idDeal.ToString()+", '"+title+"','"+begindate+"') ; else "+
                         " UPDATE [dbo].[WS_Modultron] SET Title = '"+title+"', BeginDate = '"+begindate+"' WHERE  IdDeal = "+idDeal.ToString()+" ";


            SqlCommand myOdbcCommand = new SqlCommand(sqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

            myOdbcReader.Close();
            myOdbcConnection.Close();

        }
        catch (Exception ex)
        {
            _context.Response.Write(ex.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}