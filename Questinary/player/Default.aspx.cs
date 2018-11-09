using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Collections.Generic;
using System.Web.Configuration;
using System.Net;
using System.IO;

public partial class player_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HiddenFieldIdScenario.Value = Request.QueryString["IdScenario"].ToString();
            HiddenFieldIdSession.Value = Request.QueryString["IdSession"]!=null?Request.QueryString["IdSession"].ToString():"";
            if(HiddenFieldIdScenario.Value!="")
            IsSaveAnswer = getIsSaveAnswer(Convert.ToInt32(HiddenFieldIdScenario.Value)); 
        }
    }

    //Scenarios


    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        Label QuestLabel = (Label)e.Item.FindControl("QuestLabel");
        if (QuestLabel!=null && QuestLabel.Text.IndexOf("abonentFIO") > -1)
        {
            string abonentFIO = "";
            /*   if ((Label)FormView1.FindControl("ContactNameLabel") != null)
               {
                   abonentFIO = ((Label)FormView1.FindControl("ContactNameLabel")).Text;
               } */
            if (abonentFIO == null || abonentFIO == "")
                abonentFIO = "[ФИО абонента не определено]";
            QuestLabel.Text = QuestLabel.Text.Replace("[abonentFIO]", abonentFIO).ToString();
            
             
        }

        if (QuestLabel != null && QuestLabel.Text.IndexOf("operatorFIO") > -1)
        {
            //  ProfileCommon ObjProfile = (ProfileCommon)Profile.GetProfile(User.Identity.Name);
            //    MembershipUser Member = Membership.GetUser(User.Identity.Name);



            string operatorFIO = "";
            operatorFIO = "Оператор"; //ObjProfile.Fio;
            if (operatorFIO == null || operatorFIO == "")
                operatorFIO = "[ФИО оператора не определено]";
            QuestLabel.Text = QuestLabel.Text.Replace("[operatorFIO]", operatorFIO).ToString(); 
        }

        if (QuestLabel != null && QuestLabel.Text.IndexOf("dc_call_id") > -1)
        {
            string dc_call_id = getFromDCCallId();
            if (dc_call_id!="")
            QuestLabel.Text = QuestLabel.Text.Replace("[dc_call_id]", dc_call_id).ToString();
        }
        if (QuestLabel != null) 
        QuestLabel.Text = handlerParam(QuestLabel.Text);

        //SqlDataSource SqlDataSourceFAQ = (SqlDataSource)Accordion1.Panes[0].Controls[1].Controls[5];


        //  SqlDataSourceFAQ.SelectParameters["IdQuestScenario"].DefaultValue =
        //      ((ListView)MyAccordion.Panes[0].FindControl("ListView1")).SelectedValue.ToString();
        //  Label18.Text = SqlDataSourceFAQ.SelectParameters["IdQuestScenario"].DefaultValue;
        //  GridView4.DataBind();

        //HiddenFieldIdQuestScenario.Value = ((Label)e.Item.FindControl("IDLabel")).Text;
        //Label18.Text = ((Label)e.Item.FindControl("IDLabel")).Text;
        if(e.Item.FindControl("IDLabel")!=null)
        HiddenFieldIdQuestScenario.Value = ((Label)e.Item.FindControl("IDLabel")).Text;
        DataListFaq.DataBind();
        //GridView4.DataBind();

        var LinkButtonEdit = e.Item.FindControl("LinkButtonEdit") as LinkButton;
        if (LinkButtonEdit != null)
        LinkButtonEdit.Visible =   Request.QueryString["edit"] != null;


    }

     

    private string getFromDCCallId()
    {
        try
        {
            string URL = "http://sc-vg/local/sc/get_call_id.php?" + HttpUtility.UrlDecode(Request.QueryString.ToString());

           // Response.Write(HttpUtility.UrlDecode(URL));

            var webRequest = WebRequest.Create(URL);
            var strContent = "";

            using (var response = webRequest.GetResponse())
            using (var content = response.GetResponseStream())
            using (var reader = new StreamReader(content))
            {
                strContent = reader.ReadToEnd();
            }

            return strContent;
        }
        catch (Exception ex)
        {
            return "";
        }
    }

    private string handlerParam(string p)
    {
        
        foreach (var param in Request.QueryString.AllKeys)
        {
            p = p.Replace("[" + param + "]", Request.QueryString[param].ToString());
        };
        return p;
    }

    public bool IsEdit { get { return Request.QueryString["edit"] != null; } set { } }



    public bool IsSaveAnswer { get { return Convert.ToBoolean(HiddenFieldIsSaveAnswer.Value); } set { HiddenFieldIsSaveAnswer.Value = value.ToString(); } }


    protected bool getIsSaveAnswer(int IdScenario)
    {

         
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["QuestionaryConnectionString"];

        bool isSaveAnswer = false;

        try
        {
             

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("SELECT [IsSaveAnswers] FROM [dbo].[crm_scenarios] WHERE [Id] = @Id", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@Id", IdScenario);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            if (myOdbcReader.Read())
            {
                isSaveAnswer = myOdbcReader.GetValue(0).ToString() == "True";
                 

            }
            myOdbcReader.Close();
            myOdbcConnection.Close();
        }
        catch (SqlException SqlEx)
        {

            throw new Exception("An error occurred while transaction", SqlEx);

        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }



        return isSaveAnswer;
         
    }



    protected void ListView1_ItemCreated(object sender, ListViewItemEventArgs e)
    {
        if ((Button)e.Item.FindControl("Button10") != null)
            ((Button)e.Item.FindControl("Button10")).Visible = HiddenFieldIdParentQuest.Value != "" && Session.Contents[HiddenFieldIdParentQuest.Value] != null;

        if ((Button)e.Item.FindControl("Button10_top") != null)
            ((Button)e.Item.FindControl("Button10_top")).Visible = HiddenFieldIdParentQuest.Value != "" && Session.Contents[HiddenFieldIdParentQuest.Value] != null;
    }

    public void saveAnswer(int IdScenario, int IdSession, int IdQuest, int IdAnswer){
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["QuestionaryConnectionString"]; 

        try
        {

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("INSERT INTO [dbo].[crm_scenario_Saved_Answers] ([IdSession]  ,[IdScenario]  ,[IdQuest]  ,[IdAnswer]  ,[IsBack]     ,[Created])  VALUES  (@IdSession ,@IdScenario ,@IdQuest   ,@IdAnswer    ,0  ,getDate())", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text; 
            myOdbcCommand.Parameters.AddWithValue("@IdSession", IdSession);
            myOdbcCommand.Parameters.AddWithValue("@IdScenario", IdScenario);
            myOdbcCommand.Parameters.AddWithValue("@IdQuest", IdQuest);
            myOdbcCommand.Parameters.AddWithValue("@IdAnswer", IdAnswer);
            myOdbcCommand.Connection.Open();
            myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

            myOdbcConnection.Close();
        }
        catch (SqlException SqlEx)
        {

            throw new Exception("An error occurred while transaction", SqlEx);

        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        } 

    }

    protected void Button9_Click(object sender, EventArgs e)
    {

        Button Button9 = (Button)sender;
        string IdParentAnswer = Button9.CommandArgument.ToString();
        string IdParentQuest = ((Label)Button9.Parent.FindControl("IdQuestLabel")).Text;
        if (HiddenFieldIdSession.Value != "" && IsSaveAnswer)
            saveAnswer(Convert.ToInt32(HiddenFieldIdScenario.Value), Convert.ToInt32(HiddenFieldIdSession.Value), Convert.ToInt32(IdParentQuest), Convert.ToInt32(IdParentAnswer));


        SqlDataSourceChain.SelectParameters["IdParentAnswer"].DefaultValue = IdParentAnswer;
        SqlDataSourceChain.SelectParameters["IdParentQuest"].DefaultValue = IdParentQuest;
        DataView DataView1 = (DataView)SqlDataSourceChain.Select(DataSourceSelectArguments.Empty);
        if (DataView1.Table.Rows.Count == 0)
        {
            Session.Contents["-1"] = IdParentQuest;
            Session.Contents["-1IdScenario"] = HiddenFieldIdScenario.Value;
            HiddenFieldIdParentQuest.Value = "-1";
            return;
        };
        int IdQuest = (int)DataView1.Table.Rows[0]["IdQuest"];
        int IdScenario = (int)DataView1.Table.Rows[0]["IdScenario"];

        if (IdQuest > 0)
        {

            Session.Contents[IdQuest.ToString()] = IdParentQuest;
            Session.Contents[IdQuest.ToString() + "IdScenario"] = HiddenFieldIdScenario.Value;
            //Label17.Text = Session.Contents[IdQuest.ToString() + "IdScenario"].ToString();
            HiddenFieldIdParentQuest.Value = IdQuest.ToString();
             
            HiddenFieldIdScenario.Value = IdScenario.ToString();
            //Label17.Text = HiddenFieldIdParentQuest.Value;
            //ListView1.DataBind();

        }

         /*

        Button Button9 = (Button)sender;
        string IdParentAnswer = Button9.CommandArgument.ToString();
        string IdParentQuest = ((Label)Button9.Parent.FindControl("IdQuestLabel")).Text;
        SqlDataSourceChain.SelectParameters["IdParentAnswer"].DefaultValue = IdParentAnswer;
        SqlDataSourceChain.SelectParameters["IdParentQuest"].DefaultValue = IdParentQuest;
        DataView DataView1 = (DataView)SqlDataSourceChain.Select(DataSourceSelectArguments.Empty);
        if (DataView1.Table.Rows.Count == 0)
        {
            Session.Contents["-1"] = IdParentQuest;
            HiddenFieldIdParentQuest.Value = "-1";
            return;
        };
        int IdQuest = (int)DataView1.Table.Rows[0]["IdQuest"];
        if (IdQuest > 0)
        {

            Session.Contents[IdQuest.ToString()] = IdParentQuest;
            //Label17.Text = Session.Contents[IdQuest.ToString()].ToString();
            HiddenFieldIdParentQuest.Value = IdQuest.ToString();
            //Label17.Text = HiddenFieldIdParentQuest.Value;
            //ListView1.DataBind();

        }
       
          * */

    }


    protected void Button10_Click(object sender, EventArgs e)
    {
        Button Button10 = (Button)sender;

         

        if (Session.Contents[HiddenFieldIdParentQuest.Value + "IdScenario"] != null)
        {
            HiddenFieldIdScenario.Value = Session.Contents[HiddenFieldIdParentQuest.Value + "IdScenario"].ToString();
        }


        if (Session.Contents[HiddenFieldIdParentQuest.Value] != null)
        { 
            HiddenFieldIdParentQuest.Value = Session.Contents[HiddenFieldIdParentQuest.Value].ToString();
        }

        if (HiddenFieldIdSession.Value != "" && IsSaveAnswer)
            cancelAnswer(Convert.ToInt32(HiddenFieldIdScenario.Value), Convert.ToInt32(HiddenFieldIdSession.Value), Convert.ToInt32(HiddenFieldIdParentQuest.Value));



    }


    public void cancelAnswer(int IdScenario, int IdSession, int IdQuest)
    {
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["QuestionaryConnectionString"];

        try
        {

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("UPDATE   [dbo].[crm_scenario_Saved_Answers] SET [IsBack] = 1    WHERE IdSession = @IdSession and IdScenario = @IdScenario and IdQuest = @IdQuest", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@IdSession", IdSession);
            myOdbcCommand.Parameters.AddWithValue("@IdScenario", IdScenario);
            myOdbcCommand.Parameters.AddWithValue("@IdQuest", IdQuest); 
            myOdbcCommand.Connection.Open();
            myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

            myOdbcConnection.Close();
        }
        catch (SqlException SqlEx)
        {

            throw new Exception("An error occurred while transaction", SqlEx);

        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }

    }

    //Scenarios
    protected void ListView1_DataBound(object sender, EventArgs e)
    {
        
    }
}