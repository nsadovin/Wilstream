using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Interface;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class CrmGetNoteResponse : AmoCrmResponseBase<CrmNoteResponseChild>
    {
        public override CrmNoteResponseChild Response { get; set; }
    }

    public class CrmNoteResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("notes")]
        public List<CrmNote> Notes { get; set; }

        [JsonProperty("error")]
        public dynamic Error { get; set; }
    }
}