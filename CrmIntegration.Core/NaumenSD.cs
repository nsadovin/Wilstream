using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks; 

namespace CrmIntegration.Core
{
    public class NaumenSD
    {
        private RestClient restClient;
        private string accessKey;
        public NaumenSD(string AccessKey) {
           
            restClient = new RestClient("https://sd.tanuki.ru/sd/services/rest/");
            accessKey = AccessKey;
           // return;
            var request = new RestRequest("get/{uuid}", Method.GET);
            request.AddParameter("accessKey", accessKey); // adds to POST or URL querystring based on Method
            request.AddUrlSegment("uuid", "serviceCall$7606221"); // replaces matching token in request.Resource
        //    https://sd.tanuki.ru/sd/services/rest/get/serviceCall$2294838?accessKey=ed0ea8b1-27ad-457b-aa5a-09766d02de55
                  // easily add HTTP Headers
                  //   request.AddHeader("header", "value");


            // execute the request
            IRestResponse response = restClient.Execute(request);
            var content = response.Content; // raw content as string

            //var restClient = new Easemob.Restfull4Net.Entity();
        }

        public dynamic GetServiceCall(string UUID, ref string error)
        {
            var request = new RestRequest("get/{uuid}", Method.GET);
            request.AddParameter("accessKey", accessKey); // adds to POST or URL querystring based on Method
            request.AddUrlSegment("uuid", UUID);
            IRestResponse _response = restClient.Execute(request); 
            if (_response.StatusCode == System.Net.HttpStatusCode.OK)
            {
                var content = _response.Content; // raw content as string
                dynamic result = JsonConvert.DeserializeObject<dynamic>(content);
                return result;
            }
            else
            {
                error = _response.ErrorMessage;
            }
            return "";
        }

        public string UpdateServiceCall(string UUID, string DescriptionRTF, string ShortDescr, string Urgency, ref string error)
        {
            var request = new RestRequest("edit/{UUID}/{attributes}/", Method.POST);

            request.AddParameter("accessKey", accessKey);
             

            var data = new
            {
                descriptionRTF = DescriptionRTF,
                shortDescr = ShortDescr, 
                urgency = Urgency
            };
            var attributes = JsonConvert.SerializeObject(data);
            request.RequestFormat = DataFormat.Json;
            request.AddHeader("Content-type", "application/json");
            request.AddParameter("Application/Json", attributes, ParameterType.RequestBody);

            request.AddUrlSegment("UUID", UUID);
            request.AddUrlSegment("attributes", attributes); // replaces matching token in request.Resource
                                                             //request.AddJsonBody(data); 
                                                             //  request.AddHeader("Accept", "application/json");

            IRestResponse _response = restClient.Execute(request);
            if (_response.StatusCode == System.Net.HttpStatusCode.Created)
            {
                
                return UUID;
            }
            else
            {
                error = _response.ErrorMessage;
            }
            return "";
        }

        public string AddServiceCall(string DescriptionRTF, string ShortDescr , string Urgency, ref string error)
        {
            var request = new RestRequest("create-m2m/serviceCall/{attributes}/", Method.POST);
            
            request.AddParameter("accessKey", accessKey);
            var call = new 
            {
                descriptionRTF = DescriptionRTF,
                shortDescr = ShortDescr,
                metaClass = "serviceCall$call",
                agreement = new { UUID = "agreement$605301" , title = "IT (8x5)", metaClass = "agreement$agreement"},
                urgency = new {
                    UUID = "urgency$37503",
                    title = "Низкая",
                    metaClass = "urgency",
                    code = "U2"
                },
                client = new {
                    UUID = "ou$2304353",
                    title = "Call-Центр",
                    metaClass = "ou$ou"
                  },
            };

         
            var data = new
            {
                descriptionRTF = DescriptionRTF,
                shortDescr = ShortDescr,
                metaClass = "serviceCall$call",
                agreement = "agreement$605301",
                client =  "ou$2304353" ,
                urgency = Urgency
            };
            var attributes = JsonConvert.SerializeObject(data);
            request.RequestFormat = DataFormat.Json;
            request.AddHeader("Content-type", "application/json");
            request.AddParameter("Application/Json", attributes, ParameterType.RequestBody);

            request.AddUrlSegment("attributes", attributes); // replaces matching token in request.Resource
            //request.AddJsonBody(data); 
            //  request.AddHeader("Accept", "application/json");
            
            IRestResponse _response = restClient.Execute(request);
            if (_response.StatusCode == System.Net.HttpStatusCode.Created)
            {
                var content = _response.Content; // raw content as string
                dynamic result = JsonConvert.DeserializeObject<dynamic>(content);
                return result.UUID.ToString();
            }
            else
            {
                error =_response.ErrorMessage;
            }
            return "";                                //
        }
    }
}
