using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class AddOrUpdateCompanyResponse : AmoCrmResponseBase<CrmAddOrUpdateCompanyResponseChild>
    {
        [JsonProperty("_embedded")]
        public override CrmAddOrUpdateCompanyResponseChild Response { get; set; }  
    }

    public class CrmAddOrUpdateCompanyResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("items")]
        public List<AddedOrUpdatedCompany> Companies { get; set; }

        [JsonProperty("error")]
        public dynamic Error { get; set; }
    }

    public class AddedOrUpdatedCompany
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
    public class AddedOrUpdatedCompanys
    {
        [JsonProperty("add")]
        public List<AddedCompany> Add { get; set; }
    }

    public class AddedCompany
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
}