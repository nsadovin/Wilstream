using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FAQItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                DetailsView1.ChangeMode(DetailsViewMode.Edit);
                DetailsView1.DataBind();
                Label1.Text = "Вопрос, " + ((TextBox)DetailsView1.Rows[0].Cells[1].Controls[1]).Text;
            }

        }
    }
    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        Response.Redirect("~/FAQ.aspx?IdSection=" + Request.QueryString["IdSection"].ToString());
    }
    protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
            Response.Redirect("~/FAQ.aspx?IdSection=" + Request.QueryString["IdSection"].ToString());
    }
    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {

        Response.Redirect("~/FAQ.aspx?IdSection=" + Request.QueryString["IdSection"].ToString());
    }
    protected void SqlDataSourceFAQ_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        System.Data.Common.DbCommand command = e.Command;
        string IdFAQ = command.Parameters["@IdFAQ"].Value.ToString();
        SqlDataSourceFAQReference.InsertParameters["IdQA"].DefaultValue = IdFAQ;
        GridView GridView1 = (GridView)DetailsView1.Rows[2].FindControl("GridView1");
        for (int i = 0; i < GridView1.Rows.Count; i++) {
            GridViewRow Row = GridView1.Rows[i];
            DropDownList DropDownList1 = ((DropDownList)Row.Cells[0].FindControl("DropDownList1"));
            if (DropDownList1.SelectedValue == "0") continue;
            Label Label1_ = ((Label)Row.Cells[0].FindControl("Label1_"));
            SqlDataSourceFAQReference.InsertParameters["IdReference"].DefaultValue = Label1_.Text;
            SqlDataSourceFAQReference.InsertParameters["IdReferenceData"].DefaultValue = DropDownList1.SelectedValue;
            SqlDataSourceFAQReference.Insert();
        }

        ListView ListView1 = (ListView)DetailsView1.Rows[3].FindControl("ListView1");
        
        SqlDataSourceFAQTags.InsertParameters["IdQA"].DefaultValue = IdFAQ;
        for (int i = 0; i < ListView1.Items.Count; i++)
        {
            ListViewItem Item = ListView1.Items[i];
            CheckBox CheckBox1 = (CheckBox)Item.FindControl("CheckBox1");
            Label IDLabel = ((Label)Item.FindControl("IDLabel"));
            if (!CheckBox1.Checked) continue;
            SqlDataSourceFAQTags.InsertParameters["IdTag"].DefaultValue = IDLabel.Text;
            SqlDataSourceFAQTags.Insert();
        }
    }
    protected void SqlDataSourceFAQ_Updated(object sender, SqlDataSourceStatusEventArgs e)
    { 
        
        SqlDataSourceFAQReference.Delete();
        GridView GridView1 = (GridView)DetailsView1.Rows[2].FindControl("GridView1");
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            GridViewRow Row = GridView1.Rows[i];
            DropDownList DropDownList1 = ((DropDownList)Row.Cells[0].FindControl("DropDownList1"));
            if (DropDownList1.SelectedValue == "0") continue;
            Label Label1_ = ((Label)Row.Cells[0].FindControl("Label1_"));
            SqlDataSourceFAQReference.InsertParameters["IdReference"].DefaultValue = Label1_.Text;
            SqlDataSourceFAQReference.InsertParameters["IdReferenceData"].DefaultValue = DropDownList1.SelectedValue;
            SqlDataSourceFAQReference.Insert();
        }

        ListView ListView1 = (ListView)DetailsView1.Rows[3].FindControl("ListView1");
          
        SqlDataSourceFAQTags.Delete();
        for (int i = 0; i < ListView1.Items.Count; i++)
        {
            ListViewItem Item = ListView1.Items[i];
            CheckBox CheckBox1 = (CheckBox)Item.FindControl("CheckBox1");
            Label IDLabel = ((Label)Item.FindControl("IDLabel"));
            if (!CheckBox1.Checked) continue;
            
            SqlDataSourceFAQTags.InsertParameters["IdTag"].DefaultValue = IDLabel.Text;
            SqlDataSourceFAQTags.Insert();
        }
        
    }
}