using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using WebAPI.Models; 
using Newtonsoft.Json;
using System.Web.Http;
using log4net;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace WebAPI.Controllers
{

    [Route("landpro/landprosupply")] 
    public class LandproSupplyController : ApiController
    {

        private static ILog log = LogManager.GetLogger("LOGGER");
        ApplicationContext db = new ApplicationContext();
         
        // GET: api/<LandproSupplyController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<LandproSupplyController>/5
        [HttpGet]
        public string Get(int id)
        {
            var supply = db.LandproSupplies.Include("products").FirstOrDefault(r => r.supply_id == id);
            var json = JsonConvert.SerializeObject(supply);
             
            json = json.Replace("\"deliveryTypes\":null,", "");

            log.Debug("LandproSupply update: " + json);

            var content = new StringContent(json, Encoding.UTF8, "application/json");
            var httpResponseMessage = new HttpClient().PostAsync("https://sw.landpro.site/update-supply", content);

            log.Debug("LandproSupply update: " + httpResponseMessage.Result.StatusCode.ToString());
            return "good";
        }

        // POST api/<LandproSupplyController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<LandproSupplyController>/5
        [HttpPut]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<LandproSupplyController>/5
        [HttpDelete]
        public void Delete(int id)
        {
        }
    }
}
