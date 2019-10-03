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

        private static ILog log = LogManager.GetLogger("AlfaCapital");
        WsDbContext db = new WsDbContext();
        // GET: api/AlfaCapital
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/AlfaCapital/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/AlfaCapital
        public int Post(AlfaCapital value)
        {
            db.AlfaCapitals.Add(value);
            db.SaveChanges();
            return value.Id;
        }

        // PUT: api/AlfaCapital/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/AlfaCapital/5
        public void Delete(int id)
        {
        }
    }
}
