using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class gazprom_dashboard_count_and_len : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "set_play();", true);
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GridView1.DataBind(); 
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = (DataRowView)e.Row.DataItem;
            if (e.Row.Cells[5].Text != "")
            {
                string decodedText = HttpUtility.HtmlDecode(e.Row.Cells[5].Text);
                e.Row.Cells[5].Text = decodedText;
            }
        }
    }


    protected void UpdateButton_OnClick(object sender, EventArgs e)
    {
        Timer1.Enabled = !Timer1.Enabled;
        UpdateButton.Text = Timer1.Enabled ? "Выключить обновление" : "Включить обновление"; 
    }

}