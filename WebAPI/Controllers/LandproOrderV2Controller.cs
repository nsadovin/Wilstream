using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Web.Http.Results;
using log4net;
using WebAPI.Models; 

namespace WebAPI.Controllers
{
    [Route("landpro/v2/landproorder")]
    public class LandproOrderV2Controller : ApiController
    {
        private static readonly ILog log = LogManager.GetLogger("LOGGER");
        private readonly ApplicationContext db = new ApplicationContext();


        // POST api/<LandproOrderController>
        [HttpPost]
        public IHttpActionResult Post(List<LandproOrderV2> orders)
        {

            var dbOrders = orders.Select(x => new DbLandproOrderV2()
            {
                id = x.id,
                user = x.user,
                products = x.products.Select(p => new DbLandproProductV2()
                {
                  id = p.id, 
                  price = p.price, 
                  name = p.name, 
                  quantity = p.quantity,
                  deliveryName = p.deliveryName,
                  category = p.category,
                  vendor = p.vendor,
                  description = p.description
                }).ToList(),
                price = x.price,
                deliveryPrice = x.deliveryPrice,
                paymentType = x.paymentType,
                deliveryTypes = string.Join(",", x.deliveryType)

            }).ToList();
             
            log.Debug("LandproOrderV2 new: " +  System.Web.Helpers.Json.Encode(orders) );
            try
            {

                db.DbLandproOrders.AddRange(dbOrders);
                db.SaveChanges();
                return Ok();
            }
            catch (Exception e)
            {
                log.Error(e);
                return InternalServerError();
            }

        }


        // GET api/<LandproSupplyController>/5
        [HttpGet]
        public string Get(int id)
        {
            var order = db.DbLandproOrders.Include("products").Where(r => r.order_id == id).Select(x => new LandproOrderDto()
            {
                id = x.id,
                status = x.status,
                postalCode = x.postalCode,
                street = x.street,
                settlement = x.settlement,
                administrativeArea = x.administrativeArea,
                house = x.house,
                comment = x.comment,
                price = x.price,
                deliveryPrice = x.deliveryPrice,
                deliveryType = x.deliveryType,
                products = x.products.Select(p => new LandproProductDto()
                {
                    id = p.id,
                    quantity = p.quantity,
                    name = p.name,
                    price = p.price
                }).ToList()
            }).ToList().FirstOrDefault();

            //пересчитаем сумму
            order.price = order.products.Sum(x => x.price * x.quantity);

            var json = System.Web.Helpers.Json.Encode(order);

            log.Debug("LandproOrder v2 update: " + json);

            var content = new StringContent(json, Encoding.UTF8, "application/json");
            var httpResponseMessage = new HttpClient().PostAsync("https://sw.landpro.site/update-order", content);

            log.Debug("LandproOrder update result: " + httpResponseMessage.Result.StatusCode.ToString());
            return "good";
        }
    }
}