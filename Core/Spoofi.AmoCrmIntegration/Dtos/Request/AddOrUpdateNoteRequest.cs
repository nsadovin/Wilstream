using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.Dtos.Request
{
    public class AddOrUpdateNoteRequest : IAmoCrmRequest
    {
        //[JsonProperty("request")]
        //public AddOrUpdateTaskObject Request { get; set; }

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmNote> Update { get; set; }


        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmNote> Add { get; set; }
    }

    public class AddOrUpdateNoteObject
    {
        //[JsonProperty("Tasks")]
        public AddOrUpdateCrmNotes Tasks { get; set; }
    }

    public class AddOrUpdateCrmNotes
    {
        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmNote> Add { get; set; }

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmNote> Update { get; set; }
    }

    public class AddOrUpdateCrmNote
    {
        /// <summary>
        ///     Идентификатор обновляемой задачи
        /// </summary>
        [JsonProperty("id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long Id { get; set; }

        /// <summary>
        ///     Текст задачи
        /// </summary>
        [JsonProperty("text")]
        public string Text { get; set; }


        /// <summary>
        /// Тип добавляемого события.    
        /// </summary>
        [JsonProperty("note_type", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long NoteType { get; set; }

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
        public long? LastModifiedTimestamp
        {
            get { return LastModified.GetTimestamp() ?? DateTime.Now.GetTimestamp(); }
            set { LastModified = value.GetDateTime(); }
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

        /// <summary>
        ///     Уникальный идентификатор сделки
        /// </summary>
        [JsonProperty("element_id", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public long ElementId { get; set; }



        /// <summary>
        ///     Тип привязываемого элемента (1 - контакт, 2- сделка, 3 - компания, 12 - покупатель)
        /// </summary>
        [JsonProperty("element_type", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public int ElementType { get; set; }

         
    }
     
     
}