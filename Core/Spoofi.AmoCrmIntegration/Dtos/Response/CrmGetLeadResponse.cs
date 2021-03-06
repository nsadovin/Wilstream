﻿using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Interface;


namespace Spoofi.AmoCrmIntegration.Dtos.Response
{ 

    public class CrmGetLeadResponse : AmoCrmResponseBase<CrmLeadResponseChild>
    { 
        [JsonProperty("response")]
        public override CrmLeadResponseChild Response { get; set; }
    }

    public class CrmLeadResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("leads")]
        public List<CrmLead> Leads { get; set; }

        [JsonProperty("errors")]
        public dynamic Error { get; set; }
    }
}
