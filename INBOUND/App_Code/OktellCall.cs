using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

/// <summary>
/// Сводное описание для OktellCall
/// </summary>
public class OktellCall
{

    private string _AuthUser;
    private string _AuthPassword;

    public OktellCall(string p_user, string p_baseUrl = null)
	{
        baseUrl = p_baseUrl != null ? p_baseUrl 
            //: "http://wil-oktel:4055";
            : "http://85.235.160.204:4055";
        _AuthUser = "WebAPIClient";
        _AuthPassword = "VvqrUM29";
        User = p_user;
	}

    public void wp_switchcall(string number) { 
        string url = baseUrl + "/wp_switchcall?user=" + User + "&number=" + number;
        reqGet(url); 
    }


    public void wp_autocallstop()
    {
        string url = baseUrl + "/wp_autocallstop?user=" + User;
        reqGet(url); 
    }

    public void wp_flash()
    {
        string url = baseUrl + "/wp_flash?user=" + User  ;
        reqGet(url);
    }

    public void wp_return_to_abonent()
    {
        string url = baseUrl + "/wp_flash?user=" + User + "&mode=abort";
        reqGet(url);
    }

    public string tst_getuserstate()
    {
        string url = baseUrl + "/tst_getuserstate?iduser=" + User ;
        
        string xml = reqGet(url);
        XDocument xDocument = XDocument.Parse(xml);
        string vv = xDocument.Element("oktellxmlmapper").Element("data").Element("property_set").Elements("property_simple").Where(p => p.Attribute("key").Value == "state").First().Attribute("name").Value;
        return vv;
    }


    public string linestate()
    {
        string url = baseUrl + "/execsvcscript?name=(Тестовый)%20Садовин&startparam1=" + User + "&async=0&timeout=10"; 
        string xml = reqGet(url);
        XDocument xDocument = XDocument.Parse(xml);
        string vv = xDocument.Element("oktellxmlmapper").Element("data").Element("property_set").Elements("property_cdata").Where(p => p.Attribute("key").Value == "returnvalue").First().Value;
        return vv;
    }




    private string _baseUrl;

    public string baseUrl { get { return _baseUrl; } set { _baseUrl = value; } }

    private string _user;

    public string User { get { return _user; } set { _user = value; } }
     


    private string reqGet(string url) 
    {
         
        System.Net.WebRequest reqGET = System.Net.WebRequest.Create(@url);
        //reqGET.Credentials = System.Net.CredentialCache.DefaultCredentials;/WebAPIClient:VvqrUM29
        //reqGET.Credentials = new System.Net.NetworkCredential("n.sadovin@ws", "Sad0vin2014");
        reqGET.Credentials = new System.Net.NetworkCredential(_AuthUser, _AuthPassword);
        try
        {

            System.Net.WebResponse resp = reqGET.GetResponse();
            System.IO.Stream stream = resp.GetResponseStream();
            System.IO.StreamReader sr = new System.IO.StreamReader(stream);
            string s = sr.ReadToEnd();
            return s;
        }
        catch (System.Net.WebException WE)
        {
            //Сообщение об ошибке
         //   Console.WriteLine(WE.Message);
          //  Console.ReadLine();
            return WE.Message;
        }
    }


}