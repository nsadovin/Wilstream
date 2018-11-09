using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Email : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LinkButtonCntAnser_Click(object sender, EventArgs e)
    { 
        var row = (GridViewRow)(sender as LinkButton).Parent.Parent;
        var GridViewAnswer = (GridView)row.Cells[8].FindControl("GridViewAnswer");
        GridViewAnswer.Visible = !GridViewAnswer.Visible;
    }
    protected void GridViewEmail_RowCommand(object sender, GridViewCommandEventArgs e)
    { 

    }
    protected void GridViewEmail_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
}