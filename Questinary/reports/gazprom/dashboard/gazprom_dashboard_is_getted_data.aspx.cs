using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class gazprom_dashboard_is_getted_data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GridView1.DataBind(); 
    }




    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = (DataRowView)e.Row.DataItem;

            e.Row.Cells[1].BackColor = Convert.ToInt32(e.Row.Cells[1].Text) < 100 ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            e.Row.Cells[2].BackColor = Convert.ToInt32(e.Row.Cells[2].Text) < 100 ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            e.Row.Cells[3].BackColor = Convert.ToInt32(e.Row.Cells[3].Text) < 100 ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            e.Row.Cells[1].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[2].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[3].ForeColor = System.Drawing.Color.White;
        }
    }
}