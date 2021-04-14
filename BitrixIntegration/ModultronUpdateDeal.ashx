<%@ WebHandler Language="C#" Class="ModultronUpdateDeal" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class ModultronUpdateDeal : IHttpHandler {

    private static HttpContext _context  ;



    private readonly Bitrix24 BX24 = new Bitrix24(HttpContext.Current, "local.5f3d8221baf308.35921081", "iPSI4mQS8HftaCZDUMvNFkJ4E4wXxdFkMVSTeaS7rgfEUIerQ5", "https://modultron.bitrix24.ru", "https://oauth.bitrix.info", "callcenter@banya.one", "ZauAEt7a");

  
    Int32 IdDeal = 0;
    string UpdateName = "";
    string UpdateStatus = "";
    string UpdateSTAGE_ID = "";

    public void ProcessRequest (HttpContext context) {
        _context = context;

        if (context.Request.QueryString["IdDeal"] != null)
            IdDeal = Convert.ToInt32(context.Request.QueryString["IdDeal"]);
        else
            return;

        if (context.Request.QueryString["STAGE_ID"] != null)
            UpdateSTAGE_ID = context.Request.QueryString["STAGE_ID"].ToString();
        else if (context.Request.QueryString["Name"] != null)
            UpdateName = context.Request.QueryString["Name"].ToString();
        else if (context.Request.QueryString["Status"] != null)
            UpdateStatus = context.Request.QueryString["Status"].ToString();
        else
            return;

        var deal = BX24.SendCommand("crm.deal.get", "ID=" + IdDeal, "", "GET");
        var dealByJSON = JsonConvert.DeserializeObject<dynamic>(deal);

        if (dealByJSON.result.ID == null) return;
        if (context.Request.QueryString["STAGE_ID"] != null)
            dealByJSON.result.STAGE_ID = UpdateSTAGE_ID;        
        else if (context.Request.QueryString["Name"] != null)
            dealByJSON.result.TITLE = UpdateName;        
        else if (context.Request.QueryString["Name"] != null)
            dealByJSON.result.STATUS_ID = UpdateStatus;

        var data =context.Request.QueryString["Name"] != null?
        new
        {
            id = (Object)dealByJSON.result.ID,
            fields = new Dictionary<string, object>()
              {

                  { "TITLE" , UpdateName }

            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        }: (
        
            context.Request.QueryString["STAGE_ID"] != null? new
        {
            id = (Object)dealByJSON.result.ID,
            fields = new Dictionary<string, object>()
            {

                { "STAGE_ID" , UpdateSTAGE_ID }

            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        }:new
            {
                id = (Object)dealByJSON.result.ID,
                fields = new Dictionary<string, object>()
                {

                    { "STATUS_ID" , UpdateStatus }

                },
                @params = new { REGISTER_SONET_EVENT = "Y" }
            }
        
        );
        var contentText = JsonConvert.SerializeObject(data);
        var rslt = BX24.SendCommand("crm.deal.update", "", contentText, "POST");

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}