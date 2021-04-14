using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;
using log4net.Config;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

public partial class Ekomebel : Page
{
  private static readonly ILog log = LogManager.GetLogger("LOGGER");
  private Bitrix24 BX24;
  public List<int> FilterContactFields = new List<int> {255, 253};
  public List<int> FilterDealFields = null; //new List<int>() {533, 643, 1913, 1859 , 1591,  1869};


  public List<int> FilterUserFields = new List<int> {913, 1909, 1935, 1713, 1101, 1213, 1083};
  private int IdContact;
  private int IdDeal;
  private int IdLead;
  private int IdTask;
  private string Phone = "";
  private bool JustLead = false;


  protected void Page_Init(object sender, EventArgs e)
  {
    XmlConfigurator.Configure();

    PanelSMS.Visible = false;
    if (Request.QueryString["IdLead"] != null)
    {
      IdLead = Convert.ToInt32(Request.QueryString["IdLead"]);
      PanelSMS.Visible = true;
      log.Info(string.Format("IdLead = {0}", IdLead));
    }

    if (Request.QueryString["IdContact"] != null)
    {
      IdContact = Convert.ToInt32(Request.QueryString["IdContact"]);
      log.Info(string.Format("IdContact = {0}", IdContact));
    }

    if (Request.QueryString["JustLead"] != null)
    {
      JustLead = true;
      log.Info(string.Format("JustLead = {0}", JustLead));
    }


    if (Request.QueryString["Phone"] != null)
    {
      Phone = Request.QueryString["Phone"];
      log.Info(string.Format("Phone = {0}", Phone));
    }

    if (Request.QueryString["AbonentNumber"] != null)
    {
      Phone = Request.QueryString["AbonentNumber"];
      log.Info(string.Format("AbonentNumber = {0}", Phone));
    }

    BX24 = new Bitrix24(HttpContext.Current, "local.5f8eb07b894111.02063524",
      "thV1fiKJaQFB03sYUGh0o9faUn3hy2Tst8EciXk0A0bd5oyOUl", "https://ekomebel.bitrix24.ru", "https://oauth.bitrix.info",
      "gc.ekomebel+wilstream.ru@gmail.com", "1998eko2017");


    if (!IsPostBack)
    {
      Session.Contents["productrows"] = null;
      Session.Contents["productsearch"] = null;
      Session.Contents["companysearch"] = null;
      Session.Contents["company"] = null;
    }


    var LeadStatusListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=STATUS", "", "GET");
    var StatusList = JsonConvert.DeserializeObject<dynamic>(LeadStatusListByJSON);
    foreach (var status in StatusList.result)
      DropDownListLeadSTATUS_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));
    if (DropDownListLeadSTATUS_ID.SelectedIndex < 1)
      DropDownListLeadSTATUS_ID.SelectedValue = "115";


    var LeadSourceListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=SOURCE", "", "GET");
    var SourceList = JsonConvert.DeserializeObject<dynamic>(LeadSourceListByJSON);
    foreach (var source in SourceList.result)
      DropDownListLeadSOURCE_ID.Items.Add(new ListItem(source.NAME.ToString(), source.STATUS_ID.ToString()));

    var li = DropDownListLeadSOURCE_ID.Items.FindByValue("CALL");
    if (li != null) li.Selected = true;

    var dataListUsers = new
    {
      sort = "LAST_NAME"
    };
    //&FILTER[ID][0]=15938&FILTER[ID][1]=174&FILTER[ID][2]=8170&FILTER[ID][3]=22&FILTER[ID][4]=15934&FILTER[ID][5]=15908
    var userSearchListJson =
      BX24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE", JsonConvert.SerializeObject(dataListUsers));
    var UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
    var it = 0;
    DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    DropDownListCONTACT_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    DropDownListTASK_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    DropDownListTASK_AUDITOR_1.Items.Add(new ListItem("-----", ""));
    DropDownListTASK_AUDITOR_2.Items.Add(new ListItem("-----", ""));
    DropDownListTASK_AUDITOR_3.Items.Add(new ListItem("-----", ""));
    DropDownListTASK_AUDITOR_4.Items.Add(new ListItem("-----", ""));
    DropDownListTASK_AUDITOR_5.Items.Add(new ListItem("-----", ""));
    var users = new List<KeyValuePair<string, string>>();
    while (it < 5)
    {
      it++;
      foreach (var user in UserSearchList.result)
        users.Add(new KeyValuePair<string, string>(user.LAST_NAME.ToString() + " " + user.NAME.ToString(),
          user.ID.ToString()));
      if (UserSearchList.next != null)
      {
        userSearchListJson = BX24.SendCommand("user.search",
          "FILTER[ACTIVE]=TRUE&start=" + UserSearchList.next.ToString(), JsonConvert.SerializeObject(dataListUsers),
          "POST");
        UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
      }
      else break;
    }

    foreach (var user in users.OrderBy(r => r.Key))
    {
      DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListTASK_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListCONTACT_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListTASK_AUDITOR_1.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListTASK_AUDITOR_2.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListTASK_AUDITOR_3.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListTASK_AUDITOR_4.Items.Add(new ListItem(user.Key, user.Value));
      DropDownListTASK_AUDITOR_5.Items.Add(new ListItem(user.Key, user.Value));
    }


    //doDealCreateOrUpdate();

    //return;

    if (IdContact == 0 && Phone != "" && !JustLead)
    {
      IdContact = getIdContactByPhone(Phone);
    }

    if (IdContact > 0)
    {
      PanelContact.Visible = true;
      PanelLead.Visible = false;
      doContactCreateOrUpdate(IdContact);
      PanelTask.Visible = true;
      doTaskCreate();
      return;
    }


    BX24.FilterUserFields = FilterUserFields;
    foreach (var uf in BX24.Userfields)
    {
      var tr = new TableRow {ID = "TableRow" + uf.ID};
      var tc1 = new TableCell
        {ID = "TableCellLabel" + uf.ID, Text = uf.NAME + (Request.QueryString["Fields"] != null ? $" {uf.ID}" : "")};
      var tc2 = new TableCell {ID = "TableCellUserfield" + uf.ID};
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var cbl = new CheckBoxList {ID = "CheckBoxListUserfield" + uf.ID, RepeatColumns = 3};
          foreach (var item in uf.LIST)
            cbl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          tc2.Controls.Add(cbl);
        }
        else
        {
          var ddl = new DropDownList {ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control"};
          ddl.Items.Add(new ListItem("-----", ""));
          foreach (var item in uf.LIST)
            ddl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          tc2.Controls.Add(ddl);
        }

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        TableLead.Rows.Add(tr);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        var ddl = new TextBox {ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control"};
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        TableLead.Rows.Add(tr);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = new CheckBox {ID = "CheckBoxUserfield" + uf.ID, CssClass = "form-control"};
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        TableLead.Rows.Add(tr);
      }
    }

    if (IdContact == 0 && IdLead == 0 && Phone != "")
    {
      IdLead = getIdLeadByPhone(Phone);      

      try
      {
        if (IdLead > 0)
        {
          var Lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
          var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
          //то есть этот лид получили при входе по номеру телефона
          //если статус у него Не обработан (новый) (NEW), то сменим на статус Взят в работу (15) см: https://wilstream.atlassian.net/browse/WIL-41
          if (LeadByJSON.result.STATUS_ID.ToString() == "NEW")
          {
            ChangeStatus(IdLead, LeadByJSON, "15");
          }

          PanelSMS.Visible = true;
        }
      }
      catch (Exception ex)
      {
        var r = ex;
        log.Error(ex);
      }
    }


    if (IdLead > 0)
    {

      PanelTask.Visible = true;
      doTaskCreate();

      var Lead = "";
      dynamic LeadByJSON = new { };
      if (IdLead > 0)
      {
        try
        {
          Lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
          LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
          log.Info(string.Format("Lead = {0}", Lead));
        }
        catch (WebException wex)
        {
          log.Error(wex);
          if (((HttpWebResponse) wex.Response).StatusCode == HttpStatusCode.BadRequest)
          {
            Response.Write("Ошибка в запросе. Возможно лид " + IdLead + " был удален из CRM системы");
            Response.End();
          }
        }
      }


      LabelNameLead.Text = LeadByJSON.result.TITLE;
      TextBoxLeadTITLE.Text = LeadByJSON.result.TITLE;
      TextBoxLeadNAME.Text = LeadByJSON.result.NAME;
      TextBoxLeadSECOND_NAME.Text = LeadByJSON.result.SECOND_NAME;
      TextBoxLeadADDRESS_CITY.Text = LeadByJSON.result.ADDRESS_CITY;
      TextBoxLeadLAST_NAME.Text = LeadByJSON.result.LAST_NAME;
      DropDownListLeadSTATUS_ID.SelectedValue = LeadByJSON.result.STATUS_ID;
      if (LeadByJSON.result.PHONE != null)
      {
        var countContact = 0;
        foreach (var phone in LeadByJSON.result.PHONE)
        {
          var row = new TableRow();
          var cell = new TableCell();
          var cell2 = new TableCell();
          var TextBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE" + phone.ID, Text = phone.VALUE};
          var HiddenField = new HiddenField {ID = "HiddenFieldLeadPHONE" + phone.ID, Value = phone.ID};
          var DropDownListLeadPHONE = new DropDownList
            {ID = "DropDownListLeadPHONE" + phone.ID, CssClass = "form-control"};
          DropDownListLeadPHONE.Items.AddRange(
            BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
          DropDownListLeadPHONE.SelectedValue = phone.VALUE_TYPE;
          var RequiredFieldValidator = new RequiredFieldValidator
          {
            ID = "RequiredFieldValidatorTextBoxLeadPHONE" + phone.ID, ValidationGroup = "Lead",
            ControlToValidate = "TextBoxLeadPHONE" + phone.ID, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
            Display = ValidatorDisplay.Dynamic
          };
          cell.Controls.Add(TextBox);
          cell.Controls.Add(RequiredFieldValidator);
          cell2.Controls.Add(DropDownListLeadPHONE);
          cell2.Controls.Add(HiddenField);
          row.Cells.Add(cell);
          row.Cells.Add(cell2);
          TablePhones.Rows.Add(row);

          if (Session.Contents["TableContact"] != null)
          {
            var tables = Session.Contents["TableContact"] as Dictionary<string, TableRow>;
            if (tables.ContainsKey("TableRow" + countContact))
              tables.Remove("TableRow" + countContact);
            Session.Contents["TableContact"] = tables;
          }

          countContact++;
        }
      }
      else
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var TextBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE"};
        var DropDownListLeadPHONE = new DropDownList {ID = "DropDownListLeadPHONE", CssClass = "form-control"};
        DropDownListLeadPHONE.Items.AddRange(
          BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadPHONE", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic
        };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadPHONE);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);

        if (Request.QueryString["Phone"] != null)
        {
          TextBox.Text = Request.QueryString["Phone"];
        }

        if (Request.QueryString["AbonentNumber"] != null)
        {
          TextBox.Text = Request.QueryString["AbonentNumber"];
        }
      }


      if (LeadByJSON.result.EMAIL != null)
      {
        var countContact = 0;
        foreach (var email in LeadByJSON.result.EMAIL)
        {
          var row = new TableRow();
          var cell = new TableCell();
          var cell2 = new TableCell();
          var TextBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL" + email.ID, Text = email.VALUE};
          var HiddenField = new HiddenField {ID = "HiddenFieldLeadEMAIL" + email.ID, Value = email.ID};
          var DropDownListLeadEMAIL = new DropDownList
            {ID = "DropDownListLeadEMAIL" + email.ID, CssClass = "form-control"};
          DropDownListLeadEMAIL.Items.AddRange(
            BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
          DropDownListLeadEMAIL.SelectedValue = email.VALUE_TYPE;
          var RequiredFieldValidator = new RequiredFieldValidator
          {
            ID = "RequiredFieldValidatorTextBoxLeadEMAIL" + email.ID, ValidationGroup = "Lead",
            ControlToValidate = "TextBoxLeadEMAIL" + email.ID, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
            Display = ValidatorDisplay.Dynamic, Enabled = false
          };
          cell.Controls.Add(TextBox);
          cell.Controls.Add(RequiredFieldValidator);
          cell2.Controls.Add(DropDownListLeadEMAIL);
          cell2.Controls.Add(HiddenField);
          row.Cells.Add(cell);
          row.Cells.Add(cell2);
          TableEmails.Rows.Add(row);

          if (Session.Contents["TableContactEmail"] != null)
          {
            var tables = Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>;
            if (tables.ContainsKey("TableRow" + countContact))
              tables.Remove("TableRow" + countContact);
            Session.Contents["TableContactEmail"] = tables;
          }

          countContact++;
        }
      }
      else
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var TextBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL"};
        var DropDownListLeadEMAIL = new DropDownList {ID = "DropDownListLeadEMAIL", CssClass = "form-control"};
        DropDownListLeadEMAIL.Items.AddRange(
          BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadEMAIL", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic, Enabled = false
        };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadEMAIL);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TableEmails.Rows.Add(row);
      }

      DropDownListLeadSOURCE_ID.SelectedValue = LeadByJSON.result.SOURCE_ID;
      CheckBoxLeadOPENED.Checked = LeadByJSON.result.OPENED == "1";
      TextBoxLeadCOMMENTS.Text = LeadByJSON.result.COMMENTS;
      DropDownListLeadASSIGNED_BY_ID.SelectedValue = LeadByJSON.result.ASSIGNED_BY_ID;
      Type t = LeadByJSON.result.GetType();
      foreach (var uf in BX24.Userfields)
      {
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var CheckBoxListUF = FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            foreach (JProperty item in LeadByJSON.result)
            {
              if (item.Name == uf.FIELD_NAME) //property name
              {
                foreach (var val_ in item.Value)
                {
                  var li_ = CheckBoxListUF.Items.FindByValue(val_.ToString());
                  if (li_ != null) li_.Selected = true;
                }
              }
            }
          }
          else
          {
            var DropDownListUF = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            foreach (JProperty item in LeadByJSON.result)
            {
              if (item.Name == uf.FIELD_NAME) //property name
                DropDownListUF.SelectedValue = item.Value.ToString();
            }
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          foreach (JProperty item in LeadByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME) //property name
              ddl.Text = item.Value.ToString();
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          foreach (JProperty item in LeadByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME) //property name
              ddl.Checked = item.Value.ToString() == "1";
          }
        }
      }


      //var Result = new List<Bitrix24.PRODUCT>();
      //string LeadProductList = BX24.SendCommand("crm.lead.productrows.get", "ID=" + IdLead, "", "GET");
      //var LeadProductListByJSON = JsonConvert.DeserializeObject<dynamic>(LeadProductList);
      //foreach (var item in LeadProductListByJSON.result)
      //{
      //    Result.Add(new Bitrix24.PRODUCT() { ID = item.ID, NAME = BX24.GetNameProduct(item.PRODUCT_ID.ToString()), PRODUCT_PRICE = item.PRICE, PRODUCT_QUANTITY = item.QUANTITY });
      //}
      //Session.Contents["productrows"] = Result;
      //   LeadByJSON.result.ID
      HiddenFieldIdLead.Value = IdLead.ToString();
      log.Info(string.Format("Set HiddenFieldIdLead = {0}", HiddenFieldIdLead.Value));
      ButtonSaveLead.Text = "Обновить лид";
    }
    else
    {
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var TextBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE"};
        var DropDownListLeadPHONE = new DropDownList {ID = "DropDownListLeadPHONE", CssClass = "form-control"};
        DropDownListLeadPHONE.Items.AddRange(
          BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadPHONE", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic
        };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadPHONE);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);

        if (Request.QueryString["Phone"] != null)
        {
          TextBox.Text = Request.QueryString["Phone"];
        }

        if (Request.QueryString["AbonentNumber"] != null)
        {
          TextBox.Text = Request.QueryString["AbonentNumber"];
        }
      }
      ;
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var TextBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL"};
        var DropDownListLeadEMAIL = new DropDownList {ID = "DropDownListLeadEMAIL", CssClass = "form-control"};
        DropDownListLeadEMAIL.Items.AddRange(
          BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadEMAIL", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic, Enabled = false
        };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadEMAIL);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TableEmails.Rows.Add(row);
      }
    }

    if (Session.Contents["TableContact"] != null)
      foreach (var item in Session.Contents["TableContact"] as Dictionary<string, TableRow>)
      {
        TablePhones.Controls.Add(item.Value);
      }


    if (Session.Contents["TableContactEmail"] != null)
      foreach (var item in Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>)
      {
        TableEmails.Controls.Add(item.Value);
      }

    //string LeadListByJSON = BX24.SendCommand("crm.lead.list", "", "", "GET");
    //string LeadListByJSON = BX24.SendCommand("crm.lead.add", "", contentText, "POST");

    // string UFListByJSON = BX24.SendCommand("crm.lead.userfield.list", "", "", "POST");
    //string LeadProductListByJSON = BX24.SendCommand("crm.lead.productrows.get", "id=", "", "GET");
  }

  private void ChangeStatus(int idLead, dynamic leadByJSON, string status)
  {
    var data = new
    {
      id = (object)idLead,
      fields = new Dictionary<string, object>
            {
              {"TITLE", leadByJSON.result.TITLE.ToString()},
              {"NAME", leadByJSON.result.NAME.ToString()},
              {"STATUS_ID", status}
            },
      @params = new { REGISTER_SONET_EVENT = "Y" }
    };

    var contentText = JsonConvert.SerializeObject(data); 

    var result = BX24.SendCommand("crm.lead.update", "", contentText);
    log.Info(string.Format("ChangeStatus. Result {0}", result));

  }

  protected void Page_Load(object sender, EventArgs e)
  {
  }


  protected int getIdLeadByPhone(string Phone)
  {
    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };
    var strPhone = "&values[]=" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=7" +
                   Phone.Substring(Phone.Length - 10, 10) + "&values[]=8" + Phone.Substring(Phone.Length - 10, 10);
    log.Info(string.Format("strPhone = {0}", strPhone));
    var Leads = BX24.SendCommand("crm.duplicate.findbycomm",
      "entity_type=LEAD&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC",
      JsonConvert.SerializeObject(dataListLids));
    log.Info(string.Format("crm.duplicate.findbycomm = {0}", Leads));
    var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
    try
    {
      if (LeadsJSON.result.LEAD.Count > 0)
      {
        log.Info(string.Format("LeadsJSON.result.LEAD.Count = {0}", LeadsJSON.result.LEAD.Count));
        var IdLead = (int) LeadsJSON.result.LEAD[0];
        log.Info(string.Format("Select IdLead = {0}", IdLead));
        return IdLead;
      }

      return 0;
    }
    catch (Exception ex)
    {
      var r = ex;
      log.Error(ex);
      return 0;
    }
  }


  protected int getIdContactByPhone(string Phone)
  {
    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };
    var strPhone = "&values[]=" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=7" +
                   Phone.Substring(Phone.Length - 10, 10) + "&values[]=8" + Phone.Substring(Phone.Length - 10, 10);
    log.Info(string.Format("strPhone = {0}", strPhone));
    var Contacts = BX24.SendCommand("crm.duplicate.findbycomm",
      "entity_type=CONTACT&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC",
      JsonConvert.SerializeObject(dataListLids));
    log.Info(string.Format("crm.duplicate.findbycomm = {0}", Contacts));
    var ContactsJSON = JsonConvert.DeserializeObject<dynamic>(Contacts);
    try
    {
      if (ContactsJSON.result.CONTACT.Count > 0)
      {
        log.Info(string.Format("ContactsJSON.result.CONTACT.Count = {0}", ContactsJSON.result.CONTACT.Count));
        var IdContact = (int) ContactsJSON.result.CONTACT[0];
        log.Info(string.Format("Select IdContact = {0}", IdContact));
        return IdContact;
      }

      return 0;
    }
    catch (Exception ex)
    {
      var r = ex;
      log.Error(ex);
      return 0;
    }
  }

  protected void ButtonLeadASSIGNED_BY_ID_Click(object sender, EventArgs e)
  {
    var data = new
    {
      fields = new
      {
        //NAME = TextBoxLeadASSIGNED_BY_ID.Text 
      }
    };

    var contentText = JsonConvert.SerializeObject(data);
    var userSearch = BX24.SendCommand("user.search", "", contentText);
  }

  protected void ButtonProductSearch_Click(object sender, EventArgs e)
  {
    var dataProduct = new
    {
      filter = new
      {
        NAME = TextBoxProductSearch.Text + "%"
      },
      @params = new {REGISTER_SONET_EVENT = "Y"}
    };


    var contentTextProduct = JsonConvert.SerializeObject(dataProduct);
    var ProductListByJSON = BX24.SendCommand("crm.product.list", "", contentTextProduct);
    var ProductList = JsonConvert.DeserializeObject<dynamic>(ProductListByJSON);
    foreach (var product in ProductList.result)
      BX24.ProductSeacrh.Add(new Bitrix24.PRODUCT
      {
        NAME = product.NAME.ToString(),
        ID = Convert.ToInt32(product.ID.ToString())
      });
    GridViewProductSearch.DataBind();
    Session.Contents["productsearch"] = BX24.ProductSeacrh;
  }

  protected void LinqDataSourceProducts_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var Result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productsearch"] != null)
      Result = (List<Bitrix24.PRODUCT>) Session.Contents["productsearch"];
    if (BX24.ProductSeacrh.Count > 0)
      Result = BX24.ProductSeacrh;
    Session.Contents["productsearch"] = Result;
    e.Result = Result;
  }

  protected void LinqDataSourceLeadProducts_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var productrows = Session.Contents["productrows"];
    if (productrows != null)
      e.Result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];
    else
      e.Result = new List<Bitrix24.PRODUCT>();
    //string LeadProductListByJSON = BX24.SendCommand("crm.lead.productrows.get", "id=", "", "GET");
  }

  protected void GridViewProductSearch_RowCommand(object sender, GridViewCommandEventArgs e)
  {
    if (e.CommandName == "Select")
    {
    }
  }

  protected void GridViewProductSearch_SelectedIndexChanged(object sender, EventArgs e)
  {
    var Result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productrows"] != null)
      Result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];

    var ResultSeacrh = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productsearch"] != null)
      ResultSeacrh = (List<Bitrix24.PRODUCT>) Session.Contents["productsearch"];

    if (Result.FirstOrDefault(r => r.ID == ResultSeacrh[GridViewProductSearch.SelectedIndex].ID) == null)
      Result.Add(ResultSeacrh[GridViewProductSearch.SelectedIndex]);
    Session.Contents["productrows"] = Result;
    GridViewLeadProducts.DataBind();
  }

  protected void GridViewLeadProducts_SelectedIndexChanged(object sender, EventArgs e)
  {
    var Result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productrows"] != null)
      Result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];

    if (Result.FirstOrDefault(r => r.ID == Convert.ToInt32(GridViewLeadProducts.SelectedValue)) != null)
      Result.Remove(Result.FirstOrDefault(r => r.ID == Convert.ToInt32(GridViewLeadProducts.SelectedValue)));
    Session.Contents["productrows"] = Result;
    GridViewLeadProducts.DataBind();
  }

  protected void ButtonSaveLead_Click(object sender, EventArgs e)
  {
    try
    {
      var IdLeadOld = HiddenFieldIdLead.Value != "" ? Convert.ToInt32(HiddenFieldIdLead.Value) : 0;
      log.Info(string.Format("IdLeadOld = {0}", IdLeadOld));

      if (IdLeadOld == 0)
      {
        //проверим возможно уже лид был создан пока заполняли форму
        if (string.IsNullOrEmpty(Phone) && Request.QueryString["Phone"] != null)
        {
          Phone = Request.QueryString["Phone"];
        }

        if (!string.IsNullOrEmpty(Phone))
        {
          IdLeadOld = getIdLeadByPhone(Phone);
          log.Info(string.Format("Лид найден IdLeadOld = {0}", IdLeadOld));
        }
      }

      var data =
        IdLeadOld > 0
          ? new
          {
            id = (object) IdLeadOld,
            fields = new Dictionary<string, object>
            {
              {"TITLE", TextBoxLeadTITLE.Text},
              {"NAME", TextBoxLeadNAME.Text},
              {"COMMENTS", TextBoxLeadCOMMENTS.Text},
              {"SECOND_NAME", TextBoxLeadSECOND_NAME.Text},
              {"ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text},
              {"LAST_NAME", TextBoxLeadLAST_NAME.Text},
              {"STATUS_ID", DropDownListLeadSTATUS_ID.SelectedValue},
              {"PHONE", new object[] { }},
              {"SOURCE_ID", DropDownListLeadSOURCE_ID.SelectedValue},
              {"OPENED", "0"},
              //{  "OPENED" , CheckBoxLeadOPENED.Checked?"1":"0" },
              {"ASSIGNED_BY_ID", DropDownListLeadASSIGNED_BY_ID.SelectedValue}
            },
            @params = new {REGISTER_SONET_EVENT = "Y"}
          }
          : new
          {
            id = new object(),
            fields = new Dictionary<string, object>
            {
              {"TITLE", TextBoxLeadTITLE.Text},
              {"NAME", TextBoxLeadNAME.Text},
              {"COMMENTS", TextBoxLeadCOMMENTS.Text},
              {"SECOND_NAME", TextBoxLeadSECOND_NAME.Text},
              {"ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text},
              {"LAST_NAME", TextBoxLeadLAST_NAME.Text},
              {"STATUS_ID", DropDownListLeadSTATUS_ID.SelectedValue},
              {"PHONE", new object[] { }},
              {"SOURCE_ID", DropDownListLeadSOURCE_ID.SelectedValue},
              {"OPENED", "0"},
              //  {  "OPENED" , CheckBoxLeadOPENED.Checked?"1":"0" },
              {"ASSIGNED_BY_ID", DropDownListLeadASSIGNED_BY_ID.SelectedValue}
            },
            @params = new {REGISTER_SONET_EVENT = "Y"}
          };


      var phones = new List<object>();
      foreach (TableRow row in TablePhones.Rows)
      {
        var TextBoxLeadPHONE = row.Cells[0].Controls[0] as TextBox;
        var RequiredFieldValidatorLeadPHONE = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var DropDownListLeadPHONE = row.Cells[1].Controls[0] as DropDownList;
        HiddenField HiddenFieldLeadPHONE = null;
        if (row.Cells[1].Controls.Count > 1)
          HiddenFieldLeadPHONE = row.Cells[1].Controls[1] as HiddenField;
        if (HiddenFieldLeadPHONE != null)
          phones.Add(new
          {
            ID = HiddenFieldLeadPHONE.Value, VALUE = TextBoxLeadPHONE.Text,
            VALUE_TYPE = DropDownListLeadPHONE.SelectedValue
          });
        else
          phones.Add(new {VALUE = TextBoxLeadPHONE.Text, VALUE_TYPE = DropDownListLeadPHONE.SelectedValue});
      }

      data.fields["PHONE"] = phones;


      var emails = new List<object>();
      foreach (TableRow row in TableEmails.Rows)
      {
        var TextBoxLeadEMAIL = row.Cells[0].Controls[0] as TextBox;
        var RequiredFieldValidatorLeadEMAIL = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var DropDownListLeadEMAIL = row.Cells[1].Controls[0] as DropDownList;
        HiddenField HiddenFieldLeadEMAIL = null;
        if (row.Cells[1].Controls.Count > 1)
          HiddenFieldLeadEMAIL = row.Cells[1].Controls[1] as HiddenField;
        if (HiddenFieldLeadEMAIL != null)
          emails.Add(new
          {
            ID = HiddenFieldLeadEMAIL.Value, VALUE = TextBoxLeadEMAIL.Text,
            VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue
          });
        else
          emails.Add(new {VALUE = TextBoxLeadEMAIL.Text, VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue});
      }

      data.fields["EMAIL"] = emails;

      var t = data.fields.GetType();
      foreach (var uf in BX24.Userfields)
      {
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var cbl = Page.FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            if (cbl != null)
            {
              var sel = new List<string>();

              foreach (ListItem item in cbl.Items)
              {
                if (item.Selected)
                  sel.Add(item.Value);
              }

              data.fields.Add(uf.FIELD_NAME, sel);
            }
          }
          else
          {
            var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            if (ddl != null)
            {
              data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
            }
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          if (ddl != null)
          {
            data.fields.Add(uf.FIELD_NAME, ddl.Text);
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = Page.FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          if (ddl != null)
          {
            data.fields.Add(uf.FIELD_NAME, ddl.Checked);
          }
        }
      }


      var contentText = JsonConvert.SerializeObject(data);
      if (IdLeadOld == 0)
        contentText = contentText.Replace("\"id\":{},", "");


      var NewLead =
        IdLeadOld > 0
          ? BX24.SendCommand("crm.lead.update", "", contentText)
          : BX24.SendCommand("crm.lead.add", "", contentText);
      var NewLeadByJSON = JsonConvert.DeserializeObject<dynamic>(NewLead);
      int IdLead = IdLeadOld > 0 ? IdLeadOld : Convert.ToInt32(NewLeadByJSON.result);


      var productrowsData = new
      {
        id = IdLead,
        rows = new List<dynamic>(),
        @params = new {REGISTER_SONET_EVENT = "Y"}
      };
      var Result = new List<Bitrix24.PRODUCT>();
      if (Session.Contents["productrows"] != null)
        Result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];

      productrowsData.rows.AddRange(
        Result.Select(r => new {PRODUCT_ID = r.ID, PRICE = r.PRODUCT_PRICE, QUANTITY = r.PRODUCT_QUANTITY}).ToList());

      //66864

      // { "PRODUCT_ID": 689, "PRICE": 100.00, "QUANTITY": 2 },

      contentText = JsonConvert.SerializeObject(productrowsData);
      if (productrowsData.rows.Count == 0)
        contentText = contentText.Replace("[]", "null");
      BX24.SendCommand("crm.lead.productrows.set", "", contentText);

      if (IdLeadOld == 0)
      {
        AddCommentToElement(IdLead, "Лид создан в КЦ Wilstream");
        log.Info(string.Format("New IdLead = {0}", IdLead));
        Response.Redirect("~/Ekomebel.aspx?IdLead=" + IdLead);
        Response.End();
      }
      else
      {
        AddCommentToElement(IdLead, "Лид обновлен в КЦ Wilstream");
        log.Info(string.Format("Redirect after update IdLead = {0}", IdLead));
        Response.Redirect("~/Ekomebel.aspx?IdLead=" + IdLead);
        Response.End();
      }
    }
    catch (Exception ex)
    {
      Response.Write("Ошибка сохранения лида. Возможно лид уже был удален.");
    }
  }

  protected void LinqDataSourceLeadProducts_ContextDisposing(object sender, LinqDataSourceDisposeEventArgs e)
  {
  }

  protected void LinqDataSourceLeadProducts_Init(object sender, EventArgs e)
  {
  }

  protected void GridViewLeadProducts_Load(object sender, EventArgs e)
  {
    var Result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productrows"] != null)
      Result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];
    var index = 0;
    foreach (GridViewRow tr in GridViewLeadProducts.Rows)
    {
      var HiddenField1 = tr.Cells[2].FindControl("HiddenField1") as HiddenField;
      var TextBox1 = tr.Cells[2].FindControl("TextBox1") as TextBox;
      var _Product = Result.FirstOrDefault(r => r.ID == Convert.ToInt32(HiddenField1.Value));
      if (_Product != null)
      {
        if (TextBox1 != null && Result[index] != null)
          _Product.PRODUCT_PRICE = TextBox1.Text;

        var TextBox2 = tr.Cells[3].FindControl("TextBox2") as TextBox;
        if (TextBox2 != null && Result[index] != null)
          _Product.PRODUCT_QUANTITY = TextBox2.Text;
      }

      index++;
    }

    Session.Contents["productrows"] = Result;
  }


  protected void ButtonAddPhone_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TablePhones.Rows)
    {
      if (c is TableRow) count++;
    }

    var tableRow = CreatePhoneRow(count, "Lead", TablePhones);
    if (Session.Contents["TableContact"] == null)
      Session.Contents["TableContact"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContact"] as Dictionary<string, TableRow>).Add(tableRow.ID, tableRow);
  }


  protected void ButtonContactAddPhone_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableContactPhones.Rows)
    {
      if (c is TableRow) count++;
    }

    var tableRow = CreatePhoneRow(count, "Contact", TableContactPhones);
    if (Session.Contents["TableContactContact"] == null)
      Session.Contents["TableContactContact"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContactContact"] as Dictionary<string, TableRow>).Add(tableRow.ID, tableRow);
  }


  private TableRow CreatePhoneRow(int count, string category, Table tablePhones)
  {
    var row = new TableRow {ID = "TableRow" + count};
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var TextBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}PHONE" + uniq};
    var DropDownListPHONE = new DropDownList {ID = $"DropDownList{category}PHONE" + uniq, CssClass = "form-control"};
    DropDownListPHONE.Items.AddRange(
      BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var RequiredFieldValidator = new RequiredFieldValidator
    {
      ID = $"RequiredFieldValidatorTextBox{category}PHONE" + uniq, ValidationGroup = category,
      ControlToValidate = $"TextBox{category}PHONE" + uniq, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
      Display = ValidatorDisplay.Dynamic
    };
    cell.Controls.Add(TextBox);
    cell.Controls.Add(RequiredFieldValidator);
    cell2.Controls.Add(DropDownListPHONE);
    row.Cells.Add(cell);
    row.Cells.Add(cell2);
    tablePhones.Rows.Add(row);
    return row;
  }

  protected void ButtonContactAddEmail_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableContactEmails.Rows)
    {
      if (c is TableRow) count++;
    }

    var tableRow = CreateEmailRow(count, "Contact", TableContactEmails);
    if (Session.Contents["TableContactContactEmail"] == null)
      Session.Contents["TableContactContactEmail"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContactContactEmail"] as Dictionary<string, TableRow>).Add(tableRow.ID, tableRow);
  }

  private TableRow CreateEmailRow(int count, string category, Table tableEmails)
  {
    var row = new TableRow {ID = $"TableRow{category}" + count};
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var TextBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}EMAIL" + uniq};
    var DropDownListEMAIL = new DropDownList {ID = $"DropDownList{category}EMAIL" + uniq, CssClass = "form-control"};
    DropDownListEMAIL.Items.AddRange(
      BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var RequiredFieldValidator = new RequiredFieldValidator
    {
      ID = $"RequiredFieldValidatorTextBox{category}EMAIL" + uniq, ValidationGroup = category,
      ControlToValidate = $"TextBox{category}EMAIL" + uniq, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
      Display = ValidatorDisplay.Dynamic
    };
    cell.Controls.Add(TextBox);
    cell.Controls.Add(RequiredFieldValidator);
    cell2.Controls.Add(DropDownListEMAIL);
    row.Cells.Add(cell);
    row.Cells.Add(cell2);
    tableEmails.Rows.Add(row);
    return row;
  }


  protected void ButtonAddEmail_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableEmails.Rows)
    {
      if (c is TableRow) count++;
    }

    var tableRow = CreateEmailRow(count, "Lead", TableEmails);
    if (Session.Contents["TableContactEmail"] == null)
      Session.Contents["TableContactEmail"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>).Add(tableRow.ID, tableRow);
  }


  protected void ButtonSendSMS_Click(object sender, EventArgs e)
  {
    return;
    log.Info("Отправка SMS");
    int IdLead;
    if (HiddenFieldIdLead.Value != null && int.TryParse(HiddenFieldIdLead.Value, out IdLead))
    {
      if (string.IsNullOrEmpty(TextBoxSMS.Text.Trim()))
      {
        log.Info("SMS не отправлено так как нет текста SMS");
        return;
      }

      var phone = getPhoneFromForm().Trim();
      if (string.IsNullOrEmpty(phone))
      {
        log.Info("SMS не отправлено так как нет номера для отправки");
        return;
      }

      var message = TextBoxSMS.Text.Trim();
      message = message.Substring(0, message.Length > 60 ? 60 : message.Length);
      if (sendSMS(message, phone))
      {
        AddCommentToElement(IdLead, string.Format("Отправлено SMS на номер {0} с текстом \"{1}\"", phone, message));
        log.Info(string.Format("Отправлено SMS на номер {0} с текстом \"{1}\"", phone, message));
        Response.Write(string.Format("Отправлено SMS на номер {0} с текстом \"{1}\"", phone, message));
        return;
      }
      else
      {
        log.Info("SMS не отправлено так как есть ошибка в отправке");
        return;
      }
    }
    else
    {
      log.Info("SMS не отправлено так как нет IdLead");
    }
  }

  private string getPhoneFromForm()
  {
    var phones = new List<string>();
    foreach (TableRow row in TablePhones.Rows)
    {
      var TextBoxLeadPHONE = row.Cells[0].Controls[0] as TextBox;
      phones.Add(TextBoxLeadPHONE.Text);
    }

    return phones.FirstOrDefault();
  }

  private bool sendSMS(string message, string phones)
  {
    var url = "https://smsc.ru/sys/send.php";
    var result = GET(url,
      "login=bitrix@avantsb.ru&psw=Veles2019&phones=" + phones + "&mes=" + message + "&sender=avantsb.ru");
    return result.Length > 2 && result.Substring(0, 2) == "OK";
  }


  private string GET(string Url, string Data)
  {
    log.Info(string.Format("Url SMS is {0}", Url + "?" + Data));
    var req = WebRequest.Create(Url + "?" + Data);
    var resp = req.GetResponse();
    var stream = resp.GetResponseStream();
    var sr = new StreamReader(stream);
    var Out = sr.ReadToEnd();
    sr.Close();
    return Out;
  }

  public void AddCommentToElement(int IdElement, string Comment, string type = "lead")
  {
    if (IdElement == 0) return;


    var data =
      new
      {
        fields = new Dictionary<string, object>
        {
          {"ENTITY_ID", IdElement},
          {"ENTITY_TYPE", type},
          {"COMMENT", Comment}
        }
      };
    var contentText = JsonConvert.SerializeObject(data);

    var Lead = BX24.SendCommand("crm.timeline.comment.add", "", contentText);
    var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
  }

  protected void ButtonSaveOrUpdateTask_Click(object sender, EventArgs e)
  {
    addTask();
  }


  public void addTask()
  {
    var auditors = new List<int>();
    if (DropDownListTASK_AUDITOR_1.SelectedValue != "")
      auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_1.SelectedValue));
    if (DropDownListTASK_AUDITOR_2.SelectedValue != "")
      auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_2.SelectedValue));
    if (DropDownListTASK_AUDITOR_3.SelectedValue != "")
      auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_3.SelectedValue));
    if (DropDownListTASK_AUDITOR_4.SelectedValue != "")
      auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_4.SelectedValue));
    if (DropDownListTASK_AUDITOR_5.SelectedValue != "")
      auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_5.SelectedValue));
    var data =
      new
      {
        fields = new Dictionary<string, object>
        {
          {"TITLE", TextBoxTASK_TITLE.Text},
          {"DESCRIPTION", TextBoxTASK_DESCRIPTION.Text},
          {"RESPONSIBLE_ID", DropDownListTASK_ASSIGNED_BY_ID.SelectedValue},
          {"AUDITORS", auditors.ToArray()},
          {"DEADLINE", TextBoxTASK_DEADLINE.Text},
          {"UF_CRM_TASK", new[] { IdContact>0? ("C_" + IdContact):("L_" +IdLead)  }
}
        }
      };
    var contentText = JsonConvert.SerializeObject(data);

    var Task = Request.QueryString["IdTask"] != null
      ? BX24.SendCommand("tasks.task.update", "taskId=" + Request.QueryString["IdTask"], contentText)
      : BX24.SendCommand("tasks.task.add", "", contentText);
    var TaskByJSON = JsonConvert.DeserializeObject<dynamic>(Task);
    int IdTask = Convert.ToInt32(TaskByJSON.result.task.id);

    Response.Redirect("~/Ekomebel.aspx?IdTask=" + IdTask + (JustLead? "&JustLead=true":"") + "&" + (IdContact > 0 ? ("IdContact=" + IdContact) : ("IdLead=" + IdLead)));
    Response.End();
  }

  protected void ButtonSearchCompany_Click(object sender, EventArgs e)
  {
    var dataCompany = new
    {
      filter = new
      {
        TITLE = TextBoxNameCompany.Text
      },
      @params = new {REGISTER_SONET_EVENT = "Y"}
    };

    var contentTextCompany = JsonConvert.SerializeObject(dataCompany);
    contentTextCompany = contentTextCompany.Replace("TITLE", "%TITLE");
    var CompanyListByJSON = BX24.SendCommand("crm.company.list", "", contentTextCompany);
    var CompanyList = JsonConvert.DeserializeObject<dynamic>(CompanyListByJSON);
    foreach (var company in CompanyList.result)
    {
      if (company.TITLE.ToString().Contains(TextBoxNameCompany.Text))
        BX24.CompanySeacrh.Add(new Bitrix24.COMPANY
        {
          TITLE = company.TITLE.ToString(),
          ID = Convert.ToInt32(company.ID.ToString())
        });
    }

    var dataCompanyByAddress = new
    {
      filter = new
      {
        ADDRESS = TextBoxNameCompany.Text
      },
      @params = new {REGISTER_SONET_EVENT = "Y"}
    };

    contentTextCompany = JsonConvert.SerializeObject(dataCompanyByAddress);
    contentTextCompany = contentTextCompany.Replace("ADDRESS", "%ADDRESS");
    CompanyListByJSON = BX24.SendCommand("crm.company.list", "", contentTextCompany);
    var CompanyByAddressList = JsonConvert.DeserializeObject<dynamic>(CompanyListByJSON);
    foreach (var company in CompanyByAddressList.result)
    {
      if (company.TITLE.ToString().Contains(TextBoxNameCompany.Text))
        BX24.CompanySeacrh.Add(new Bitrix24.COMPANY
        {
          TITLE = company.TITLE.ToString(),
          ID = Convert.ToInt32(company.ID.ToString())
        });
    }

    GridViewCompanySearch.DataBind();
    Session.Contents["companysearch"] = BX24.CompanySeacrh;
  }


  protected void GridViewCompanySearch_RowCommand(object sender, GridViewCommandEventArgs e)
  {
    if (e.CommandName == "Select")
    {
    }
  }


  protected void GridViewCompanySearch_SelectedIndexChanged(object sender, EventArgs e)
  {
    Bitrix24.COMPANY Result = null;

    var ResultSeacrh = new List<Bitrix24.COMPANY>();
    if (Session.Contents["companysearch"] != null)
      ResultSeacrh = ((List<Bitrix24.COMPANY>) Session.Contents["companysearch"]).OrderBy(r => r.TITLE).ToList();

    if (Result == null)
    {
      Result = ResultSeacrh[GridViewCompanySearch.SelectedIndex];
    }

    LabelTASK_UF_CRM_TASK.Text = string.Format("({0}) {1}", Result.ID, Result.TITLE);
    HiddenFieldTASK_UF_CRM_TASK.Value = Result.ID.ToString();
    Session.Contents["company"] = Result;
    GridViewLeadProducts.DataBind();
  }


  protected void LinqDataSourceCompamies_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var Result = new List<Bitrix24.COMPANY>();
    if (Session.Contents["companysearch"] != null)
      Result = (List<Bitrix24.COMPANY>) Session.Contents["companysearch"];
    if (BX24.CompanySeacrh.Count > 0)
      Result = BX24.CompanySeacrh;
    Session.Contents["companysearch"] = Result;
    e.Result = Result;
  }


  private void doContactCreateOrUpdate(int IdContact)
  {
    createContactFields();


    var LeadStatusListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=CONTACT_TYPE", "", "GET");
    DropDownListCONTACT_TYPE_ID.Items.Add(new ListItem("------", ""));
    var StatusList = JsonConvert.DeserializeObject<dynamic>(LeadStatusListByJSON);
    foreach (var status in StatusList.result)
      DropDownListCONTACT_TYPE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));


    if (IdContact > 0)
    {
      log.Info(string.Format("IdContact = {0}", IdContact));


      ButtonSaveContact.Text = "Обновить контакт";

      HiddenFieldIdContact.Value = IdContact.ToString();

      var Contact = BX24.SendCommand("crm.contact.get", "id=" + IdContact);
      var valueByJSON = JsonConvert.DeserializeObject<dynamic>(Contact);
      LabelNameContact.Text = TextBoxCONTACT_NAME.Text = valueByJSON.result.NAME;
      TextBoxCONTACT_SECOND_NAME.Text = valueByJSON.result.SECOND_NAME;
      TextBoxCONTACT_LAST_NAME.Text = valueByJSON.result.LAST_NAME;

      var category = "Contact";
      var tablePhones = TableContactPhones;

      createrAndFillPhones(valueByJSON, category, tablePhones);

      var tableEmails = TableContactEmails;

      createrAndFillEmails(valueByJSON, category, tableEmails);

      TextBoxCONTACT_COMMENTS.Text = valueByJSON.result.COMMENTS;
      DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue = valueByJSON.result.ASSIGNED_BY_ID;
      DropDownListCONTACT_TYPE_ID.SelectedValue = valueByJSON.result.TYPE_ID;

      fillContactUserFields(valueByJSON);
    }
  }

  private void createrAndFillEmails(dynamic valueByJSON, string category, Table tableEmails)
  {
    if (valueByJSON.result.EMAIL != null)
    {
      var countContact = 0;
      foreach (var email in valueByJSON.result.EMAIL)
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var TextBox = new TextBox
          {CssClass = "form-control", ID = $"TextBox{category}EMAIL" + email.ID, Text = email.VALUE};
        var HiddenField = new HiddenField {ID = $"HiddenField{category}EMAIL" + email.ID, Value = email.ID};
        var DropDownListEMAIL = new DropDownList
          {ID = $"DropDownList{category}EMAIL" + email.ID, CssClass = "form-control"};
        DropDownListEMAIL.Items.AddRange(
          BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        DropDownListEMAIL.SelectedValue = email.VALUE_TYPE;
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = $"RequiredFieldValidatorTextBox{category}EMAIL" + email.ID, ValidationGroup = category,
          ControlToValidate = $"TextBox{category}EMAIL" + email.ID, ForeColor = Color.Red,
          ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic, Enabled = false
        };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListEMAIL);
        cell2.Controls.Add(HiddenField);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        tableEmails.Rows.Add(row);

        if (Session.Contents[$"TableContact{category}Email"] != null)
        {
          var tables = Session.Contents[$"TableContact{category}Email"] as Dictionary<string, TableRow>;
          if (tables.ContainsKey("TableRow" + countContact))
            tables.Remove("TableRow" + countContact);
          Session.Contents[$"TableContact{category}Email"] = tables;
        }

        countContact++;
      }
    }
    else
    {
      var row = new TableRow();
      var cell = new TableCell();
      var cell2 = new TableCell();
      var TextBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}EMAIL"};
      var DropDownListEMAIL = new DropDownList {ID = $"DropDownList{category}EMAIL", CssClass = "form-control"};
      DropDownListEMAIL.Items.AddRange(
        BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
      var RequiredFieldValidator = new RequiredFieldValidator
      {
        ID = $"RequiredFieldValidatorTextBox{category}EMAIL", ValidationGroup = category,
        ControlToValidate = $"TextBox{category}EMAIL", ForeColor = Color.Red,
        ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic, Enabled = false
      };
      cell.Controls.Add(TextBox);
      cell.Controls.Add(RequiredFieldValidator);
      cell2.Controls.Add(DropDownListEMAIL);
      row.Cells.Add(cell);
      row.Cells.Add(cell2);
      tableEmails.Rows.Add(row);
    }
  }

  private void createrAndFillPhones(dynamic valueByJSON, string category, Table tablePhones)
  {
    if (valueByJSON.result.PHONE != null)
    {
      var countContact = 0;
      foreach (var phone in valueByJSON.result.PHONE)
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var TextBox = new TextBox
          {CssClass = "form-control", ID = $"TextBox{category}PHONE" + phone.ID, Text = phone.VALUE};
        var HiddenField = new HiddenField {ID = $"HiddenField{category}PHONE" + phone.ID, Value = phone.ID};
        var DropDownListPHONE = new DropDownList
          {ID = $"DropDownList{category}PHONE" + phone.ID, CssClass = "form-control"};
        DropDownListPHONE.Items.AddRange(
          BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        DropDownListPHONE.SelectedValue = phone.VALUE_TYPE;
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = $"RequiredFieldValidatorTextBox{category}PHONE" + phone.ID, ValidationGroup = category,
          ControlToValidate = $"TextBox{category}PHONE" + phone.ID, ForeColor = Color.Red,
          ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic
        };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListPHONE);
        cell2.Controls.Add(HiddenField);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        tablePhones.Rows.Add(row);

        if (Session.Contents[$"TableContact{category}"] != null)
        {
          var tables = Session.Contents[$"TableContact{category}"] as Dictionary<string, TableRow>;
          if (tables.ContainsKey("TableRow" + countContact))
            tables.Remove("TableRow" + countContact);
          Session.Contents[$"TableContact{category}"] = tables;
        }

        countContact++;
      }
    }
    else
    {
      var row = new TableRow();
      var cell = new TableCell();
      var cell2 = new TableCell();
      var TextBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}PHONE"};
      var DropDownListPHONE = new DropDownList {ID = $"DropDownList{category}PHONE", CssClass = "form-control"};
      DropDownListPHONE.Items.AddRange(
        BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
      var RequiredFieldValidator = new RequiredFieldValidator
      {
        ID = $"RequiredFieldValidatorTextBox{category}PHONE", ValidationGroup = category,
        ControlToValidate = $"TextBox{category}PHONE", ForeColor = Color.Red,
        ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic
      };
      cell.Controls.Add(TextBox);
      cell.Controls.Add(RequiredFieldValidator);
      cell2.Controls.Add(DropDownListPHONE);
      row.Cells.Add(cell);
      row.Cells.Add(cell2);
      tablePhones.Rows.Add(row);

      if (Request.QueryString["Phone"] != null)
      {
        TextBox.Text = Request.QueryString["Phone"];
      }

      if (Request.QueryString["AbonentNumber"] != null)
      {
        TextBox.Text = Request.QueryString["AbonentNumber"];
      }
    }
  }

  private void createContactFields()
  {
    var i = 6;
    BX24.FilterContactFields = FilterContactFields;
    var fields = BX24.ContactFields.ToList();
    var tableFileds = TableContact;
    createrFields(fields, tableFileds, i);
  }

  private void createrFields(List<Bitrix24.Userfield> fields, Table tableFileds, int i)
  {
    foreach (var uf in fields)
    {
      var tr = new TableRow {ID = "TableRow" + uf.ID};
      var tc1 = new TableCell
        {ID = "TableCellLabel" + uf.ID, Text = uf.NAME + (Request.QueryString["Fields"] != null ? $" {uf.ID}" : "")};
      var tc2 = new TableCell {ID = "TableCellUserfield" + uf.ID};
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var cbl = new CheckBoxList {ID = "CheckBoxListUserfield" + uf.ID, RepeatColumns = 3};
          foreach (var item in uf.LIST)
            cbl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          tc2.Controls.Add(cbl);
        }
        else
        {
          var ddl = new DropDownList {ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control"};
          ddl.Items.Add(new ListItem("-----", ""));
          foreach (var item in uf.LIST)
            ddl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          tc2.Controls.Add(ddl);
        }

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        tableFileds.Rows.AddAt(i++, tr);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        var ddl = new TextBox {ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control"};
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        tableFileds.Rows.AddAt(i++, tr);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        var ddl = new TextBox {ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control"};
        tc2.Controls.Add(ddl);
        var ddl2 = new DropDownList {ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control"};
        ddl2.Items.Add(new ListItem {Value = "RUB", Text = "Рубль"});
        ddl2.Items.Add(new ListItem {Value = "USD", Text = "Доллар США"});
        tc2.Controls.Add(ddl2);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        tableFileds.Rows.AddAt(i++, tr);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = new CheckBox {ID = "CheckBoxUserfield" + uf.ID, CssClass = "form-control"};
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
        tableFileds.Rows.AddAt(i++, tr);
      }
    }
  }

  private void fillContactUserFields(dynamic valueByJSON)
  {
    BX24.FilterContactFields = FilterContactFields;
    var fields = BX24.ContactFields.ToList();
    fillFields(valueByJSON, fields);
  }

  private void fillFields(dynamic valueByJSON, List<Bitrix24.Userfield> fields)
  {
    foreach (var uf in fields)
    {
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var CheckBoxListUF = FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
          foreach (JProperty item in valueByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME) //property name
            {
              foreach (var val_ in item.Value)
              {
                var li_ = CheckBoxListUF.Items.FindByValue(val_.ToString());
                if (li_ != null) li_.Selected = true;
              }
            }
          }
        }
        else
        {
          var DropDownListUF = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
          foreach (JProperty item in valueByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME && item.Value.ToString() != "") //property name
              DropDownListUF.SelectedValue = item.Value.ToString();
          }
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        if (ddl != null)
          foreach (JProperty item in valueByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME) //property name
              ddl.Text = item.Value.ToString();
          }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        var ddl2 = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
        foreach (JProperty item in valueByJSON.result)
        {
          if (item.Name == uf.FIELD_NAME) //property name
          {
            var arr = item.Value.ToString().Split('|').ToArray();
            if (arr.Length > 1)
            {
              ddl.Text = arr[0];
              ddl2.SelectedValue = arr[1];
            }
          }
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
        foreach (JProperty item in valueByJSON.result)
        {
          if (item.Name == uf.FIELD_NAME) //property name
            ddl.Checked = item.Value.ToString() == "1";
        }
      }
    }
  }

  private void doDealCreateOrUpdate()
  {
    createUserFields();
    if (Request.QueryString["IdDeal"] != null)
    {
      IdDeal = Convert.ToInt32(Request.QueryString["IdDeal"]);
      log.Info(string.Format("IdDeal = {0}", IdDeal));

      HiddenFieldIdDeal.Value = IdDeal.ToString();


      var Deal = BX24.SendCommand("crm.deal.get", "id=" + IdDeal);
      var DealByJSON = JsonConvert.DeserializeObject<dynamic>(Deal);
      TextBoxDEAL_TITLE.Text = DealByJSON.result.TITLE;
      TextBoxDEAL_OPPORTUNITY.Text = DealByJSON.result.OPPORTUNITY;
      DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue = DealByJSON.result.ASSIGNED_BY_ID;
      DropDownListDEAL_CURRENCY_ID.SelectedValue = DealByJSON.result.CURRENCY_ID;

      if (DealByJSON.result.CONTACT_ID != null)
      {
        HiddenFieldDEAL_CONTACT_ID.Value = DealByJSON.result.CONTACT_ID.ToString();
        var Contact = BX24.SendCommand("crm.contact.get", "id=" + DealByJSON.result.CONTACT_ID, "", "POST");
        var ContactByJSON = JsonConvert.DeserializeObject<dynamic>(Contact);
        var phones = "";
        if (ContactByJSON.result.PHONE != null)
        {
          foreach (var phone in ContactByJSON.result.PHONE)
          {
            phones += (phones != "" ? "," : "") + phone.VALUE;
          }
        }

        TextBoxDEAL_ContactInfoName.Text = ContactByJSON.result.NAME;
        LabelDEAL_ContactInfoPhone.Text = phones;
      }

      TextBoxDEAL_BEGINDATE.Text = DealByJSON.result.BEGINDATE;
      TextBoxDEAL_COMMENTS.Text = DealByJSON.result.COMMENTS;

      string leadStatusListByJSON =
        BX24.SendCommand("crm.dealcategory.stage.list", "id=" + DealByJSON.result.CATEGORY_ID, "", "GET");
      var statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJSON);
      foreach (var status in statusList.result)
        DropDownListDEAL_STAGE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));


      DropDownListDEAL_STAGE_ID.SelectedValue = DealByJSON.result.STAGE_ID;
      LabelNameDeal.Text = string.Format("Сделка №{0}", DealByJSON.result.ID);

      fillUserFields(DealByJSON);
    }
  }

  private void fillUserFields(dynamic DealByJSON)
  {
    BX24.FilterDealFields = FilterDealFields;
    var fields = BX24.DealFields.ToList();

    fillFields(DealByJSON, fields);
  }

  private void createUserFields()
  {
    var i = 7;
    BX24.FilterDealFields = FilterDealFields;
    var fields = BX24.DealFields.ToList();
    var tableFileds = TableDeal;

    createrFields(fields, tableFileds, i);
  }

  private void doTaskCreate()
  {
    if (Request.QueryString["IdTask"] != null)
    {
      IdTask = Convert.ToInt32(Request.QueryString["IdTask"]);
      log.Info(string.Format("IdTask = {0}", IdTask));


      var Task = BX24.SendCommand("tasks.task.get", "taskId=" + IdTask);
      var TaskByJSON = JsonConvert.DeserializeObject<dynamic>(Task);
      TextBoxTASK_TITLE.Text = TaskByJSON.result.task.title;
      TextBoxTASK_DESCRIPTION.Text = TaskByJSON.result.task.description;
      DropDownListTASK_ASSIGNED_BY_ID.SelectedValue = TaskByJSON.result.task.responsibleId;
      var i = 1;
      if (TaskByJSON.result.task.auditors != null)
        foreach (int auditor in TaskByJSON.result.task.auditors)
        {
          switch (i)
          {
            case 1:
              DropDownListTASK_AUDITOR_1.SelectedValue = auditor.ToString();
              break;
            case 2:
              DropDownListTASK_AUDITOR_2.SelectedValue = auditor.ToString();
              break;
            case 3:
              DropDownListTASK_AUDITOR_3.SelectedValue = auditor.ToString();
              break;
            case 4:
              DropDownListTASK_AUDITOR_4.SelectedValue = auditor.ToString();
              break;
            case 5:
              DropDownListTASK_AUDITOR_5.SelectedValue = auditor.ToString();
              break;
          }

          i++;
        }

      ;
      TextBoxTASK_DEADLINE.Text = TaskByJSON.result.task.deadline;
      if (TaskByJSON.result.task.ufCrmTask !=null && TaskByJSON.result.task.ufCrmTask.Count > 0)
      {
        LabelTASK_UF_CRM_TASK.Text = string.Format("({0}) {1}", TaskByJSON.result.task.ufCrmTask[0], "");
        HiddenFieldTASK_UF_CRM_TASK.Value = TaskByJSON.result.task.ufCrmTask[0];
      }

      LabelNameTask.Text = string.Format("Задача №{0}", TaskByJSON.result.task.id);
    }
    else
    {
      if (IdContact > 0)
      {
        DropDownListTASK_ASSIGNED_BY_ID.SelectedValue = DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue;
      }
      else if (IdLead > 0)
      {
        DropDownListTASK_ASSIGNED_BY_ID.SelectedValue = DropDownListLeadASSIGNED_BY_ID.SelectedValue;
      }

      //  TextBoxTASK_TITLE.Text = string.Format("{0}, ", DateTime.Now);
      //if (Request.QueryString["Phone"] != null)
      //{
      //  Phone = Request.QueryString["Phone"];
      //  log.Info(string.Format("Phone = {0}", Phone));
      //  TextBoxTASK_DESCRIPTION.Text = string.Format("Телефон: {0}{1}", Phone, Environment.NewLine);
      //}
    }
  }

  protected void ButtonSaveOrUpdateDeal_OnClick(object sender, EventArgs e)
  {
    var data =
      new
      {
        id = (object) HiddenFieldIdDeal.Value,
        fields = new Dictionary<string, object>
        {
          {"TITLE", TextBoxDEAL_TITLE.Text},
          {"ASSIGNED_BY_ID", DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue},
          {"OPPORTUNITY", TextBoxDEAL_OPPORTUNITY.Text},
          {"CURRENCY_ID", DropDownListDEAL_CURRENCY_ID.SelectedValue},
          {"STAGE_ID", DropDownListDEAL_STAGE_ID.SelectedValue},
          {"BEGINDATE", TextBoxDEAL_BEGINDATE.Text},
          {"COMMENTS", TextBoxDEAL_COMMENTS.Text}
        }
      };

    BX24.FilterDealFields = FilterDealFields;
    foreach (var uf in BX24.DealFields)
    {
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var cbl = Page.FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
          if (cbl != null)
          {
            var sel = new List<string>();

            foreach (ListItem item in cbl.Items)
            {
              if (item.Selected)
                sel.Add(item.Value);
            }

            data.fields.Add(uf.FIELD_NAME, sel);
          }
        }
        else
        {
          var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
          if (ddl != null)
          {
            data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
          }
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        if (ddl != null)
        {
          data.fields.Add(uf.FIELD_NAME, ddl.Text);
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        var ddl2 = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
        if (ddl != null)
        {
          data.fields.Add(uf.FIELD_NAME, ddl.Text + "|" + ddl2.SelectedValue);
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = Page.FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
        if (ddl != null)
        {
          data.fields.Add(uf.FIELD_NAME, ddl.Checked);
        }
      }
    }

    if (!string.IsNullOrEmpty(HiddenFieldDEAL_CONTACT_ID.Value) != null)
    {
      var dataContact =
        new
        {
          id = (object) HiddenFieldDEAL_CONTACT_ID.Value,
          fields = new Dictionary<string, object>
          {
            {"NAME", TextBoxDEAL_ContactInfoName.Text}
          }
        };

      var contentContactText = JsonConvert.SerializeObject(dataContact);
      var contact = BX24.SendCommand("crm.contact.update", "", contentContactText);
      var contactByJSON = JsonConvert.DeserializeObject<dynamic>(contact);
    }


    var contentText = JsonConvert.SerializeObject(data);

    var Deal = Request.QueryString["IdDeal"] != null
      ? BX24.SendCommand("crm.deal.update", "", contentText)
      : BX24.SendCommand("crm.deal.add", "", contentText);
    var DealByJSON = JsonConvert.DeserializeObject<dynamic>(Deal);

    Response.Redirect("~/Modultron.aspx?IdDeal=" + HiddenFieldIdDeal.Value);
    Response.End();
  }

  protected void ButtonSaveContact_OnClick(object sender, EventArgs e)
  {
    try
    {
      var IdContactOld = HiddenFieldIdContact.Value != "" ? Convert.ToInt32(HiddenFieldIdContact.Value) : 0;
      log.Info(string.Format("IdContactOld = {0}", IdContactOld));

      if (IdContactOld == 0)
      {
        //проверим возможно уже контакт был создан пока заполняли форму
        if (string.IsNullOrEmpty(Phone) && Request.QueryString["Phone"] != null)
        {
          Phone = Request.QueryString["Phone"];
        }

        if (!string.IsNullOrEmpty(Phone))
        {
          IdContactOld = getIdContactByPhone(Phone);
          log.Info(string.Format("Лид найден IdLeadOld = {0}", IdContactOld));
        }
      }


      var data =
        IdContactOld > 0
          ? new
          {
            id = (object) IdContactOld,
            fields = new Dictionary<string, object>
            {
              {"NAME", TextBoxCONTACT_NAME.Text},
              {"SECOND_NAME", TextBoxCONTACT_SECOND_NAME.Text},
              {"LAST_NAME", TextBoxCONTACT_LAST_NAME.Text},
              {"COMMENTS", TextBoxCONTACT_COMMENTS.Text},
              {"ASSIGNED_BY_ID", DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue},
              {"TYPE_ID", DropDownListCONTACT_TYPE_ID.SelectedValue}
            },
            @params = new {REGISTER_SONET_EVENT = "Y"}
          }
          : new
          {
            id = new object(),
            fields = new Dictionary<string, object>
            {
              {"NAME", TextBoxCONTACT_NAME.Text},
              {"SECOND_NAME", TextBoxCONTACT_SECOND_NAME.Text},
              {"LAST_NAME", TextBoxCONTACT_LAST_NAME.Text},
              {"COMMENTS", TextBoxCONTACT_COMMENTS.Text},
              {"ASSIGNED_BY_ID", DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue},
              {"TYPE_ID", DropDownListCONTACT_TYPE_ID.SelectedValue}
            },
            @params = new {REGISTER_SONET_EVENT = "Y"}
          };


      var phones = new List<object>();
      foreach (TableRow row in TableContactPhones.Rows)
      {
        var TextBoxLeadPHONE = row.Cells[0].Controls[0] as TextBox;
        var RequiredFieldValidatorLeadPHONE = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var DropDownListLeadPHONE = row.Cells[1].Controls[0] as DropDownList;
        HiddenField HiddenFieldLeadPHONE = null;
        if (row.Cells[1].Controls.Count > 1)
          HiddenFieldLeadPHONE = row.Cells[1].Controls[1] as HiddenField;
        if (HiddenFieldLeadPHONE != null)
          phones.Add(new
          {
            ID = HiddenFieldLeadPHONE.Value, VALUE = TextBoxLeadPHONE.Text,
            VALUE_TYPE = DropDownListLeadPHONE.SelectedValue
          });
        else
          phones.Add(new {VALUE = TextBoxLeadPHONE.Text, VALUE_TYPE = DropDownListLeadPHONE.SelectedValue});
      }

      data.fields["PHONE"] = phones;


      var emails = new List<object>();
      foreach (TableRow row in TableContactEmails.Rows)
      {
        var TextBoxLeadEMAIL = row.Cells[0].Controls[0] as TextBox;
        var RequiredFieldValidatorLeadEMAIL = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var DropDownListLeadEMAIL = row.Cells[1].Controls[0] as DropDownList;
        HiddenField HiddenFieldLeadEMAIL = null;
        if (row.Cells[1].Controls.Count > 1)
          HiddenFieldLeadEMAIL = row.Cells[1].Controls[1] as HiddenField;
        if (HiddenFieldLeadEMAIL != null)
          emails.Add(new
          {
            ID = HiddenFieldLeadEMAIL.Value, VALUE = TextBoxLeadEMAIL.Text,
            VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue
          });
        else
          emails.Add(new {VALUE = TextBoxLeadEMAIL.Text, VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue});
      }

      data.fields["EMAIL"] = emails;

      var t = data.fields.GetType();
      foreach (var uf in BX24.ContactFields)
      {
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var cbl = Page.FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            if (cbl != null)
            {
              var sel = new List<string>();

              foreach (ListItem item in cbl.Items)
              {
                if (item.Selected)
                  sel.Add(item.Value);
              }

              data.fields.Add(uf.FIELD_NAME, sel);
            }
          }
          else
          {
            var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            if (ddl != null)
            {
              data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
            }
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          if (ddl != null)
          {
            data.fields.Add(uf.FIELD_NAME, ddl.Text);
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = Page.FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          if (ddl != null)
          {
            data.fields.Add(uf.FIELD_NAME, ddl.Checked);
          }
        }
      }


      var contentText = JsonConvert.SerializeObject(data);
      if (IdContactOld == 0)
        contentText = contentText.Replace("\"id\":{},", "");


      var NewLead =
        IdContactOld > 0
          ? BX24.SendCommand("crm.contact.update", "", contentText)
          : BX24.SendCommand("crm.contact.add", "", contentText);
      var NewLeadByJSON = JsonConvert.DeserializeObject<dynamic>(NewLead);
      int IdContact = IdContactOld > 0 ? IdContactOld : Convert.ToInt32(NewLeadByJSON.result);

      if (IdContact == 0)
      {
        AddCommentToElement(IdContact, "Контакт создан в КЦ Wilstream", "contact");
        log.Info(string.Format("New IdContact = {0}", IdContact));
        Response.Redirect("~/Ekomebel.aspx?IdContact=" + IdContact);
        Response.End();
      }
      else
      {
        AddCommentToElement(IdContact, "Контакт обновлен в КЦ Wilstream", "contact");
        log.Info(string.Format("Redirect after update IdContact = {0}", IdContact));
        Response.Redirect("~/Ekomebel.aspx?IdContact=" + IdContact);
        Response.End();
      }
    }
    catch (Exception ex)
    {
      Response.Write("Ошибка сохранения лида. Возможно лид уже был удален.");
    }
  }
}