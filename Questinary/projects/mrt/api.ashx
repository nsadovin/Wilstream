<%@ WebHandler Language="C#" Class="api" %>

using System;
using System.Web;
using System.Collections.Generic;

using System.Data.SqlClient;
using System.Data;
using System.Linq;
using Newtonsoft.Json;
    
using System.Globalization;

public class api : IHttpHandler {

    public void ProcessRequest (HttpContext context) {


        var token = context.Request["token"] != null ? context.Request["token"].ToString() : "";

        if (token != "asdh_asd432lasl54ra!snc")
        {
                context.Response.ContentType = "text/plain";
                context.Response.Write("Token is not valid");
                context.Response.End();
        }

        var type = context.Request["type"] != null ? context.Request["type"].ToString() : "json";
        if(type=="json")
            context.Response.ContentType = "application/json";
        else
            context.Response.ContentType = "application/xml";
        // context.Response.ContentType = "text/plain";
        //context.Response.Write("test");
        CultureInfo customCulture = new CultureInfo("en-US", true);

        customCulture.DateTimeFormat.ShortDatePattern = "yyyy-MM-dd h:mm tt";

        System.Threading.Thread.CurrentThread.CurrentCulture = customCulture;
        System.Threading.Thread.CurrentThread.CurrentUICulture = customCulture;

        string dateString = context.Request["last_request_date"].ToString();   
        DateTime dateTime16 = DateTime.ParseExact(dateString, new string[] { "yyyy-MM-dd HH:mm:ss" }, customCulture, DateTimeStyles.None); 

        context.Response.Write(GetData(dateTime16,type,context));
    }

    public bool IsReusable {
        get {
            return false;
        }
    }


    private string GetData(DateTime dateTime, string type, HttpContext context) {
        try
        {
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "select * from [dbo].[A_TaskManager_LocalList_af9bf193-9264-4efb-95a7-de963f8ff8a9_0] with(nolock) where LastCall > '"+ dateTime.ToString( "yyyy-MM-dd HH:mm:ss" )+"' and [Статус] like 'Жд_т звонка менеджера'  ";
            //context.Response.Write(SqlStr);
            var rslt = new List<Dictionary<string,string>>();

            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                var item = new Dictionary<string, string>();


                item.Add("created", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("LastCall"))? myOdbcReader.GetDateTime(myOdbcReader.GetOrdinal("LastCall")).ToString("yyyy-MM-dd HH:mm:ss"): string.Empty);
                item.Add("comment", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Комментарий"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Комментарий")): string.Empty);
                item.Add("car_cost", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("car_cost"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("car_cost")): string.Empty);
                item.Add("last_name", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Фамилия"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Фамилия")): string.Empty);
                item.Add("first_name", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Имя"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Имя")): string.Empty);
                item.Add("middle_name", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Отчество"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Отчество")): string.Empty);
                item.Add("mobile_tel", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Телефон"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Телефон")): string.Empty);
                item.Add("email", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("email"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("email")): null);
                item.Add("work_income", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("work_income"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("work_income")): string.Empty);
                item.Add("birthdate", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("birthdate"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("birthdate")): null);
                item.Add("place_reg", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Город"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Город")): string.Empty);
                item.Add("brand", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Марка"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Марка")): string.Empty);
                item.Add("model", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Модель"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Модель")): string.Empty);
                item.Add("complectation", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("complectation"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("complectation")): string.Empty);
                item.Add("credit_term", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("credit_term"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("credit_term")): string.Empty);
                item.Add("inital_pay", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("inital_pay"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("inital_pay")): string.Empty);
                item.Add("ip_address", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("ip_address"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("ip_address")): string.Empty);
                item.Add("referer", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("referer"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("referer")): string.Empty);
                item.Add("ad_channel", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("ad_channel"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("ad_channel")): string.Empty);
                item.Add("additional_params", "a:2:{s:10:\"utm_source\";s:8:\"LeonLead\";s:12:\"utm_campaign\";s:8:\"LeonLead\";}");
                 

                rslt.Add(item);

            }
            myOdbcReader.Close();
            myOdbcConnection.Close();
            if (type == "json")
                return JsonConvert.SerializeObject(rslt);
            else
            {
                return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+JsonConvert.DeserializeXmlNode("{'root':{'item':"+JsonConvert.SerializeObject(rslt)+"}}").OuterXml;
            }

        }
        catch (Exception ex)
        {
            context.Response.Write(ex.Message);
            return "";
        }
    }


}