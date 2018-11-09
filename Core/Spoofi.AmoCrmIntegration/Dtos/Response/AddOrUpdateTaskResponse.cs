using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class AddOrUpdateTaskResponse : AmoCrmResponseBase<CrmAddOrUpdateTaskResponseChild>
    {
        [JsonProperty("_embedded")]
        public override CrmAddOrUpdateTaskResponseChild Response { get; set; }  
    }

    public class CrmAddOrUpdateTaskResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("items")]
        public List<AddedOrUpdatedTask> Tasks { get; set; }

        [JsonProperty("error")]
        public dynamic Error { get; set; }
    }

    public class AddedOrUpdatedTask
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
    public class AddedOrUpdatedTasks
    {
        [JsonProperty("add")]
        public List<AddedTask> Add { get; set; }
    }

    public class AddedTask
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
}