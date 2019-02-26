<%@ WebHandler Language="C#" Class="gank" %>

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

public class gank : IHttpHandler {

    private static readonly AmoCrmConfig Config = new AmoCrmConfig("gank", "dmkolosov@mail.ru", "8bed274348dbe7a2740546af3acd18e723eac262", 10);

    private static int StatusNothandled = 23440957;//22373157;
    private static HttpContext _context  ;

    private readonly IAmoCrmService _service = new AmoCrmService(Config);

    public void ProcessRequest (HttpContext context) {
        _context = context;
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();

        var IdChain = context.Request.QueryString["IdChain"] != null ? context.Request.QueryString["IdChain"].ToString() : "";
        var Link = context.Request.QueryString["Link"] != null ? context.Request.QueryString["Link"].ToString() : "";

        if (String.IsNullOrEmpty(IdChain))
        {
            return;
        }

        var note  = _service.GetNotes("CallId:" + IdChain).Where(r=>r.Text=="CallId:" + IdChain).FirstOrDefault();
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