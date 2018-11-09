using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.AmoCrmEntity
{
    public class CrmTask : IAmoCrmEntity
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("text")]
        public string Text { get; set; }
         

        [JsonProperty("updated_at")]
        public long LastModifiedTimestamp { get; set; }

        public DateTime LastModified
        {
            get { return LastModifiedTimestamp.GetDateTime(); }
            set { LastModifiedTimestamp = value.GetTimestamp(); }
        }
         
        [JsonProperty("responsible_user_id")]
        public long ResponsibleUserId { get; set; }

        [JsonProperty("created_at")]
        public long DateCreateTimestamp { get; set; }

        public DateTime DateCreate
        {
            get { return DateCreateTimestamp.GetDateTime(); }
            set { DateCreateTimestamp = value.GetTimestamp(); }
        }

        [JsonProperty("created_by")]
        public long CreatedUserId { get; set; }




        [JsonProperty("complete_till_at")]
        public long CompleteTillAtTimestamp { get; set; }

        public DateTime CompleteTillAt
        {
            get { return CompleteTillAtTimestamp.GetDateTime(); }
            set { CompleteTillAtTimestamp = value.GetTimestamp(); }
        }



        [JsonProperty("element_id")]
        public long ElementId { get; set; }


        [JsonProperty("element_type")]
        public int ElementType { get; set; }


        [JsonProperty("task_type")]
        public int TaskType { get; set; }



        [JsonProperty("is_completed")]
        public bool IsCompleted { get; set; }



    }
}