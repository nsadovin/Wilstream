<%@ WebHandler Language="C#" Class="ModultronAddCommentToLead" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class ModultronAddCommentToLead : IHttpHandler {
    //22
    private static HttpContext _context  ;

        

   
    private readonly Bitrix24 BX24 = new Bitrix24(HttpContext.Current, "local.5f3d8221baf308.35921081", "iPSI4mQS8HftaCZDUMvNFkJ4E4wXxdFkMVSTeaS7rgfEUIerQ5", "https://modultron.bitrix24.ru", "https://oauth.bitrix.info", "callcenter@banya.one", "ZauAEt7a");

 

         
    Int32 IdDeal = 0;
    string Comment = "";
    string Phone = "";

    public void ProcessRequest (HttpContext context) {
        _context = context;

        if (context.Request.QueryString["IdDeal"] != null)
            IdDeal = Convert.ToInt32(context.Request.QueryString["IdDeal"]);
         
        else
            return;

        if (context.Request.QueryString["Comment"] != null)
            Comment = context.Request.QueryString["Comment"].ToString();
        else
            return;

        if (IdDeal== 0)
        {
              
                return;
        }

        var data =
        new
        {
            fields = new Dictionary<string, object>()
              {

                  { "ENTITY_ID" , IdDeal },
                  { "ENTITY_TYPE" , "deal" },
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