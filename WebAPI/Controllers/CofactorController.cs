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
   // [Authorize]
    public class CofactorController : ApiController
    {

        private static ILog log = LogManager.GetLogger("Cofactor");
        WsDbContext db = new WsDbContext();
        // GET api/Cofactor?uid=0fa74214-175c-4981-8055-89b8acffedb9
        public CofactorUserResponse Get(Guid uid)
        {
            log.Debug("Request get user info. Uid is " + uid);
            var user = db.CofactorUsers.FirstOrDefault(r => r.uid == uid);
            
            return CofactorUserResponse.Creater(user);
        }

         
        [HttpPost]
        public JsonResponse Publish(CofactorStatRequest stat)
        {
            log.Debug("Request post user stat. Stat is " + JsonConvert.SerializeObject(stat));
            try
            {
                Guid uid = stat.uid;
                var user = db.CofactorUsers.FirstOrDefault(r => r.uid == uid);
                if (user != null)
                {
                    
                    var dbStat =  db.CofactorStats.FirstOrDefault(r => r.uid == uid && r.prid == stat.prid);
                    if (dbStat == null)
                    {
                        dbStat = new CofactorStat();
                        db.CofactorStats.Add(dbStat);
                    }
                    dbStat.created = DateTime.Now;
                    dbStat.uid = uid;
                    dbStat.prid = stat.prid;
                    dbStat.duration = stat.duration;
                    dbStat.data = JsonConvert.SerializeObject(stat.data);
                    db.SaveChanges();
                }
                else 
                    return new JsonResponse() { status = 404 };
            }
            catch (Exception ex)
            {
                log.Error(ex);

                return new JsonResponse() { status = 400 };
            }
            return  new JsonResponse() { status = 200 };
        }

        [HttpDelete]
        public JsonResponse Clear(Guid uid, string prid)
        {
            log.Debug("Request delete user stat. Uid is " + uid + " and prid is "+prid);
            try
            { 
                var user = db.CofactorUsers.FirstOrDefault(r => r.uid == uid);
                if (user != null)
                {

                    var dbStat = db.CofactorStats.FirstOrDefault(r => r.uid == uid && r.prid == prid);
                    if (dbStat != null)
                    {
                        db.CofactorStats.Remove(dbStat);
                        db.SaveChanges();

                        log.Debug("Request delete user stat is successed. Uid is " + uid + " and prid is " + prid);
                    }
                   
                }
                else
                    return new JsonResponse() { status = 404 };
            }
            catch (Exception ex)
            {
                log.Error(ex);

                return new JsonResponse() { status = 400 };
            }

            return new JsonResponse() { status = 200 };
        }


        [HttpGet]
        public CofactorStatResponse Show(Guid uid, string prid)
        {
            log.Debug("Request show user stat. Uid is " + uid + " and prid is " + prid);
            try
            {
                var user = db.CofactorUsers.FirstOrDefault(r => r.uid == uid);
                if (user != null)
                {
                    
                    var dbStat = db.CofactorStats.FirstOrDefault(r => r.uid == uid && r.prid == prid);
                    if (dbStat != null)
                    {

                        log.Debug("Request show user stat is successed. Uid is " + uid + " and prid is " + prid);
                        return CofactorStatResponse.Creator(dbStat);
                    }
                    else
                        return new CofactorStatResponse() { status = 404 };

                }
                else
                    return new CofactorStatResponse() { status = 404 };
            }
            catch (Exception ex)
            {
                log.Error(ex);

                return new CofactorStatResponse() { status = 400 };
            }
             
        }
    }
}
