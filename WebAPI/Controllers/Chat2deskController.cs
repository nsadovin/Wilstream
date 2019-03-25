using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPI.Models;

namespace WebAPI.Controllers
{
    public class Chat2deskController : ApiController
    {
        // GET api/values
        public IEnumerable<Operator> Get()
        {
            return OktellOperators.GetReadyOperators();
        }

        // GET api/chat2desk/5
        public string Get(int id)
        {
            return "value";
        }


        // PUT api/values/5
        public dynamic Put(Guid id)
        {
            var rslt = OktellOperators.setOperatorDialog(id);
            return new { Status = rslt.Key, OperatorId = rslt.Value };
        }
    }
}
