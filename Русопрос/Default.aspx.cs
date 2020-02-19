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
using System.Web.Configuration;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
     
    private string Column_13 = "";
    private string Column_14 = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        if (IsPostBack)
        {


            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "msg1", " randomTable();", true);

        }

        if (!IsPostBack)
        {
            bool is_mobile = true;
            string loginid;
            string fio_client;			
            HiddenFieldOut_ID.Value = Request.QueryString["Out_ID"];
            string debug = Request.QueryString["debug"];
            HF_Fio.Value = Request.QueryString["an"];
            HF_Out_ID.Value = Request.QueryString["aid"];
            HF_cid.Value = Request.QueryString["Campaign_ID"];
            HF_Abonent_ID.Value = Request.QueryString["Abonent_ID"];
             Label1.Text = Label2.Text = Request.QueryString["OperatorName"];
            is_mobile = Request.QueryString["is_mobile"]!=null&& Request.QueryString["is_mobile"].ToString() == "1";

            string column_17="";
            if (Request.QueryString["Column_17"] != null)
                column_17 = HttpUtility.UrlDecode(Request.QueryString["Column_17"], Encoding.GetEncoding("windows-1251"));
             
            Column_13 = Request.QueryString["Column_13"] != null ? Request.QueryString["Column_13"].ToString() : "";
            Column_14 = Request.QueryString["Column_14"] != null ? Request.QueryString["Column_14"].ToString() : "";
             
            HiddenFieldColumn_13.Value = Column_13;
            HiddenFieldColumn_14.Value = Column_14;
            HiddenFieldColumn_17.Value = column_17.ToString();


            var Column_5 = Request.QueryString["Column_1"] != null ? Request.QueryString["Column_1"].ToString() : "";
            
            HiddenField1.Value =  debug;

            if (debug == null)
            {

                loginid = Request.QueryString["loginid"];
                fio_client = HttpUtility.UrlDecode(Request.QueryString["an"], Encoding.GetEncoding("windows-1251"));

            }
            else
            {
                HF_Out_ID.Value = "1111";
                loginid = "1001";
                fio_client = "Иванов Иван Иванович";
            }


             IterateControls(Page, fio_client, "fio");



            SqlConnection conn = null;

            ConnectionStringSettings settingsSCCS =
            ConfigurationManager.ConnectionStrings["SCCSConnectionString"];

            // If found, return the connection string.


            try
            {



                //узнаем имя оператора
                if (debug == null && 1 == 0)
                {
                    OdbcConnection myOdbcConnection = new OdbcConnection(settingsSCCS.ConnectionString);

                    OdbcCommand myOdbcCommand = new OdbcCommand("Select GivenName,SurName from blue.dbo.Agent where TelsetLoginID='" + loginid + "'", myOdbcConnection);
                    myOdbcCommand.CommandType = CommandType.Text;
                    myOdbcCommand.Connection.Open();
                    OdbcDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
                    //Label26.Text = "[unknown]";
                    while (myOdbcReader.Read())
                    {
                        //Label1.Text = myOdbcReader.GetString(0) + " " + myOdbcReader.GetString(1);
                    }
                    myOdbcReader.Close();
                    myOdbcConnection.Close();


                }
                else
                {
                    //Label1.Text = "Василий пупкин";
                }




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
    }


    public static void IterateControls(Control parent, string text, string mark)
    {
        //iterate parent control
        foreach (Control c in parent.Controls)
        {
            if (c is Label)
                if (((Label)c).CssClass == mark)
                    ((Label)c).Text = text;
            //iterate childlren
            if (c.Controls.Count != 0)
                IterateControls(c, text, mark);
        }
    }
    #region standart function begin
    /* standart function begin */

    protected void standartNext(object sender, EventArgs e)
    {
        string CommandName = ((Button)sender).CommandName;
        ((Button)sender).Parent.Visible = false;
        ((Button)sender).Parent.Parent.FindControl(CommandName).Visible = true;
        Session.Contents[CommandName] = ((Panel)((Button)sender).Parent).ID;
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            
            if (c is Label)
            {
                if (((Label)c).Attributes["type"]!=null&&((Label)c).Attributes["type"].ToString() == "cod")
                    ((Label)c).Text = ((Button)sender).CommandArgument;
            }
            if (c is HiddenField)
            {

                ((HiddenField)c).Value = ((Button)sender).Text;
            }
        }
    }

    protected void standartPrev(object sender, EventArgs e)
    {
        ((Button)sender).Parent.Visible = false;

        Panel PrevPanel = (Panel)((Button)sender).Parent.Parent.FindControl(Session.Contents[((Button)sender).Parent.ID].ToString());
        PrevPanel.Visible = true;
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is HiddenField)
                ((HiddenField)c).Value = "";
        }
      //  if (PrevPanel.CssClass != "")
      //      deleteData(Convert.ToInt32(PrevPanel.CssClass));
    }

    private void saveData(int id, string value)
    {

        if (!(HiddenField1.Value != "1")) return;
        SqlDataSource1.InsertParameters["IdChain"].DefaultValue = HF_Out_ID.Value;
        SqlDataSource1.InsertParameters["Abonent_ID"].DefaultValue = HF_Abonent_ID.Value;
        SqlDataSource1.InsertParameters["Campaign_ID"].DefaultValue = HF_cid.Value;
        SqlDataSource1.InsertParameters["result_id"].DefaultValue = id.ToString();
        SqlDataSource1.InsertParameters["result"].DefaultValue = value;
        SqlDataSource1.Insert();
    }




    private void deleteData(int id)
    {
        if (!(HiddenField1.Value != "1")) return;
        SqlDataSource1.DeleteParameters["IdChain"].DefaultValue = HF_Out_ID.Value;
        SqlDataSource1.DeleteParameters["result_id"].DefaultValue = id.ToString();
        SqlDataSource1.Delete();
    }


    protected void QAC_RadioButtonList(object sender, EventArgs e)
    {

        TextBox TextBoxQ = null;
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                TextBoxQ = (TextBox)c;

            }

        }

        if (TextBoxQ != null)
        {
            saveData(Convert.ToInt32(((Button)sender).CommandArgument + "01"), TextBoxQ.Visible ? TextBoxQ.Text : "");
        }

        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is RadioButtonList)
            {
                saveData(Convert.ToInt32(((Button)sender).CommandArgument), ((RadioButtonList)c).SelectedValue);
            }
        }

        standartNext(sender, e);
    }

    protected void QAC_CheckBoxList(object sender, EventArgs e, string error_message = "Укажите хотя бы один пункт")
    {
        CheckBoxList CheckBoxListQ = null;
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is CheckBoxList)
            {
                CheckBoxListQ = (CheckBoxList)c;
                string data = "";
                LBMSG.Text = "";
                LBMSG.Visible = false;
                for (int i = 0; i < CheckBoxListQ.Items.Count; i++)
                {
                    data += (data != "" && CheckBoxListQ.Items[i].Selected ? "," : "") + (CheckBoxListQ.Items[i].Selected ? CheckBoxListQ.Items[i].Value : "");
                    saveData(Convert.ToInt32(((Button)sender).CommandArgument + ((i + 1) < 10 ? "0" : "") + Convert.ToString(i + 1)), CheckBoxListQ.Items[i].Selected ? "1" : "0");
                }

                if (data == "")
                {
                    LBMSG.Visible = true;
                    LBMSG.Text = error_message;
                    return;
                }

                saveData(Convert.ToInt32(((Button)sender).CommandArgument), "");


            }
        }
        TextBox TextBoxQ = null;
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                TextBoxQ = (TextBox)c;
                if (CheckBoxListQ != null && TextBoxQ.Visible)
                    saveData(Convert.ToInt32(((Button)sender).CommandArgument + (CheckBoxListQ.Items.Count + 1 < 10 ? "0" : "") + Convert.ToString(CheckBoxListQ.Items.Count + 1)), TextBoxQ.Text);
            }
        }

        standartNext(sender, e);
    }

    protected void QAC_DropDownList(object sender, EventArgs e)
    {
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is DropDownList)
            {
                saveData(Convert.ToInt32(((Button)sender).CommandArgument), ((DropDownList)c).SelectedValue);
            }
        }

        standartNext(sender, e);
    }

    protected void QAC_CheckBoxList_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        CheckBoxList CheckBoxListQ = (CheckBoxList)sender;
        TextBox TextBoxQ = null;
        foreach (Control c in ((Panel)((CheckBoxList)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                TextBoxQ = (TextBox)c;
                TextBoxQ.Visible = false;
            }

        }


        RequiredFieldValidator RequiredFieldValidatorQ = null;

        foreach (Control c in ((Panel)((CheckBoxList)sender).Parent).Controls)
        {
            if (c is RequiredFieldValidator)
            {
                if (((RequiredFieldValidator)c).ControlToValidate == TextBoxQ.ID)
                {
                    RequiredFieldValidatorQ = (RequiredFieldValidator)c;
                    RequiredFieldValidatorQ.Enabled = false; ;
                }
            }

        }

        int max = 0;
        if (CheckBoxListQ.CssClass != "")
        {
            max = Convert.ToInt32(CheckBoxListQ.CssClass);
            if (max > 0)
            {
                int cnt_sel = 0;
                for (int i = 0; i < CheckBoxListQ.Items.Count; i++)
                {

                    if (CheckBoxListQ.Items[i].Selected)
                        cnt_sel++;
                }

                if (cnt_sel == (max))
                {
                    for (int i = 0; i < CheckBoxListQ.Items.Count; i++)
                    {
                        CheckBoxListQ.Items[i].Enabled = CheckBoxListQ.Items[i].Selected;
                    }
                }
                else
                {
                    for (int i = 0; i < CheckBoxListQ.Items.Count; i++)
                    {
                        CheckBoxListQ.Items[i].Enabled = true;
                    }
                }

            }
        }


        if (TextBoxQ == null) return;


        for (int i = 0; i < CheckBoxListQ.Items.Count; i++)
        {

            if (CheckBoxListQ.Items[i].Selected && (CheckBoxListQ.Items[i].Text.IndexOf("Другой") > -1 || CheckBoxListQ.Items[i].Text.IndexOf("УТОЧНИТЕ НАЗВАНИЕ") > -1 || CheckBoxListQ.Items[i].Text.IndexOf("другие") > -1 || CheckBoxListQ.Items[i].Text.IndexOf("другой") > -1 || CheckBoxListQ.Items[i].Text.IndexOf("Другое") > -1 || CheckBoxListQ.Items[i].Text.IndexOf("другие") > -1 || CheckBoxListQ.Items[i].Text.IndexOf("Другие") > -1))
            {
                TextBoxQ.Visible = true;
                if (RequiredFieldValidatorQ != null)
                    RequiredFieldValidatorQ.Enabled = true;

            }





        }
    }

    protected void QAC_RadioButtonList_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList RadioButtonListQ = (RadioButtonList)sender;
        TextBox TextBoxQ = null;
        RequiredFieldValidator RequiredFieldValidatorQ = null;
        foreach (Control c in ((Panel)((RadioButtonList)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                TextBoxQ = (TextBox)c;
                TextBoxQ.Visible = false;
            }

        }

        if (TextBoxQ == null) return;

        foreach (Control c in ((Panel)((RadioButtonList)sender).Parent).Controls)
        {
            if (c is RequiredFieldValidator)
            {
                if (((RequiredFieldValidator)c).ControlToValidate == TextBoxQ.ID)
                {
                    RequiredFieldValidatorQ = (RequiredFieldValidator)c;
                    RequiredFieldValidatorQ.Enabled = false; ;
                }
            }

        }


        for (int i = 0; i < RadioButtonListQ.Items.Count; i++)
        {

            if (RadioButtonListQ.Items[i].Selected && (RadioButtonListQ.Items[i].Text.IndexOf("Другие") > -1 || RadioButtonListQ.Items[i].Text.IndexOf("другой") > -1 || RadioButtonListQ.Items[i].Text.IndexOf("другие") > -1 || RadioButtonListQ.Items[i].Text.IndexOf("Другое") > -1 || RadioButtonListQ.Items[i].Text.IndexOf("Другой") > -1 || RadioButtonListQ.Items[i].Text.IndexOf("УТОЧНИТЬ") > -1))
            {
                TextBoxQ.Visible = true;
                if (RequiredFieldValidatorQ != null)
                    RequiredFieldValidatorQ.Enabled = true;
            }
        }
    }

    protected void QAC_Button(object sender, EventArgs e)
    {
        TextBox TextBoxQ = null;
        CheckBoxList CheckBoxListQ = null;
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {

            if (c is CheckBoxList)
            {
                CheckBoxListQ = (CheckBoxList)c;
                LBMSG.Text = "";
                LBMSG.Visible = false;
                for (int i = 0; i < CheckBoxListQ.Items.Count; i++)
                {
                    saveData(Convert.ToInt32(((Button)sender).ToolTip + ((i + 1) < 10 ? "0" : "") + Convert.ToString(i + 1)), "");
                }



            }
        }
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                TextBoxQ = (TextBox)c;
                if (CheckBoxListQ != null)
                    saveData(Convert.ToInt32(((Button)sender).ToolTip + (CheckBoxListQ.Items.Count + 1 < 10 ? "0" : "") + Convert.ToString(CheckBoxListQ.Items.Count + 1)), "");
            }
        }

        saveData(Convert.ToInt32(((Button)sender).ToolTip), ((Button)sender).CommandArgument);
        standartNext(sender, e);
    }
    
    protected void QAC_TextBox(object sender, EventArgs e)
    {
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                saveData(Convert.ToInt32(((Button)sender).CommandArgument), ((TextBox)c).Text);
            }
        }

        standartNext(sender, e);
    }






    /* standart function end */

    #endregion








    private static void Shuffle<T>(T[] array)
    {
        Random random = new Random();
        for (int i = 0; i < array.Length; i++)
        {
            int j = random.Next(array.Length);
            Swap(ref array[i], ref array[j]);
        }
    }

    private static void Swap<T>(ref T first, ref T second)
    {
        T buf = first;
        first = second;
        second = buf;
    }


    string[] PanelsQ20 = new string[4];

    protected void standartNextQ20(object sender, EventArgs e)
    {
        // надо сделать супер ротацию
        PanelsQ20[0] = "Panel32";
        PanelsQ20[1] = "Panel33";
        PanelsQ20[2] = "Panel34";
        PanelsQ20[3] = "Panel35";

        Shuffle(PanelsQ20);


        Session.Contents["PanelsQ20"] = PanelsQ20;
       // Response.Write(PanelsQ20[0]);
       

        ((Button)sender).CommandName = PanelsQ20[0];
        standartNext(sender, e);
    }


    protected void standartNextQ20_ext(object sender, EventArgs e)
    {
        string[] Panels = (string[])Session.Contents["PanelsQ20"];

        standartNextRouter(sender, e, Panels, "Panel36");
    }


    protected void standartNextRouter(object sender, EventArgs e, string[] Panels, string LastNextPanel)
    {

        string PanelID = ((Panel)((Button)sender).Parent).ID;
        for (Int32 i = 0; i < Panels.Count(); i++)
        {
            if (Panels[i] == PanelID)
            {

                if ((i + 1) < Panels.Count())
                {
                    if (Panels[i + 1] != "" && Panels[i + 1] != null)
                        ((Button)sender).CommandName = Panels[i + 1];
                    else
                    {
                        if ((i + 2) < Panels.Count())
                            ((Button)sender).CommandName = Panels[i + 2];
                        else
                            ((Button)sender).CommandName = LastNextPanel;
                    }
                }
                else
                    ((Button)sender).CommandName = LastNextPanel;
            }
        }
       

        QAC_RadioButtonList(sender, e);
    }




    protected void ButtonS1_3_Click(object sender, EventArgs e)
    {
        LBMSG.Visible = true;
        if (TextBoxNewPhone.Text != "")
        {
            saveData(5555501, "IsNewPhone");
            saveData(5555502, TextBoxNewPhone.Text);
            LBMSG.Text = "Сохранено!";
            standartNext(sender, e);

            LBMSG.Text = "";
            LBMSG.Visible = false;
        } 

        else
        {
            LBMSG.Text = "Укажите номер для перезвона!";


        }

    }
     
     


     

         
    protected void CheckBoxOther_CheckedChanged(object sender, EventArgs e)
    {
        var CheckBoxOther = sender as CheckBox;
        foreach (Control c in CheckBoxOther.Parent.Controls)
        {
            if (c is TextBox)
            {
                (c as TextBox).Visible = CheckBoxOther.Checked;
            }
            if (c is RequiredFieldValidator)
            {
                (c as RequiredFieldValidator).Enabled = CheckBoxOther.Checked;
            }
        }
    } 
      


     

      
     
                           
    protected void QAC_Button_A1_2(object sender, EventArgs e)
    {
        var cod = (sender as Button).CommandArgument;

        if (quoteCountRoom(cod))
        {
            LBMSG.Visible = false;
            LBMSG.Text = "";
            (sender as Button).CommandName = "Panel32";
        }
        else
        {
            LBMSG.Visible = true;
            LBMSG.Text = "Квота по '" + (sender as Button).Text + "' выполнена";
            (sender as Button).CommandName = "Panel3";
        }


        QAC_Button(sender, e);
    }

      

    protected void QAC_Button_Q11(object sender, EventArgs e)
    {
        HiddenFieldQ11.Value = (sender as Button).CommandArgument;
        QAC_TextBox(sender, e);
    }

        

    protected void QAC_Button_Q17(object sender, EventArgs e)
    {
       
        QAC_Button(sender, e);
    }

    protected void CheckBoxListQ17А_PreRender(object sender, EventArgs e)
    {
     
    }
    protected void QAC_Button_Q18(object sender, EventArgs e)
    {

        QAC_Button(sender, e);
    }
    protected void CheckBoxListQ19А_PreRender(object sender, EventArgs e)
    {

    }
     
    protected void CheckBoxA5_CheckedChanged(object sender, EventArgs e)
    {
        var CheckBoxOther = sender as CheckBox;
        foreach (Control c in CheckBoxOther.Parent.Controls)
        {
            if (c is TextBox)
            {
                (c as TextBox).Visible = CheckBoxOther.Checked;
            }
            if (c is RequiredFieldValidator)
            {
                (c as RequiredFieldValidator).Enabled = CheckBoxOther.Checked;
            }
        }
    }

         
    

    protected void CheckBoxListA5_CheckedChanged(object sender, EventArgs e)
    {
        var CheckBoxOther = sender as CheckBoxList;
        foreach (Control c in CheckBoxOther.Parent.Controls)
        {
            if (c is TextBox)
            {
                (c as TextBox).Visible = CheckBoxOther.Items.FindByValue("3").Selected;
            }
            if (c is RequiredFieldValidator)
            {
                (c as RequiredFieldValidator).Enabled = CheckBoxOther.Items.FindByValue("3").Selected;
            }
        }
    }

    


    protected bool quoteCountRoom(string code)
    {
        
        if (!(HiddenField1.Value != "1")) return true;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        bool is_quote = true;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[checkQuoteCountRoom] " + HF_cid.Value + ",'" + code + "', "+HF_Abonent_ID.Value+"", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                if (myOdbcReader.GetString(0) == "0")
                {
                    is_quote = false;
                }
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }


    protected void QAC_Button_S0(object sender, EventArgs e)
    {
        HiddenFieldS0_1.Value = (sender as Button).CommandArgument;
        QAC_Button(sender, e);
    }


    protected void QAC_Button_S1(object sender, EventArgs e)
    {
        if (!quoteCountSexAge((sender as Button).CommandArgument + '_' + HiddenFieldS0_1.Value)) 
            (sender as Button).CommandName = "Panel69_s1";
        else
            (sender as Button).CommandName = "Panel24";
        QAC_Button(sender, e);
    }


    protected void QAC_Button_D1(object sender, EventArgs e)
    {
        if (!quoteCountObr((sender as Button).CommandArgument))
            (sender as Button).CommandName = "Panel69_q1";
        else
            (sender as Button).CommandName = "Panel34";
        QAC_Button(sender, e);
    }



    protected void QAC_Button_S2(object sender, EventArgs e)
    {
        if (!quoteCountFO((sender as Button).CommandArgument))
            (sender as Button).CommandName = "Panel69_s2";
        else
            (sender as Button).CommandName = "Panel31";
        QAC_Button(sender, e);
    }



    protected bool quoteCountSexAge(string code)
    {

        if (!(HiddenField1.Value != "1")) return true;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        bool is_quote = true;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[checkQuoteInclusiveSexAge] " + HF_cid.Value + ",'" + code + "', " + HF_Abonent_ID.Value + "", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                if (myOdbcReader.GetString(0) == "0")
                {
                    is_quote = false;
                }
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }


    protected bool quoteCountObr(string code)
    {

        if (!(HiddenField1.Value != "1")) return true;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        bool is_quote = true;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[checkQuoteInclusiveObr] " + HF_cid.Value + ",'" + code + "', " + HF_Abonent_ID.Value + "", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                if (myOdbcReader.GetString(0) == "0")
                {
                    is_quote = false;
                }
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }

    protected bool quoteCountFO(string code)
    {

        if (!(HiddenField1.Value != "1")) return true;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        bool is_quote = true;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[checkQuoteInclusiveFO] " + HF_cid.Value + ",'" + code + "', " + HF_Abonent_ID.Value + "", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                if (myOdbcReader.GetString(0) == "0")
                {
                    is_quote = false;
                }
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }

    protected void QAC_CheckBoxList_S3(object sender, EventArgs e)
    {
        int TypeQuote = 0;
        int Select = 0; 
 

        if (CheckBoxListS3.Items[0].Selected
            && !CheckBoxListS3.Items[1].Selected
            && !CheckBoxListS3.Items[2].Selected
            && !CheckBoxListS3.Items[3].Selected
            && !CheckBoxListS3.Items[4].Selected
            ) { TypeQuote = 1; Select = 1; }
        else if (!CheckBoxListS3.Items[0].Selected
            && (CheckBoxListS3.Items[1].Selected
            || CheckBoxListS3.Items[2].Selected
            || CheckBoxListS3.Items[3].Selected
            || CheckBoxListS3.Items[4].Selected
            )
            ) {TypeQuote = 2; Select = 2; }
        else
        {
            TypeQuote = minQuoteType(); Select = 3; 
           
        }
        saveData(60000, TypeQuote.ToString());

        HiddenFieldS4.Value = Select.ToString(); 

        if (!quoteTypeCustomer(TypeQuote))
            (sender as Button).CommandName = "Panel69_s2";
        else
            (sender as Button).CommandName = "Panel34";
        QAC_CheckBoxList(sender, e);
    }
    protected void QAC_Button_S4(object sender, EventArgs e)
    {
        if (!quoteRegion((sender as Button).CommandArgument))
            (sender as Button).CommandName = "Panel69_s2";
        else
        {
            (sender as Button).CommandName = HiddenFieldS4.Value == "2"|| HiddenFieldS4.Value=="3" ? "Panel59" : "Panel30";
            Button60.CommandName = HiddenFieldS4.Value == "3" ? "Panel30" : "Panel4";
            Button28.CommandName = HiddenFieldS4.Value == "3" ? "Panel30" : "Panel4";
        }
        QAC_Button(sender, e);
    }

    private bool quoteRegion(string RegionCode)
    {

        if (!(HiddenField1.Value != "1")) return true;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        bool is_quote = true;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[RusOpros_checkQuoteRegion] " + HF_cid.Value + ",'" + RegionCode + "', " + HF_Abonent_ID.Value + "", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                if (myOdbcReader.GetString(0) == "0")
                {
                    is_quote = false;
                }
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }


    private bool quoteTypeCustomer(int code)
    {


        if (!(HiddenField1.Value != "1")) return true;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        bool is_quote = true;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[RusOpros_checkQuoteTypeCustomer] " + HF_cid.Value + ",'" + code + "', " + HF_Abonent_ID.Value + "", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                if (myOdbcReader.GetString(0) == "0")
                {
                    is_quote = false;
                }
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }

    private int minQuoteType()
    {

        if (!(HiddenField1.Value != "1")) return 1;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];

        // If found, return the connection string.
        int is_quote = 1;

        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand(" dbo.[RusOpros_minQuoteType] " + HF_cid.Value + " ", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            { 
                    is_quote = Convert.ToInt32(myOdbcReader.GetString(0)); 
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();



            //is_quote = false;

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
        return is_quote;
    }
    protected void QAC_Q6(object sender, EventArgs e)
    {
        saveData(601, CheckBoxQ6_1_1.Checked ? "1" : "");
        saveData(602, CheckBoxQ6_1_2.Checked ? "1" : "");
        saveData(603, CheckBoxQ6_1_3.Checked ? "1" : "");
        saveData(604, CheckBoxQ6_1_4.Checked ? "1" : "");
        saveData(605, CheckBoxQ6_1_5.Checked ? "1" : "");
        saveData(606, CheckBoxQ6_1_6.Checked ? "1" : "");
        saveData(607, CheckBoxQ6_1_7.Checked ? "1" : "");
        saveData(608, CheckBoxQ6_1_8.Checked ? "1" : "");
        saveData(609, CheckBoxQ6_1_9.Checked ? "1" : "");
        saveData(610, CheckBoxQ6_1_10.Checked ? "1" : "");
        saveData(611, CheckBoxQ6_1_11.Checked ? "1" : "");
        saveData(612, CheckBoxQ6_1_12.Checked ? "1" : "");
        saveData(613, CheckBoxQ6_1_13.Checked ? "1" : "");
        saveData(614, CheckBoxQ6_1_14.Checked ? "1" : "");
        saveData(615, CheckBoxQ6_1_15.Checked ? "1" : "");
        saveData(616, CheckBoxQ6_1_16.Checked ? "1" : "");
        saveData(617, CheckBoxQ6_1_17.Checked ? "1" : "");

        saveData(611, CheckBoxQ6_2_1.Checked ? "1" : "");
        saveData(612, CheckBoxQ6_2_2.Checked ? "1" : "");
        saveData(613, CheckBoxQ6_2_3.Checked ? "1" : "");
        saveData(614, CheckBoxQ6_2_4.Checked ? "1" : "");
        saveData(615, CheckBoxQ6_2_5.Checked ? "1" : "");
        saveData(616, CheckBoxQ6_2_6.Checked ? "1" : "");
        saveData(617, CheckBoxQ6_2_7.Checked ? "1" : "");
        saveData(618, CheckBoxQ6_2_8.Checked ? "1" : "");
        saveData(619, CheckBoxQ6_2_9.Checked ? "1" : "");
        saveData(620, CheckBoxQ6_2_10.Checked ? "1" : "");
        saveData(621, CheckBoxQ6_2_11.Checked ? "1" : "");
        saveData(622, CheckBoxQ6_2_12.Checked ? "1" : "");
        saveData(623, CheckBoxQ6_2_13.Checked ? "1" : "");
        saveData(624, CheckBoxQ6_2_14.Checked ? "1" : "");
        saveData(625, CheckBoxQ6_2_15.Checked ? "1" : "");
        saveData(626, CheckBoxQ6_2_16.Checked ? "1" : "");
        saveData(627, CheckBoxQ6_2_17.Checked ? "1" : "");

        saveData(621, CheckBoxQ6_3_1.Checked ? "1" : "");
        saveData(622, CheckBoxQ6_3_2.Checked ? "1" : "");
        saveData(623, CheckBoxQ6_3_3.Checked ? "1" : "");
        saveData(624, CheckBoxQ6_3_4.Checked ? "1" : "");
        saveData(625, CheckBoxQ6_3_5.Checked ? "1" : "");
        saveData(626, CheckBoxQ6_3_6.Checked ? "1" : "");
        saveData(627, CheckBoxQ6_3_7.Checked ? "1" : "");
        saveData(628, CheckBoxQ6_3_8.Checked ? "1" : "");
        saveData(629, CheckBoxQ6_3_9.Checked ? "1" : "");
        saveData(630, CheckBoxQ6_3_10.Checked ? "1" : "");
        saveData(631, CheckBoxQ6_3_11.Checked ? "1" : "");
        saveData(632, CheckBoxQ6_3_12.Checked ? "1" : "");
        saveData(633, CheckBoxQ6_3_13.Checked ? "1" : "");
        saveData(634, CheckBoxQ6_3_14.Checked ? "1" : "");
        saveData(635, CheckBoxQ6_3_15.Checked ? "1" : "");
        saveData(636, CheckBoxQ6_3_16.Checked ? "1" : "");
        saveData(637, CheckBoxQ6_3_17.Checked ? "1" : "");


      


        standartNext(sender, e);
    }


    protected void TableQ7_PreRender(object sender, EventArgs e)
    {
        for (int i = 1; i < TableQ6.Rows.Count; i++)
        {
            TableRow tr = TableQ6.Rows[i];
            TableQ7.Rows[i-1].Visible =
                (tr.Cells[3].Controls[0] as CheckBox).Checked;
        }
    }



    protected void TableQ13_PreRender(object sender, EventArgs e)
    {
        for (int i = 1; i < TableQ12.Rows.Count; i++)
        {
            TableRow tr = TableQ12.Rows[i];
            TableQ13.Rows[i - 1].Visible =
                (tr.Cells[3].Controls[0] as CheckBox).Checked;
        }
    }

    protected void QAC_Q7(object sender, EventArgs e)
    {

        saveData(701, DropDownListQ7_1.SelectedValue);
        saveData(702, DropDownListQ7_2.SelectedValue);
        saveData(703, DropDownListQ7_3.SelectedValue);
        saveData(704, DropDownListQ7_4.SelectedValue);
        saveData(705, DropDownListQ7_5.SelectedValue);
        saveData(706, DropDownListQ7_6.SelectedValue);
        saveData(707, DropDownListQ7_7.SelectedValue);
        saveData(708, DropDownListQ7_8.SelectedValue);
        saveData(709, DropDownListQ7_9.SelectedValue);
        saveData(710, DropDownListQ7_10.SelectedValue);
        saveData(711, DropDownListQ7_11.SelectedValue);
        saveData(712, DropDownListQ7_12.SelectedValue);
        saveData(713, DropDownListQ7_13.SelectedValue);
        saveData(714, DropDownListQ7_14.SelectedValue);
        saveData(715, DropDownListQ7_15.SelectedValue);
        saveData(716, DropDownListQ7_16.SelectedValue);
        saveData(717, DropDownListQ7_17.SelectedValue);


        if (
            (DropDownListQ7_1.SelectedIndex < 0 && TableQ7.Rows[0].Visible)
            || (DropDownListQ7_2.SelectedIndex < 0 && TableQ7.Rows[1].Visible)
            || (DropDownListQ7_3.SelectedIndex < 0 && TableQ7.Rows[2].Visible)
            || (DropDownListQ7_4.SelectedIndex < 0 && TableQ7.Rows[3].Visible)
            || (DropDownListQ7_5.SelectedIndex < 0 && TableQ7.Rows[4].Visible)
            || (DropDownListQ7_6.SelectedIndex < 0 && TableQ7.Rows[5].Visible)
            || (DropDownListQ7_7.SelectedIndex < 0 && TableQ7.Rows[6].Visible)
            || (DropDownListQ7_8.SelectedIndex < 0 && TableQ7.Rows[7].Visible)
            || (DropDownListQ7_9.SelectedIndex < 0 && TableQ7.Rows[8].Visible)
            || (DropDownListQ7_10.SelectedIndex < 0 && TableQ7.Rows[9].Visible)
            || (DropDownListQ7_11.SelectedIndex < 0 && TableQ7.Rows[10].Visible)
            || (DropDownListQ7_12.SelectedIndex < 0 && TableQ7.Rows[11].Visible)
            || (DropDownListQ7_13.SelectedIndex < 0 && TableQ7.Rows[12].Visible)
            || (DropDownListQ7_14.SelectedIndex < 0 && TableQ7.Rows[13].Visible)
            || (DropDownListQ7_15.SelectedIndex < 0 && TableQ7.Rows[14].Visible)
            || (DropDownListQ7_16.SelectedIndex < 0 && TableQ7.Rows[15].Visible)
            || (DropDownListQ7_17.SelectedIndex < 0 && TableQ7.Rows[16].Visible)
            )
        {
            LBMSG.Visible = true;
            LBMSG.Text = "Укажите ответ по каждой марке";
            return;
        }
        else {
            LBMSG.Visible = false;
            LBMSG.Text = "";
        };

        Button66.CommandName
            = (CheckBoxQ6_1_1.Checked || CheckBoxQ6_1_10.Checked) ? "Panel29" : "Panel30"; 

        Button3.CommandName =Button24.CommandName =Button27.CommandName =
            Button42.CommandName =


            (CheckBoxQ6_2_1.Checked && CheckBoxQ6_2_10.Checked) ? "Panel65" : "Panel30";
        /*
        Button60.CommandName = (CheckBoxQ6_2_2.Checked 
            || CheckBoxQ6_2_3.Checked
            || CheckBoxQ6_2_4.Checked
            || CheckBoxQ6_2_5.Checked
            || CheckBoxQ6_2_6.Checked
            || CheckBoxQ6_2_7.Checked
            || CheckBoxQ6_2_8.Checked
            || CheckBoxQ6_2_9.Checked
            ) ? "Panel30" : (HiddenFieldS4.Value == "3" ? "Panel66" : "Panel5");
            */

        standartNext(sender, e);
    }
    protected void QAC_Q12(object sender, EventArgs e)
    {

        saveData(1201, CheckBoxQ12_1_1.Checked ? "1" : "");
        saveData(1202, CheckBoxQ12_1_2.Checked ? "1" : "");
        saveData(1203, CheckBoxQ12_1_3.Checked ? "1" : "");
        saveData(1204, CheckBoxQ12_1_4.Checked ? "1" : "");
        saveData(1205, CheckBoxQ12_1_5.Checked ? "1" : "");
        saveData(1206, CheckBoxQ12_1_6.Checked ? "1" : "");
        saveData(1207, CheckBoxQ12_1_7.Checked ? "1" : "");
        saveData(1208, CheckBoxQ12_1_8.Checked ? "1" : "");
        saveData(1209, CheckBoxQ12_1_9.Checked ? "1" : "");
        saveData(1210, CheckBoxQ12_1_10.Checked ? "1" : "");
        saveData(1211, CheckBoxQ12_1_11.Checked ? "1" : "");
        saveData(1212, CheckBoxQ12_1_12.Checked ? "1" : "");

        saveData(1211, CheckBoxQ12_2_1.Checked ? "1" : "");
        saveData(1212, CheckBoxQ12_2_2.Checked ? "1" : "");
        saveData(1213, CheckBoxQ12_2_3.Checked ? "1" : "");
        saveData(1214, CheckBoxQ12_2_4.Checked ? "1" : "");
        saveData(1215, CheckBoxQ12_2_5.Checked ? "1" : "");
        saveData(1216, CheckBoxQ12_2_6.Checked ? "1" : "");
        saveData(1217, CheckBoxQ12_2_7.Checked ? "1" : "");
        saveData(1218, CheckBoxQ12_2_8.Checked ? "1" : "");
        saveData(1219, CheckBoxQ12_2_9.Checked ? "1" : "");
        saveData(1220, CheckBoxQ12_2_10.Checked ? "1" : "");
        saveData(1221, CheckBoxQ12_2_11.Checked ? "1" : "");
        saveData(1223, CheckBoxQ12_2_12.Checked ? "1" : "");

        saveData(1221, CheckBoxQ12_3_1.Checked ? "1" : "");
        saveData(1222, CheckBoxQ12_3_2.Checked ? "1" : "");
        saveData(1223, CheckBoxQ12_3_3.Checked ? "1" : "");
        saveData(1224, CheckBoxQ12_3_4.Checked ? "1" : "");
        saveData(1225, CheckBoxQ12_3_5.Checked ? "1" : "");
        saveData(1226, CheckBoxQ12_3_6.Checked ? "1" : "");
        saveData(1227, CheckBoxQ12_3_7.Checked ? "1" : "");
        saveData(1228, CheckBoxQ12_3_8.Checked ? "1" : "");
        saveData(1229, CheckBoxQ12_3_9.Checked ? "1" : "");
        saveData(1230, CheckBoxQ12_3_10.Checked ? "1" : "");
        saveData(1231, CheckBoxQ12_3_11.Checked ? "1" : "");
        saveData(1232, CheckBoxQ12_3_12.Checked ? "1" : "");

        standartNext(sender, e);
    }
    protected void QAC_Q13(object sender, EventArgs e)
    {

        saveData(1301, DropDownListQ13_1.SelectedValue);
        saveData(1302, DropDownListQ13_2.SelectedValue);
        saveData(1303, DropDownListQ13_3.SelectedValue);
        saveData(1304, DropDownListQ13_4.SelectedValue);
        saveData(1305, DropDownListQ13_5.SelectedValue);
        saveData(1306, DropDownListQ13_6.SelectedValue);
        saveData(1307, DropDownListQ13_7.SelectedValue);
        saveData(1308, DropDownListQ13_8.SelectedValue);
        saveData(1309, DropDownListQ13_9.SelectedValue);
        saveData(1310, DropDownListQ13_10.SelectedValue);
        saveData(1311, DropDownListQ13_11.SelectedValue);
        saveData(1312, DropDownListQ13_12.SelectedValue);


        if (
            (DropDownListQ13_1.SelectedIndex < 0 && TableQ13.Rows[0].Visible)
            || (DropDownListQ13_2.SelectedIndex < 0 && TableQ13.Rows[1].Visible)
            || (DropDownListQ13_3.SelectedIndex < 0 && TableQ13.Rows[2].Visible)
            || (DropDownListQ13_4.SelectedIndex < 0 && TableQ13.Rows[3].Visible)
            || (DropDownListQ13_5.SelectedIndex < 0 && TableQ13.Rows[4].Visible)
            || (DropDownListQ13_6.SelectedIndex < 0 && TableQ13.Rows[5].Visible)
            || (DropDownListQ13_7.SelectedIndex < 0 && TableQ13.Rows[6].Visible)
            || (DropDownListQ13_8.SelectedIndex < 0 && TableQ13.Rows[7].Visible)
            || (DropDownListQ13_9.SelectedIndex < 0 && TableQ13.Rows[8].Visible)
            || (DropDownListQ13_10.SelectedIndex < 0 && TableQ13.Rows[9].Visible)
            || (DropDownListQ13_11.SelectedIndex < 0 && TableQ13.Rows[10].Visible)
            || (DropDownListQ13_12.SelectedIndex < 0 && TableQ13.Rows[11].Visible)             
            )
        {
            LBMSG.Visible = true;
            LBMSG.Text = "Укажите ответ по каждой марке";
            return;
        }
        else
        {
            LBMSG.Visible = false;
            LBMSG.Text = "";
        }
         
        standartNext(sender, e);
    }


    protected void QAC_Q15(object sender, EventArgs e)
    {

        saveData(1501, TextBoxQ15_1.Text);
        saveData(1502, TextBoxQ15_2.Text);

        standartNext(sender, e);
    }

    protected void QAC_Button_Q14(object sender, EventArgs e)
    {

        (sender as Button).CommandName = CheckBoxQ12_2_1.Checked ? "Panel76" : "Panel4";
        Button46.CommandName = (CheckBoxQ12_2_2.Checked
                        || CheckBoxQ12_2_3.Checked
                        || CheckBoxQ12_2_4.Checked
                        || CheckBoxQ12_2_5.Checked
                        || CheckBoxQ12_2_6.Checked
                        || CheckBoxQ12_2_7.Checked
                        || CheckBoxQ12_2_8.Checked
                        || CheckBoxQ12_2_9.Checked
                        || CheckBoxQ12_2_10.Checked 
            )? "Panel4" : "Panel4";

        QAC_Button(sender, e);
    }
    protected void CheckBoxQ17_8_CheckedChanged(object sender, EventArgs e)
    {
        TextBoxQ17_8.Visible = RequiredFieldValidator5.Enabled = CheckBoxQ17_8.Checked;
    } 
    protected void QAC_Q17(object sender, EventArgs e)
    {

        saveData(1701, CheckBoxQ17_1.Checked ? "1" : "");
        saveData(1702, CheckBoxQ17_2.Checked ? "1" : "");
        saveData(1703, CheckBoxQ17_3.Checked ? "1" : "");
        saveData(1704, CheckBoxQ17_4.Checked ? "1" : "");
        saveData(1705, CheckBoxQ17_5.Checked ? "1" : "");
        saveData(1706, CheckBoxQ17_6.Checked ? "1" : ""); 
        saveData(1708, CheckBoxQ17_8.Checked ? "1" : "");
        saveData(1799, CheckBoxQ17_8.Checked ? TextBoxQ17_8.Text : "");


         
        standartNext(sender, e);
    }


    protected void CheckBoxQ18_17_CheckedChanged(object sender, EventArgs e)
    {
        TextBoxQ18_17.Visible = RequiredFieldValidator14.Enabled = CheckBoxQ18_17.Checked;
    }
    protected void QAC_Q18(object sender, EventArgs e)
    { 
        saveData(1802, CheckBoxQ18_2.Checked ? "1" : "");
        saveData(1803, CheckBoxQ18_3.Checked ? "1" : "");
        saveData(1804, CheckBoxQ18_4.Checked ? "1" : "");
        saveData(1805, CheckBoxQ18_5.Checked ? "1" : "");
        saveData(1806, CheckBoxQ18_6.Checked ? "1" : "");
        saveData(1807, CheckBoxQ18_7.Checked ? "1" : "");
        saveData(1808, CheckBoxQ18_8.Checked ? "1" : "");
        saveData(1809, CheckBoxQ18_9.Checked ? "1" : "");
        saveData(1810, CheckBoxQ18_10.Checked ? "1" : "");
        saveData(1811, CheckBoxQ18_11.Checked ? "1" : "");
        saveData(1812, CheckBoxQ18_12.Checked ? "1" : "");
        saveData(1813, CheckBoxQ18_13.Checked ? "1" : "");
        saveData(1814, CheckBoxQ18_14.Checked ? "1" : "");
        saveData(1815, CheckBoxQ18_15.Checked ? "1" : "");
        saveData(1816, CheckBoxQ18_16.Checked ? "1" : "");
        saveData(1817, CheckBoxQ18_17.Checked ? "1" : "");
        saveData(1899, CheckBoxQ18_7.Checked ? TextBoxQ18_17.Text : "");

        standartNext(sender, e);
    }
    protected void QAC_Q19(object sender, EventArgs e)
    {

        saveData(1911, TextBoxQ19_1.Text);
        saveData(1912, TextBoxQ19_2.Text);
        saveData(1913, TextBoxQ19_3.Text);
        saveData(1914, TextBoxQ19_4.Text);
        saveData(1915, TextBoxQ19_5.Text);
        saveData(1916, TextBoxQ19_6.Text);
        saveData(1917, TextBoxQ19_7.Text);
        saveData(1918, TextBoxQ19_8.Text); 

        //if  
        //    (
        //    TextBoxQ19_1.Text=="" 
        //    || TextBoxQ19_2.Text == ""
        //    || TextBoxQ19_3.Text == ""
        //    || TextBoxQ19_4.Text == ""
        //    || TextBoxQ19_5.Text == ""
        //    || TextBoxQ19_6.Text == ""
        //    || TextBoxQ19_7.Text == ""
        //    || TextBoxQ19_8.Text == ""  
        //    )
        //{
        //    LBMSG.Visible = true;
        //    LBMSG.Text = "Укажите ответ по каждой марке";
        //    return;
        //}
        //else
        //{
        //    LBMSG.Visible = false;
        //    LBMSG.Text = "";
        //}
         

        standartNext(sender, e);
    }
    protected void QAC_Q9(object sender, EventArgs e)
    {

        saveData(901, TextBoxQ9_1.Text);
        saveData(902, TextBoxQ9_2.Text); 
        standartNext(sender, e);
    } 
    protected void CheckBoxQ6_1_1_CheckedChanged(object sender, EventArgs e)
    {
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[3].Controls[0] as CheckBox).Enabled =
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[4].Controls[0] as CheckBox).Enabled =
            (sender as CheckBox).Checked;
        if (!(sender as CheckBox).Checked)
        {
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[3].Controls[0] as CheckBox).Checked =
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[4].Controls[0] as CheckBox).Checked = false;
        }
    }
    protected void QAC_Q10(object sender, EventArgs e)
    { 
        saveData(1001, TextBoxQ10.Text);
        saveData(1002, TextBoxQ10_2.Text);
        standartNext(sender, e);
    }
    protected void QAC_Q16(object sender, EventArgs e)
    {
        saveData(1601, TextBoxQ16.Text);
        saveData(1602, TextBoxQ16_2.Text);
        standartNext(sender, e);
    }
    protected void CheckBoxQ19_6_1_CheckedChanged(object sender, EventArgs e)
    {
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[2].Controls[0] as CheckBox).Enabled =
           (((sender as CheckBox).Parent.Parent as TableRow).Cells[3].Controls[0] as CheckBox).Enabled =
           (((sender as CheckBox).Parent.Parent as TableRow).Cells[4].Controls[0] as CheckBox).Enabled =
           (((sender as CheckBox).Parent.Parent as TableRow).Cells[5].Controls[0] as CheckBox).Enabled =
           (((sender as CheckBox).Parent.Parent as TableRow).Cells[6].Controls[0] as CheckBox).Enabled =
               !(sender as CheckBox).Checked;
        if ((sender as CheckBox).Checked)
        {
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[2].Controls[0] as CheckBox).Checked =
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[3].Controls[0] as CheckBox).Checked =
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[4].Controls[0] as CheckBox).Checked =
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[5].Controls[0] as CheckBox).Checked =
            (((sender as CheckBox).Parent.Parent as TableRow).Cells[6].Controls[0] as CheckBox).Checked = 
                false;
        }
    }




    protected void QAC_CheckBoxList_Q20(object sender, EventArgs e)
    {
        QAC_CheckBoxList(sender, e, "Уажите ТРИ варианта ответа");
    }

    protected void QAC_CheckBoxList_Q21(object sender, EventArgs e)
    {
        QAC_CheckBoxList(sender, e, "Уажите ТРИ варианта ответа");
    }


}