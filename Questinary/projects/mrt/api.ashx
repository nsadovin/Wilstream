<%@ WebHandler Language="C#" Class="api" %>

using System;
using System.Web;
using System.Collections.Generic;

using System.Data.SqlClient;
using System.Data;
using System.Linq;
using Newtonsoft.Json;

public class api : IHttpHandler {

    public void ProcessRequest (HttpContext context) {

        var type = context.Request["type"] != null ? context.Request["type"].ToString() : "json";
        if(type=="json")
            context.Response.ContentType = "application/json";
        else
            context.Response.ContentType = "application/xml";
        // context.Response.ContentType = "text/plain";
        //context.Response.Write("test");
        context.Response.Write(GetData( Convert.ToDateTime(context.Request["dt"].ToString()),type,context));
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

            var SqlStr = "select * from [dbo].[A_TaskManager_LocalList_af9bf193-9264-4efb-95a7-de963f8ff8a9_0] with(nolock) where convert(varchar(10), LastCall, 104)   = '"+ dateTime.ToShortDateString()+"' and LastStatus in ('Согласился, переключили')  ";
            //context.Response.Write(SqlStr);
            var rslt = new List<Dictionary<string,string>>();

            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                var item = new Dictionary<string, string>();
                item.Add("Телефон", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Телефон"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Телефон")): string.Empty);
                item.Add("Имя", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Имя"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Имя")): string.Empty);
                item.Add("Город", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Город"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Город")): string.Empty);
                item.Add("Марка", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Марка"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Марка")): string.Empty);
                item.Add("Модель", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("Модель"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("Модель")): string.Empty);
                item.Add("utm_source", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("utm_source"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("utm_source")): string.Empty);
                item.Add("utm_campaign", !myOdbcReader.IsDBNull(myOdbcReader.GetOrdinal("utm_campaign"))? myOdbcReader.GetString(myOdbcReader.GetOrdinal("utm_campaign")): string.Empty);
                rslt.Add(item);
                ///	context.Response.Write(SqlStr);
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