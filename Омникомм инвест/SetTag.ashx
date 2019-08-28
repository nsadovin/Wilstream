<%@ WebHandler Language="C#" Class="SetTag" %>

using System;
using System.Web;

using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.Service;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;
using System.Text.RegularExpressions;

using System.Data.SqlClient;
using System.Data;

public class SetTag : IHttpHandler {

    private static readonly AmoCrmConfig Config = new AmoCrmConfig("omnicrm", "dealer@omnicomm.ru", "cefdc2f47c19370cf472b7b79933eedda1e03aa1", 500);

    private static int StatusNothandled = 23440957;//22373157;
    private static HttpContext _context  ;

    private readonly IAmoCrmService _service = new AmoCrmService(Config);

    public void ProcessRequest(HttpContext context) {
        _context = context;
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();

        context.Response.ContentType = "text/plain";

        var IdCompany = context.Request.QueryString["IdCompany"]!=null ? context.Request.QueryString["IdCompany"].ToString():"";

        if (IdCompany == "")
        {

            return;
        } 
         
                var company_ = _service.GetCompany(Convert.ToInt32(IdCompany));
                  
                    var request = new AddOrUpdateCompanyRequest();
                    var updateCompany = new AddOrUpdateCrmCompany();
                    updateCompany.Contacts = company_.Contacts;
                    updateCompany.CustomFields = company_.CustomFields;
                    updateCompany.Id = company_.Id;
                    updateCompany.Name = company_.Name; 
                    updateCompany.Tags = "Call center";
                    request.Add = new List<AddOrUpdateCrmCompany>();
                    request.Update = new List<AddOrUpdateCrmCompany>();
                    request.Update.Add(updateCompany);
                    _service.AddOrUpdateCompany(request);
                    
            
             
        context.Response.Write("Good");
    }
         
          
    public bool IsReusable {
        get {
            return false;
        }
    }

}