using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrmIntegration.Core;
using CrmIntegration.Core.ServiceReferenceNaumen; 

public partial class Naumen : System.Web.UI.Page
{
    NaumenSD n;
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
        {
            Path = "~/Scripts/jquery-3.0.0.min.js",
        });
        n = new NaumenSD("4a1090ac-c13f-42cd-9295-a8f0e992eeab");

        if (Request.QueryString["UUID"] != null && !IsPostBack)
        {
            string error = "";
            var call = n.GetServiceCall(Request.QueryString["UUID"].ToString(), ref error);
            if (error =="")
            {
                TextBoxDescriptionRTF.Text = call.descriptionRTF.ToString();
                TextBoxShortDescr.Text = call.shortDescr.ToString().Replace("<br/>", System.Environment.NewLine);
                if(DropDownListUrgency.Items.FindByValue(call.urgency.UUID.ToString())!=null)
                DropDownListUrgency.SelectedValue = call.urgency.UUID.ToString();
                LabelLead.Text = "Заявка: " + call.shortDescr.ToString()+". Номер: SD"+ call.number.ToString();
                HiddenFieldLeadUUID.Value = call.UUID.ToString();
            }
        }
    }

    string ReplaceNewlines(string blockOfText, string replaceWith)
    {
        return blockOfText.Replace("\r\n", replaceWith).Replace("\n", replaceWith).Replace("\r", replaceWith);
    }

    protected void ButtonSaveLead_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;
            LabelError.Text = "";
        PanelError.Visible = false;
        string error = "";
        string UUID = "";
        if (HiddenFieldLeadUUID.Value!="")
            UUID = n.UpdateServiceCall(HiddenFieldLeadUUID.Value, ReplaceNewlines(TextBoxDescriptionRTF.Text, " "), TextBoxShortDescr.Text, DropDownListUrgency.SelectedValue, ref error);
        else
            UUID = n.AddServiceCall(ReplaceNewlines(TextBoxDescriptionRTF.Text, " "), TextBoxShortDescr.Text, DropDownListUrgency.SelectedValue, ref error);
        if (error == "")
            Response.Redirect("~/Naumen.aspx?UUID=" + UUID);
        else
        {
            LabelError.Text = error;
            PanelError.Visible = true;
        }
    }
}