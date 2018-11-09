using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FormValuesManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[4].Selected = true;
    }
    protected void DropDownListProjects_SelectedIndexChanged(object sender, EventArgs e)
    {
        PanelColumns.Visible = DropDownListProjects.SelectedIndex > 0;
    }
}