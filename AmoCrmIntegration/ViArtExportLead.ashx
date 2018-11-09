<%@ WebHandler Language="C#" Class="ViArtExportLead" %>


using System;
using System.Web;

using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.Service;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class ViArtExportLead : IHttpHandler {

    private static readonly AmoCrmConfig Config = new AmoCrmConfig("bcdelo", "eliseeva.kv@bcdelo.ru", "210ef47aeaed3b08076db72fc0af186f848a3484", 10);

    private static HttpContext _context  ;

    private readonly IAmoCrmService _service = new AmoCrmService(Config);


    public void ProcessRequest (HttpContext context) {
        _context = context;
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();

        var phone = context.Request.QueryString["phone"] != null ? context.Request.QueryString["phone"].ToString() : "9197651287";
        var dtcall = context.Request.QueryString["dtcall"] != null ? context.Request.QueryString["dtcall"].ToString() : "2018-10-31 21:25:00";
        var result = context.Request.QueryString["result"] != null ? context.Request.QueryString["result"].ToString() : "Успех";
        var l = _service.GetLead(Convert.ToInt64(10258157)); 
        var c =  _service.GetContact(23939153) ;
        var request = new AddOrUpdateLeadRequest();
        var lead = new AddOrUpdateCrmLead();
        lead.Name = "Звонок в КЦ. Статус: " + result;
        lead.DateCreate = DateTime.Parse(dtcall);
        lead.StatusId = "21770533";
        request.Add = new List<AddOrUpdateCrmLead>();
        request.Add.Add(lead);
        var rslt =  _service.AddOrUpdateLead(request);
        if (rslt.Count() > 0)
        {
                
                var requestContact = new AddOrUpdateContactRequest();
                requestContact.Update = new List<AddOrUpdateCrmContact>();
                requestContact.Add = new List<AddOrUpdateCrmContact>();

                var _contact = new AddOrUpdateCrmContact();
                _contact.LeadsId = rslt.FirstOrDefault().Id.ToString();
                _contact.Name = phone;
                _contact.CustomFields = new List<AddContactCustomField>() {
                    new AddContactCustomField() { 
                         Id = 459675, 
                         Values = new List<Object> { new AddCustomFieldValuesEnum() { Value = phone, Enum = "914571" } } 
                    }
                };

                requestContact.Add.Add(_contact);
                
                var rs = _service.AddOrUpdateContact(requestContact);
                
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}