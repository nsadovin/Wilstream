﻿using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.AmoCrmEntity
{
    public class CrmContact : IAmoCrmEntity
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("company_name")]
        public string CompanyName { get; set; }

        [JsonProperty("last_modified")]
        public long LastModifiedTimestamp { get; set; }

        public DateTime LastModified
        {
            get { return LastModifiedTimestamp.GetDateTime(); }
            set { LastModifiedTimestamp = value.GetTimestamp(); }
        }

        [JsonProperty("account_id")]
        public long AccountId { get; set; }

        [JsonProperty("responsible_user_id")]
        public long ResponsibleUserId { get; set; }
     
        [JsonProperty("created_at")]
        public long DateCreateTimestamp { get; set; }

        public DateTime DateCreate
        {
            get { return DateCreateTimestamp.GetDateTime(); }
            set { DateCreateTimestamp = value.GetTimestamp(); }
        }

        [JsonProperty("created_user_id")]
        public long CreatedUserId { get; set; }

        [JsonProperty("leads")]
        public CrmLeadInfo leads { get; set; }

        [JsonProperty("tags")]
        public List<CrmTag> Tags { get; set; }

        [JsonProperty("Type")]
        public string Type { get; set; }

        [JsonProperty("custom_fields")]
        public List<CrmCustomField> CustomFields { get; set; }
    }

    public class CrmLeadInfo
    {
        [JsonProperty("id")]
        public List<long> Ids { get; set; }
        [JsonProperty("_links")]
        public CrmCompanyLinks Links { get; set; }
    }
}