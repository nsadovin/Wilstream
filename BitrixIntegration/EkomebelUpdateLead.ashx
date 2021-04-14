<%@ WebHandler Language="C#" Class="EkomebelUpdateDeal" %>

using System;
using System.Collections.Generic;
using System.Web;
using Newtonsoft.Json;

public class EkomebelUpdateDeal : IHttpHandler
{
  private static HttpContext _context;

    
  private readonly Bitrix24
    BX24 = new Bitrix24(HttpContext.Current, "local.5f8eb07b894111.02063524",
      "thV1fiKJaQFB03sYUGh0o9faUn3hy2Tst8EciXk0A0bd5oyOUl", "https://ekomebel.bitrix24.ru", "https://oauth.bitrix.info",
      "gc.ekomebel+wilstream.ru@gmail.com", "1998eko2017");


  private int IdLead;
  private string UpdateName = "";
  private string UpdateSTAGE_ID = "";
  private string UpdateStatus = "";

  public void ProcessRequest(HttpContext context)
  {
    _context = context;

    if (context.Request.QueryString["IdLead"] != null)
      IdLead = Convert.ToInt32(context.Request.QueryString["IdLead"]);
    else
      return;

    if (context.Request.QueryString["STAGE_ID"] != null)
      UpdateSTAGE_ID = context.Request.QueryString["STAGE_ID"];
    else if (context.Request.QueryString["Name"] != null)
      UpdateName = context.Request.QueryString["Name"];
    else if (context.Request.QueryString["STATUS_ID"] != null)
      UpdateStatus = context.Request.QueryString["STATUS_ID"];
    else
      return;

    var lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
    var leadByJSON = JsonConvert.DeserializeObject<dynamic>(lead);

    if (leadByJSON.result.ID == null) return;
    if (context.Request.QueryString["STAGE_ID"] != null)
      leadByJSON.result.STAGE_ID = UpdateSTAGE_ID;
    else if (context.Request.QueryString["Name"] != null)
      leadByJSON.result.TITLE = UpdateName;
    else if (context.Request.QueryString["STATUS_ID"] != null)
      leadByJSON.result.STATUS_ID = UpdateStatus;

    var data = context.Request.QueryString["Name"] != null ? new
      {
        id = (object) leadByJSON.result.ID,
        fields = new Dictionary<string, object>
        {
          {"TITLE", UpdateName}
        },
        @params = new {REGISTER_SONET_EVENT = "Y"}
      } :
      context.Request.QueryString["STAGE_ID"] != null ? new
      {
        id = (object) leadByJSON.result.ID,
        fields = new Dictionary<string, object>
        {
          {"STAGE_ID", UpdateSTAGE_ID}
        },
        @params = new {REGISTER_SONET_EVENT = "Y"}
      } : new
      {
        id = (object) leadByJSON.result.ID,
        fields = new Dictionary<string, object>
        {
          {"STATUS_ID", UpdateStatus}
        },
        @params = new {REGISTER_SONET_EVENT = "Y"}
      };
    var contentText = JsonConvert.SerializeObject(data);
    var rslt = BX24.SendCommand("crm.lead.update", "", contentText);

    context.Response.ContentType = "text/plain";
    context.Response.Write("Good");
  }


  public bool IsReusable => false;
}