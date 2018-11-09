using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Scenario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Menu Menu1 = (Menu)Master.FindControl("Menu1");
        Menu1.Items[0].Selected = true;
        if (!IsPostBack)
        {
            if (Request.QueryString["ID"] != null)
            {
                DetailsView1.ChangeMode(DetailsViewMode.Edit);
                DetailsView1.DataBind();
                Label1.Text = "Сценарий, " + ((TextBox)DetailsView1.Rows[0].Cells[1].Controls[1]).Text;
            }

        }
    }


    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        Response.Redirect("~/Scenarios.aspx");
    }
    protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
            Response.Redirect("~/Scenarios.aspx");
    }
    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {

        Response.Redirect("~/Scenarios.aspx");
    }
    protected void SqlDataSourceScenario_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        System.Data.Common.DbCommand command = e.Command;
        string IdScenario = command.Parameters["@IdScenario"].Value.ToString();
        SqlDataSourceScenarioTypeClient.InsertParameters["IdScenario"].DefaultValue = IdScenario;
   
        ListView ListView1 = (ListView)DetailsView1.Rows[3].FindControl("ListView1");

        
        for (int i = 0; i < ListView1.Items.Count; i++)
        {
            ListViewItem Item = ListView1.Items[i];
            CheckBox CheckBox1 = (CheckBox)Item.FindControl("ActiveCheckBox");
            HiddenField HiddenField1 = ((HiddenField)Item.FindControl("HiddenField1"));
            if (!CheckBox1.Checked) continue;
            SqlDataSourceScenarioTypeClient.InsertParameters["IdClientType"].DefaultValue = HiddenField1.Value;
            SqlDataSourceScenarioTypeClient.Insert();
        }

        TextBox TextBox3 = (TextBox)DetailsView1.Rows[4].FindControl("TextBox3");
        String[] Buttons = TextBox3.Text.ToString().Split(new Char [] {','});
        for (int i = 0; i < Buttons.Length; i++)
        {
            string ButtonIVR = Buttons[i].Trim();
            if (ButtonIVR != "") {
                SqlDataSourceIVR.InsertParameters["IdScenario"].DefaultValue = IdScenario;
                SqlDataSourceIVR.InsertParameters["Button"].DefaultValue = ButtonIVR;
                SqlDataSourceIVR.Insert();
            }
        }

    }


    protected void SqlDataSourceScenario_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {

        SqlDataSourceScenarioTypeClient.Delete();
        ListView ListView1 = (ListView)DetailsView1.Rows[3].FindControl("ListView1");
        
        for (int i = 0; i < ListView1.Items.Count; i++)
        {
            ListViewItem Item = ListView1.Items[i];
            CheckBox CheckBox1 = (CheckBox)Item.FindControl("ActiveCheckBox");
            HiddenField HiddenField1 = ((HiddenField)Item.FindControl("HiddenField1"));
            
            if (!CheckBox1.Checked) continue;
            
            SqlDataSourceScenarioTypeClient.InsertParameters["IdClientType"].DefaultValue = HiddenField1.Value;
            SqlDataSourceScenarioTypeClient.Insert();
        }
       // Response.Write("111");
       // Response.End();
        SqlDataSourceIVR.Delete();
        TextBox TextBox3 = (TextBox)DetailsView1.Rows[4].FindControl("TextBox3");
        String[] Buttons = TextBox3.Text.ToString().Split(new Char[] { ',' });
        for (int i = 0; i < Buttons.Length; i++)
        {
            string ButtonIVR = Buttons[i].Trim();
            if (ButtonIVR != "")
            {
                SqlDataSourceIVR.InsertParameters["Button"].DefaultValue = ButtonIVR;
                SqlDataSourceIVR.Insert();
            }
        }

    }

    protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
    {

    }
    protected void DetailsView1_ItemCreated(object sender, EventArgs e)
    {
        if (DetailsView1.CurrentMode == DetailsViewMode.Edit) {
            SqlDataSourceIVR.DataSourceMode = SqlDataSourceMode.DataReader;
            System.Collections.IEnumerator rdr = SqlDataSourceIVR.Select(DataSourceSelectArguments.Empty).GetEnumerator();
            IDataRecord row;
            string Button = "";
            while (rdr.MoveNext())
            {
                row = (IDataRecord)rdr.Current; 
                Button += (Button != "" ? "," : "") + ((int)row["Button"]).ToString();
            }
            TextBox TextBox3 = (TextBox)DetailsView1.Rows[4].FindControl("TextBox3");
            TextBox3.Text = Button;
        }
    }
    protected void DetailsView1_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        
    }
    protected void SqlDataSourceTypeClient_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void SqlDataSourceScenarioTypeClient_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
}