<%@ WebHandler Language="C#" Class="UpdateCaompanyName" %>

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

public class UpdateCaompanyName : IHttpHandler {

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
        var rows = GetCompanies();
        int importCnt = 0;
        foreach (var row in rows) {
            try
            {
                var company_ = _service.GetCompany(row.Key);
                
                    context.Response.Write("CompanyId: " + row.Key.ToString() + " CompanyName: " + row.Value.ToString() + "<br/>");
                    var request = new AddOrUpdateCompanyRequest();
                    var updateCompany = new AddOrUpdateCrmCompany();
                    updateCompany.Contacts = company_.Contacts;
                    updateCompany.CustomFields = company_.CustomFields;
                    updateCompany.Id = company_.Id; 
                    updateCompany.Tags = "Call center";
                    updateCompany.Name = company_.Name;
                    request.Add = new List<AddOrUpdateCrmCompany>();
                    request.Update = new List<AddOrUpdateCrmCompany>();
                    request.Update.Add(updateCompany);
                    _service.AddOrUpdateCompany(request);
                    importCnt++;
                  
            }
            catch (Exception ex) { 
                context.Response.Write(ex.Message);
            }
        }
        context.Response.Write("Good" +importCnt.ToString());
    }

    string GetDigital(string subjectString) {
        string resultString = null;
        try {
            Regex regexObj = new Regex(@"[^\d]");
            resultString = regexObj.Replace(subjectString, "");
        } catch (ArgumentException ex) {
            // Syntax error in the regular expression
        }
        return resultString;
    }



    private Dictionary<int, string> GetCompanies() {
        try
        {
            //    return new Dictionary<int, string>() { { 36859361, "ws test update" } };
            var rows = new Dictionary<int, string>();
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "select CompanyId, Name from [dbo].[WS_OmnicommInvest] with(nolock)  where [Текущий статус] is null";


            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                rows.Add(myOdbcReader.GetInt32(0),myOdbcReader.GetString(1));

            }
            myOdbcReader.Close();
            myOdbcConnection.Close();

            return rows;

        }
        catch (Exception ex)
        {
            _context.Response.Write(ex.Message);
            return new Dictionary<int, string>();
        }
    }



    private void AddToDataBase(CrmCompany crmCompany,string Phones, string NameLPR) {
        try
        {
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "IF not exists(select * from [dbo].[WS_OmnicommInvest] with(nolock) where CompanyId = "+crmCompany.Id.ToString()+")"+
                    " INSERT INTO  [dbo].[WS_OmnicommInvest]   (DTAdded, Phones, CompanyId, Name, [Статус контрагента],[Группа SAP],[ФИО ЛПР]) Values (getDate(), '"
                    + Phones + "', "
                    +crmCompany.Id.ToString()+", '"
                    +crmCompany.Name.ToString()+"',  '"
                    +(crmCompany.CustomFields.Count(r=>r.Name=="Статус контрагента")>0? crmCompany.CustomFields.FirstOrDefault(r=>r.Name=="Статус контрагента").Values.FirstOrDefault().Value:"")+"',  '"
                    +(crmCompany.CustomFields.Count(r=>r.Name=="Группа SAP")>0? crmCompany.CustomFields.FirstOrDefault(r=>r.Name=="Группа SAP").Values.FirstOrDefault().Value:"")+"','"+NameLPR+"')  ";


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