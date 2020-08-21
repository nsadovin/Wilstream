using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using CoreWebAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace CoreWebAPI.Controllers
{
    [Route("landpro/[controller]")]
    [ApiController]
    public class LandproSupplyController : ControllerBase
    {
        private ApplicationContext db;
        public LandproSupplyController(ApplicationContext context)
        {
            db = context;
        }
        // GET: api/<LandproSupplyController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<LandproSupplyController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            var supply = db.LandproSupplies.Include(u => u.products).FirstOrDefault(r => r.supply_id == id);
            var json = JsonConvert.SerializeObject(supply);
            
            var content = new StringContent(json, Encoding.UTF8, "application/json");
            new HttpClient().PostAsync("http://...", content);
            return "good";
        }

        // POST api/<LandproSupplyController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<LandproSupplyController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<LandproSupplyController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
