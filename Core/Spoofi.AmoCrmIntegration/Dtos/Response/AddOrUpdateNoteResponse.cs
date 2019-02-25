using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class AddOrUpdateNoteResponse : AmoCrmResponseBase<CrmAddOrUpdateNoteResponseChild>
    {
        [JsonProperty("_embedded")]
        public override CrmAddOrUpdateNoteResponseChild Response { get; set; }  
    }

    public class CrmAddOrUpdateNoteResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("items")]
        public List<AddedOrUpdatedNote> Tasks { get; set; }

        [JsonProperty("error")]
        public dynamic Error { get; set; }
    }

    public class AddedOrUpdatedNote
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
    public class AddedOrUpdatedNotes
    {
        [JsonProperty("add")]
        public List<AddedTask> Add { get; set; }
    }

    public class AddedNote
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
}