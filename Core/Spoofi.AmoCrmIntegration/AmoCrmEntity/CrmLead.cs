using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.AmoCrmEntity
{
    public class CrmLead : IAmoCrmEntity
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("responsible_user_id")]
        public long ResponsibleUserId { get; set; }

        [JsonProperty("updated_at")]
        public long LastModifiedTimestamp { get; set; } 

        public DateTime LastModified
        {
            get { return LastModifiedTimestamp.GetDateTime(); }
            set { LastModifiedTimestamp = value.GetTimestamp(); }
        } 

        [JsonProperty("account_id")]
        public long AccountId { get; set; }


        [JsonProperty("created_at")]
        public long DateCreateTimestamp { get; set; }

        public DateTime DateCreate
        {
            get { return DateCreateTimestamp.GetDateTime(); }
            set { DateCreateTimestamp = value.GetTimestamp(); }
        } 

        [JsonProperty("created_by")]
        public long CreatedUserId { get; set; }  

        [JsonProperty("tags", NullValueHandling = NullValueHandling.Ignore)]
        public List<CrmTag> Tags { get; set; }

        


        [JsonProperty("is_deleted")]
        public bool IsDeleted { get; set; } 

        [JsonProperty("group_id")]
        public Int32 GroupId { get; set; }

        [JsonProperty("closed_at")]
        public long ClosedAt { get; set; }

        [JsonProperty("status_id")]
        public Int32 StatusId { get; set; }


        [JsonProperty("pipeline_id")]
        public Int32 PipelineId { get; set; }

        [JsonProperty("sale")]
        public Int32 Sale { get; set; }

        [JsonProperty("main_contact")]
        public CrmMainContact MainContact { get; set; }

        public long MainContactId
        {
            get { return MainContact.id; }
            set { MainContact.id = value; }
        } 

        [JsonProperty("contacts")]
        public CrmContacts Contacts { get; set; }   
        

        [JsonProperty("custom_fields", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<CrmCustomField> CustomFields { get; set; }



        [JsonProperty("pipeline")]
        public CrmPipeline Pipeline { get; set; }

    }


    public class CrmMainContact
    {
        [JsonProperty("id")]
        public long id { get; set; }
    }

    public class CrmContacts  
    {
        [JsonProperty("id")]
        public List<long> Ids { get; set; } 
    }
     

}
