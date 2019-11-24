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

    private string Column_11 = ""; //профессия
    private string Column_12 = ""; //email
    private string Column_13 = ""; //отрасль, профиль
    private string Column_14 = "";
    private string Column_15 = "";
    private string Column_10 = "";
    private string Column_7 = "";
    private string Column_17 = ""; //TRUE FALSE
    private string Column_9 = ""; //кампания
    protected void Page_Load(object sender, EventArgs e)
    {
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
            Label1.Text = Request.QueryString["OperatorName"];
            is_mobile = Request.QueryString["is_mobile"] != null && Request.QueryString["is_mobile"].ToString() == "1";


            if (Request.QueryString["Column_17"] != null)
                Column_17 = HttpUtility.UrlDecode(Request.QueryString["Column_17"], Encoding.GetEncoding("windows-1251"));

            Column_10 = Request.QueryString["Column_10"] != null ? Request.QueryString["Column_10"].ToString() : "";
            Column_11 = Request.QueryString["Column_11"] != null ? Request.QueryString["Column_11"].ToString() : "";
            Column_12 = Request.QueryString["Column_12"] != null ? Request.QueryString["Column_12"].ToString() : "";
            Column_13 = Request.QueryString["Column_13"] != null ? Request.QueryString["Column_13"].ToString() : "";
            Column_14 = Request.QueryString["Column_14"] != null ? Request.QueryString["Column_14"].ToString() : "";
            Column_7 = Request.QueryString["Column_7"] != null ? Request.QueryString["Column_7"].ToString() : "";
            Column_9 = Request.QueryString["Column_9"] != null ? Request.QueryString["Column_9"].ToString() : "";
          //  TextBoxA17.Text = Request.QueryString["PhoneNumber"] != null ? Request.QueryString["PhoneNumber"].ToString() : "";
          //  Label3.Text = Request.QueryString["Column_5"] != null ? Request.QueryString["Column_5"].ToString() : "";
            HiddenFieldColumn_11.Value = Column_11;
            HiddenFieldColumn_12.Value = Column_12;
            HiddenFieldColumn_13.Value = Column_13;
            HiddenFieldColumn_14.Value = Column_14;
            HiddenFieldColumn_17.Value = Column_17.ToString();
            HiddenFieldColumn_9.Value = Column_9.ToString();


            IterateControls(Page, Column_11, "Column_11");
            IterateControls(Page, Column_9, "Column_9");
            IterateControls(Page, Column_13, "Column_13");

            var Is1 = Column_9 != "" && Column_11 != "" && Column_13 != "";
            var Is2 = Column_9 == "" && Column_11 != "" && Column_13 == "";
            var Is3 = !Is1 && !Is2;

            if (Is3)
            {

            }
            else if (Is2)
            {

            }
            else
            {

            }



            //Panel1_2.Visible = Column_10 == "";
            //Panel1.Visible = !Panel1_2.Visible;

            Column_15 = Request.QueryString["Column_15"] != null ? Request.QueryString["Column_15"].ToString() : "";
            HiddenFieldColumn_15.Value = Column_15;
            //LabelCamp_1.Text = Column_15;
            //LabelCamp_2.Text = Column_15;
            // PanelOtr_2.Visible = !(Column_15 != "");
            // PanelOtr_1.Visible = (Column_15 != "");
            // PanelOtr_2_2.Visible = !(Column_15 != "");
            // PanelOtr_1_2.Visible = (Column_15 != "");
            //Button12_1.CommandName = Column_15 != "" ? "Panel5_camp" : "Panel4";

            //  LabelCamp_Otr_1.Text = LabelCamp_Otr_2.Text = Column_15;

            HiddenField1.Value = debug;

            //saveData(17, TextBoxA17.Text);
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
                if (((Label)c).Attributes["type"] != null && ((Label)c).Attributes["type"].ToString() == "cod")
                    ((Label)c).Text = ((Button)sender).CommandArgument;
            }
            if (c is HiddenField)
            {

                ((HiddenField)c).Value = ((Button)sender).CommandArgument;
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

    protected void QAC_CheckBoxList(object sender, EventArgs e)
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
                    LBMSG.Text = "Укажите хотя бы один пункт";
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




    protected void QAC_TextBox_S2(object sender, EventArgs e)
    {
        //((Button)sender).CommandName = Convert.ToInt32(TextBoxS2.Text) < 20 ? "Panel3" : "Panel5";
        QAC_TextBox(sender, e);
    }


    protected void standartNextA2(object sender, EventArgs e)
    {


        standartNext(sender, e);
    }





















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
    protected void QAC_CheckBoxList_A2(object sender, EventArgs e)
    {

        QAC_CheckBoxList(sender, e);
    }
    protected void QAC_TextBox_A4_1(object sender, EventArgs e)
    {
        /*  if (HiddenFieldColumn_17.Value == "ЛОЖЬ" && TextBoxA4_1.Text != "" && (TextBoxA4_1.Text == HiddenFieldColumn_13.Value || TextBoxA4_1.Text == HiddenFieldColumn_14.Value))
              Button12.CommandName = HiddenFieldColumn_15.Value != "" ? "Panel5_camp" : "Panel4";
          else
              Button12.CommandName = HiddenFieldColumn_15.Value != "" ? "Panel5_camp" : "Panel4";*/
        QAC_TextBox(sender, e);
    }




    protected void QAC_Button_3(object sender, EventArgs e)
    {

        // ButtonA8_2.CommandName = HiddenFieldColumn_15.Value != "" ? "Panel5_camp_2" : "Panel13";
        QAC_Button(sender, e);
    }

    /*
    protected void QAC_ButtonA7_1(object sender, EventArgs e)
    {
        if (HiddenFieldColumn_17.Value == "ЛОЖЬ"  )
            Button56.CommandName = "Panel60";
        else
            Button56.CommandName = "Panel17";
        QAC_Button(sender, e);
    }


    protected void QAC_TextBox_A21_2(object sender, EventArgs e)
    {
        if (HiddenFieldColumn_17.Value == "ЛОЖЬ" && TextBoxA21_2.Text != "" && (TextBoxA21_2.Text == HiddenFieldColumn_13.Value || TextBoxA21_2.Text == HiddenFieldColumn_14.Value))
            Button33.CommandName = "Panel61";
        else
            Button33.CommandName = "Panel41";
        QAC_TextBox(sender, e);
    }

    protected void QAC_TextBox_A21_2_3(object sender, EventArgs e)
    {
        if (HiddenFieldColumn_17.Value == "ЛОЖЬ" && TextBoxA21_2_3.Text != "" && (TextBoxA21_2_3.Text == HiddenFieldColumn_13.Value || TextBoxA21_2_3.Text == HiddenFieldColumn_14.Value))
            Button76.CommandName = "Panel62";
        else
            Button76.CommandName = "Panel50";
        QAC_TextBox(sender, e);
    }
    */




    protected void actualFIO(string FIO, string Dolgnost)
    {

        if (!(HiddenField1.Value != "1")) return;
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["CCAConnectionString"];



        //return is_quote;

        try
        {




            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("UPDATE OUTBOUND.dbo.Abonent_Info_1 SET Column_10 = '" + FIO + "', Column_11 = '" + Dolgnost + "' WHERE Campaign_ID = " + HF_cid.Value + " AND Abonent_ID = " + HF_Abonent_ID.Value
                + "; IF exists(select * from OUTBOUND.dbo.Abonent_Info  WHERE Abonent_ID = " + HF_Abonent_ID.Value + " AND  Column_ID = 10) "
                + " UPDATE OUTBOUND.dbo.Abonent_Info SET Column_Value = '" + FIO + "' WHERE Abonent_ID = " + HF_Abonent_ID.Value + " AND  Column_ID = 10; else "
                + " INSERT INTO OUTBOUND.dbo.Abonent_Info (Abonent_ID, Column_ID, Column_Value ) VALUES (" + HF_Abonent_ID.Value + ", 10,  '" + FIO + "' );   "
                + " IF exists(select * from OUTBOUND.dbo.Abonent_Info  WHERE Abonent_ID = " + HF_Abonent_ID.Value + " AND  Column_ID = 11) "
                + " UPDATE OUTBOUND.dbo.Abonent_Info SET Column_Value = '" + Dolgnost + "' WHERE Abonent_ID = " + HF_Abonent_ID.Value + " AND  Column_ID = 11; else "
                + " INSERT INTO OUTBOUND.dbo.Abonent_Info (Abonent_ID, Column_ID, Column_Value ) VALUES (" + HF_Abonent_ID.Value + " , 11,  '" + Dolgnost + "');   "
                , myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
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



      
    protected void TableA2_PreRender(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA2.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            TableA2.Rows[i].Visible = r.Selected;
        }
    }

    protected void QAC_A2(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA2.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i]; 
            var r2 = TableA2.FindControl("CheckBoxListA2_" + (i + 1).ToString()) as CheckBoxList;
            for (int j = 0; j < r2.Items.Count; j++) {
                ListItem li = r2.Items[j];
                saveData(200100 + (i * 100) + j, r.Selected ?(li.Selected?"1":"") : "");
            }
        }
         
        standartNext(sender, e);
    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void TableA5a_PreRender(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA5a.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            TableA5a.Rows[i].Visible = r.Selected;
        }
    }

    protected void RadioButtonListA5a_SelectedIndexChanged(object sender, EventArgs e)
    {
        var tb = ((sender as RadioButtonList).Parent.FindControl("TextBoxA5a_"+ (sender as RadioButtonList).ID.Replace("RadioButtonListA5a_",""))) as TextBox;
        tb.Visible = (sender as RadioButtonList).SelectedValue == "5";
    }

    protected void QAC_A5a(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA5a.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i]; 
            var r2 = TableA5a.FindControl("RadioButtonListA5a_" + (i + 1).ToString()) as RadioButtonList;
            var r3 = TableA5a.FindControl("TextBoxA5a_" + (i + 1).ToString()) as TextBox;

            saveData(50200 + (i * 10), r.Selected ? r2.SelectedValue : ""); 
            saveData(50200 + (i * 10)+1, r.Selected && r2.SelectedValue =="5" ? r3.Text : ""); 
        }

        standartNext(sender, e);
    }

    protected void TableA6_PreRender(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA6.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            TableA6.Rows[i].Visible = r.Selected;
        }
    }

    protected void QAC_A6(object sender, EventArgs e)
    {

        for (var i = 0; i < TableA6.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            var r2 = TableA6.FindControl("RadioButtonListA6_" + (i + 1).ToString()) as RadioButtonList; 

            saveData(600 + i, r.Selected ? r2.SelectedValue : ""); 
        }

        standartNext(sender, e);
    }

    protected void QAC_A7(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA7.Rows.Count - 1; i++)
        {
            var r2 = TableA7.FindControl("RadioButtonListA7_" + (i + 1).ToString()) as RadioButtonList;
            if (r2 != null)
                saveData(700 + i, r2.SelectedValue);
        }

        standartNext(sender, e);
    }




    protected void QAC_A9(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA9.Rows.Count - 1; i++)
        {
            var r2 = TableA9.FindControl("RadioButtonListA9_" + (i + 1).ToString()) as RadioButtonList;
            if (r2 != null)
                saveData(900 + i, r2.SelectedValue);
        }

        standartNext(sender, e);
    }


    protected void QAC_A10(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA10.Rows.Count; i++)
        {
            var r2 = TableA10.FindControl("TextBoxA10_" + (i + 1).ToString()) as TextBox;

            saveData(1000 + i, r2.Text);
        }
        saveData(1099, TextBoxA10_4_dr.Text);

        standartNext(sender, e);
    }

    protected void TableA14_PreRender(object sender, EventArgs e)
    {
        for (var i = 1; i < TableA14.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i-1];
            TableA14.Rows[i].Visible = r.Selected;
        }
    }

    protected void RadioButtonListA14_SelectedIndexChanged(object sender, EventArgs e)
    {

        var tb = ((sender as RadioButtonList).Parent.FindControl("TextBoxA14_" + (sender as RadioButtonList).ID.Replace("RadioButtonListA14_", ""))) as TextBox;
        tb.Visible = (sender as RadioButtonList).SelectedValue == "1" || (sender as RadioButtonList).SelectedValue == "2";
        (tb.Parent as TableCell).Controls[1].Visible = (sender as RadioButtonList).SelectedValue == "1";
        (tb.Parent as TableCell).Controls[2].Visible = (sender as RadioButtonList).SelectedValue == "2";
    }

    protected void QAC_A14(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA14.Rows.Count-1; i++)
        {
            var r = CheckBoxListA1.Items[i];
            var r2 = TableA14.FindControl("RadioButtonListA14_" + (i + 1).ToString()) as RadioButtonList;
            var r3 = TableA14.FindControl("TextBoxA14_" + (i + 1).ToString()) as TextBox;

            saveData(140200 + (i * 10), r.Selected ? r2.SelectedValue : "");
            saveData(140200 + (i * 10) + 1, r.Selected && (r2.SelectedValue == "1"|| r2.SelectedValue == "2") ? r3.Text : "");
        }

        standartNext(sender, e);
    }

    protected void RadioButtonListA15_SelectedIndexChanged(object sender, EventArgs e)
    {

        var tb = ((sender as RadioButtonList).Parent.FindControl("TextBoxA15_" + (sender as RadioButtonList).ID.Replace("RadioButtonListA15_", ""))) as TextBox;
        tb.Visible = (sender as RadioButtonList).SelectedValue == "1";
        (tb.Parent as TableCell).Controls[1].Visible = (sender as RadioButtonList).SelectedValue == "1";
    }

    protected void QAC_A15(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA15.Rows.Count; i++)
        { 
            var r2 = TableA15.FindControl("RadioButtonListA15_" + (i + 1).ToString()) as RadioButtonList;
            var r3 = TableA15.FindControl("TextBoxA15_" + (i + 1).ToString()) as TextBox;
            if(r2!=null)
            saveData(150200 + (i * 10),   r2.SelectedValue  );
            if (r3 != null && r2!=null)
            saveData(150200 + (i * 10) + 1,   r2.SelectedValue == "1" ? r3.Text : "");
        }

        saveData(1599, TextBoxA15_5_dr.Text );
        standartNext(sender, e);

    }


    protected void RadioButtonListA16_SelectedIndexChanged(object sender, EventArgs e)
    {

        var tb = ((sender as RadioButtonList).Parent.FindControl("TextBoxA16_" + (sender as RadioButtonList).ID.Replace("RadioButtonListA16_", ""))) as TextBox;
        tb.Visible = (sender as RadioButtonList).SelectedValue == "1";
        (tb.Parent as TableCell).Controls[1].Visible = (sender as RadioButtonList).SelectedValue == "1";
    }

    protected void QAC_A16(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA16.Rows.Count; i++)
        {
            var r2 = TableA16.FindControl("RadioButtonListA16_" + (i + 1).ToString()) as RadioButtonList;
            var r3 = TableA16.FindControl("TextBoxA16_" + (i + 1).ToString()) as TextBox;
            if (r2 != null)
                saveData(160200 + (i * 10), r2.SelectedValue);
            if (r3 != null && r2 != null)
                saveData(160200 + (i * 10) + 1, r2.SelectedValue == "1" ? r3.Text : "");
        }

        saveData(1699, TextBoxA16_5_dr.Text);
        standartNext(sender, e);

    }

    protected void TableA17_PreRender(object sender, EventArgs e)
    {
        for (var i = 1; i < TableA17.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i-1];
            TableA17.Rows[i].Visible = r.Selected;
        }
    }



    protected void QAC_A17(object sender, EventArgs e)
    {

        for (var i = 0; i < TableA17.Rows.Count-1; i++)
        {
            var r = CheckBoxListA1.Items[i];
            var r2 = TableA17.FindControl("TextBoxA17_" + (i + 1).ToString()) as TextBox;
            var r3 = TableA17.FindControl("TextBoxA17_2_" + (i + 1).ToString()) as TextBox;
            if (r2 != null)
                saveData(1700 + i, r.Selected ? r2.Text : "");
            if (r3 != null && r2 != null)
                saveData(1750 + i, r.Selected ? r3.Text : "");
        }

        standartNext(sender, e);
    }


    protected void QAC_TextBox_A18(object sender, EventArgs e)
    {
        var Any = false;
        for (var i = 0; i < TableA5a.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            var r2 = TableA2.FindControl("RadioButtonListA5a_" + (i + 1).ToString()) as RadioButtonList;
            if (r2.SelectedValue == "1" && r.Selected) Any = true;
        }
        Button116.CommandName = Any ? "Panel25" : "Panel15";
        QAC_TextBox(sender, e);
    }



    protected void QAC_Button_A18(object sender, EventArgs e)
    {
        var Any = false;
        for (var i = 0; i < TableA5a.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            var r2 = TableA2.FindControl("RadioButtonListA5a_" + (i + 1).ToString()) as RadioButtonList;
            if (r2 != null)
                if (r2.SelectedValue == "1" && r.Selected) Any = true;
        }
        Button38.CommandName = Any ? "Panel25" : "Panel15";
        QAC_Button(sender, e);
    }

    protected void QAC_A19(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA19.Rows.Count-1; i++)
        {
            var r2 = TableA19.FindControl("TextBoxA19_" + (i + 1).ToString()) as TextBox;
            if (r2 != null)
                saveData(1900 + i, r2.Text);
        }
        saveData(1999, TextBoxA19_5_dr.Text);

        standartNext(sender, e);
    }


    protected void RadioButtonListA21_SelectedIndexChanged(object sender, EventArgs e)
    {

        var tb = ((sender as RadioButtonList).Parent.FindControl("TextBoxA21_" + (sender as RadioButtonList).ID.Replace("RadioButtonListA21_", ""))) as TextBox;
        tb.Visible = (sender as RadioButtonList).SelectedValue == "1";
        (tb.Parent as TableCell).Controls[1].Visible = (sender as RadioButtonList).SelectedValue == "1";
    }



    protected void QAC_A21(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA21.Rows.Count-1; i++)
        {
            var r2 = TableA21.FindControl("RadioButtonListA21_" + (i + 1).ToString()) as RadioButtonList;
            var r3 = TableA21.FindControl("TextBoxA21_" + (i + 1).ToString()) as TextBox;
            if (r2 != null)
                saveData(210200 + (i * 10), r2.SelectedValue);
            if (r2 != null)
                saveData(210200 + (i * 10) + 1, r2.SelectedValue == "1" ? r3.Text : "");
        }

        saveData(2199, TextBoxA21_10_dr.Text);
        standartNext(sender, e);

    }


    protected void QAC_A24(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA24.Rows.Count-1; i++)
        {
            var r2 = TableA24.FindControl("RadioButtonListA24_" + (i + 1).ToString()) as RadioButtonList;
            if (r2 != null)
                saveData(2400 + (i), r2.SelectedValue); 
        }


        var Any = false;
        for (var i = 0; i < TableA5a.Rows.Count; i++)
        {
            var r = CheckBoxListA1.Items[i];
            var r2 = TableA2.FindControl("RadioButtonListA5a_" + (i + 1).ToString()) as RadioButtonList;
            if (r2.SelectedValue == "1" && r.Selected) Any = true;
        }
        Button52.CommandName = Any ? "Panel16" : "Panel18";

        standartNext(sender, e);

    }


    protected void QAC_A25(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA25.Rows.Count-1; i++)
        {
            var r2 = TableA25.FindControl("RadioButtonListA25_" + (i + 1).ToString()) as RadioButtonList;
            if (r2 != null)
                saveData(2500 + (i), r2.SelectedValue);
        }

        saveData(2599, TextBoxA25_5.Text);

        standartNext(sender, e);

    }

    protected void QAC_A26(object sender, EventArgs e)
    {
        for (var i = 0; i < TableA26.Rows.Count-1; i++)
        {
            var r2 = TableA26.FindControl("RadioButtonListA26_" + (i + 1).ToString()) as RadioButtonList;
            if (r2 != null)
                saveData(2600 + (i), r2.SelectedValue);
        }

        standartNext(sender, e);

    }
}