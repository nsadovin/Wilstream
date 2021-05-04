using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebAPI.Models
{
    public class LandproOrderV2
    { 
        [Required] public int id { get; set; }

        [Required] public UserLanpro user { get; set; }

        [Required] public List<LandproProductV2> products { get; set; }

        [Required] public int price { get; set; }

        [Required] public int deliveryPrice { get; set; } 

        [Required] public string paymentType { get; set; }

        [Required] public List<string> deliveryType { get; set; }
  }

    [ComplexType]
    public class UserLanpro
    {
        public string name { get; set; }
        public string phone { get; set; }
    }



    [Table("WS_LandproOrder")]
    public class DbLandproOrderV2
    {
        [Key] public int order_id { get; set; }

        [Required] public int id { get; set; }


        public string status { get; set; }
        public string postalCode { get; set; }
        public string street { get; set; }
        public string settlement { get; set; }
        public string administrativeArea { get; set; }
        public string house { get; set; }
        public string comment { get; set; }


        [Required] public UserLanpro user { get; set; }

        [Required] public List<DbLandproProductV2> products { get; set; }


        [Required] public int price { get; set; }

        [Required] public int deliveryPrice { get; set; }
        [Required] public string paymentType { get; set; }

        [Required] public string deliveryTypes { get; set; }
        public string deliveryType { get; set; }
    }





    
    public class LandproOrderDto
    {    
        [Required] public int id { get; set; }

        [Required]
        public string status { get; set; }
        public string postalCode { get; set; }
        public string street { get; set; }
        public string settlement { get; set; }
        public string administrativeArea { get; set; }
        public string house { get; set; }
        public string comment { get; set; }
         

        public List<LandproProductDto> products { get; set; }


        [Required] public int price { get; set; }

        [Required] public int deliveryPrice { get; set; }
         
        public string deliveryType { get; set; }
    }

}