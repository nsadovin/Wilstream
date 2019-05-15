using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;

public partial class Realtime : System.Web.UI.Page
{

    public List<Operator> Operators;

    protected void Page_Load(object sender, EventArgs e)
    {
        Operators = GetReadyOperators();
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        //     Page.ClientScript.RegisterClientScriptBlock(this.GetType(),  "chartsUpdate", "<script>  drawChartAll();   </script>");
    }

    private List<Tuple<Guid, String>> GetOperatorsId(int line = 1)
    {
        var rslt = new List<Tuple<Guid,String>>();
        try
        {
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktell_ccwsConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand();
            myOdbcCommand.Connection = myOdbcConnection;
            myOdbcCommand.CommandType = CommandType.Text;
            if(line==1)
            myOdbcCommand.CommandText = "SELECT  t2.Id, t2.Name FROM [oktell_settings].[dbo].[A_TaskManager_Operators] t1 WITH(NOLOCK), oktell_cc_temp.dbo.A_Cube_CC_Cat_OperatorInfo t2 with(nolock) 	WHERE t1.OperatorId = t2.Id and TaskId = 'B78D18B8-64AC-4A81-982E-A6C0987F2107'";
            if (line == 2)
                myOdbcCommand.CommandText = "SELECT  t2.Id, t2.Name FROM [OKTELL_DB1.WILSTREAM.RU].[oktell_settings].[dbo].[A_TaskManager_Operators] t1 WITH(NOLOCK), [OKTELL_DB1.WILSTREAM.RU].oktell_cc_temp.dbo.A_Cube_CC_Cat_OperatorInfo t2 with(nolock) 	WHERE t1.OperatorId = t2.Id and TaskId = 'CDDB70E2-4CB8-4664-A966-442A83FA7D94'";
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {  
                rslt.Add(new Tuple<Guid, String> (myOdbcReader.GetGuid(0), myOdbcReader.GetString(1)));
            }

            myOdbcReader.Close();
            myOdbcConnection.Close();
            return rslt;
        }
        catch (Exception ex)
        {
            return new List<Tuple<Guid, String>>();
        }
    }

    public List<Operator> GetReadyOperators()
    {
        var rslt = new List<Operator>();
        List<Guid> users_id = new List<Guid>();
        var op = GetOperatorsId(1);
        users_id = op.Select(r=>r.Item1).ToList();

        foreach (var user_id in users_id)
        {
            var xml = request(user_id); 
            var obj = Parse(xml);
            rslt.Add(new Operator() { OperatorId = user_id, Name = op.FirstOrDefault(r=>r.Item1==user_id).Item2, OperatorStatus = obj.Data.PropertySet.PropertySimple.FirstOrDefault(r => r.key == "state").name });
            //rslt.Add(new Operator() { OperatorId = Guid.Empty, OperatorStatus = xml });

        }
        op = GetOperatorsId(2);
        users_id = op.Select(r => r.Item1).ToList();

        foreach (var user_id in users_id)
        {
            var xml = request(user_id,2);
            var obj = Parse(xml);
            rslt.Add(new Operator() { OperatorId = user_id, Name = op.FirstOrDefault(r => r.Item1 == user_id).Item2, OperatorStatus = obj.Data.PropertySet.PropertySimple.FirstOrDefault(r => r.key == "state").name });
            //rslt.Add(new Operator() { OperatorId = Guid.Empty, OperatorStatus = xml });

        }

        return rslt;
    }

    private oktellxmlmapper Parse(string xml)
    {
        oktellxmlmapper obj = null;
        XmlSerializer serializer = new XmlSerializer(typeof(oktellxmlmapper));
        using (StringReader stringReader = new StringReader(xml))
        {
            obj = (oktellxmlmapper)serializer.Deserialize(stringReader);
        }
        return obj;
    }


    private   string request(Guid user_id, int nline = 1)
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
        string username = "sadovin";
        string password = "azsxdcfv890";
        string host = "";
        if (nline == 1)
        {
            username = "sadovin";
            password = "azsxdcfv890";
            host = "192.168.3.3:4055";
        }
        else if(nline == 2)
        {
            username = "nsadovin";
            password = "ns8inNS8IN";
            host = "192.168.13.41:4055";
        } 
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://"+ host + "/tst_getuserstate?iduser=" + user_id);
        // HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://sadovin.ru/?iduser=" + user_id); 
        
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
                    rslt += line != null ? line : "";
                }
            }
        }
        response.Close();
        return rslt;
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

    public class Operator
    {
        public Guid OperatorId { get; set; }
        public String Name { get; set; }
        public String OperatorStatus { get; set; }
    }
}