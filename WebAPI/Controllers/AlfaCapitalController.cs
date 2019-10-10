using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPI.Models;

namespace WebAPI.Controllers
{
    public class AlfaCapitalController : ApiController
    {

        private static ILog log = LogManager.GetLogger("LOGGER");
        WsDbContext db = new WsDbContext();
        

        // GET: api/AlfaCapital/5
        public AlfaCapital Get(int id)
        {
            log.Debug("get call: " + id.ToString());
            return db.AlfaCapitals.FirstOrDefault(r=>r.Id == id);
        }

        // POST: api/AlfaCapital
        public int Post(AlfaCapital call)
        {
            log.Debug("Add new call: "+ call.ToString());
            try
            {
                call.DateTransferContact = DateTime.Now.ToString();
                db.AlfaCapitals.Add(call);
                db.SaveChanges();
                return call.Id;
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return 0;
            }
        }

         
    }
}
