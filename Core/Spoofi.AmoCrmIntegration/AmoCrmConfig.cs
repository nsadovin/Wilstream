using System;
using System.Collections.Generic;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration
{
    public class AmoCrmConfig
    {
        public AmoCrmConfig(string subdomain, string userLogin, string userHash, int? limitRows = 500, int? limitOffset = 0, DateTime? modifiedSince = null)
        {
            Subdomain = subdomain;
            UserLogin = userLogin;
            UserHash = userHash;
            LimitRows = limitRows;
            LimitOffset = limitOffset;
            ModifiedSince = modifiedSince;
        }

        private string Subdomain { get; set; }

        internal string UserLogin { get; set; }

        internal string UserHash { get; set; }

        public string AuthUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/auth.php?type=json", Subdomain); }
        }

        private string AccountCurrentUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/accounts/current?", Subdomain); }
        }

        public string TasksListUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/tasks/list?", Subdomain); }
        }

        public string ContactEventsListUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/notes/list?type=contact", Subdomain); }
        }

        public string LeadEventsListUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/notes/list?type=lead", Subdomain); }
        }

        public string UpdateTaskUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/tasks/set", Subdomain); }
        }

        private string ContactsListUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/contacts/list?", Subdomain); }
        }

        private string LeadsListUrl
        {
          //  get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/leads/list?", Subdomain); }
            get { return string.Format("https://{0}.amocrm.ru/api/v2/leads", Subdomain); }
        }


        private string NotesListUrl
        {
                get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/notes/list?type=lead&note_type=4", Subdomain); }
          //  get { return string.Format("https://{0}.amocrm.ru/api/v2/notes?type=lead", Subdomain); }
        }


        private string PipeLinesUrl
        {
            //  get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/leads/list?", Subdomain); }
            get { return string.Format("https://{0}.amocrm.ru/api/v2/pipelines", Subdomain); }
        }


        public string SetContactUrl
        {
            //get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/contacts/set", Subdomain); }
            get { return string.Format("https://{0}.amocrm.ru/api/v2/contacts/", Subdomain); } 
        }
        public string SetLeadUrl
        {
            //get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/leads/set", Subdomain); }
            get { return string.Format("https://{0}.amocrm.ru/api/v2/leads/", Subdomain); }
        }
         
        public string SetTaskUrl
        {
           // get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/tasks/set", Subdomain); }
            get { return string.Format("https://{0}.amocrm.ru/api/v2/tasks/", Subdomain); }
        }
        public string SetNoteUrl
        {
            // get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/notes/set", Subdomain); }
            get { return string.Format("https://{0}.amocrm.ru/api/v2/notes/", Subdomain); }
        }

        public string DealUrl
        {
            get { return string.Format("https://{0}.amocrm.ru/private/api/v2/json/leads/list?", Subdomain); }
        }

        public bool IsReady
        {
            get { return (UserHash.HasValue() && UserLogin.HasValue() && Subdomain.HasValue()); }
        }

        public int? LimitRows { get; set; }

        public int? LimitOffset { get; set; }

        public DateTime? ModifiedSince { get; set; }

        internal string GetUrl<T>() where T : class, IAmoCrmResponse
        {
            string result;
            var typeDictionary = new Dictionary<Type, string>
            {
                {typeof (CrmGetAccountInfoResponse), AccountCurrentUrl},
                {typeof (CrmGetContactResponse), ContactsListUrl},
                {typeof (CrmGetNoteResponse), NotesListUrl},
                {typeof (CrmGetLeadResponse), LeadsListUrl},
                {typeof (CrmGetPipeLineResponse), PipeLinesUrl}, 
                {typeof (AddOrUpdateLeadResponse), SetLeadUrl},
                {typeof (AddOrUpdateContactResponse), SetContactUrl},
                {typeof (AddOrUpdateTaskResponse), SetTaskUrl},
                {typeof (AddOrUpdateNoteResponse), SetNoteUrl}
            };
            typeDictionary.TryGetValue(typeof (T), out result);
            return result;
        }
    }
}