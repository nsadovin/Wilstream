﻿namespace Spoofi.AmoCrmIntegration.AmoCrmEntity
{
    using System;
    using System.Collections.Generic;
    using Newtonsoft.Json;
    using Spoofi.AmoCrmIntegration.Interface;
    using Spoofi.AmoCrmIntegration.Misc;
    public class CrmCompany: IAmoCrmEntity
    {

        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("responsible_user_id")]
        public long ResponsibleUserId { get; set; }

        [JsonProperty("created_at")]
        public long DateCreateTimestamp { get; set; }

        public DateTime DateCreate
        {
            get { return DateCreateTimestamp.GetDateTime(); }
            set { DateCreateTimestamp = value.GetTimestamp(); }
        }

        [JsonProperty("updated_at")]
        public long LastModifiedTimestamp { get; set; }

        public DateTime LastModified
        {
            get { return LastModifiedTimestamp.GetDateTime(); }
            set { LastModifiedTimestamp = value.GetTimestamp(); }
        }

        [JsonProperty("tags")]
        public List<CrmTag> Tags { get; set; }

        [JsonProperty("leads_id")]
        public string LeadsId { get; set; }

        [JsonProperty("customers_id")]
        public string CustomersId { get; set; }


        [JsonProperty("contacts")]
        public CrmCompanyContacts Contacts { get; set; }

        [JsonProperty("custom_fields")]
        public List<CrmCustomField> CustomFields { get; set; }


    }

    public class CrmCompanyContacts
    {
        [JsonProperty("id")]
        public List<long> Ids { get; set; }
        [JsonProperty("_links")]
        public CrmCompanyLinks Links { get; set; }
    }

    public class CrmCompanyLinks
    {
        [JsonProperty("self")]
        public CrmCompanySelf Self { get; set; } 
    }

    public class CrmCompanySelf
    {
        [JsonProperty("href")]
        public string Href { get; set; }
        [JsonProperty("method")]
        public string Method { get; set; }
    }
}