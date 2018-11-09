using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class reports_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GridViewForms_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        var procedure = "[INBOUND].[dbo].[reportForm]";
        if (e.CommandName != "")
            procedure = e.CommandName;
        Response.Redirect("~/Report.aspx?Procedure=" + procedure + "&IdAllString=1&report=form_IdForm_" + e.CommandArgument);

    }
}