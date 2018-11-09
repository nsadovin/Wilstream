using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TaskTabs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[3].Selected = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Projects.aspx");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        mvTabs.ActiveViewIndex = 1;
    }
    protected void dvTab_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        mvTabs.ActiveViewIndex = 0;
    }
    protected void dvTab_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        mvTabs.ActiveViewIndex = 0;
    }
}