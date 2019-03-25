using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebAPI.Models
{
    public class OktellOperators
    {


        public static IEnumerable<Operator> GetReadyOperators()
        {
            var rslt = new List<Operator>();
            List<Guid> users_id = new List<Guid>();
            users_id.Add(Guid.Parse("F947931E-CDDF-4BA4-BD0B-6E9171BA5824")); 

            foreach (var user_id in users_id)
            {
                var xml = request(user_id);
                var obj = Parse(xml);
                rslt.Add(new Operator() { OperatorId = user_id, OperatorStatus = obj.Data.OktellPropertySimple.FirstOrDefault(r => r.key == "state").name });

            }
            return rslt;
        }

        private static oktellxmlmapper Parse(string xml)
        {
            oktellxmlmapper obj = null;
            XmlSerializer serializer = new XmlSerializer(typeof(oktellxmlmapper));
            using (StringReader stringReader = new StringReader(xml))
            {
                obj = (oktellxmlmapper)serializer.Deserialize(stringReader);
            }
            return obj;
        }


        private static string request(Guid user_id)
        {
           /* return @"<?xml version=""1.0"" encoding=""utf-16""?>
<oktellxmlmapper version=""80710"">
  <data name=""userstate"" count=""1"">
    <property_set name=""user"" id=""f947931e-cddf-4ba4-bd0b-6e9171ba5824"">
      <property_simple key=""id"" value=""f947931e-cddf-4ba4-bd0b-6e9171ba5824"" />
      <property_simple key=""state"" value=""1"" name=""usReady"" />
    </property_set>
  </data>
</oktellxmlmapper>";*/
            string line = ""; 
            CookieContainer myContainer = new CookieContainer();
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://192.168.3.3:4055/tst_getuserstate?iduser=" + user_id);
            request.Credentials = new NetworkCredential("sadovin", "azsxdcfv890");
            request.CookieContainer = myContainer;
            request.PreAuthenticate = true;
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (Stream stream = response.GetResponseStream())
            {
                using (StreamReader reader = new StreamReader(stream))
                {

                    while ((line = reader.ReadLine()) != null)
                    {
                        line += line;
                    }
                }
            }
            response.Close();
            return line;
        }

        public static KeyValuePair<bool, Guid> setOperatorDialog(Guid user_id)
        {
            var xml = requestScript(user_id);
                var obj = Parse(xml);  
            if(obj.Data.OktellPropertySimple.FirstOrDefault(r => r.key == "returnvalue").name!="")
                return new KeyValuePair<bool, Guid>(true, Guid.Parse(obj.Data.OktellPropertySimple.FirstOrDefault(r => r.key == "returnvalue").name));
            else 
                return new KeyValuePair<bool, Guid>(false, Guid.Empty);
        }


        private static string requestScript(Guid user_id)
        {
            /*return @"<?xml version=""1.0"" encoding=""utf-16""?>
<oktellxmlmapper version=""80710"">
  <data name=""result"" count=""1"">
    <property_set name=""execsvcscript"">
      <property_simple key=""started"" value=""1"" name=""success"" />
      <property_simple key=""startresult"" value=""0"" name=""success"" />
      <property_simple key=""returnvalue"" name=""f947931e-cddf-4ba4-bd0b-6e9171ba5824"" />
    </property_set>
  </data>
</oktellxmlmapper>";*/
            string line = "";
            CookieContainer myContainer = new CookieContainer();
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://192.168.3.3:4055/execsvcscript?name=chat2desk_set_operator_to_task&async=1&startparam1=" + user_id);
            request.Credentials = new NetworkCredential("sadovin", "azsxdcfv890");
            request.CookieContainer = myContainer;
            request.PreAuthenticate = true;
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (Stream stream = response.GetResponseStream())
            {
                using (StreamReader reader = new StreamReader(stream))
                {

                    while ((line = reader.ReadLine()) != null)
                    {
                        line += line;
                    }
                }
            }
            response.Close();
            return line;
        }

    }



    [Serializable]
    public class oktellxmlmapper
    {
        [XmlElement("data")]
        public OktellData Data { get; set; }

    }

    [Serializable]
    public class OktellData
    {
        [XmlArray("property_set")]
        [XmlArrayItem("property_simple", typeof(OktellPropertySimple))]
        public OktellPropertySimple[] OktellPropertySimple { get; set; }


    }

    [Serializable]
    public class OktellPropertySimple
    {
        [XmlAttribute]
        public string key { get; set; }
        [XmlAttribute]
        public string value { get; set; }
        [XmlAttribute]
        public string name { get; set; }
    }

    public class Operator {
        public Guid OperatorId {get; set;}
        public String OperatorStatus {get; set;}
    }
}