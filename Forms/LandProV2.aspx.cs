using DaData.Client;
using System;
using System.Collections.Generic;
using System.Linq; 
using System.Web.UI;
using System.Web.UI.WebControls;
using static DaData.Client.SuggestAddressResponse;

public partial class LandProV2 : System.Web.UI.Page
{

    private SuggestClient _api { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        //var token = "6e970c6ac0f96e9a33da308da7196c4619bfaf6a";
        //var url = "https://suggestions.dadata.ru/suggestions/api/4_1/rs";
        //_api = new SuggestClient(token, url);
    }

    public List<Suggestions> SuggestAddressBoundsTest(string Qquery)
    {
        var query = new AddressSuggestQuery(Qquery); 
        var response = _api.QueryAddress(query); 
        return response.suggestions;
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
            ddl.Items.AddRange(val.Split(',').Select(r=> new ListItem(r,r)).ToArray());
        }
    }

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        var data = e;
        var keys = e.Keys.Keys;
        var supple_id = e.Keys[0].ToString();

        

        try
        {
            if(!Context.Request.Url.Host.Contains("localhost") && Context.Request.QueryString["Debug"]==null)
                GET("http://vg.wilstream.ru:82/API/landpro/v2/landproorder/", "id=" + supple_id); 
            if (Context.Request.Url.Host.Contains("localhost") && Context.Request.QueryString["Debug"] == null)
                GET("http://localhost:49538/landpro/v2/landproorder/", "id=" + supple_id);
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

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        

    }
     
    protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        var gv = (sender as DetailsView);
          
        foreach (TableRow row in gv.Rows)
        foreach (TableCell rowCell in row.Cells)
        {
            foreach (Control rowCellControl in rowCell.Controls)
            {
                if (rowCellControl is GridView)
                {
                    var subGv = (rowCellControl as GridView);
                    foreach (GridViewRow subGvRow in subGv.Rows)
                    {
                        if (subGvRow.RowType == DataControlRowType.DataRow)
                            subGv.UpdateRow(subGvRow.RowIndex, false);
                    }
                }
            }
        }

    }

    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        var data = e;
        var keys = e.Keys.Keys;
        var supple_id = e.Keys[0].ToString();



        try
        {
          //if (!Context.Request.Url.Host.Contains("localhost") && Context.Request.QueryString["Debug"] == null)
                GET("http://vg.wilstream.ru:82/API/landpro/v2/landproorder/", "id=" + supple_id);
            if (Context.Request.Url.Host.Contains("localhost") && Context.Request.QueryString["Debug"] == null)
                GET("http://localhost:49538/landpro/v2/landproorder/", "id=" + supple_id);
        }
        catch
        {
        }
    }
}