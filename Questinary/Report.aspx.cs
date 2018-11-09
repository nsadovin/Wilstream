using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class reports_ResultsAnketa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter tw = new HtmlTextWriter(sw);


        GridView1.AllowPaging = GridView1.AllowSorting = false;
        GridView1.AutoGenerateSelectButton = false;
        GridView1.DataBind();


        foreach (GridViewRow row in GridView1.Rows)
        {
           
            foreach (TableCell cell in row.Cells)
            {
                if (row.RowIndex % 2 == 0)
                {
                    cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                }
                else
                {
                    cell.BackColor = GridView1.RowStyle.BackColor;
                }

                 
                cell.CssClass =  Request.QueryString["IdAllString"]!=null? "textmode":"";
              //  cell.Text = "'" + cell.Text;
            }
        }

        GridView1.RenderControl(tw);

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=Results.xls");
        //Response.Charset = "utf-8";

        Response.ContentType = "application/vnd.ms-excel";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());
        //Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
//style to format numbers to string
        string style = @"<style> .textmode {mso-number-format:\@; } </style>";
        Response.Write(style);

       // Response.Output.Write(sw.ToString());
        Response.Write(sw.ToString());

        GridView1.AllowPaging = GridView1.AllowSorting = true;

         

        Response.Flush();
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //Оставить пустым
    }

    protected void SqlDataSource_SetTimeout(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.CommandTimeout = 12000;
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            for (int i = 0; i < e.Row.Cells.Count; i++)
            {
                string encoded = e.Row.Cells[i].Text;
                e.Row.Cells[i].Text = Context.Server.HtmlDecode(encoded);
            }
        }
    }

}