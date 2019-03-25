<%@ WebHandler Language="C#" Class="chat2desk" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using System.Xml;
using System.Xml.Serialization;
using Newtonsoft.Json;

public class chat2desk : IHttpHandler {

    public void ProcessRequest(HttpContext context) {
        context.Response.ContentType = "application/json"; 
        context.Response.Write(GetReadyOperators());
    }


    private string GetReadyOperators()
    {
        var rslt = new Dictionary<Guid, String>();
        List<Guid> users_id = new List<Guid>();
        users_id.Add(Guid.Parse("F947931E-CDDF-4BA4-BD0B-6E9171BA5824"));
        users_id.Add(Guid.Parse("EDB3BDFF-F689-4EF7-96D7-ACEA9D829246"));
         
        foreach (var user_id in users_id)
        {
            var xml = request(user_id);
            var obj =     Parse(xml);
                rslt.Add(user_id, obj.Data.OktellPropertySimple.FirstOrDefault(r => r.key == "state").name);
             
        }
        return JsonConvert.SerializeObject(rslt);
    }

    private oktellxmlmapper Parse (string xml){
        oktellxmlmapper obj = null;
        XmlSerializer serializer = new XmlSerializer(typeof(oktellxmlmapper));
        using (StringReader stringReader = new StringReader(xml))
        {
            obj  = (oktellxmlmapper)serializer.Deserialize(stringReader);
        }
        return obj;
    }


    private  string request(Guid user_id)
    {
        return @"<?xml version=""1.0"" encoding=""utf-16""?>
<oktellxmlmapper version=""80710"">
  <data name=""userstate"" count=""1"">
    <property_set name=""user"" id=""f947931e-cddf-4ba4-bd0b-6e9171ba5824"">
      <property_simple key=""id"" value=""f947931e-cddf-4ba4-bd0b-6e9171ba5824"" />
      <property_simple key=""state"" value=""1"" name=""usReady"" />
    </property_set>
  </data>
</oktellxmlmapper>";
        string line = "";
        WebRequest request = WebRequest.Create("http//sadovin:azsxdcfv890@192.168.3.3:4055/tst_getuserstate?iduser="+user_id);
        WebResponse response = request.GetResponse();
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}