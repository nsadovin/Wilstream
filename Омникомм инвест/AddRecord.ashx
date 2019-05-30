<%@ WebHandler Language="C#" Class="AddRecord" %>
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

public class AddRecord : IHttpHandler {
    
    private static readonly AmoCrmConfig Config = new AmoCrmConfig("omnicrm", "dealer@omnicomm.ru", "cefdc2f47c19370cf472b7b79933eedda1e03aa1", 500);

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
        var IdChain = context.Request.QueryString["IdChain"] != null ? context.Request.QueryString["IdChain"].ToString() : "";
        var Link = context.Request.QueryString["Link"] != null ? context.Request.QueryString["Link"].ToString() : "";

        if (String.IsNullOrEmpty(IdChain))
        {
            return;
        }

        var note  = _service.GetNotes(elementId).Where(r=>r.Text=="CallId:" + IdChain).FirstOrDefault();
        if (note != null)
        {
                 var requestNote = new AddOrUpdateNoteRequest(); 
                    requestNote.Update = new List<AddOrUpdateCrmNote>();
                    requestNote.Add = new List<AddOrUpdateCrmNote>();
                    {
                        var _note = new AddOrUpdateCrmNote();
                        _note.ElementId = note.ElementId;
                        _note.ElementType = (int)note.ElementType;
                        _note.Text = "Запись разговора: "+ Link;
                        _note.ResponsibleUserId = note.ResponsibleUserId;
                        _note.NoteType = note.NoteType;
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