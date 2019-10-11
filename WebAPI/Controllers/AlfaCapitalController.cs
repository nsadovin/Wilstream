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


        // PUT api/values/5
        public void Put(AlfaCapital call)
        {
            log.Debug("update call: " + call.ToString());
            try
            {
                var _call = db.AlfaCapitals.FirstOrDefault(r=>r.Id == call.Id);

                if (_call != null)
                {
                    _call.Partner = call.Partner;
                    _call.Stage = call.Stage;
                    _call.Timestamp = call.Timestamp;
                    _call.State = call.State;
                    _call.ScheduledTime = call.ScheduledTime;
                    _call.Error = call.Error;
                    _call.FIO = call.FIO;
                    _call.Task = call.Task;
                    _call.MOBILE = call.MOBILE;

                    db.SaveChanges();
                }
                return;
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return;
            }
        }


    }
}
