using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class player_FAQ : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }






     

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataList1.DataBind();
        
    }
    protected void DataList1_PreRender(object sender, EventArgs e)
    {
        foreach (DataListItem dli in DataList1.Items)
        {
            var AnswerLabel = dli.FindControl("AnswerLabel") as Label;
            var QuestLabel = dli.FindControl("QuestLabel") as Label;
            var QuestLinkButton = dli.FindControl("QuestLinkButton") as LinkButton;
            foreach (string key in Request.QueryString.AllKeys)
            {
                string value = Request.QueryString[key].ToString();
                if (QuestLinkButton != null) QuestLinkButton.Text = QuestLinkButton.Text.ToString().Replace("[" + key + "]", value);

                if (QuestLabel != null) QuestLabel.Text = QuestLabel.Text.ToString().Replace("[" + key + "]", value);
                if (AnswerLabel != null) AnswerLabel.Text = AnswerLabel.Text.ToString().Replace("[" + key + "]", value);
            }
        }
    }
}