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
            Label2_2.Text = Request.QueryString["OperatorName"];
            is_mobile = Request.QueryString["is_mobile"]!=null&& Request.QueryString["is_mobile"].ToString() == "1";

             
            if (Request.QueryString["Column_17"] != null)
                Column_17 = HttpUtility.UrlDecode(Request.QueryString["Column_17"], Encoding.GetEncoding("windows-1251"));

            Column_10 = Request.QueryString["Column_10"] != null ? Request.QueryString["Column_10"].ToString() : "";
            Column_11 = Request.QueryString["Column_11"] != null ? Request.QueryString["Column_11"].ToString() : "";
            Column_12 = Request.QueryString["Column_12"] != null ? Request.QueryString["Column_12"].ToString() : "";
            Column_13 = Request.QueryString["Column_13"] != null ? Request.QueryString["Column_13"].ToString() : "";
            Column_14 = Request.QueryString["Column_14"] != null ? Request.QueryString["Column_14"].ToString() : "";
            Column_7 = Request.QueryString["Column_7"] != null ? Request.QueryString["Column_7"].ToString() : "";
            Column_9 = Request.QueryString["Column_9"] != null ? Request.QueryString["Column_9"].ToString() : "";
            Label1_Campaign.Text = Column_9;
            HiddenFieldColumn_11.Value = Column_11;
            HiddenFieldColumn_12.Value = Column_12;
            Label3_37.Text = Column_11;
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

            Panel12_1.Visible = Button13.Visible = Button13_2.Visible = CheckBoxListF5.Visible = Column_9 != "" && Column_11 != "" && Column_13 != "";
            Panel12_2.Visible = Is2;
            Panel12_3.Visible = Is3;
            if (Is3)
            {
                
                Button14.Visible = Button15.Visible = true;
            }
            else if (Is2)
            {
                
                Button14_2.Visible = Button15_2.Visible = true;
            }
            else
            {
                 
                Button14.Visible = Button15.Visible = false;
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
    protected void QAC_CheckBoxList_A4_2(object sender, EventArgs e)
    {
        Button41.CommandName = CheckBoxListA4_2.Items[0].Selected ? "Panel6" : (CheckBoxListA4_2.Items[1].Selected ? "Panel8" : (CheckBoxListA4_2.Items[3].Selected ? "Panel9" : "Panel55_1"));
        ButtonA4_3_1.CommandName = 
        ButtonA4_3_2.CommandName = 
        ButtonA4_3_3.CommandName = 
        ButtonA4_3_4.CommandName = 
        ButtonA4_3_5.CommandName = 
        ButtonA4_3_6.CommandName = 
        ButtonA4_3_7.CommandName = 
        ButtonA4_3_8.CommandName = 
        Button20.CommandName =
             (CheckBoxListA4_2.Items[1].Selected ? "Panel8" : (CheckBoxListA4_2.Items[3].Selected ? "Panel9" : "Panel55_1"));

        ButtonA4_4_1.CommandName =
        ButtonA4_4_2.CommandName =
        ButtonA4_4_3.CommandName =
        ButtonA4_4_4.CommandName =
        ButtonA4_4_5.CommandName =
        ButtonA4_4_6.CommandName = CheckBoxListA4_2.Items[3].Selected ? "Panel9" : "Panel55_1";

        QAC_CheckBoxList(sender, e); 
    }
     
    protected void QAC_TextBox_A4_1(object sender, EventArgs e)
    {
      /*  if (HiddenFieldColumn_17.Value == "ЛОЖЬ" && TextBoxA4_1.Text != "" && (TextBoxA4_1.Text == HiddenFieldColumn_13.Value || TextBoxA4_1.Text == HiddenFieldColumn_14.Value))
            Button12.CommandName = HiddenFieldColumn_15.Value != "" ? "Panel5_camp" : "Panel4";
        else
            Button12.CommandName = HiddenFieldColumn_15.Value != "" ? "Panel5_camp" : "Panel4";*/
        QAC_TextBox(sender,e);
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
    
    protected void QAC_TextBox_A11(object sender, EventArgs e)
    {
        if (HiddenFieldColumn_17.Value == "ЛОЖЬ" && TextBoxA11.Text != "" && (TextBoxA11.Text == HiddenFieldColumn_13.Value || TextBoxA11.Text == HiddenFieldColumn_14.Value))
            Button85.CommandName = "Panel57_2";
        else
            Button85.CommandName = "Panel23";
        QAC_TextBox(sender, e);
    }

    protected void standartNextNewPerson(object sender, EventArgs e)
    {
       // saveData(60001, TextBoxNewPerson_FIO.Text);
      //  saveData(60002, TextBoxNewPerson_Dolgnost.Text);
        QAC_Button(sender, e);
    }


    protected void standartNextNewPerson2(object sender, EventArgs e)
    {
      //  saveData(60001, TextBoxNewPerson_FIO2.Text);
     //   saveData(60002, TextBoxNewPerson_Dolgnost2.Text);
        QAC_Button(sender, e);
    }

    protected void standartNextNewPerson3(object sender, EventArgs e)
    {
        saveData(60001, TextBoxNewPerson_FIO3.Text);
        saveData(60002, TextBoxNewPerson_Dolgnost3.Text);
        saveData(60003, TextBoxNewPhone.Text);

        LBMSG.Visible = true;
        if (TextBoxNewPhone.Text != "")
        {
            saveData(5555501, "IsNewPhone");
            saveData(5555502, TextBoxNewPhone.Text);
            actualFIO(TextBoxNewPerson_FIO3.Text, TextBoxNewPerson_Dolgnost3.Text);
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



    protected void actualFIO(string FIO, string Dolgnost)
    {

        if (!(HiddenField1.Value != "1")) return  ;
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

    protected void QAC_Button_F3(object sender, EventArgs e)
    {
        Button9.CommandName = HiddenFieldColumn_11.Value != "" ? "Panel22_2" : "Panel22";
        QAC_Button(sender, e);
    }


    protected void QAC_Button_F4(object sender, EventArgs e)
    {
        switch (HiddenFieldColumn_11.Value) {
            case "косметолог": ButtonF4_1_1.CommandName = "Panel57_F4_1"; break;
            case "косметолог (сюда же относятся дерматовенерологи, дерматологи, специалисты эстетической медицины)": ButtonF4_1_1.CommandName = "Panel57_F4_1"; break;
            case "мастер ногтевого сервиса": ButtonF4_1_1.CommandName = "Panel57_F4_2"; break;
            case "парикмахер или стилист": ButtonF4_1_1.CommandName = "Panel57_F4_3"; break;
            case "Визажист": ButtonF4_1_1.CommandName = "Panel57_F4_4"; break;
            case "массажист": ButtonF4_1_1.CommandName = "Panel57_F4_5"; break;
            case "владелец/руководитель/администратор": ButtonF4_1_1.CommandName = "Panel57_F4_6"; break;
            case "любая иная должность/профессия, не указанная выше": ButtonF4_1_1.CommandName = "Panel57_F4_6"; break;
            case "врач, трихолог, подолог": ButtonF4_1_1.CommandName = "Panel57_F4_8"; break;
            case "мастер перманентного макияжа": ButtonF4_1_1.CommandName = "Panel57_F4_9"; break;
            default: ButtonF4_1_1.CommandName = "Panel57_F4_7"; break;
        } 
        QAC_Button(sender, e);
    }

    protected void QAC_TextBox_F6(object sender, EventArgs e)
    {
        Button12_2.CommandName = 
            HiddenFieldColumn_12.Value == TextBoxF6_1.Text
            && HiddenFieldColumn_17.Value=="FALSE"
            ?
        "Panel60" :
        HiddenFieldColumn_12.Value == TextBoxF6_1.Text
            && HiddenFieldColumn_17.Value == "TRUE"?
            "Panel17" : "Panel2"
        ;
        QAC_TextBox(sender, e);
    }
    protected void QAC_TextBox_7(object sender, EventArgs e)
    {
        Button12_2_56.CommandName =
            TextBoxA4_1_2.Text == TextBoxF6_1.Text 
            ?
        "Panel15_tot" :  "Panel18"
        ;
        QAC_TextBox(sender, e);
    }

    protected void standartNext_F5(object sender, EventArgs e)
    {
        Button13.CommandName =
            CheckBoxListF5.Items[0].Selected || CheckBoxListF5.Items[1].Selected
            ?
        "Panel_F5_1_1" : 
        (
        CheckBoxListF5.Items[2].Selected?  "Panel11":  "Panel11"
        );
        Panel_F5_Dolgnost.Visible = RequiredFieldValidatorF5_1_1.Enabled = CheckBoxListF5.Items[0].Selected;
        Panel_F5_Company.Visible = RequiredFieldValidatorF5_1_2.Enabled = CheckBoxListF5.Items[1].Selected;

        standartNext(sender, e);
    }


    protected void standartNext_F5_1(object sender, EventArgs e)
    {
        Button128F5_1_1.CommandName = CheckBoxListF5.Items[2].Selected ? "Panel11" : "Panel6";

        saveData(511, TextBoxF5_1_1.Text);
        saveData(512, TextBoxF5_1_2.Text);  
        standartNext(sender, e);
    }

    

}