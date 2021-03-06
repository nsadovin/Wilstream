﻿using System;
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
            Label1.Text = Label2.Text = Request.QueryString["OperatorName"];
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
            TextBoxA17.Text = Request.QueryString["PhoneNumber"] != null ? Request.QueryString["PhoneNumber"].ToString() : "";
            Label3.Text = Request.QueryString["Column_5"] != null ? Request.QueryString["Column_5"].ToString() : "";
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

            saveData(17, TextBoxA17.Text);
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






    protected void CheckBoxA1_CheckedChanged(object sender, EventArgs e)
    {
        var IsChecked = (sender as CheckBox).Checked;
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[2].Controls[0] as TextBox).Visible = IsChecked;
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[3].Controls[0] as CheckBox).Visible = IsChecked;
    }


    protected void QAC_CheckBoxList_A3(object sender, EventArgs e)
    {
        var isStop = true;
        for (var i = 0; i < CheckBoxListA3.Items.Count; i++)
        {
            ListItem li = CheckBoxListA3.Items[i];
            if (li.Selected && i < 9)
                isStop = false;
            Button13.CommandName = isStop ? "Panel3" : "Panel2_4";
        }
        QAC_CheckBoxList(sender, e);
    }

    protected void QAC_A4(object sender, EventArgs e)
    {
        saveData(401, RadioButtonListA4_1.SelectedValue);
        saveData(402, RadioButtonListA4_2.SelectedValue);
        saveData(403, RadioButtonListA4_3.SelectedValue);
        saveData(404, RadioButtonListA4_4.SelectedValue);
        saveData(405, RadioButtonListA4_5.SelectedValue);
        saveData(406, RadioButtonListA4_6.SelectedValue);
        saveData(407, RadioButtonListA4_7.SelectedValue);
        saveData(408, RadioButtonListA4_8.SelectedValue);
        saveData(409, RadioButtonListA4_9.SelectedValue);
        var cnt = 0;
        for (var i = 0; i < 9; i++)
        {
            var r = TableA4.FindControl("RadioButtonListA4_" + (i + 1).ToString()) as RadioButtonList;
            TableA5.Rows[i].Visible = r.SelectedValue == "1" || r.SelectedValue == "999";
            if (r.SelectedValue == "1" || r.SelectedValue == "999")
            {
                cnt++;
            }
        }
        if (cnt == 1)
        {
            for (var i = 0; i < 9; i++)
            {
                var r = TableA4.FindControl("RadioButtonListA4_" + (i + 1).ToString()) as RadioButtonList;
                if (r.SelectedValue == "1" || r.SelectedValue == "999")
                {
                    saveData(501 + i, "1");
                }
            }
        }

        Button15.CommandName = "Panel26";
        if (cnt == 0) Button15.CommandName = "Panel3";
        if (cnt == 1) Button15.CommandName = "Panel4";


        standartNext(sender, e);
    }

    protected void TableA4_PreRender(object sender, EventArgs e)
    {
        for (var i = 0; i < 9; i++)
        {
            ListItem li = CheckBoxListA3.Items[i];
            if (HiddenFieldShowAll.Value == "1")
            {
                TableA4.Rows[i].Visible = true;
                (TableA4.Rows[i].FindControl("RequiredFieldValidatorA4_" + (i + 1).ToString()) as RequiredFieldValidator).Enabled = true;
            }
            else
            {
                TableA4.Rows[i].Visible = li.Selected;
                (TableA4.Rows[i].FindControl("RequiredFieldValidatorA4_" + (i + 1).ToString()) as RequiredFieldValidator).Enabled = li.Selected;
            }
        }
    }

    protected void TableA5_PreRender(object sender, EventArgs e)
    {
        for (var i = 0; i < 9; i++)
        {
            ListItem li = CheckBoxListA3.Items[i];
            TableA5.Rows[i].Visible = li.Selected;
        }
    }

    protected void QAC_A5(object sender, EventArgs e)
    {
        LBMSG.Visible = false;
        var cnt = 0;

        for (var i = 0; i < 9; i++)
        {
            var r = TableA4.FindControl("CheckBoxA5_" + (i + 1).ToString()) as CheckBox;
            saveData(501 + i, r.Checked ? "1" : "");
            if (r.Checked)
                cnt++;


            (Panel55.FindControl("ButtonA4_3_" + (i + 1)) as Button).Visible = r.Checked;
        }
        Button6.Visible = CheckBoxListA3.Items[10].Selected;

        if (cnt == 0)
        {
            LBMSG.Text = "Выберите хотя бы один ответ";
            LBMSG.Visible = true;
            return;
        }

        Button18.CommandName = cnt > 1 ? "Panel55" : "Panel4";

        standartNext(sender, e);
    }

    protected void QAC_A8(object sender, EventArgs e)
    {
        var anyOne = false;
        for (var i = 0; i < TableA8.Rows.Count; i++)
        {
            var r = TableA8.FindControl("RadioButtonListA8_" + (i + 1).ToString()) as RadioButtonList;
            if (r.SelectedValue == "1") anyOne = true;
            saveData(801 + i, r.SelectedValue);
        }
        Button20.CommandName = anyOne ? "Panel7" : "Panel8";
        standartNext(sender, e);
    }

    protected void QAC_A9(object sender, EventArgs e)
    {

        for (var i = 0; i < TableA9.Rows.Count; i++)
        {
            var r = TableA9.FindControl("RadioButtonListA9_" + (i + 1).ToString()) as RadioButtonList;
            saveData(901 + i, r.SelectedValue);
        }

        standartNext(sender, e);
    }

    protected void TableA9_PreRender(object sender, EventArgs e)
    {

        for (var i = 0; i < TableA8.Rows.Count; i++)
        {
            var r = TableA8.FindControl("RadioButtonListA8_" + (i + 1).ToString()) as RadioButtonList;
            TableA9.Rows[i].Visible = r.SelectedValue == "1";
        }

    }

    protected void Panel10_PreRender(object sender, EventArgs e)
    {
        Panel36.Visible = HiddenFieldA1.Value == "998";
        Panel30.Visible = HiddenFieldA1.Value == "1";
        Panel31.Visible = HiddenFieldA1.Value == "2";
    }

    protected void QAC_Button_A1(object sender, EventArgs e)
    {
        (sender as Button).CommandName = (
            ((HiddenField0_1.Value == "1" || HiddenField0_1.Value == "2") && (sender as Button).CommandArgument == "1")
            ||
            ((HiddenField0_2.Value == "1" || HiddenField0_2.Value == "2") && (sender as Button).CommandArgument == "2")
            ||
            ((HiddenField0_3.Value == "1" || HiddenField0_3.Value == "2") && (sender as Button).CommandArgument == "998")
            ) ? "Panel28" : "Panel3";

        (sender as Button).CommandName = ((sender as Button).CommandArgument == "998") ? "Panel2" : (sender as Button).CommandName;

        Button5.CommandName = (((HiddenField0_3.Value == "1" || HiddenField0_3.Value == "2") && (sender as Button).CommandArgument == "998")
            ) ? "Panel28" : "Panel3";


        HiddenFieldA1.Value = (sender as Button).CommandArgument; 
        QAC_Button(sender, e);
    }
    protected void QAC_Button_A10(object sender, EventArgs e)
    { 
        if (HiddenFieldA1.Value == "1")
        {
            if((sender as Button).CommandArgument== "998" && (sender as Button).ToolTip!="101")
            (sender as Button).CommandName = "Panel9";
            else
            (sender as Button).CommandName = "Panel10";
        }
        else if (HiddenFieldA1.Value == "2")
        {
            saveData(111,"5");
            (sender as Button).CommandName = "Panel14";
        }
        else if (HiddenFieldA1.Value == "998")
        {
            saveData(111, "5");
            saveData(121, "5");
            (sender as Button).CommandName = "Panel17";
        }
        QAC_Button(sender, e);
    }

    protected void Panel14_PreRender(object sender, EventArgs e)
    {
        Panel37.Visible = HiddenFieldA1.Value == "998";
        Panel34.Visible = HiddenFieldA1.Value == "1";
        Panel35.Visible = HiddenFieldA1.Value == "2";
    }

    protected void QAC_Button_A2(object sender, EventArgs e)
    {
        (sender as Button).CommandName = 
            (
            (HiddenFieldA1.Value != "998" && ((sender as Button).CommandArgument == "1"|| (sender as Button).CommandArgument == "2" || (sender as Button).CommandArgument == "3" || (sender as Button).CommandArgument == "4"))
            ||
            (HiddenFieldA1.Value == "998" && ((sender as Button).CommandArgument == "3"|| (sender as Button).CommandArgument == "4"))            
            )
            ? "Panel29" : "Panel3";
        HiddenFieldShowAll.Value = (sender as Button).CommandName == "Panel2_4"?"1":"0";
        QAC_Button(sender, e);
    }

    protected void QAC_TextBox_A10(object sender, EventArgs e)
    {
        (sender as Button).CommandName = "Panel9";
        var i = 0;
        if (int.TryParse(TextBoxA10.Text, out i))
        {
            if (i <= 5)
                saveData(101,"1");
            else if (i <= 10)
                saveData(101, "2");
            else if (i <= 15)
                saveData(101, "3");
            else if (i <= 20)
                saveData(101, "4");
            else if (i <= 50)
                saveData(101, "5");
            else if (i <= 100)
                saveData(101, "6");
            else if (i <= 250)
                saveData(101, "7");
            else if (i <= 500)
                saveData(101, "8");
            else if (i <= 1000)
                saveData(101, "9");
            else  
                saveData(101, "10");
            (sender as Button).CommandName = "Panel10";
        }

        if ((sender as Button).CommandName == "Panel10")
        {
            if (HiddenFieldA1.Value == "1")
            {
                (sender as Button).CommandName = "Panel10";
            }
            else if (HiddenFieldA1.Value == "2")
            {
                saveData(111, "5");
                (sender as Button).CommandName = "Panel14";
            }
            else if (HiddenFieldA1.Value == "998")
            {
                saveData(111, "5");
                saveData(121, "5");
                (sender as Button).CommandName = "Panel17";
            }
        }

        QAC_TextBox(sender, e); 
    }

    protected void QAC_TextBox_A14(object sender, EventArgs e)
    {
        (sender as Button).CommandName = "Panel20";
        var i = 0;
        if (int.TryParse(TextBoxA14.Text, out i))
        {
            if (i < 25)
                saveData(141, "1");
            else if (i <= 30)
                saveData(141, "2");
            else if (i <= 34)
                saveData(141, "3");
            else if (i <= 45)
                saveData(141, "4");
            else  
                saveData(141, "5"); 
            (sender as Button).CommandName = "Panel21";
        }
        QAC_TextBox(sender, e);

    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid =
            CheckBoxA5_1.Checked ||
            CheckBoxA5_2.Checked ||
            CheckBoxA5_3.Checked ||
            CheckBoxA5_4.Checked ||
            CheckBoxA5_5.Checked ||
            CheckBoxA5_6.Checked ||
            CheckBoxA5_7.Checked ||
            CheckBoxA5_8.Checked ||
            CheckBoxA5_9.Checked;
    }

    protected void QAC_TextBox_A11(object sender, EventArgs e)
    {
        (sender as Button).CommandName = "Panel11";
        var i = 0;
        if (int.TryParse(TextBoxA11.Text, out i))
        {
            if (i == 1)
            {
                (sender as Button).CommandName = "Panel38";
            }
            else if (i <= 3)
            {
                saveData(111, "3");
                (sender as Button).CommandName = "Panel14";
            }
            else if (i > 3)
            {
                saveData(111, "4");
                (sender as Button).CommandName = "Panel14";
            }
            
        } 
        QAC_TextBox(sender, e);
    }

    protected void QAC_TextBox_A12(object sender, EventArgs e)
    {
        (sender as Button).CommandName = "Panel15";
        var i = 0;
        if (int.TryParse(TextBoxA12.Text, out i))
        {
            if (i == 1)
            {
                (sender as Button).CommandName = "Panel39";
            }
            else if (i <= 3)
            {
                saveData(121, "3");
                (sender as Button).CommandName = "Panel17";
            }
            else if (i > 3)
            {
                saveData(121, "4");
                (sender as Button).CommandName = "Panel17";
            }

        }
        QAC_TextBox(sender, e);
    }
}