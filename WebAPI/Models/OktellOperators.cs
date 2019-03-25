using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Text;
using log4net;
using log4net.Config;

namespace WebAPI.Models
{
    public class OktellOperators
    {

        private static ILog log = LogManager.GetLogger("LOGGER");

        public static IEnumerable<Operator> GetReadyOperators()
        {
            
            
            var rslt = new List<Operator>();
            List<Guid> users_id = new List<Guid>();
            users_id.Add(Guid.Parse("F947931E-CDDF-4BA4-BD0B-6E9171BA5824")); 

            foreach (var user_id in users_id)
            {
                var xml = request(user_id);
                OktellOperators.log.Debug(xml);
                var obj = Parse(xml);
                rslt.Add(new Operator() { OperatorId = user_id, OperatorStatus = obj.Data.PropertySet.PropertySimple.FirstOrDefault(r => r.key == "state").name });
                //rslt.Add(new Operator() { OperatorId = Guid.Empty, OperatorStatus = xml });

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
            string rslt = "";  
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://192.168.3.3:4055/tst_getuserstate?iduser=" + user_id); 
           // HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://sadovin.ru/?iduser=" + user_id); 
            string username = "sadovin";
            string password = "azsxdcfv890"; 
            string svcCredentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(username + ":" + password)); 
            request.Headers.Add("Authorization", "Basic " + svcCredentials);
              
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (Stream stream = response.GetResponseStream())
            {
                using (StreamReader reader = new StreamReader(stream))
                {
                    string line = "";
                    while ((line = reader.ReadLine()) != null)
                    {
                        rslt += line!=null?line:"";
                    }
                }
            }
            response.Close();
            return rslt;
        }

        public static KeyValuePair<bool, Guid> setOperatorDialog(Guid user_id)
        {
            var xml = requestScript(user_id);
            OktellOperators.log.Debug(xml);
            var obj = Parse(xml);
            OktellOperators.log.Debug(obj.Data.PropertySet.PropertyCData.ToString());
            if (obj.Data.PropertySet.PropertyCData.ToString() != "-1")
                return new KeyValuePair<bool, Guid>(true, Guid.Parse(obj.Data.PropertySet.PropertyCData.ToString().Replace("![CDATA[", "").Replace("]]", "")));
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
 <property_cdata key=""returnvalue""><![CDATA[f947931e-cddf-4ba4-bd0b-6e9171ba5824]]></property_cdata>    </property_set>  </data></oktellxmlmapper>";
 return @"<?xml version=""1.0"" encoding=""utf-16""?>
<oktellxmlmapper version=""80710"">
  <data name=""result"" count=""1"">
    <property_set name=""execsvcscript"">
      <property_simple key=""started"" value=""1"" name=""success"" />
      <property_simple key=""startresult"" value=""0"" name=""success"" />
      <property_simple key=""returnvalue"" name=""f947931e-cddf-4ba4-bd0b-6e9171ba5824"" />
    </property_set>
  </data>
</oktellxmlmapper>";

 <?xml version="1.0" encoding="utf-16"?>
 <oktellxmlmapper version="80710">  
 <data name="result" count="1">    
 <property_set name="execsvcscript">      
 <property_simple key="started" value="1" name="success" />      
 <property_simple key="startresult" value="0" name="success" />      
 <property_cdata key="returnvalue"><![CDATA[f947931e-cddf-4ba4-bd0b-6e9171ba5824]]></property_cdata>    </property_set>  </data></oktellxmlmapper>
             */
            string rslt = ""; 
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://192.168.3.3:4055/execsvcscript?name=chat2desk_set_operator_to_task&async=0&startparam1=" + user_id);
            string username = "sadovin";
            string password = "azsxdcfv890";
            string svcCredentials = Convert.ToBase64String(ASCIIEncoding.ASCII.GetBytes(username + ":" + password));
            request.Headers.Add("Authorization", "Basic " + svcCredentials);

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (Stream stream = response.GetResponseStream())
            {
                using (StreamReader reader = new StreamReader(stream))
                {
                    string line = "";
                    while ((line = reader.ReadLine()) != null)
                    {
                        rslt += line;
                    }
                }
            }
            response.Close();
            return rslt;
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
        [XmlElement("property_set")]
        public OktellPropertySet PropertySet { get; set; } 
    }


    [Serializable]
    public class OktellPropertySet
    {
        
        [XmlElement("property_simple", typeof(OktellPropertySimple))]
        public OktellPropertySimple[] PropertySimple { get; set; } 

        [XmlElement("property_cdata", typeof(string))]
        public string PropertyCData { get; set; }


    }

    [Serializable]
    public class OktellPropertyCData
    {
        [XmlAttribute]
        public string key { get; set; }
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