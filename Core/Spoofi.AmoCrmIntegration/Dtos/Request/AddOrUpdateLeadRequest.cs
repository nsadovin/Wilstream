using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.Dtos.Request
{ 
    public class AddOrUpdateLeadRequest : IAmoCrmRequest
    {
       // [JsonProperty("request")]
     //   public AddOrUpdateLeadObject Request { get; set; }

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmLead> Update { get; set; }

        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmLead> Add { get; set; }
    }

    public class AddOrUpdateLeadObject
    {
        [JsonProperty("leads")]
        public AddOrUpdateCrmLeads Leads { get; set; }
    }

    public class AddOrUpdateCrmLeads
    {
        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmLead> Add { get; set; }

        
    }

    public class AddOrUpdateCrmLead
    {
        /// <summary>
        ///     Идентификатор обновляемого лида
        /// </summary>
        [JsonProperty("id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string Id { get; set; }

        /// <summary>
        ///     Имя контакта
        /// </summary>
        [JsonProperty("name")]
        public string Name { get; set; }

        /// <summary>
        ///     Уникальный идентификатор записи в клиентской программе (не обязательный параметр)
        /// </summary>
        [JsonProperty("request_id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long RequestId { get; set; }

        [JsonProperty("created_at", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long? DateCreateTimestamp
        {
            get { return DateCreate.GetTimestamp(); }
            set { DateCreate = value.GetDateTime(); }
        }

        [JsonProperty("main_contact")]
        public CrmMainContact MainContact { get; set; }
        /// <summary>
        ///     Дата создания контакта (не обязательный параметр)
        /// </summary>
        [JsonIgnore]
        public DateTime? DateCreate { get; set; }

        [JsonProperty("updated_at")]
        public long LastModifiedTimestamp
        {
            get { return LastModified.GetTimestamp()  ?? DateTime.Now.GetTimestamp() ; }
            set { LastModified =  value.GetDateTime(); }
        }


        /// <summary>
        ///     Статус сделки
        /// </summary>
        [JsonProperty("status_id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string StatusId { get; set; }




        /// <summary>
        ///     Статус сделки
        /// </summary>
        [JsonProperty("pipeline_id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string PipelineId { get; set; }


        /// <summary>
        ///     Дата последнего изменения контакта (не обязательный параметр)
        /// </summary>
        [JsonIgnore]
        public DateTime? LastModified { get; set; }

        /// <summary>
        ///     Уникальный идентификатор ответственного пользователя
        /// </summary>
        [JsonProperty("responsible_user_id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long ResponsibleUserId { get; set; }
         
         
        /// <summary>
        ///     Название тегов через запятую
        /// </summary>
        [JsonProperty("tags", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string Tags { get; set; }

        /// <summary>
        ///     Дополнительные поля контакта
        /// </summary>
        [JsonProperty("custom_fields", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddLeadCustomField> CustomFields { get; set; }
    }


    public interface IAddCustomField
    {         
        long Id { get; set; } 
        
        List<Object> Values { get; set; }
    }

    public class AddLeadCustomField : IAddCustomField
    {
        [JsonProperty("id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long Id { get; set; }

        [JsonProperty("values", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<Object> Values { get; set; }
    }
     
    public class AddCustomFieldValues
    {
        [JsonProperty("value", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string Value { get; set; }


        [JsonProperty("Enum", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long Enum { get; set; }


        

    } 
    public class AddCustomFieldValuesEnum
    {
        [JsonProperty("value", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string Value { get; set; }


        [JsonProperty("enum", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public string Enum { get; set; }

    }

}
