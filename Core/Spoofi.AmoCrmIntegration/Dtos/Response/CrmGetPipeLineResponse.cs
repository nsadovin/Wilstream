using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Interface;


namespace Spoofi.AmoCrmIntegration.Dtos.Response
{ 

    public class CrmGetPipeLineResponse : AmoCrmResponseBase<CrmPipeLineResponseChild>
    { 
        [JsonProperty("_embedded")]
        public override CrmPipeLineResponseChild Response { get; set; }
    }

    public class CrmPipeLineResponseChild : IAmoCrmResponseChild
    {
        [JsonProperty("items")] 
        //[JsonConverter(typeof(SupplierDataConverter))]
        public Dictionary<string, CrmPipeline> Pipelines { get; set; }

        [JsonProperty("errors")]
        public dynamic Error { get; set; }
    }

    class SupplierDataConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return true;
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            JToken token = JToken.Load(reader);
            if (token.Type == JTokenType.Object)
            {
                var str = token.ToString();
                return Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, CrmPipeline>>(str);
                //return token.ToObject<Dictionary<string, CrmPipeline>>();
            }
            return null;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            serializer.Serialize(writer, value);
        }
    }
}
