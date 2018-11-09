using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Projects : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[3].Selected = true;
    }
    protected void GridViewTasks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reports") {
            Response.Redirect("~/TaskReport.aspx?IdTask=" + e.CommandArgument);
        }
        if (e.CommandName == "Settings")
        {
            Response.Redirect("~/TaskSetting.aspx?IdTask=" + e.CommandArgument);
        }
        if (e.CommandName == "Tabs")
        {
            Response.Redirect("~/TaskTabs.aspx?IdTask=" + e.CommandArgument);
        }
    }
    protected void btnAddProject_Click(object sender, EventArgs e)
    {
        mvProjects.ActiveViewIndex = 1;
    }
    protected void btnBackToProjects_Click(object sender, EventArgs e)
    {
        mvProjects.ActiveViewIndex = 0;
        GridViewProjects.DataBind();
    }
    protected void dvProject_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        mvProjects.ActiveViewIndex = 0;
        GridViewProjects.DataBind();
    }
    protected void btnAddNewTask_Click(object sender, EventArgs e)
    {
        mvProjects.ActiveViewIndex = 2;
        var btnAddNewTask = sender as Button;
        var HiddenFieldIdProject = btnAddNewTask.Parent.FindControl("HiddenFieldIdProject") as HiddenField;
        hfIdProject.Value = HiddenFieldIdProject.Value;
    }
    protected void dvTask_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        mvProjects.ActiveViewIndex = 0;
        GridViewProjects.DataBind();
    }
}