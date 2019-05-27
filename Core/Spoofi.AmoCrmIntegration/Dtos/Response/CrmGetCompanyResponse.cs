using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Interface;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class CrmGetCompanyResponse : AmoCrmResponseBase<CrmCompanyResponseChild>
    {
        public override CrmCompanyResponseChild Response { get; set; }
    }

    public class CrmCompanyResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("companies")]
        public List<CrmCompany> Companies { get; set; }

        [JsonProperty("error")]
        public dynamic Error { get; set; }
    }
}