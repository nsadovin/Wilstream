using log4net;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPI.Models;


namespace WebAPI.Controllers
{
    public class Cofactor2Controller : ApiController
    {
        private static ILog log = LogManager.GetLogger("Cofactor2");
        WsDbContext db = new WsDbContext();
        // GET api/Cofactor?uid=0fa74214-175c-4981-8055-89b8acffedb9
        public Cofactor2UserResponse Get(Guid uid)
        {
            log.Debug("Request get user info. Uid is " + uid);
            var user = db.Cofactor2Users.FirstOrDefault(r => r.UID == uid);

            return Cofactor2UserResponse.Creater(user);
        }
        
        // GET api/Cofactor?email=vesdehod@mail.ru
        [HttpGet]
        public Cofactor2UserResponse email(String email)
        {
            
            ;
            
                log.Debug("Request get user info. email is " + email);
                var query = db.Cofactor2Users.Where(r => r.email == email);
             
            return Cofactor2UserResponse.Creater(query.FirstOrDefault());
        }
        // GET api/Cofactor?phone=vesdehod@mail.ru
        [HttpGet]
        public Cofactor2UserResponse phone(String phone)
        {

                log.Debug("Request get user info. phone is " + phone);
                var query = db.Cofactor2Users.Where(r => r.phone == phone);
            return Cofactor2UserResponse.Creater(query.FirstOrDefault());
        }
        // GET api/Cofactor?email=vesdehod@mail.ru
        public List<Cofactor2User> Get()
        {
            log.Debug("Request get all user info.");
            return db.Cofactor2Users.ToList(); 
        }


        // PUT api/values/5
       
        public IHttpActionResult Post(Cofactor2User user)
        {



            if (user == null)
            {
                log.Error("user is empty");
                return BadRequest();
            }
            log.Debug("update user: " + user.ToString());


            try
            {
                var _user = db.Cofactor2Users.FirstOrDefault(r => r.UID == user.UID);






                if (_user != null)
                {
                     
                    ModelState.Remove("user.Id");
                    if(user.firstname!=null)
                    _user.firstname = user.firstname;
                    if (user.email != null)
                        _user.email = user.email;
                    if (user.patronymic != null)
                        _user.patronymic = user.patronymic;
                    if (user.lastname != null)
                        _user.lastname = user.lastname;
                    if (user.phone != null)
                        _user.phone = user.phone; 


                    if (!ModelState.IsValid)
                    {
                        log.Error("user is not valid");
                        return BadRequest(ModelState);
                    }


                    db.SaveChanges();
                    return Ok();
                }
                else
                {
                    log.Error("user not found");
                    return BadRequest("user not found");
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return BadRequest();
            }
        }

    }
}
