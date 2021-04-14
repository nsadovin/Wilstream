using System.Collections.Generic;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Interface;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class AddOrUpdateLeadV2Response : AmoCrmResponseBase<CrmAddOrUpdateLeadV2ResponseChild>
    {
        [JsonProperty("_embedded")]
        public override CrmAddOrUpdateLeadV2ResponseChild Response { get; set; }
    }

    public class CrmAddOrUpdateLeadV2ResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("items")]
        public List<AddedOrUpdatedLead> Leads { get; set; }

        [JsonProperty("errors")]
        public dynamic Error { get; set; }
    }


    //{"_links":{"self":{"href":"/api/v2/leads","method":"post"}},"_embedded":{"items":[],"errors":{"update":{"21388995":"Last modified date is older than in database"}}}}
    public class AddOrUpdateLeadResponse : AmoCrmResponseBase<CrmAddOrUpdateLeadResponseChild>
    {
        [JsonProperty("response")]
        public override CrmAddOrUpdateLeadResponseChild Response { get; set; }

       // [JsonProperty("_embedded")]
     //   public override CrmAddOrUpdateLeadResponseChild Response { get; set; }
    }

    public class CrmAddOrUpdateLeadResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("leads")]
        public AddedOrUpdatedLeads Leads { get; set; }

        [JsonProperty("errors")]
        public dynamic Error { get; set; }
    }
      

public class AddedOrUpdatedLead
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }

    public class AddedOrUpdatedLeads
    {
        [JsonProperty("add")]
        public List<AddedLead> Add { get; set; }

        [JsonProperty("update")]
        public List<AddedLead> Update { get; set; }
    }


    public class UpdatedLead
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }

        [JsonProperty("errors")]
        public List<ErrorLead> Errors { get; set; }
    }

    public class ErrorLead
    {
        [JsonProperty("code")]
        public long Code { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }         
    }

    public class AddedLead
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("request_id")]
        public long RequestId { get; set; }
    }
}
