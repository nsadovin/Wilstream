﻿using System.Collections.Generic;
using Newtonsoft.Json;

namespace Spoofi.AmoCrmIntegration.Dtos.Response
{
    public class AccountInfoCustomFields
    {
        [JsonProperty("contacts")]
        public List<CustomFieldDto> Contacts { get; set; }

        [JsonProperty("leads")]
        public List<CustomFieldDto> Leads { get; set; }
    }

    public class CustomFieldDto
    {
        [JsonProperty("id")]
        public long Id { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("multiple")]
        public string Multiple { get; set; }

        [JsonProperty("type_id")]
        public long TypeId { get; set; }

        [JsonProperty("enums")]
        public object Enums { get; set; }

        
        [JsonProperty("origin")]
        public object Origin { get; set; }

        [JsonProperty("is_visible")]
        public object IsVisible { get; set; }


        [JsonProperty("is_editable")]
        public object IsEditable { get; set; }

        [JsonProperty("is_required")]
        public object IsRequired { get; set; }
         

    }
}