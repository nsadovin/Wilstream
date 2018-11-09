using System; 
using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Misc;

namespace Spoofi.AmoCrmIntegration.AmoCrmEntity
{
    public class CrmPipeline
    {
        [JsonProperty("id")]
        public long id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("statuses")]
        public Dictionary<string,CrmLeadStatus> CrmLeadStatus { get; set; }
    }
}
