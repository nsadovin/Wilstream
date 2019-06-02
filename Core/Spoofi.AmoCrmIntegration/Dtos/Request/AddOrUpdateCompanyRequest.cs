using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.Dtos.Request
{ 
    public class AddOrUpdateCompanyRequest : IAmoCrmRequest
    {
        // [JsonProperty("request")]
        //   public AddOrUpdateCompanyObject Request { get; set; }

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmCompany> Update { get; set; }

        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmCompany> Add { get; set; }
    }

    public class AddOrUpdateCompanyObject
    {
        [JsonProperty("companies")]
        public AddOrUpdateCrmCompanies Companies { get; set; }
    }

    public class AddOrUpdateCrmCompanies
    {
        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmCompany> Add { get; set; }

        
    }

    public class AddOrUpdateCrmCompany
    {
        /// <summary>
        ///     Идентификатор обновляемого лида
        /// </summary>
        [JsonProperty("id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long Id { get; set; }

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
        ///     Дата последнего изменения контакта (не обязательный параметр)
        /// </summary>
        [JsonIgnore]
        public DateTime? LastModified { get; set; }

        /// <summary>
        ///     Уникальный идентификатор ответственного пользователя
        /// </summary>
        [JsonProperty("responsible_user_id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long ResponsibleUserId { get; set; }



        [JsonProperty("tags")]
        public String Tags { get; set; }
        /// <summary>
        ///     Дополнительные поля контакта
        /// </summary>
        //   [JsonProperty("custom_fields", DefaultValueHandling = DefaultValueHandling.Ignore)]
        //   public List<AddCompanyCustomField> CustomFields { get; set; }




        [JsonProperty("leads_id")]
        public string LeadsId { get; set; }

        [JsonProperty("customers_id")]
        public string CustomersId { get; set; }


        [JsonProperty("contacts")]
        public CrmCompanyContacts Contacts { get; set; }

        [JsonProperty("custom_fields")]
        public List<CrmCustomField> CustomFields { get; set; }



    }



    public class AddCompanyCustomField : IAddCustomField
    {
        [JsonProperty("id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long Id { get; set; }

        [JsonProperty("values", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<Object> Values { get; set; }
    }
       
}
