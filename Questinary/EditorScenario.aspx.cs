using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;


using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Collections.Generic;
using System.Web.Configuration;
using System.Net;
using System.IO;

public partial class EditorScenario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        DetailsView1.DataBind();
    }
    protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if(e.CommandName=="Cancel")
            MultiView1.ActiveViewIndex = 0;      
    }
    protected void DetailsView2_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {

    }
    protected void SqlDataSourceQuest_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
         
            if (e.Command.Parameters["@LastID"].Value.ToString()!=""){
            
                
                SqlDataSourceQuest.SelectParameters["IdQuest"].DefaultValue = e.Command.Parameters["@LastID"].Value.ToString();
                SqlDataSourceQuest.DataBind();
                DetailsView2.DataBind();
                MultiView1.ActiveViewIndex = 2;
            }
            GridView1.DataBind();
    }
    protected void DetailsView2_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
       
        
    }
    protected void SqlDataSourceQuest_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {

        GridView1.DataBind();    
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        SqlDataSourceQuest.SelectParameters["IdQuest"].DefaultValue = ((Button)sender).CommandArgument.ToString();
        SqlDataSourceQuest.DataBind();
        DetailsView2.DataBind();
        MultiView1.ActiveViewIndex = 2;
    }
    protected void Button1_Click2(object sender, EventArgs e)
    {
        SqlDataSourceAnswer.SelectParameters["ID"].DefaultValue = ((Button)sender).CommandArgument.ToString();
        SqlDataSourceAnswer.DataBind();
        //DetailsView4.DataBind();
        Panel2_ModalPopupExtender.Show();

    }

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static string GetDynamicContent(string contextKey)
    {
        return default(string);
    }
    protected void SqlDataSourceAnswer_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView2.DataBind();
    }
    protected void SqlDataSourceAnswer_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView2.DataBind();

        Panel2_ModalPopupExtender.Hide();
    }
    protected void ListView3_PreRender(object sender, EventArgs e)
    {
        CheckBox CheckBox1 = ((CheckBox)((ListView)sender).Parent.FindControl("CheckBox1"));
        ListView ListView3 = (ListView)sender;
        //Response.Write(CheckBox1.Checked ? "1" : "2");
        ListView3.Visible = CheckBox1.Checked;
    }
    protected void ListView3_Load(object sender, EventArgs e)
    {
        CheckBox CheckBox1 = ((CheckBox)((ListView)sender).Parent.FindControl("CheckBox1"));
        ListView ListView3 = (ListView)sender;
        //Response.Write(CheckBox1.Checked?"1":"2");
        ListView3.Visible = CheckBox1.Checked;
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        SqlDataSourceChain.Delete();
        for (int i = 0; i < GridView3.Rows.Count; i++) {
            TableCell TableCell1 = (TableCell)GridView3.Rows[i].Cells[0];
            CheckBox CheckBox1 = (CheckBox)TableCell1.FindControl("CheckBox1");
            if(!CheckBox1.Checked) continue;
            HiddenField HiddenField2 = (HiddenField)TableCell1.FindControl("HiddenField2");
            ListView ListView3 = (ListView)TableCell1.FindControl("ListView3");
            SqlDataSourceChain.InsertParameters["IdParentQuest"].DefaultValue = HiddenField2.Value;
            int cnt_answer_checked = 0;
            for (int j = 0; j < ListView3.Items.Count; j++) {
                ListViewDataItem ListItem1 = (ListViewDataItem)ListView3.Items[j];
                CheckBox ActiveCheckBox = (CheckBox)ListItem1.FindControl("ActiveCheckBox");
                if (!ActiveCheckBox.Checked) continue;
                HiddenField HiddenField3 = (HiddenField)ListItem1.FindControl("HiddenField3");
                SqlDataSourceChain.InsertParameters["IdParentAnswer"].DefaultValue = HiddenField3.Value;
                SqlDataSourceChain.Insert();
                cnt_answer_checked++;
            }
            if(cnt_answer_checked==0)
                SqlDataSourceChain.Insert();
        }
            
    }
    protected void ListView3_DataBound(object sender, EventArgs e)
    {

    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        SqlDataSourceScenarioFAQ.Delete();
        for (int i = 0; i < GridView5.Rows.Count; i++)
        {
            TableCell TableCell1 = (TableCell)GridView5.Rows[i].Cells[0];
            CheckBox CheckBox1 = (CheckBox)TableCell1.FindControl("CheckBox1");
            if (!CheckBox1.Checked) continue;
            HiddenField HiddenField4 = (HiddenField)TableCell1.FindControl("HiddenField4");
            SqlDataSourceScenarioFAQ.InsertParameters["IdFAQ"].DefaultValue = HiddenField4.Value;
            SqlDataSourceScenarioFAQ.Insert();
        }
    }
    protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
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
        return (clearText.ToString() != "")?(
            
            (clearText.Length > Count)?
            ( clearText.ToString().Substring(0, Count) + (clearText.Length > Count ? more : ""))
            : clearText
            )
            :"";
    }

    protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        SqlDataSourceQuest.InsertParameters["Active"].DefaultValue = ((CheckBox)DetailsView1.Rows[3].Cells[1].FindControl("CheckBox1")).Checked?"1":"0";
    }
    protected void DetailsView3_ItemInserting(object sender, DetailsViewInsertEventArgs e)
    {
        SqlDataSourceAnswer.InsertParameters["Active"].DefaultValue = ((CheckBox)DetailsView3.Rows[3].Cells[1].FindControl("CheckBox1")).Checked ? "1" : "0";
    }
    protected void Button3_Command(object sender, CommandEventArgs e)
    {

        GridView1.DataBind();
        MultiView1.ActiveViewIndex = 1;
        DetailsView1.DataBind();
    }
    protected void Button1_Command(object sender, CommandEventArgs e)
    { 
        GridView1.DataBind();
        MultiView1.ActiveViewIndex = 0;  
    }
    protected void Button3_Command1(object sender, CommandEventArgs e)
    {
        Panel1_ModalPopupExtender.Show();
    }
    protected void Button1_Command1(object sender, CommandEventArgs e)
    {

    }

    
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        string IdScenario = Request.QueryString["ID"].ToString();

        for(int i =0; i <  DropDownList1.Items.Count; i++)
            DropDownList1.Items[i].Selected = DropDownList1.Items[i].Value == IdScenario;

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView3.DataBind();

    }
    protected void DropDownListSectionFAQ_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView5.DataBind();
    }
    protected void DropDownListSectionFAQ_DataBound(object sender, EventArgs e)
    {

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["QuestionaryConnectionString"];


        // If found, return the connection string.
        string IdSection = "";

        try
        {

            
                
                 
                    SqlConnection myConnection = new SqlConnection(settings.ConnectionString);
                    //запишем инфу о звонке  в бд
                    SqlCommand myCommand = new SqlCommand("SELECT top 1 crm_faq_QA.IdSection FROM crm_faq_QA LEFT OUTER JOIN crm_scenario_FAQ ON crm_faq_QA.ID = crm_scenario_FAQ.IdFAQ  WHERE (crm_faq_QA.IsDeleted = 0) AND crm_scenario_FAQ.IdQuest = " + DetailsView2.SelectedValue.ToString()+ " ORDER BY crm_faq_QA.ID DESC"
                        , myConnection);
                    myCommand.CommandType = CommandType.Text;
                    myCommand.Connection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
                    if (myReader.Read())
                    {
                        IdSection = myReader.GetInt32(0).ToString();
                    }
                    myReader.Close();
                    myConnection.Close();


                    for (int i = 0; i < DropDownListSectionFAQ.Items.Count; i++)
                        DropDownListSectionFAQ.Items[i].Selected = DropDownListSectionFAQ.Items[i].Value == IdSection;



        }
        catch (SqlException SqlEx)
        {

            throw new Exception("An error occurred while transaction", SqlEx);

        }
        finally
        {
             
        }

    }
}