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
    }
    [Table("WS_LandproProduct")]
    public class DbLandproProductV2
    {
        [Key] public int product_id { get; set; }

        [Required] public int id { get; set; }

        [Required] public int price { get; set; }

        [Required] public string name { get; set; }

        [Required] public int quantity { get; set; }
    }
     
    public class LandproProductDto
    { 

        [Required] public int id { get; set; }

        [Required] public int price { get; set; }

        [Required] public string name { get; set; }

        [Required] public int quantity { get; set; }
    }
}