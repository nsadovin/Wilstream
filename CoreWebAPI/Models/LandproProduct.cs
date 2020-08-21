using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace CoreWebAPI.Models
{
    public class LandproProduct
    {
        [JsonIgnore]
        [Key]
        public int product_id { get; set; }
        [Required]
        public int id { get; set; }
        [Required]
        [JsonIgnore]
        public string productName { get; set; }
        [Required]
        public int quantity { get; set; }
    }
}