namespace CoreWebAPI.Models
{
    using Newtonsoft.Json;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public class LandproSupply
    {
        [JsonIgnore]
        [Key]
        public int supply_id { get; set; }
        [Required]
        public int id { get; set; }
        [Required]
        public string status { get; set; }
        public string postalCode { get; set; }
        public string administrativeArea { get; set; }
        public string settlement { get; set; }
        public string street { get; set; }
        public string house { get; set; }
        [JsonIgnore]
        [Column("deliveryTypes")]
        public String _deliveryTypes { get; set; }
        [Required]
        public List<LandproProduct> products { get; set; }
        [NotMapped]
        [JsonIgnore]
        public List<string> deliveryTypes { get; set; }
        public string deliveryType { get; set; }

        public void update_DeliveryTypes()
        {
            _deliveryTypes = String.Join(';', deliveryTypes);
        }
        public void updateDeliveryTypes()
        {
            deliveryTypes = _deliveryTypes.Split(';').ToList(); 
        }
    }
}