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
        [JsonProperty("request")]
        public AddOrUpdateLeadObject Request { get; set; }

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

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmLead> Update { get; set; }

    }


//    {"response":{"leads":[
// {"id":"22005731",
// "name":"Lead phone 79179404224",
// "date_create":1547795159,
//? "created_user_id":"0",
// "last_modified":1547795159,
//? "account_id":"16419280",
//"price":"",
//"responsible_user_id":"0",
//?"linked_company_id":"",
//?"group_id":-1,
//"pipeline_id":776794,
//?"date_close":0,
//?"closest_task":0,
//?"loss_reason_id":0,
//?"modified_user_id":"0",
//?"deleted":0,
//"tags":[],
//"status_id":26019205,
//?"source_id":null,
//"custom_fields":[],
//"main_contact_id":38172941,
//?"source_data":{"from":"+79179404224","to":1746505,"date":1547795157,"service":"amo_gravitel","duration":"185","link":"https://records.gravitel.ru/record/aquator.gravitel.ru/2019-01-18/e307b8ed-f988-4f02-bef6-2eed6a65631e/78005506035_in_2019_01_18%2D10_02_41_79179404224_tubv.mp3","source":"1547795157","source_uid":"537bcfb4-f3da-47fb-a218-a3cb12907933","uid":null},"category":"sip"}],
//?"server_time":1601390310}}

    public class AddOrUpdateCrmLead
    {
        [JsonProperty("price", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public int Price;

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

        [JsonProperty("date_create", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long? DateCreateTimestamp
        {
            get { return DateCreate.GetTimestamp(); }
            set { DateCreate = value.GetDateTime(); }
        }
          
        [JsonProperty("main_contact_id")]
        public long MainContactId { get; set; }


        [JsonProperty("main_contact")]
        public CrmMainContact MainContact { set { MainContactId = value.id; } get { return new CrmMainContact() { id = MainContactId }; }  }
        /// <summary>
        ///     Дата создания контакта (не обязательный параметр)
        /// </summary>
        [JsonIgnore]
        public DateTime? DateCreate { get; set; }

        [JsonProperty("last_modified")]
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
