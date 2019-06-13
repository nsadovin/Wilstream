<%@ WebHandler Language="C#" Class="getCompany" %>

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

public class getCompany : IHttpHandler {

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


        // var company_ = _service.GetCompany(31118823);
        //    return;
        var companies = _service.GetCompanies();

        var companiesFilter = companies.Where(r => r.CustomFields.Exists(r1 =>

        (
        r1.Name == "Статус контрагента" && r1.Values.Exists(r2 =>
         r2.Value == "Не заполнено"
         || r2.Value == "Конечный клиент"
         || r2.Value == "Партнер-Интегратор"
        )
        )
            ||
            (
                r1.Name == "Группа SAP" && r1.Values.Exists(r2 =>
             r2.Value == "Не заполнено"
             || r2.Value == "Клиент"
             || r2.Value == "Интегратор"
            )
            )


        ));



        var importCnt = 0;
        foreach (var crmCompany in  companiesFilter)
        {
            var NameLPR = "";
            try
            {

                var contacts = new List<string>();
                if (crmCompany.Contacts.Ids != null)
                    foreach (var contactId in crmCompany.Contacts.Ids)
                    {

                        var contact = _service.GetContact(contactId);
                        if (contact.CustomFields != null && contact.CustomFields.Count(r => r.Code == "PHONE") > 0)
                        {
                            var phone = GetDigital(contact.CustomFields.FirstOrDefault(r => r.Code == "PHONE").Values.FirstOrDefault().Value.ToString());
                            if (phone.Length > 9)
                            {
                                phone = "8" + phone.Substring(phone.Length - 10, 10);
                                if (!contacts.Contains(phone))
                                    contacts.Add(GetDigital(phone));
                            }

                        }
                        if (!String.IsNullOrEmpty(contact.Name))
                        {
                                NameLPR = contact.Name;
                        }
                    }

                if (crmCompany.CustomFields != null && crmCompany.CustomFields.Count(r => r.Code == "PHONE") > 0)
                {
                    var phone = GetDigital(crmCompany.CustomFields.FirstOrDefault(r => r.Code == "PHONE").Values.FirstOrDefault().Value);
                    if (phone.Length > 9)
                    {
                        phone = "8" + phone.Substring(phone.Length - 10, 10);
                        if (!contacts.Contains(phone))
                            contacts.Add(GetDigital(phone));
                    }
                }

                if (contacts.Count == 0) continue;
                importCnt++;
                AddToDataBase(crmCompany, String.Join(",", contacts), NameLPR);
                //          break;
            }
            catch (Exception ex)
            {
            }
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
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
                    +crmCompany.CustomFields.FirstOrDefault(r=>r.Name=="Статус контрагента").Values.FirstOrDefault().Value+"',  '"
                    +crmCompany.CustomFields.FirstOrDefault(r=>r.Name=="Группа SAP").Values.FirstOrDefault().Value+"','"+NameLPR+"')  ";


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