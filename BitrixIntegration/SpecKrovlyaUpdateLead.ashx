<%@ WebHandler Language="C#" Class="SpecKrovlyaUpdateLead" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class SpecKrovlyaUpdateLead : IHttpHandler {

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

    Int32 IdLead = 0;
    string UpdateName = "";

    public void ProcessRequest (HttpContext context) {
        _context = context;

        if (context.Request.QueryString["IdLead"] != null)
            IdLead = Convert.ToInt32(context.Request.QueryString["IdLead"]);
        else
            return;

        if (context.Request.QueryString["Name"] != null)
            UpdateName = context.Request.QueryString["Name"].ToString();
        else
            return;

        var Lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
        var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);

        if (LeadByJSON.result.ID == null) return;

        LeadByJSON.result.TITLE = UpdateName;
        var data =
        new
        {
            id = (Object)LeadByJSON.result.ID,
            fields = new Dictionary<string, object>()
              {

                  { "TITLE" , UpdateName }

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