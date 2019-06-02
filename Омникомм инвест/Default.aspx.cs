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
using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Service;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;

public partial class _Default : System.Web.UI.Page
{

    private static readonly AmoCrmConfig Config = new AmoCrmConfig("omnicrm", "dealer@omnicomm.ru", "cefdc2f47c19370cf472b7b79933eedda1e03aa1", 500);

    private readonly IAmoCrmService _service = new AmoCrmService(Config);

    private List<Int64> LeadFields = new List<Int64>() {
        67570,100608,607327, 569382
    };
    private List<Int64> ContactFields = new List<Int64>()
    {
        //   38953, 38955, 38951
    };
    private Dictionary<Int64, String> PipelinesStatus = new Dictionary<Int64, String>()
    {
        /*  {21650955, "неотработанные"},  
          {10601559, "Новый интерес"},  
          {17740020, "Приглашены на показ"},
          {14509461, "Пришли на Показ"},
          {10601565, "Резерв"},
          {11961628, "ДДУ готовится на согласование"},
          {11961631, "ДДУ на согласовании"},
          {11961634, "ДДУ на подписании"},
          {10612266, "Подготовка ДДУ для регистрации"},
          {10612269, "ДДУ подан на регистрацию"},
          {10759587, "ДДУ получен, но не оплачен"},
          {142, "Успешно реализовано"},
          {143, "Закрыто и не реализовано"}, */
    };

    private string Column_3 = ""; //профессия
    private string Column_11 = ""; //профессия
    private string Column_12 = ""; //email
    private string Column_13 = ""; //отрасль, профиль
    private string Column_14 = "";
    private string Column_15 = "";
    private string Column_10 = "";
    private string Column_7 = "";
    private string Column_17 = ""; //TRUE FALSE
    private string Column_9 = ""; //кампания

    public string GetIdChain()
    {
        return HF_Out_ID.Value;
    }

    public string GetColumn3()
    {
        return HiddenFieldColumn_3.Value;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (IsPostBack)
        {


            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "msg1", "     $(function () {        $('.datetimepicker1').datetimepicker({    locale: 'ru'  });    });", true);

        }

        if (!IsPostBack)
        {
            bool is_mobile = true;
            string loginid;
            string fio_client;			
            HiddenFieldOut_ID.Value = Request.QueryString["Out_ID"];
            string debug = Request.QueryString["debug"];
            HF_Fio.Value = LabelCompany.Text= Request.QueryString["an"];
            HF_Out_ID.Value = Request.QueryString["aid"];
            HF_cid.Value = Request.QueryString["Campaign_ID"];
            HF_Abonent_ID.Value = Request.QueryString["Abonent_ID"];
            LabelOperatorName.Text =   Request.QueryString["OperatorName"];
            HiddenFieldIdCompany.Value = Request.QueryString["CompanyId"];

            IterateControls(Page, LabelOperatorName.Text, "operator");
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
            Column_3 = Request.QueryString["Column_3"] != null ? Request.QueryString["Column_3"].ToString() : "";
            //TextBoxNameCampaign.Text = Column_3;
            TextBoxFIOLPR.Text = HttpUtility.UrlDecode(Request.QueryString["an"], Encoding.GetEncoding("windows-1251"));
           // TextBoxPhoneLPR.Text = Request.QueryString["Column_8"] != null ? Request.QueryString["Column_8"].ToString() : "";
            HiddenFieldColumn_3.Value = Column_3;
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
        saveForm();
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


                if (!string.IsNullOrEmpty(((Panel)((sender as Button).Parent)).ToolTip))
                {
                    HiddenFieldResultAnketa.Value += ((Panel)((sender as Button).Parent)).ToolTip + ": " + ((DropDownList)c).SelectedItem.Text + Environment.NewLine;
                }
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


        if (!string.IsNullOrEmpty(((Panel)((sender as Button).Parent)).ToolTip))
        {
            HiddenFieldResultAnketa.Value += ((Panel)((sender as Button).Parent)).ToolTip + ": " + ((Button)sender).CommandArgument + Environment.NewLine;
        }

        saveData(Convert.ToInt32(((Button)sender).ToolTip), ((Button)sender).CommandArgument);
        standartNext(sender, e);
    }
    
