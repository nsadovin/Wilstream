using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReportTasks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[2].Selected = true;
    }
    protected void btnNewTask_Click(object sender, EventArgs e)
    {
        lblTask.Text = "Новая задача";
        dvTask.ChangeMode(DetailsViewMode.Insert);
        dvTask.DataBind();
        mvTasks.ActiveViewIndex = 1;
    }
    protected void dvTask_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        mvTasks.ActiveViewIndex = 0;
        gwTasks.DataBind();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        lblTask.Text = "Редактирование задачи, " + (sender as Button).ToolTip;
        mvTasks.ActiveViewIndex = 1;
        dvTask.ChangeMode(DetailsViewMode.Edit);
        dvTask.DataBind();
    }
    protected void dvTask_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
        {
            mvTasks.ActiveViewIndex = 0;
            gwTasks.SelectedIndex = -1;
            gwTasks.DataBind();
        }
    }
    protected void dvTask_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        mvTasks.ActiveViewIndex = 0;
        gwTasks.SelectedIndex = -1;
        gwTasks.DataBind();
    }
    protected void btnBackToTasks_Click(object sender, EventArgs e)
    {
        mvTasks.ActiveViewIndex = 0;
        gwTasks.SelectedIndex = -1;
        gwTasks.DataBind();
    }
    protected void btnToProjects_Click(object sender, EventArgs e)
    {
        mvTasks.ActiveViewIndex = 2;
        hfIdTask.Value = (sender as Button).CommandArgument;
        LabelProjects.Text = (sender as Button).CommandName;
    }
    protected void SqlDataSourcetaskOktell_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
  }
    protected void dvTaskOktell_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvOktellTasks.DataBind();
    }
    protected void dvTaskOktell_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {

        SqlDataSourcetaskOktell.InsertParameters["Task"].DefaultValue = (dvTaskOktell.Rows[0].FindControl("ddlTasksOktell") as DropDownList).SelectedItem.Text;
  
    }
    protected void dvSkillset_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gvSkillsets.DataBind();
    }
    protected void dvApplication_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        gwApplications.DataBind();
    }
}