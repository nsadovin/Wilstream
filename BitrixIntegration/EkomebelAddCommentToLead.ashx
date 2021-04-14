<%@ WebHandler Language="C#" Class="EkomebelAddCommentToLead" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class EkomebelAddCommentToLead : IHttpHandler {
  //22
  private static HttpContext _context  ;



  private readonly Bitrix24
    BX24 = new Bitrix24(HttpContext.Current, "local.5f8eb07b894111.02063524",
      "thV1fiKJaQFB03sYUGh0o9faUn3hy2Tst8EciXk0A0bd5oyOUl", "https://ekomebel.bitrix24.ru", "https://oauth.bitrix.info",
      "gc.ekomebel+wilstream.ru@gmail.com", "1998eko2017");



  Int32 IdLead = 0;
  string Comment = "";
  string Phone = "";

  public void ProcessRequest (HttpContext context) {
    _context = context;

    if (context.Request.QueryString["IdLead"] != null)
      IdLead = Convert.ToInt32(context.Request.QueryString["IdLead"]);
    else if (context.Request.QueryString["Phone"] != null)
      Phone = context.Request.QueryString["Phone"];
    else
      return;

    if (context.Request.QueryString["Comment"] != null)
      Comment = context.Request.QueryString["Comment"].ToString();
    else
      return;

    if (IdLead== 0 && string.IsNullOrEmpty(Phone))
    {
      return;
    }

    if (IdLead == 0)
    {
      IdLead = getIdLeadByPhone(Phone);
      if (IdLead == 0)
      {
        return;
      }
    }

    var data =
    new
    {
      fields = new Dictionary<string, object>()
          {

                  { "ENTITY_ID" , IdLead },
                  { "ENTITY_TYPE" , "lead" },
                  { "COMMENT" , Comment }

        }
    };
    var contentText = JsonConvert.SerializeObject(data);

    var Lead = BX24.SendCommand("crm.timeline.comment.add", "", contentText, "POST");
    var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);

    context.Response.ContentType = "text/plain";
    context.Response.Write("Good");
  }


  public bool IsReusable {
    get {
      return false;
    }
  }


  protected int getIdLeadByPhone(string Phone)
  {
    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };
    var strPhone = "&values[]=" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=7" +
                   Phone.Substring(Phone.Length - 10, 10) + "&values[]=8" + Phone.Substring(Phone.Length - 10, 10);
    //log.Info(string.Format("strPhone = {0}", strPhone));
    var Leads = BX24.SendCommand("crm.duplicate.findbycomm",
      "entity_type=LEAD&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC",
      JsonConvert.SerializeObject(dataListLids));
    //log.Info(string.Format("crm.duplicate.findbycomm = {0}", Leads));
    var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
    try
    {
      if (LeadsJSON.result.LEAD.Count > 0)
      {
        // log.Info(string.Format("LeadsJSON.result.LEAD.Count = {0}", LeadsJSON.result.LEAD.Count));
        var IdLead = (int) LeadsJSON.result.LEAD[0];
        //  log.Info(string.Format("Select IdLead = {0}", IdLead));
        return IdLead;
      }

      return 0;
    }
    catch (Exception ex)
    {
      var r = ex;
      // log.Error(ex);
      return 0;
    }
  }

}