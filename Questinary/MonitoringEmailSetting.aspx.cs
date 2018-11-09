using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MonitoringEmailSetting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[1].Selected = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        DetailsView1.DefaultMode = DetailsViewMode.Insert;
        DetailsView1.ChangeMode(DetailsViewMode.Insert);
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
        DetailsView1.DefaultMode = DetailsViewMode.Edit;
        DetailsView1.ChangeMode(DetailsViewMode.Edit);
        MultiView1.ActiveViewIndex = 0;
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ((sender as DropDownList).Parent.FindControl("TextBox12") as TextBox).Text = (sender as DropDownList).SelectedValue;
    }
    protected void DropDownList4_DataBound(object sender, EventArgs e)
    {
        (sender as DropDownList).SelectedValue = ((sender as DropDownList).Parent.FindControl("TextBox100") as TextBox).Text;
    }
}