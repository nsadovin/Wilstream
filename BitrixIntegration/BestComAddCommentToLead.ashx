<%@ WebHandler Language="C#" Class="SpecKrovlyaAddCommentToLead" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class SpecKrovlyaAddCommentToLead : IHttpHandler {

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
    string Comment = "";
    string Phone = "";

    public void ProcessRequest (HttpContext context) {
        _context = context;

        if (context.Request.QueryString["IdLead"] != null)
            IdLead = Convert.ToInt32(context.Request.QueryString["IdLead"]);
        else
        if (context.Request.QueryString["Phone"] != null)
        {
            Phone = context.Request.QueryString["Phone"].ToString();
        }
        else
            return;

        if (context.Request.QueryString["Comment"] != null)
            Comment = context.Request.QueryString["Comment"].ToString();
        else
            return;

        if (IdLead == 0)
        {
            var dataListLids = new
            {
                sort = new { ID = "desc" }
            };

            string Leads = BX24.SendCommand("crm.lead.list", "FILTER[PHONE]=" + Phone + "&ORDER[ID]=DESC", JsonConvert.SerializeObject(dataListLids), "POST");
            var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
            if (LeadsJSON.total > 0)
            {
                IdLead = (int)LeadsJSON.result[0].ID;
            }
            else
                return;
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

}