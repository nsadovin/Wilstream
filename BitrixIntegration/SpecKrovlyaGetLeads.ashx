<%@ WebHandler Language="C#" Class="SpecKrovlyaGetLeads" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class SpecKrovlyaGetLeads : IHttpHandler {

    private static HttpContext _context  ;


    private readonly Bitrix24 BX24 = new Bitrix24(HttpContext.Current, "local.5df71697ba4c32.83741482", "OgtWQyF0ETIsXQtJGb4zll1zcaeBnkHNTg0x3XlZY0V8XEL3TU", "https://spec-krovlya.bitrix24.ru", "https://oauth.bitrix.info", "wilstream.krov1@mail.ru", "1qazxsw2");



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
        string Leads = BX24.SendCommand("crm.lead.list", "SELECT[]=PHONE&SELECT[]=ID&SELECT[]=SOURCE_ID&SELECT[]=DATE_CREATE&FILTER[STATUS_ID]=NEW&ORDER[ID]=DESC", JsonConvert.SerializeObject(dataListLids), "POST");

        var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
        if (LeadsJSON.total == 0) return;

        foreach (var lead in LeadsJSON.result)
        {
            if (FilterSOURCE_IDs.Contains(Convert.ToString(lead.SOURCE_ID)) || lead.PHONE == null) continue;
            if (IsExistsInDataBase(Convert.ToString(lead.PHONE[0].VALUE), (int)lead.ID, Convert.ToDateTime(lead.DATE_CREATE)))
            {
                var data =  new
                {
                    id = (Object)lead.ID,
                    fields = new Dictionary<string, object>()
                      {

                          { "STATUS_ID" , 3 }

                    },
                    @params = new { REGISTER_SONET_EVENT = "Y" }
                };
                var contentText = JsonConvert.SerializeObject(data);
                var rslt = BX24.SendCommand("crm.lead.update", "", contentText, "POST");
            }
            else
            {
                AddToDataBase(Convert.ToString(lead.PHONE[0].VALUE), (int)lead.ID, Convert.ToDateTime(lead.DATE_CREATE));
                UpdateStatusLead((int)lead.ID, "5");
            }
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }


    private void UpdateStatusLead(int IdLead, string UpdateStatus)
    {
        var data =  new
        {
            id = (Object)IdLead,
            fields = new Dictionary<string, object>()
              {

                  { "STATUS_ID" , UpdateStatus }

            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        };
        var contentText = JsonConvert.SerializeObject(data);
        var rslt = BX24.SendCommand("crm.lead.update", "", contentText, "POST");
    }


    private bool IsExistsInDataBase(string Phone, int IdLead, DateTime Created) {
        var result = false;
        try
        {

            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "select * from [dbo].[WS_SpecKrovlya] with(nolock) " +
                "where IdLead <> "+IdLead.ToString()+" and Phone = oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + Phone + "') and dateadd(mi,30,Created) > @CreatedLead; ";


            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@CreatedLead", Created);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            if (myOdbcReader.HasRows) {
                result = true;
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();

        }
        catch (Exception ex)
        {
            _context.Response.Write(ex.Message);
        }

        return result;
    }

    private void AddToDataBase(string Phone, int IdLead, DateTime Created) {
        try
        {

            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "IF not exists(select * from [dbo].[WS_SpecKrovlya] with(nolock) where IdLead = "+IdLead.ToString()+") INSERT INTO  [dbo].[WS_SpecKrovlya]   (Phone, IdLead, [Created]) Values ( oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + Phone + "'), "+IdLead.ToString()+", @CreatedLead)  ";


            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@CreatedLead", Created);
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