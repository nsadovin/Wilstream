using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LandPro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    protected void DropDownList1_PreRender(object sender, EventArgs e)
    {

    }

    protected void DropDownList1_DataBinding(object sender, EventArgs e)
    {
        var ddl = (sender as DropDownList);
        var val = (ddl.Parent.FindControl("HiddenFieldTypes") as HiddenField).Value;
        if (val != "")
        {
            ddl.Items.AddRange(val.Split(';').Select(r=> new ListItem(r,r)).ToArray());
        }
    }

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        var data = e;
        var keys = e.Keys.Keys;
        var supple_id = e.Keys[0].ToString();
        try
        {
            GET("http://vg.wilstream.ru:82/API/landpro/landprosupply/", "id=" + supple_id);
        }
        catch
        { 
            }
    }

    private static string GET(string Url, string Data)
    {
        System.Net.WebRequest req = System.Net.WebRequest.Create(Url + "?" + Data);
        System.Net.WebResponse resp = req.GetResponse();
        System.IO.Stream stream = resp.GetResponseStream();
        System.IO.StreamReader sr = new System.IO.StreamReader(stream);
        string Out = sr.ReadToEnd();
        sr.Close();
        return Out;
    }
}