using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebAPI.Models
{
    public class LandproProductV2
    { 

        [Required] public int id { get; set; }

        [Required] public int price { get; set; }

        [Required] public string name { get; set; }

        [Required] public int quantity { get; set; }
        public string vendor { get; set; }
        public string description { get; set; }
        public string deliveryName { get; set; }
        public string category { get; set; }
  }
   


  [Table("WS_LandproProduct")]
    public class DbLandproProductV2
    {
        [Key] public int product_id { get; set; }

        [Required] public int id { get; set; }

        [Required] public int price { get; set; }

          public string name { get; set; }

        [Required] public int quantity { get; set; }
        public string deliveryName { get; set; }
         public string category { get; internal set; }
       public string vendor { get; internal set; }
       public string description { get; internal set; }
  }
   

  public class LandproProductDto
    { 

        [Required] public int id { get; set; }

        [Required] public int price { get; set; }

        [Required] public string name { get; set; }

        [Required] public int quantity { get; set; }
    }
}