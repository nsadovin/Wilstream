<%@ WebHandler Language="C#" Class="avgisAddRecord" %>
using System;
using System.Web;

using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.Service;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using System.Linq;
using System.Collections.Generic; 
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;

public class avgisAddRecord : IHttpHandler {
    
    private static readonly AmoCrmConfig Config = new AmoCrmConfig("new56d95221cf36c", "call@avgis.ru", "ec333ac6a168a1de554cbaafff351caa982a8b23", 10);

    private static int StatusNothandled = 23440957;//22373157;
    private static HttpContext _context  ;

    private readonly IAmoCrmService _service = new AmoCrmService(Config);

    public void ProcessRequest (HttpContext context) {

        _context = context;
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();

        var elementId = context.Request.QueryString["elementId"] != null ? Convert.ToInt64(context.Request.QueryString["elementId"].ToString()) : 0;
        var Link = context.Request.QueryString["Link"] != null ? context.Request.QueryString["Link"].ToString() : "";
        var Phone = context.Request.QueryString["Phone"] != null ? context.Request.QueryString["Phone"].ToString() : "";

         
        if (String.IsNullOrEmpty(Phone))
        {
            return;
        }

        var contact  = _service.GetContacts(Phone).FirstOrDefault();
        
        var lead  = _service.GetLead(contact.leads.Ids.FirstOrDefault());
        if (lead != null)
        {
                 var requestNote = new AddOrUpdateNoteRequest(); 
                    requestNote.Update = new List<AddOrUpdateCrmNote>();
                    requestNote.Add = new List<AddOrUpdateCrmNote>();
                    {
                        var _note = new AddOrUpdateCrmNote();
                        _note.ElementId = lead.Id;
                        _note.ElementType = 2;
                        _note.Text = "Запись разговора: "+ Link;
                        _note.ResponsibleUserId = lead.ResponsibleUserId;
                        _note.NoteType = 4;
                        requestNote.Add.Add(_note);
                    }


                    _service.AddOrUpdateNote(requestNote);
        }



        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }



    public bool IsReusable {
        get {
            return false;
        }
    }

}