<%@ WebHandler Language="C#" Class="ModultronGetLeads" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

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
        string deals = BX24.SendCommand("crm.deal.list", "SELECT[]=CONTACT_ID&SELECT[]=ID&FILTER[ASSIGNED_BY_ID]=2887&FILTER[>DATE_CREATE]="+DateTime.Now.AddHours(-100).ToString("yyyy-MM-ddTHH:mm:ss")+"&ORDER[ID]=ASC", JsonConvert.SerializeObject(dataListLids), "POST");

        var dealsJSON = JsonConvert.DeserializeObject<dynamic>(deals);
        if (dealsJSON.total == 0) return;

        foreach (var deal in dealsJSON.result)
        { 
            if (deal.CONTACT_ID != null)
            {
                  
                var contact = BX24.SendCommand("crm.contact.get", "id=" + deal.CONTACT_ID, "", "POST");
                var contactByJSON = JsonConvert.DeserializeObject<dynamic>(contact);
                var phones = "";
                if (contactByJSON.result.PHONE != null)
                { 
                    AddToDataBase(Convert.ToString(contactByJSON.result.NAME), Convert.ToString(contactByJSON.result.PHONE[0].VALUE), (int)deal.ID);
                } 
                   
            }
            
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }

    private void AddToDataBase(string NameContact, string Phone,int IdDeal) {
        try
        {
                
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "IF not exists(select * from [dbo].[WS_Modultron] with(nolock) where IdDeal = "+IdDeal.ToString()+") INSERT INTO  [dbo].[WS_Modultron]   (Name, Phone, IdDeal) Values ( '"+NameContact+"', oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + Phone + "'), "+IdDeal.ToString()+")  ";


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