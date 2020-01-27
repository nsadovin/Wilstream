<%@ WebHandler Language="C#" Class="BestComUpdateLead" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class BestComUpdateLead : IHttpHandler {

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

    Int32 IdLead = 0;
    string UpdateName = "";
    string UpdateStatus = "";

    public void ProcessRequest (HttpContext context) {
        _context = context;

        if (context.Request.QueryString["IdLead"] != null)
            IdLead = Convert.ToInt32(context.Request.QueryString["IdLead"]);
        else
            return;

        if (context.Request.QueryString["Name"] != null)
            UpdateName = context.Request.QueryString["Name"].ToString();
        else if (context.Request.QueryString["Status"] != null)
            UpdateStatus = context.Request.QueryString["Status"].ToString();
        else
            return;

        var Lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
        var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);

        if (LeadByJSON.result.ID == null) return;
        if (context.Request.QueryString["Name"] != null)
            LeadByJSON.result.TITLE = UpdateName;        
        else if (context.Request.QueryString["Name"] != null)
            LeadByJSON.result.STATUS_ID = UpdateStatus;

        var data =context.Request.QueryString["Name"] != null?
        new
        {
            id = (Object)LeadByJSON.result.ID,
            fields = new Dictionary<string, object>()
              {

                  { "TITLE" , UpdateName }

            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        }: new
        {
            id = (Object)LeadByJSON.result.ID,
            fields = new Dictionary<string, object>()
              {

                  { "STATUS_ID" , UpdateStatus }

            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        };
        var contentText = JsonConvert.SerializeObject(data);
        var rslt = BX24.SendCommand("crm.lead.update", "", contentText, "POST");

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}