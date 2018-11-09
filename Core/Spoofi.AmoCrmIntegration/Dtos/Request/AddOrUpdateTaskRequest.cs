using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.Dtos.Request
{
    public class AddOrUpdateTaskRequest : IAmoCrmRequest
    {
        //[JsonProperty("request")]
        //public AddOrUpdateTaskObject Request { get; set; }

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmTask> Update { get; set; }


        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmTask> Add { get; set; }
    }

    public class AddOrUpdateTaskObject
    {
        //[JsonProperty("Tasks")]
        public AddOrUpdateCrmTasks Tasks { get; set; }
    }

    public class AddOrUpdateCrmTasks
    {
        [JsonProperty("add", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmTask> Add { get; set; }

        [JsonProperty("update", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public List<AddOrUpdateCrmTask> Update { get; set; }
    }

    public class AddOrUpdateCrmTask
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



        [JsonProperty("complete_till_at")]
        public long? CompleteTillAtTimestamp
        {
            get { return CompleteTillAt.GetTimestamp() ?? DateTime.Now.GetTimestamp(); }
            set { CompleteTillAt = value.GetDateTime(); }
        }

        /// <summary>
        ///     Дата, до которой необходимо завершить задачу. Если указано время 23:59, то в интерфейсах системы вместо времени будет отображаться "Весь день".
        /// </summary>
        [JsonIgnore]
        public DateTime? CompleteTillAt { get; set; }


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

        /// <summary>
        ///     Тип задачи
        /// </summary>
        [JsonProperty("task_type", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public int TaskType { get; set; }

        /// <summary>
        ///     Задача завершена или нет
        /// </summary>
        [JsonProperty("is_completed", DefaultValueHandling = DefaultValueHandling.Ignore)]
        public bool IsCompleted { get; set; }
    }
     
     
}