using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FAQSections : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[1].Selected = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if(e.CommandName == "Cancel")
            MultiView1.ActiveViewIndex = -1;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("~/FAQ.aspx?IdSection="+ GridView1.SelectedDataKey.Value.ToString());
        Response.End();
    }
}