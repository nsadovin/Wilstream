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

    [Table("WS_Cofactor2")]
    public class Cofactor2User
    {
        [Key]
        [Column("Id")]
        public int id { get; set; }
        [Column("UID")]
        public Guid UID { get; set; } 
        [Column("email")]
        public String email { get; set; } 
        [Column("Имя")]
        public String lastname { get; set; } 
        [Column("Фамилия")]
        public String firstname { get; set; } 
        [Column("Отчество")]
        public String patronymic { get; set; } 
        [Column("Телефон")]
        public String phone { get; set; }
    }



    public class Cofactor2UserResponse
    {
        public static Cofactor2UserResponse Creater(Cofactor2User user)
        {
            if (user != null)

                return new Cofactor2UserResponse()
                {
                    email = user.email,
                    firstname = user.firstname,
                    lastname = user.lastname,
                    patronymic = user.patronymic,
                    UID = user.UID,
                    phone = user.phone 
                };
            else
                return new Cofactor2UserResponse()
                {
                    error = "User not found"
                };
        }
        public Guid UID { get; set; }
        [MaxLength(100)]
        public String email { get; set; }
        [MaxLength(100)]
        public String lastname { get; set; }
        [MaxLength(100)]
        public String firstname { get; set; }
        [MaxLength(100)]
        public String patronymic { get; set; }
        public String phone { get; set; }
        public string error { get; set; }
    }
}