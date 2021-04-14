<%@ WebHandler Language="C#" Class="EkomebelGetLeads" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Web;
using Newtonsoft.Json;

public class EkomebelGetLeads : IHttpHandler
{
  //33
  private static HttpContext _context;


  private readonly Bitrix24
    BX24 = new Bitrix24(HttpContext.Current, "local.5f8eb07b894111.02063524",
      "thV1fiKJaQFB03sYUGh0o9faUn3hy2Tst8EciXk0A0bd5oyOUl", "https://ekomebel.bitrix24.ru", "https://oauth.bitrix.info",
      "gc.ekomebel+wilstream.ru@gmail.com", "1998eko2017");


  public void ProcessRequest(HttpContext context)
  {
    _context = context;


    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };

    //string Leads = BX24.SendCommand("crm.lead.list", "FILTER[STATUS_ID]=NEW&"+String.Join("&",FilterSOURCE_IDs.Select(r=>"FILTER[SOURCE_ID]<>"+r)), JsonConvert.SerializeObject(dataListLids), "POST");
    //string deals = BX24.SendCommand("crm.deal.list", "SELECT[]=CONTACT_ID&SELECT[]=ID&FILTER[ASSIGNED_BY_ID]=2887&FILTER[>DATE_CREATE]="+DateTime.Now.AddHours(-100).ToString("yyyy-MM-ddTHH:mm:ss")+"&ORDER[ID]=ASC", JsonConvert.SerializeObject(dataListLids), "POST");

    /*   var deals = BX24.SendCommand("crm.deal.list",
         $"SELECT[]=CONTACT_ID&SELECT[]=ID&SELECT[]=TITLE&SELECT[]=BEGINDATE&FILTER[ASSIGNED_BY_ID]=1287&start={start}&ORDER[ID]=ASC",
         JsonConvert.SerializeObject(dataListLids));*/

    var start = "0";
    dynamic leadsJson;
    do
    {

      string leads = BX24.SendCommand("crm.lead.list", $"SELECT[]=TITLE&SELECT[]=NAME&SELECT[]=PHONE&SELECT[]=ID&FILTER[STATUS_ID]=NEW&FILTER[ASSIGNED_BY_ID]=1287&start={start}&ORDER[ID]=ASC", JsonConvert.SerializeObject(dataListLids), "POST");


      leadsJson = JsonConvert.DeserializeObject<dynamic>(leads);
      if (leadsJson.total == 0) return;
      start = leadsJson.next;
      HandlerLeads(leadsJson);
      Thread.Sleep(1000);
    } while (leadsJson.next != null);


    context.Response.ContentType = "text/plain";
    context.Response.Write("Good");
  }

  public bool IsReusable => false;

  private void HandlerLeads(dynamic leadsJson)
  {
    foreach (var lead in leadsJson.result)
    {
      if (lead.PHONE != null)
      {
        try
        {
           
            AddToDataBase(Convert.ToString(lead.NAME),
              Convert.ToString(lead.PHONE[0].VALUE), (int) lead.ID, lead.TITLE.ToString());
          
            var data =  new
            {
              id = (Object)lead.ID,
              fields = new Dictionary<string, object>()
              {

                { "STATUS_ID" , 15 }

              },
              @params = new { REGISTER_SONET_EVENT = "Y" }
            };
            var contentText = JsonConvert.SerializeObject(data);
            var rslt = BX24.SendCommand("crm.lead.update", "", contentText, "POST");

          Thread.Sleep(50);
        }
        catch (Exception ex)
        {
          _context.Response.Write(ex);
        }
      }
    }
  }

  private void AddToDataBase(string nameContact, string phone, int idLead, string title)
  {
    try
    {
      var settings =
        ConfigurationManager.ConnectionStrings["oktellConnectionString"];

      var myOdbcConnection = new SqlConnection(settings.ConnectionString);

      var sqlStr = "IF not exists(select * from [dbo].[WS_Ekomebel] with(nolock) where IdLead = " + idLead + ") " +
                   " INSERT INTO  [dbo].[WS_Ekomebel]   (Name, Phone, IdLead, Title) " +
                   "Values ( '" + nameContact + "', oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + phone + "'), " +
                   idLead + ", '" + title + "') ; else " +
                   " UPDATE [dbo].[WS_Ekomebel] SET Title = '" + title + "'   WHERE  IdLead = " + idLead + " ";


      var myOdbcCommand = new SqlCommand(sqlStr, myOdbcConnection);
      myOdbcCommand.CommandType = CommandType.Text;
      myOdbcCommand.Connection.Open();
      var myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

      myOdbcReader.Close();
      myOdbcConnection.Close();
    }
    catch (Exception ex)
    {
      _context.Response.Write(ex.Message);
    }
  }
}