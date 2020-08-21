using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using WebAPI.Models;
using AuthorizeAttribute = System.Web.Http.AuthorizeAttribute;

namespace WebAPI.Controllers
{
    [Authorize]
    public class AlfaCapitalController : ApiController
    {

        private static ILog log = LogManager.GetLogger("LOGGER");
        WsDbContext db = new WsDbContext();
        

        // GET: api/AlfaCapital/5
        public IHttpActionResult Get(int id)
        {
            log.Debug("get call: " + id.ToString());
            var call = db.AlfaCapitals.FirstOrDefault(r => r.Id == id);
            if (call == null)
            {
                log.Error("Call not found");
                return BadRequest("Call not found");
            }

            return Ok(call);
        }

        // POST: api/AlfaCapital
        public IHttpActionResult Post(AlfaCapital call)
        { 
            log.Debug("Add new call: "+ call.ToString());
             
            if (call == null)
            {
                log.Error("Call is empty");
                return BadRequest();
            }

            if (!ModelState.IsValid)
            { 
                log.Error("Call is not valid");
                return BadRequest(ModelState);
            }

            try
            {
                call.DateTransferContact = DateTime.Now;
                db.AlfaCapitals.Add(call);
                db.SaveChanges();
                return Ok(call.Id);
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return BadRequest();
            }
        }


        // PUT api/values/5
        public IHttpActionResult Put(AlfaCapital call)
        {



            if (call == null)
            {
                log.Error("Call is empty");
                return BadRequest();
            }
            log.Debug("update call: " + call.ToString());
             

            try
            {
                var _call = db.AlfaCapitals.FirstOrDefault(r=>r.Id == call.Id);






                if (_call != null)
                {
                    if (call.Partner == null) call.Partner = _call.Partner;
                    if (call.Stage == null) call.Stage = _call.Stage;
                    if (call.Timestamp == null) call.Timestamp = _call.Timestamp;
                    if (call.State == null) call.State = _call.State;
                    if (call.ScheduledTime == null) call.ScheduledTime = _call.ScheduledTime;
                    if (call.Error == true) call.Error = _call.Error;
                    if (call.FIO == null) call.FIO = _call.FIO;
                    if (call.Task == null) call.Task = _call.Task;
                    if (call.MOBILE == null) call.MOBILE = _call.MOBILE;
                    if (call.contractnum == null) call.contractnum = _call.contractnum;
                    if (call.contractdate == null) call.contractdate = _call.contractdate;
                    if (call.sitepaymenttype == null) call.sitepaymenttype = _call.sitepaymenttype;
                    if (call.sitepaymentstate == null) call.sitepaymentstate = _call.sitepaymentstate;

                    ModelState.Remove("call.Partner");
                    ModelState.Remove("call.Stage");
                    ModelState.Remove("call.Timestamp");
                    ModelState.Remove("call.ScheduledTime");
                    ModelState.Remove("call.Error");
                    ModelState.Remove("call.FIO");
                    ModelState.Remove("call.Task");
                    ModelState.Remove("call.MOBILE");
                    ModelState.Remove("call.contractnum");
                    ModelState.Remove("call.contractdate");
                    ModelState.Remove("call.sitepaymenttype");
                    ModelState.Remove("call.sitepaymentstate");


                    _call.Partner = call.Partner;
                    _call.Stage = call.Stage;
                    _call.Timestamp = call.Timestamp;
                    _call.State = call.State;
                    _call.ScheduledTime = call.ScheduledTime;
                    _call.Error = call.Error;
                    _call.FIO = call.FIO;
                    _call.Task = call.Task;
                    _call.MOBILE = call.MOBILE;
                    _call.contractnum = call.contractnum;
                    if(call.contractdate!=DateTime.MinValue)
                    _call.contractdate = call.contractdate;
                    _call.sitepaymenttype = call.sitepaymenttype;
                    _call.sitepaymentstate = call.sitepaymentstate;

                     
                    if (!ModelState.IsValid)
                    {
                        log.Error("Call is not valid");
                        return BadRequest(ModelState);
                    }


                    db.SaveChanges();
                    return Ok(); 
                }
                else
                { 
                        log.Error("Call not found");
                        return BadRequest("Call not found"); 
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