    protected void QAC_TextBox(object sender, EventArgs e)
    { 
        var text = "";
        foreach (Control c in ((Panel)((Button)sender).Parent).Controls)
        {
            if (c is TextBox)
            {
                text = ((TextBox)c).Text;
                saveData(Convert.ToInt32(((Button)sender).CommandArgument), ((TextBox)c).Text);
            }
        }

        if (!string.IsNullOrEmpty(((Panel)((sender as Button).Parent)).ToolTip))
        {
            HiddenFieldResultAnketa.Value += ((Panel)((sender as Button).Parent)).ToolTip + ": " + text + Environment.NewLine;
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
     
   
     



    protected void CheckBoxA1_CheckedChanged(object sender, EventArgs e)
    {
        var IsChecked = (sender as CheckBox).Checked;
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[2].Controls[0] as TextBox).Visible = IsChecked;
        (((sender as CheckBox).Parent.Parent as TableRow).Cells[3].Controls[0] as CheckBox).Visible = IsChecked;
    }

    protected void QAC_A5(object sender, EventArgs e)
    {
        
        standartNext(sender, e);
    }

    protected void QAC_Button_Result(object sender, EventArgs e)
    { 
        var request = new AddOrUpdateLeadRequest();
        var lead = new AddOrUpdateCrmLead();
       // lead.Name = TextBoxNameCampaign.Text;
        lead.ResponsibleUserId = Convert.ToInt64(3160069);
        lead.DateCreate = DateTime.Now;
        lead.Tags = "колл-центр";
        var pipelines = _service.GetPipelines();

        lead.StatusId = "24732799";// pipelines.OrderBy(r => r.Name).FirstOrDefault().id.ToString();
        lead.PipelineId = "1570399";
        if (HiddenFieldIdLead.Value != "")
        {
            lead.Id = HiddenFieldIdLead.Value;
            request.Update = new List<AddOrUpdateCrmLead>();
            request.Update.Add(lead);
        }
        else
        {
            request.Add = new List<AddOrUpdateCrmLead>();
            request.Add.Add(lead);
        }
        var newLead = _service.AddOrUpdateLead(request);
        if (newLead.Count > 0)
        {
            if (HF_Out_ID.Value != null)
            {
                if (HiddenFieldIdLead.Value == "")
                    addNote(newLead.FirstOrDefault().Id, "CallId:" + HF_Out_ID.Value,"");

                var answers = "";
               // answers += "Наличие проектов: " + HiddenFieldA1.Value + Environment.NewLine;
             //   if (TextBoxA2.Text != "")
             //       answers += "Планы по проектам: " + TextBoxA2.Text + Environment.NewLine;
                if ((sender as Button).Text != "")
                    answers += "Результат: " + (sender as Button).Text + Environment.NewLine;

                if (TextBoxA4_3.Text != "")
                    answers += "Дата и время звонка специалиста: " + TextBoxA4_3.Text + Environment.NewLine;


                answers += "Комментарий: " + TextBoxComment.Text + Environment.NewLine;

                HiddenFieldIdNoteA1.Value = addNote(newLead.FirstOrDefault().Id, answers, HiddenFieldIdNoteA1.Value).ToString();

                /*
                HiddenFieldIdNoteA1.Value = addNote(newLead.FirstOrDefault().Id, "Наличие проектов: " + HiddenFieldA1.Value, HiddenFieldIdNoteA1.Value).ToString();
                if(HiddenFieldA2.Value!="")
                    HiddenFieldIdNoteA2.Value = addNote(newLead.FirstOrDefault().Id, "Планы по проектам: " + HiddenFieldA2.Value, HiddenFieldIdNoteA2.Value).ToString();
                if ((sender as Button).Text != "")
                    HiddenFieldIdNoteA3.Value = addNote(newLead.FirstOrDefault().Id, "Результат: " + (sender as Button).Text, HiddenFieldIdNoteA3.Value).ToString();
                if (TextBoxA4_3.Text != "")
                    HiddenFieldIdNoteA4_3.Value = addNote(newLead.FirstOrDefault().Id, "Дата и время звонка специалиста: " + TextBoxA4_3.Text, HiddenFieldIdNoteA4_3.Value).ToString();


                HiddenFieldIdNoteAComment.Value = addNote(newLead.FirstOrDefault().Id, "Комментарий: " + TextBoxComment.Text, HiddenFieldIdNoteAComment.Value).ToString();
                */
            }
            var IdContact = CreateContacts(newLead.FirstOrDefault());
            HiddenFieldIdLead.Value = newLead.FirstOrDefault().Id.ToString();
        }
        QAC_Button(sender, e);
    }

    private long addNote(long LeadId, string Text, string IdNote)
    {
        var company = _service.GetCompany(LeadId);
        var requestNote = new AddOrUpdateNoteRequest();
        requestNote.Update = new List<AddOrUpdateCrmNote>();
        requestNote.Add = new List<AddOrUpdateCrmNote>();

        {
            var _note = new AddOrUpdateCrmNote();
            _note.ElementId = company.Id;
            _note.ElementType = 3;
            _note.Text = Text;
            _note.ResponsibleUserId = Convert.ToInt64(company.ResponsibleUserId);
            _note.NoteType = 4;
            if (IdNote != "")
            {
                _note.Id =  Convert.ToInt64(IdNote);
                requestNote.Update.Add(_note);
            }
            else
                requestNote.Add.Add(_note);
        }
        var newNotes = _service.AddOrUpdateNote(requestNote);
        return newNotes.FirstOrDefault().Id;
    }

    private Int64 CreateContacts(AddedOrUpdatedLead crmLead)
    {
        var laed =  _service.GetLead(crmLead.Id);
        var request = new AddOrUpdateContactRequest(); 
        request.Update = new List<AddOrUpdateCrmContact>();
        request.Add = new List<AddOrUpdateCrmContact>();

        {
            var _contact = new AddOrUpdateCrmContact(); 
            _contact.Name = TextBoxFIOLPR.Text;
            _contact.LeadsId = crmLead.Id.ToString();
       //     _contact.CompanyName = TextBoxNameCampaign.Text;
            var CustomFields = new List<AddContactCustomField>();
            CustomFields.Add(new AddContactCustomField() { Id = 232955, Values = new List<Object> { new AddCustomFieldValues() { Value = TextBoxDolgnostLPR.Text } } });
            
            //CustomFields.Add(new AddContactCustomField() { Id = 232957, Values = new List<Object> { new AddCustomFieldValuesEnum() { Value = TextBoxPhoneLPR.Text, Enum = "WORK" } } });//352111
         //   CustomFields.Add(new AddContactCustomField() { Id = 232959, Values = new List<Object> { new AddCustomFieldValuesEnum() { Value = TextBoxEmailLPR.Text, Enum = "WORK" } } });//352111
            
            //232957
            _contact.CustomFields = CustomFields;
            if (laed.MainContactId > 0)
            {
                _contact.Id = laed.MainContactId;
                request.Update.Add(_contact);
            }
            else
            {
                request.Add.Add(_contact);
            }
        }

        var countContact = 0; 
        var rslt = _service.AddOrUpdateContact(request);

        if (rslt.FirstOrDefault() != null)
        {
            //HiddenFieldMainContactId.Value = rslt.FirstOrDefault().Id.ToString();
            return rslt.FirstOrDefault().Id;
        }

        return 0;
    }

    protected void QAC_TextBox_A4_3(object sender, EventArgs e)
    {
        var answers = "";
       // answers += "Наличие проектов: " + HiddenFieldA1.Value + Environment.NewLine;
      //  if (TextBoxA2.Text != "")
     //       answers += "Планы по проектам: " + TextBoxA2.Text + Environment.NewLine;
        if (HiddenFieldA3.Value != "")
            answers += "Результат: " + HiddenFieldA3.Value + Environment.NewLine;        

        if (TextBoxA4_3.Text != "")
            answers += "Дата и время звонка специалиста: " + TextBoxA4_3.Text + Environment.NewLine;
        // HiddenFieldIdNoteA4_3.Value = addNote(Convert.ToInt64(HiddenFieldIdLead.Value), "Дата и время звонка специалиста: " + TextBoxA4_3.Text, HiddenFieldIdNoteA4_3.Value).ToString();

        answers += "Комментарий: " + TextBoxComment.Text + Environment.NewLine;

        HiddenFieldIdNoteA1.Value = addNote(Convert.ToInt64(HiddenFieldIdLead.Value), answers, HiddenFieldIdNoteA1.Value).ToString();
         
        QAC_TextBox(sender, e);
    }


    protected void saveForm()
    {
       // saveData(101, TextBoxNameCampaign.Text);
        saveData(102, TextBoxFIOLPR.Text);
        saveData(103, TextBoxDolgnostLPR.Text);
      //  saveData(104, TextBoxEmailLPR.Text);
    //    saveData(105, TextBoxPhoneLPR.Text);
        saveData(106, TextBoxComment.Text);
    }

    protected void QAC_TextBox_A303(object sender, EventArgs e)
    {
      //  HiddenFieldResultAnketa.Value += "Как его зовут?  : " + TextBoxA701.Text + Environment.NewLine;
     //   HiddenFieldResultAnketa.Value += "Какую должность он(а) занимает?  : " + TextBoxA702.Text + Environment.NewLine;

        standartNext(sender, e);
    }

    protected void QAC_Button_End(object sender, EventArgs e)
    {
        QAC_Button(sender, e);
        ToCrm();

    }
    

    protected void QAC_TextBox_End(object sender, EventArgs e)
    {
        QAC_TextBox(sender, e);
        ToCrm();
    }
    private void ToCrm()
    {
        if (HiddenFieldIdCompany.Value != "")
            addNote(Convert.ToInt64(HiddenFieldIdCompany.Value), "CallId:" + HF_Out_ID.Value, "");

        if (HiddenFieldIdCompany.Value != "")
            addNote(Convert.ToInt64(HiddenFieldIdCompany.Value), 
                "Результат опроса:" + Environment.NewLine + Environment.NewLine 
                + HiddenFieldResultAnketa.Value + Environment.NewLine
                + "Комментарии:" + TextBoxComment.Text
                , "");

        var company = _service.GetCompany(Convert.ToInt64(HiddenFieldIdCompany.Value));
         
        var request = new AddOrUpdateCompanyRequest();
        var updateCompany = new AddOrUpdateCrmCompany();
        updateCompany.Contacts = company.Contacts;
         
        if (!company.Tags.Exists(r => r.Name == "Call center"))
        {
            company.Tags.Add(new Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmTag() {Name = "Call center" });
        }
        updateCompany.Tags = String.Join(",", company.Tags.Select(r=>r.Name).ToArray());
        updateCompany.CustomFields = company.CustomFields;
        updateCompany.Id = company.Id;
        request.Add = new List<AddOrUpdateCrmCompany>();
        request.Update = new List<AddOrUpdateCrmCompany>();
        request.Update.Add(updateCompany);
        _service.AddOrUpdateCompany(request);
        CreateContacts();
        if (TextBoxA1_7.Text != "")
            CreateTask();
    }

    private void CreateTask() {
        var request = new AddOrUpdateTaskRequest(); 
        request.Update = new List<AddOrUpdateCrmTask>();
        request.Add = new List<AddOrUpdateCrmTask>();
        {
            var _task = new AddOrUpdateCrmTask();
            _task.ElementId = Convert.ToInt64(HiddenFieldIdCompany.Value);
            _task.ElementType = 3;
            _task.Text = "Звонок специалиста в "+ TextBoxA1_7.Text;
            _task.IsCompleted = false; 
            _task.TaskType = 1;
            if (TextBoxA1_7.Text != "")
            {
                DateTime CompleteTillAt;
                if (DateTime.TryParse(TextBoxA1_7.Text, out CompleteTillAt))
                    _task.CompleteTillAt = CompleteTillAt;
            }
            request.Add.Add(_task);
        } 
        _service.AddOrUpdateTask(request);
    }


    private Int64 CreateContacts()
    {
        var company = _service.GetCompany(Convert.ToInt64(HiddenFieldIdCompany.Value));

        var request = new AddOrUpdateContactRequest();
        request.Update = new List<AddOrUpdateCrmContact>();
        request.Add = new List<AddOrUpdateCrmContact>(); 
        {
            var _contact = new AddOrUpdateCrmContact();
            _contact.Name = TextBoxFIOLPR.Text; 
           
            var CustomFields = new List<AddContactCustomField>();
            CustomFields.Add(new AddContactCustomField() { Id = 267173, Values = new List<Object> { new AddCustomFieldValues() { Value = TextBoxDolgnostLPR.Text } } });

            CustomFields.Add(new AddContactCustomField() { Id = 267175, Values = new List<Object> { new AddCustomFieldValuesEnum() { Value = TextBoxA1_3.Text, Enum = "WORK" } } });//352111
            CustomFields.Add(new AddContactCustomField() { Id = 267177, Values = new List<Object> { new AddCustomFieldValuesEnum() { Value = TextBoxA1_2.Text, Enum = "WORK" } } });//352111

            //232957
            _contact.CustomFields = CustomFields;
            _contact.CompanyId = company.Id;


            request.Add.Add(_contact);
           
        }
         
        var rslt = _service.AddOrUpdateContact(request);

        if (rslt.FirstOrDefault() != null)
        {
            //HiddenFieldMainContactId.Value = rslt.FirstOrDefault().Id.ToString();
            var contact_id = rslt.FirstOrDefault().Id;
            
            return contact_id;
        }

        return 0;
    }



    protected void QAC_Button_ChangeStatusToPartnerIntegrator(object sender, EventArgs e)
    {
        changeStatus("1271549", "Партнер-Интегратор");
        QAC_Button(sender, e);
    }


    protected void QAC_Button_ChangeStatusToEndClient(object sender, EventArgs e)
    {
        changeStatus("1271547", "Конечный клиент");
        QAC_Button(sender, e);
    }

    private void changeStatus(string id, string newStatus) {
        var company = _service.GetCompany(Convert.ToInt64(HiddenFieldIdCompany.Value));
        if (company.CustomFields.Exists(r1 =>
         (
         r1.Name == "Статус контрагента"
         )))
        {
            var fieldStatus = company.CustomFields.FirstOrDefault(r1 =>
              (
              r1.Name == "Статус контрагента"
              ));
            var val = fieldStatus.Values.FirstOrDefault();
            val.Value = newStatus;
            val.Enum = id;
        }
        else
        {
            company.CustomFields.Add(new Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomField() { Name = "Статус контрагента", Values = new List<Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomFieldValue>() { new Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomFieldValue() { Value = newStatus, Enum = id } } });
        };
        var request = new AddOrUpdateCompanyRequest();
        var updateCompany = new AddOrUpdateCrmCompany();
        updateCompany.Contacts = company.Contacts; 
        updateCompany.CustomFields = company.CustomFields; 
        updateCompany.Id = company.Id;
        request.Add = new List<AddOrUpdateCrmCompany>();
        request.Update = new List<AddOrUpdateCrmCompany>();
        request.Update.Add(updateCompany);
        _service.AddOrUpdateCompany(request);
    }


    protected void DropDownListA1_4_Init(object sender, EventArgs e)
    {
        try
        {
            var region_field = _service.GetAccountInfo().CustomFields.Companies.FirstOrDefault(r => r.Id == 595525);
            if (region_field != null)
            {
                var enums = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(region_field.Enums.ToString());
                foreach (var option in enums)
                {
                    DropDownListA1_4.Items.Add(new ListItem() { Value = option.Key.ToString(), Text = option.Value });
                };
            }
        }
        catch (Exception ex)
        {
        }
       
    }

    protected void QAC_DropDownList_A1_4(object sender, EventArgs e)
    {
        var company = _service.GetCompany(Convert.ToInt64(HiddenFieldIdCompany.Value));
        if (company.CustomFields.Exists(r1 =>
         (
         r1.Name == "Регион"
         )))
        {
            var fieldStatus = company.CustomFields.FirstOrDefault(r1 =>
              (
              r1.Name == "Регион"
              ));
            var val = fieldStatus.Values.FirstOrDefault();
            if (val == null)
                val = new Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomFieldValue();
            val.Value = DropDownListA1_4.SelectedItem.Text;
            val.Enum = DropDownListA1_4.SelectedItem.Value;
        }
        else
        {
            company.CustomFields.Add(new Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomField() { Id = 595525,  Name = "Регион", Values = new List<Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomFieldValue>() { new Spoofi.AmoCrmIntegration.AmoCrmEntity.CrmCustomFieldValue() { Value = DropDownListA1_4.SelectedItem.Text, Enum = DropDownListA1_4.SelectedItem.Value } } });
        };
        var request = new AddOrUpdateCompanyRequest();
        var updateCompany = new AddOrUpdateCrmCompany(); 
        updateCompany.CustomFields = company.CustomFields;
        updateCompany.Id = company.Id;
        request.Add = new List<AddOrUpdateCrmCompany>();
        request.Update = new List<AddOrUpdateCrmCompany>();
        request.Update.Add(updateCompany);
        _service.AddOrUpdateCompany(request);

        QAC_DropDownList(sender, e);
    }
}