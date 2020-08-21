using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebAPI.Models;
using System.Web.Http;
using System.Web.UI.WebControls;
using System.IO;
using log4net;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace WebAPI.Controllers
{
    [Route("landpro/landproorder")]
    public class LandproOrderController : ApiController
    {
        ApplicationContext db = new ApplicationContext();
        private static ILog log = LogManager.GetLogger("LOGGER");
        // GET: api/<LandproOrderController>
        [HttpGet]
        public IEnumerable<LandproOrder> Get()
        {
            return db.LandproOrders.ToList();
        }

        // GET api/<LandproOrderController>/5
        [HttpGet]
        public LandproOrder Get(int id)
        {
            return db.LandproOrders.FirstOrDefault(r=>r.id == id);
        }

        // POST api/<LandproOrderController>
        [HttpPost]
        public IHttpActionResult Post(List<LandproOrder> orders)
        {
            orders.ForEach(r => r.supplies.ForEach(s => s.update_DeliveryTypes())); 
            log.Debug("LandproOrder new: " + Request.Content.ToString()); 
            db.LandproOrders.AddRange(orders);
            db.SaveChanges();

            return Ok();
        }

        // PUT api/<LandproOrderController>/5
        [HttpPut]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<LandproOrderController>/5
        [HttpDelete]
        public void Delete(int id)
        {
        }
    }
}
