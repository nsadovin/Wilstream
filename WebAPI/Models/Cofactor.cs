using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    [Table("WS_Cofactor")]
    public class CofactorUser
    {
        [Key]
        [Column("Id")]
        public int id { get; set; }
        [Column("Uid")]
        public Guid uid { get; set; }
        [MaxLength(100)]
        [Column("Email")]
        public String email { get; set; }
        [MaxLength(100)]
        [Column("Lastname")]
        public String lastname { get; set; }
        [MaxLength(100)]
        [Column("Firstname")]
        public String firstname { get; set; }
        [MaxLength(100)]
        [Column("Patronymic")]
        public String patronymic { get; set; }
    }
     
    public class CofactorUserResponse
    {
        public static CofactorUserResponse Creater(CofactorUser user) {
            if (user != null)

                return new CofactorUserResponse()
                {
                    email = user.email,
                    firstname = user.firstname,
                    lastname = user.lastname,
                    patronymic = user.patronymic,
                    uid = user.uid,
                    status = 200
            };            
            else
                return new CofactorUserResponse()
                {
                    status = 404
                };
        } 
        public Guid uid { get; set; }
        [MaxLength(100)] 
        public String email { get; set; }
        [MaxLength(100)] 
        public String lastname { get; set; }
        [MaxLength(100)] 
        public String firstname { get; set; }
        [MaxLength(100)] 
        public String patronymic { get; set; } 
        public int status { get; set; }
    }

    [Table("WS_Cofactor_Stat")]
    public class CofactorStat
    {
        [Key]
        [Column("Id")]
        public int id { get; set; }
        [Column("Prid")]
        public string prid { get; set; }
        [Column("Uid")]
        public Guid uid { get; set; } 
        [Column("Duration")]
        public int duration { get; set; } 
        [Column("Data")]
        public String data { get; set; }
        [Column("DtCreated")]
        public DateTime created { get; set; }
    }

     
    public class CofactorStatRequest
    {  
        public string prid { get; set; } 
        public Guid uid { get; set; } 
        public int duration { get; set; } 
        public List<CofactorSlideStat> data { get; set; } 
    }

    public class CofactorSlideStat
    {
        public string slide_id { get; set; }  
        public IEnumerable<IDictionary<String, Object>> userdata { get; set; }

    }


     
    public class CofactorStatResponse : JsonResponse
    {
        public static CofactorStatResponse Creator(CofactorStat  stat) {
            return new CofactorStatResponse()
            {
                creation_date = stat.created,
                duration = stat.duration,
                prid = stat.prid,
                uid = stat.uid,
                data = JsonConvert.DeserializeObject<List<CofactorSlideStat>>(stat.data),
                status = 200
            };
        }
        public string prid { get; set; } 
        public Guid uid { get; set; } 
        public int duration { get; set; } 
        public List<CofactorSlideStat> data { get; set; } 
        public DateTime creation_date { get; set; }
    }

    public class JsonResponse
    { 
        public int status { get; set; }
    }


}