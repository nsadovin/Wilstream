using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CoreWebAPI.Controllers
{
    [Route("landpro/[controller]")]
    [ApiController]
    public class LandproOrderController : ControllerBase
    {
        private ApplicationContext db;
        public LandproOrderController(ApplicationContext context)
        {
            db = context;
        }
        // GET: api/<LandproOrderController>
        [HttpGet]
        public IEnumerable<LandproOrder> Get()
        {
            return db.LandproOrders.ToList();
        }

        // GET api/<LandproOrderController>/5
        [HttpGet("{id}")]
        public LandproOrder Get(int id)
        {
            return db.LandproOrders.FirstOrDefault(r=>r.id == id);
        }

        // POST api/<LandproOrderController>
        [HttpPost]
        public void Post(List<LandproOrder> orders)
        {
            orders.ForEach(r => r.supplies.ForEach(s => s.update_DeliveryTypes()));
            db.LandproOrders.AddRange(orders);
            db.SaveChanges();
        }

        // PUT api/<LandproOrderController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<LandproOrderController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
