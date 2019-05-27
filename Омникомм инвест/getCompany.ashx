<%@ WebHandler Language="C#" Class="getCompany" %>

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

public class getCompany : IHttpHandler {

    private static readonly AmoCrmConfig Config = new AmoCrmConfig("omnicrm", "dealer@omnicomm.ru", "cefdc2f47c19370cf472b7b79933eedda1e03aa1", 10);

    private static int StatusNothandled = 23440957;//22373157;
    private static HttpContext _context  ;

    private readonly IAmoCrmService _service = new AmoCrmService(Config);

    public void ProcessRequest(HttpContext context) {
        _context = context;
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();


        var companies = _service.GetCompanies();

        var companiesFilter = companies.Where(r => r.CustomFields.Exists(r1 =>

        //(
        //r1.Name == "Статус контрагента" && r1.Values.Exists(r2 =>
        // r2.Value == "Не заполнено"
        // || r2.Value == "Конечный клиент"
        // || r2.Value == "Партнер-Интегратор" 
        //)
        //)
        //    ||
            (
                r1.Name == "Группа SAP" && r1.Values.Exists(r2 =>
             r2.Value == "Не заполнено"
             || r2.Value == "Клиент"
             || r2.Value == "Интегратор"
            )
            )


        ));



        return;

        var leads = _service.GetLeads(StatusNothandled).OrderByDescending(r => r.DateCreate).Where(r=> r.DateCreate < DateTime.Now.AddMinutes(-10));

        foreach (var lead in leads)
        {
            var contact =  _service.GetContact(lead.MainContactId);
            if(contact!=null && contact.CustomFields.Count(r=>r.Code=="PHONE")>0)
                AddToDataBase(contact.CustomFields.FirstOrDefault(r=>r.Code=="PHONE").Values.FirstOrDefault().Value, lead.Id);
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }

    private void AddToDataBase(string Phone, long IdLead) {
        try
        {
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "IF not exists(select * from [dbo].[WS_Veganza] with(nolock) where IdLead = "+IdLead.ToString()+") INSERT INTO  [dbo].[WS_Ipoteka_not_handled]   (Phone, IdLead) Values ( '8'+right('" + Phone + "',10), "+IdLead.ToString()+")  ";


            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

            myOdbcReader.Close();
            myOdbcConnection.Close();

        }
        catch (Exception ex)
        {
            _context.Response.Write(ex.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}