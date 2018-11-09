using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ScenarioTypeClient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[4].Selected = true;
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                DetailsView1.ChangeMode(DetailsViewMode.Edit);
                DetailsView1.DataBind();
                Label1.Text = "Тип клиента, " + ((TextBox)DetailsView1.Rows[0].Cells[1].Controls[1]).Text;
            }

        }
    }



    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        Response.Redirect("~/ScenarioTypeClients.aspx");
    }
    protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
            Response.Redirect("~/ScenarioTypeClients.aspx");
    }
    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {

        Response.Redirect("~/ScenarioTypeClients.aspx");
    }
}