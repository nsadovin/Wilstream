using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Scenarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[0].Selected = true;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Scenario.aspx?ID=" + ((Button)sender).CommandArgument);
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/EditorScenario.aspx?ID=" + ((Button)sender).CommandArgument);
    }
    protected void ButtonOpenPlayerScenario_Click(object sender, EventArgs e)
    {
        //string url = "window.open('~/player/Default.aspx?IdScenario=" + ((Button)sender).CommandArgument+"','Title','status=1,toolbar=1,menubar=1');";
    //    ClientScript.RegisterStartupScript(
//this.Page.GetType(),
//"",url
//,
//true);

         Response.Redirect("~/player/Default.aspx?IdScenario=" + ((Button)sender).CommandArgument+"&edit=1");
    }
}