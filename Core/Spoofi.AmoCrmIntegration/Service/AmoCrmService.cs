using System.Collections.Generic;
using System.Linq;
using System.Threading;
using RestSharp;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Methods;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.Service
{
    public class AmoCrmService : IAmoCrmService
    {
        private readonly AmoCrmConfig _crmConfig;

        public AmoCrmService(AmoCrmConfig crmConfig)
        {
            _crmConfig = crmConfig;
        }

        public CrmAccountInfo GetAccountInfo()
        {
            var accountInfo = AmoMethod.Get<CrmGetAccountInfoResponse>(_crmConfig);
            if (accountInfo == null || accountInfo.Response == null)
                throw new AmoCrmException(AmoCrmErrors.Unknown);
            return accountInfo.Response.Account;
        }

        public IEnumerable<CrmUser> GetCrmUsers()
        {
            return GetAccountInfo().Users;
        }


        public IEnumerable<CrmLead> GetLeads()
        {
            var leads = new List<CrmLead>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var leadsList = AmoMethod.Get<CrmGetLeadResponse>(_crmConfig);
                if (leadsList == null)
                    break;
                leads.AddRange(leadsList.Response.Leads);
            }
            return leads;
        }

        public IEnumerable<CrmPipeline> GetPipelines()
        {
            var pipelines = new List<CrmPipeline>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var pipelinesList = AmoMethod.Get<CrmGetPipeLineResponse>(_crmConfig); 
                
                pipelines.AddRange(pipelinesList.Response.Pipelines.Select(t=>t.Value).ToList());
                break;
            }
            return pipelines;
        }
        

        public IEnumerable<CrmLead> GetLeads(string query)
        {
            var leads = new List<CrmLead>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterQuery = new Parameter { Name = "query", Value = query, Type = ParameterType.QueryString };
                var leadsList = AmoMethod.Get<CrmGetLeadResponse>(_crmConfig, parameterQuery);
                if (leadsList == null)
                    break;
                leads.AddRange(leadsList.Response.Leads);
            }
            return leads;
        }


        public IEnumerable<CrmLead> GetLeads(int status)
        {
            var leads = new List<CrmLead>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterQuery = new Parameter { Name = "status", Value = status.ToString(), Type = ParameterType.QueryString };
                var leadsList = AmoMethod.Get<CrmGetLeadResponse>(_crmConfig, parameterQuery);
                if (leadsList == null)
                    break;
                leads.AddRange(leadsList.Response.Leads);
            }
            return leads;
        }


        public CrmLead GetLead(long leadId)
        {
            var parameterId = new Parameter { Name = "id", Value = leadId, Type = ParameterType.QueryString };
            var leadsList = AmoMethod.Get<CrmGetLeadResponse>(_crmConfig, parameterId);
            if (leadsList == null) return null;
            return leadsList.Response.Leads.FirstOrDefault();
        }
         


        public CrmCompany GetCompany(long companyId)
        {
            var parameterId = new Parameter { Name = "id", Value = companyId, Type = ParameterType.QueryString };
            var company = AmoMethod.Get<CrmGetCompanyResponse>(_crmConfig, parameterId);
            return company.Response.Companies.FirstOrDefault();
        }

        public IEnumerable<CrmCompany> GetCompanies()
        {
            var companies = new List<CrmCompany>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var companiesList = AmoMethod.Get<CrmGetCompanyResponse>(_crmConfig);
                if (companiesList == null)
                    break;
                if (companiesList.Response.Error == "Неверный логин или пароль")
                {
                    Thread.Sleep(5000);
                    companiesList = AmoMethod.Get<CrmGetCompanyResponse>(_crmConfig);
                    if (companiesList == null)
                        break;
                }
                companies.AddRange(companiesList.Response.Companies);
                if(offset>0&&offset % 500==0)
                    Thread.Sleep(1000);

                //if (offset > 300)   break;
            }
            return companies;
        }

        public IEnumerable<CrmCompany> GetCompanies(string query)
        {
            var companies = new List<CrmCompany>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterQuery = new Parameter { Name = "query", Value = query, Type = ParameterType.QueryString };
                var companiesList = AmoMethod.Get<CrmGetCompanyResponse>(_crmConfig, parameterQuery);
                if (companiesList == null)
                    break;
                companies.AddRange(companiesList.Response.Companies);
                if (offset > 0 && offset % 1000 == 0)
                    Thread.Sleep(1000);
            }
            return companies;
        }

        public IEnumerable<CrmContact> GetContacts()
        {
            var contacts = new List<CrmContact>();
            for (var offset = 0;; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var contactsList = AmoMethod.Get<CrmGetContactResponse>(_crmConfig);
                if (contactsList == null)
                    break;
                contacts.AddRange(contactsList.Response.Contacts);
            }
            return contacts;
        }

        public IEnumerable<CrmContact> GetContacts(string query)
        {
            var contacts = new List<CrmContact>();
            for (var offset = 0;; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterQuery = new Parameter {Name = "query", Value = query, Type = ParameterType.QueryString};
                var parameterEntity = new Parameter {Name = "entity", Value = "contacts", Type = ParameterType.QueryString};
                Parameter[] params_ = new Parameter[]{ parameterQuery , parameterEntity };
                var contactsList = AmoMethod.Get<CrmGetContactResponse>(_crmConfig, params_);
                if (contactsList == null)
                    break;
                contacts.AddRange(contactsList.Response.Contacts);
            }
            return contacts;
        }

        public IEnumerable<CrmContact> GetContacts(long responsibleUserId)
        {
            var contacts = new List<CrmContact>();
            for (var offset = 0;; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterResponsibleUserId = new Parameter {Name = "responsible_user_id", Value = responsibleUserId, Type = ParameterType.QueryString};
                var contactsList = AmoMethod.Get<CrmGetContactResponse>(_crmConfig, parameterResponsibleUserId);
                if (contactsList == null)
                    break;
                contacts.AddRange(contactsList.Response.Contacts);
            }
            return contacts;
        }

        public IEnumerable<CrmNote> GetNotes(long elementId)
        {
            var notes = new List<CrmNote>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterResponsibleUserId = new Parameter { Name = "element_id", Value = elementId, Type = ParameterType.QueryString };
                var contactsList = AmoMethod.Get<CrmGetNoteResponse>(_crmConfig, parameterResponsibleUserId);
                if (contactsList == null)
                    break;
                notes.AddRange(contactsList.Response.Notes);
            }
            return notes;
        }

         

        public IEnumerable<CrmNote> GetNotes(string query)
        {
            var notes = new List<CrmNote>();
            for (var offset = 0; ; offset += _crmConfig.LimitRows ?? 500)
            {
                _crmConfig.LimitOffset = offset;
                var parameterResponsibleUserId = new Parameter { Name = "query", Value = query, Type = ParameterType.QueryString };
                var contactsList = AmoMethod.Get<CrmGetNoteResponse>(_crmConfig, parameterResponsibleUserId);
                if (contactsList == null)
                    break;
                notes.AddRange(contactsList.Response.Notes);
            }
            return notes;
        }

        public CrmContact GetContact(long contactId)
        {
            var parameterId = new Parameter {Name = "id", Value = contactId, Type = ParameterType.QueryString};
            var contact = AmoMethod.Get<CrmGetContactResponse>(_crmConfig, parameterId);
            return contact?.Response?.Contacts?.FirstOrDefault();
        }


        public List<AddedOrUpdatedCompany> AddOrUpdateCompany(AddOrUpdateCompanyRequest addOrUpdateCompanyRequest)
        {
            var request = addOrUpdateCompanyRequest;
            var response = AmoMethod.Post<AddOrUpdateCompanyResponse>(request, _crmConfig);
            return response.Response.Companies;
        }

        public List<AddedOrUpdatedContact> AddOrUpdateContact(AddOrUpdateContactRequest addOrUpdateContactRequest)
        {
            var request = addOrUpdateContactRequest;
            var response = AmoMethod.Post<AddOrUpdateContactResponse>(request, _crmConfig);
            return response.Response.Contacts;
        }


        public List<AddedOrUpdatedLead> AddOrUpdateLead(AddOrUpdateLeadRequest addOrUpdateLeadRequest)
        {
            var request = addOrUpdateLeadRequest;
            var response = AmoMethod.Post<AddOrUpdateLeadResponse>(request, _crmConfig);

            long id = 0;
            if (addOrUpdateLeadRequest.Request.Leads.Add != null)
                id = response.Response.Leads.Add.First().Id;
            else 
                id = response.Response.Leads.Update.First().Id;
            return new List<AddedOrUpdatedLead>()
                {new AddedOrUpdatedLead() {Id = id}};

            //return response.Response.Leads;
        }


        public List<AddedOrUpdatedLead> AddOrUpdateLeadV2(AddOrUpdateLeadRequest addOrUpdateLeadRequest)
        {
            var request = addOrUpdateLeadRequest;
            var response = AmoMethod.Post<AddOrUpdateLeadV2Response>(request, _crmConfig);

            long id = 0;
            if (addOrUpdateLeadRequest.Add != null)
                id = response.Response.Leads.First().Id;
            else
                id = response.Response.Leads.First().Id;
            return new List<AddedOrUpdatedLead>()
                {new AddedOrUpdatedLead() {Id = id}};
        }

        public List<AddedOrUpdatedTask> AddOrUpdateTask(AddOrUpdateTaskRequest addOrUpdateTaskRequest)
        {
            var request = addOrUpdateTaskRequest;
            var response = AmoMethod.Post<AddOrUpdateTaskResponse>(request, _crmConfig);
            return response.Response.Tasks;
        }

        public List<AddedOrUpdatedNote> AddOrUpdateNote(AddOrUpdateNoteRequest addOrUpdateNoteRequest)
        {
            var request = addOrUpdateNoteRequest;
            var response = AmoMethod.Post<AddOrUpdateNoteResponse>(request, _crmConfig);
            return response.Response.Tasks;
        }

    }
}