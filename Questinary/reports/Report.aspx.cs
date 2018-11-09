using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Text.RegularExpressions;

using System.Reflection;

public partial class reports_ResultsAnketa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
          {

              // Copy the original querystring parameters.
              NameValueCollection queryString = HttpUtility.ParseQueryString(Request.QueryString.ToString());

            string pattern = @"_IdTaskOktell_(.*)?";
              
            Regex r = new Regex(pattern, RegexOptions.IgnoreCase);

            Match m = r.Match(queryString.Get("report"));
              int matchCount = 0;
              if (m.Success) 
              {
                  Group g = m.Groups[1];
                  CaptureCollection cc = g.Captures;
                  var IdTask = cc[0].ToString();
                  ddlTasksOktell.SelectedValue = IdTask;
                 //m = m.NextMatch();
              }

             
            
          }
        //ddlTasksOktell.SelectValue = 
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


    protected void Index_Changed(Object sender, EventArgs e)
    {
        if (IsPostBack)
          {

              // Copy the original querystring parameters.
              NameValueCollection queryString = HttpUtility.ParseQueryString(Request.QueryString.ToString());

            string pattern = @"(_IdTaskOktell.*)?";
             
            string replacement = "";
            Regex rgx = new Regex(pattern);
            string result = rgx.Replace(queryString.Get("report"), replacement) + "_IdTaskOktell_" + ddlTasksOktell.SelectedValue.ToString();


              // Set the first parameter (it will be added if it does not exist).
            queryString.Set("report", result);
              // Postback to the same page, with adjusted querystring parameters.
            Response.Redirect(string.Format("{0}?{1}", Request.Url.AbsolutePath, queryString.ToString()));
            
          }

        

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