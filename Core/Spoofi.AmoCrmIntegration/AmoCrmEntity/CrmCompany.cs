namespace Spoofi.AmoCrmIntegration.AmoCrmEntity
{
    using System;
    using System.Collections.Generic;
    using Newtonsoft.Json;
    using Spoofi.AmoCrmIntegration.Interface;
    using Spoofi.AmoCrmIntegration.Misc;
    public class CrmCompany: IAmoCrmEntity
    {

        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }
}