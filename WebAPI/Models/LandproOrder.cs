using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPI.Models
{
    public class LandproOrder
    {
       
        [Key]
        public int order_id { get; set; }
        [Required]
        public int id { get; set; }
        [Required]
        public string userName { get; set; }
        [Required]
        public string phone { get; set; }
        [Required]
        public List<LandproSupply> supplies { get; set; }


        public float totalSum { get; set; }



    }
}
