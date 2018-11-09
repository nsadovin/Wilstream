using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
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

        GridView1.RenderControl(tw);

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=Results.xls");
        //Response.Charset = "utf-8";

        Response.ContentType = "application/vnd.ms-excel";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());
        //Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");

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

}