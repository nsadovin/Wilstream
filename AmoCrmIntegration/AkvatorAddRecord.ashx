<%@ WebHandler Language="C#" Class="AkvatorAddRecord" %>
using System;
using System.Web;
using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.Service;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using System.Linq;
using System.Collections.Generic;

public class AkvatorAddRecord : IHttpHandler {

  private static readonly AmoCrmConfig Config = new AmoCrmConfig("akvatorsamara", "danko@akvator.su",
    "ff1d486361e94e2f6a75bf7199ce80f373e68513", 10);

  private static int StatusNothandled = 23440957;//22373157;
  private static HttpContext _context  ;

  private readonly IAmoCrmService _service = new AmoCrmService(Config);

  public void ProcessRequest (HttpContext context) {

    _context = context;

    var IdLead = context.Request.QueryString["IdLead"] != null ? context.Request.QueryString["IdLead"].ToString() : "";
    var Link = context.Request.QueryString["Link"] != null ? context.Request.QueryString["Link"].ToString() : "";

    var phone = context.Request.QueryString["phone"] != null ? context.Request.QueryString["phone"] : "";

    if (phone.Length > 10)
      phone = phone.Substring(phone.Length - 10, 10);


    var lead  = IdLead!=""?_service.GetLead(Convert.ToInt64(IdLead)):null;


    if (phone != "" && lead ==null)
    {
      var leads = _service.GetLeads(phone);
      if (leads != null && leads.Count() > 0)
      {
        lead = leads.OrderBy(x=>x.Id).Last();
      }
      else
      {
        var contact_search = _service.GetContacts(phone).OrderByDescending(r => r.DateCreate).FirstOrDefault();
        if (contact_search != null)
        {
          IdLead = contact_search.leads.Ids.FirstOrDefault().ToString();
          lead = _service.GetLead(Convert.ToInt64(IdLead));
        }
      }
    }


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