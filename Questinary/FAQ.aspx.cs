using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Text.RegularExpressions;

public partial class faq : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[1].Selected = true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/FAQItem.aspx?ID=" + ((Button)sender).CommandArgument + "&IdSection=" + Request.QueryString["IdSection"].ToString());
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

    }

    public static string RemoveTags(string textWithHtmlTags, int Count = 999999, string more = " ...")
    {
        string clearText = string.Empty;
        if (!String.IsNullOrEmpty(textWithHtmlTags))
        {
            clearText = System.Text.RegularExpressions.Regex.Replace(textWithHtmlTags, @"\<(.+?)\>", String.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled);
            clearText = System.Text.RegularExpressions.Regex.Replace(clearText, @"\</(.+?)\>", String.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled);
            clearText = System.Text.RegularExpressions.Regex.Replace(clearText, @"\[(.+?)\]", String.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled);
            clearText = System.Text.RegularExpressions.Regex.Replace(clearText, @"\[/(.+?)\]", String.Empty, RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled);
        }
        return (clearText.ToString() != "") ? (

            (clearText.Length > Count) ?
            (clearText.ToString().Substring(0, Count) + (clearText.Length > Count ? more : ""))
            : clearText
            )
            : "";
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string IDs = "";
        int CntId = 0;
        for (int i = 0; i < GridView2.Rows.Count; i++) {
            DropDownList DropDownList1 = (DropDownList)GridView2.Rows[i].Cells[1].FindControl("DropDownList1");
            if (DropDownList1.SelectedValue != "0" && DropDownList1.SelectedValue!="")
            {
                IDs += (IDs!=""? ",":"") + DropDownList1.SelectedValue;
                CntId++;
            }
        }
        if (IDs != "")
        {
            SqlDataSourceFAQ.SelectCommand = SqlDataSourceFAQ.SelectCommand.Replace("@IdReferenceData2", IDs);
            SqlDataSourceFAQ.SelectCommand = SqlDataSourceFAQ.SelectCommand.Replace("@IdReferenceData1", "1");
            SqlDataSourceFAQ.SelectCommand = SqlDataSourceFAQ.SelectCommand.Replace("@IdReferenceData3", CntId.ToString());
            //Response.Write(SqlDataSourceFAQ.SelectCommand);
            SqlDataSourceFAQ.Select(DataSourceSelectArguments.Empty);
            SqlDataSourceFAQ.DataBind();

            
        }
        GridView1.DataBind();
    }
    
    protected void CheckBox1_OnCheckedChanged(object sender, EventArgs e)
    {
        string IDs = "";
        int CntId = 0;
        for (int i = 0; i < ListView1.Items.Count; i++)
        {
            CheckBox CheckBox1 = (CheckBox)ListView1.Items[i].FindControl("CheckBox1");
            Label IDLabel = (Label)ListView1.Items[i].FindControl("IDLabel");
            
            if (CheckBox1.Checked)
            {
                IDs += (IDs != "" ? "," : "") + IDLabel.Text;
                CntId++;
            }
        }
        if (IDs != "")
        {
            SqlDataSourceFAQ.SelectCommand = SqlDataSourceFAQ.SelectCommand.Replace("@IdTag2", IDs);
            SqlDataSourceFAQ.SelectCommand = SqlDataSourceFAQ.SelectCommand.Replace("@IdTag1", "1");
            SqlDataSourceFAQ.SelectCommand = SqlDataSourceFAQ.SelectCommand.Replace("@IdTag3", CntId.ToString());
            //Response.Write(SqlDataSourceFAQ.SelectCommand);
            SqlDataSourceFAQ.Select(DataSourceSelectArguments.Empty);
            SqlDataSourceFAQ.DataBind();


        }
        GridView1.DataBind();
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/FAQItem.aspx?IdSection=" + Request.QueryString["IdSection"].ToString());
        Response.End();
    }
}