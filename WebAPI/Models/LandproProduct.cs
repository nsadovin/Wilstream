using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace WebAPI.Models
{
    public class LandproProduct
    {
         
        [Key]
        public int product_id { get; set; }
        [Required]
        public int id { get; set; }
        
        [Required] 
        public string productName { get; set; }
        [Required]
        public int quantity { get; set; }

      //  public LandproSupply landproSupply { get; set; }
    }
}