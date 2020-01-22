<%@ WebHandler Language="C#" Class="BestComGetLeads" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class BestComGetLeads : IHttpHandler {

    private static HttpContext _context  ;


    private readonly Bitrix24 BX24 = new Bitrix24(HttpContext.Current, "local.5e2197fe17aad4.81768834", "YMHv21gyMTwYjtPnkABt29UHpKvXsGLdPrZh2oGSKQQh7VAXJZ", "https://bestcom.bitrix24.ru", "https://oauth.bitrix.info", "willstream@bestcom.moscow", "Cde3Cde3");
         



    //private List<string> FilterSOURCE_IDs = new List<string>() {
    //    "79254995910", //«Напрямую набрали с Krov777.ru»
    //    "SELF",//· «Звонок с spec-krovlya.ru»
    //    "79254995918",//· «С подменой Roistat»
    //    "79254995914",//· «С.К.ru звонок без подмены»
    //    "79254995904",//· «Krov777 SEO»
    //    "OTHER",//· «Входящий на 999 333 12-59»
    //};


    private List<string> FilterSOURCE_IDs = new List<string>() {
        "Напрямую набрали с Krov777.ru", //«Напрямую набрали с Krov777.ru»
        "Звонок с spec-krovlya.ru",//· «Звонок с spec-krovlya.ru»
        "С подменой Roistat",//· «С подменой Roistat»
        "С.К.ru звонок без подмены",//· «С.К.ru звонок без подмены»
        "Krov777 SEO",//· «Krov777 SEO»
        "Входящий на 999 333 12-59",//· «Входящий на 999 333 12-59»
    };


    public void ProcessRequest (HttpContext context) {
        _context = context;


        var dataListLids = new
        {
            sort = new { ID = "desc" }
        };

        //string Leads = BX24.SendCommand("crm.lead.list", "FILTER[STATUS_ID]=NEW&"+String.Join("&",FilterSOURCE_IDs.Select(r=>"FILTER[SOURCE_ID]<>"+r)), JsonConvert.SerializeObject(dataListLids), "POST");
        string Leads = BX24.SendCommand("crm.lead.list", "SELECT[]=PHONE&SELECT[]=ID&FILTER[%TITLE]=Wantresult&FILTER[>DATE_CREATE]="+DateTime.Now.AddHours(-10).ToString("yyyy-MM-ddTHH:mm:ss")+"&ORDER[ID]=ASC", JsonConvert.SerializeObject(dataListLids), "POST");

        var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
        if (LeadsJSON.total == 0) return;

        foreach (var lead in LeadsJSON.result)
        { 
            AddToDataBase(Convert.ToString(lead.PHONE[0].VALUE), (int)lead.ID);
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }

    private void AddToDataBase(string Phone, int IdLead) {
        try
        {
                
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "IF not exists(select * from [dbo].[WS_BestCom] with(nolock) where IdLead = "+IdLead.ToString()+") INSERT INTO  [dbo].[WS_BestCom]   (Phone, IdLead) Values ( oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + Phone + "'), "+IdLead.ToString()+")  ";


            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
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