using log4net;
using log4net.Config;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Avantsb2 : System.Web.UI.Page
{
  Bitrix24 BX24;
  Sourcers Sourcers = new Sourcers();
  Int32 IdLead = 0;
  Int32 IdContact = 0;
  string Phone = "";

  private static ILog log = LogManager.GetLogger("LOGGER");
  private static string RedirectUrl = "Avantsb2.aspx";
  private List<KeyValuePair<string, string>> Responsiblies;
  private List<KeyValuePair<string, string>> Sources;


  public List<int> FilterUserFields =  new List<int>() { 654, 776};
  public List<int> FilterContactFields = new List<int>();
  public List<int> FilterDealFields = new List<int>() {777, 778 };
  public List<int> FilterOpenDealFields = new List<int>() {269,270, 271, 272, 273, 166, 274, 275,276,277 };

  public Dictionary<int, FieldSettings> UserFieldSettings = new Dictionary<int, FieldSettings>() {
     {776, new FieldSettings() { Position = 1 } },
     {654, new FieldSettings() { Position = 11, Alias = "Направление ЛИД" } },
  };

  public Dictionary<int, FieldSettings> DealFieldSettings = new Dictionary<int, FieldSettings>() {
     {777, new FieldSettings() { Position = 1 } },
     {778, new FieldSettings() { Position = 5, Alias = "Направление" } },
     {269, new FieldSettings() { PreTitle = "АДРЕС ДОСТАВКИ" } },
     {270, new FieldSettings() { Readonly = true } },
     {271, new FieldSettings() { Readonly = true } },
     {272, new FieldSettings() { Readonly = true } }, 
     {166, new FieldSettings() {   Readonly = true, PreTitle = "ПТС И ДКП - ДОСТАВКА" } },
     {274, new FieldSettings() { Readonly = true } },
     {275, new FieldSettings() { Readonly = true } },
  };

  private enum TypeObject {
    Undefined,
    Lead,
    Contact
  }

  protected void Page_Init(object sender, EventArgs e)
  {
    XmlConfigurator.Configure(); 

    if (Request.QueryString["IdLead"] != null)
    {
      IdLead = Convert.ToInt32(Request.QueryString["IdLead"]); 
      log.Info(String.Format("IdLead = {0}", IdLead));
    }

    if (Request.QueryString["IdContact"] != null)
    {
      IdContact = Convert.ToInt32(Request.QueryString["IdContact"]); 
      log.Info(String.Format("IdContact = {0}", IdContact));
    }

    if (Request.QueryString["Phone"] != null)
    {
      Phone = Request.QueryString["Phone"].ToString();
      log.Info(String.Format("Phone = {0}", Phone));
    }
    if (Request.QueryString["AbonentNumber"] != null)
    {
      Phone = Request.QueryString["AbonentNumber"].ToString();
      log.Info(String.Format("AbonentNumber = {0}", Phone));
    }

    BX24 = new Bitrix24(HttpContext.Current, "local.6062e98e18b1c1.59172320", "aXYiuqGbyT029ll19EN4tVv8KwTW3Ate5cD8qDbqQqtyrYnSUl", "https://dev01.veles24.com", "https://oauth.bitrix.info", "CCW", "cc@avantsb.ruZ10");

    Responsiblies = GetResponsiblies();
    Sources = GetSources();


    if (!IsPostBack)
    {
      Session.Contents["productrows"] = null;
      Session.Contents["productsearch"] = null;
    }

    var show = TypeObject.Undefined;

    if (IdLead > 0)
    {
      show = TypeObject.Lead;
    }
    else if (IdContact > 0)
    {
      show = TypeObject.Contact;
    }
    else if (Phone != "")
    {
      IdContact = getIdContactByPhone(Phone);

      if (IdContact > 0)
      {
        show = TypeObject.Contact;
      }
      else
      {
        IdLead = getIdLeadByPhone(Phone);
        show = TypeObject.Lead;
      }
    }



    switch (show)
    {
      case TypeObject.Lead:
        CreateLeadForm(IdLead);
        break;

      case TypeObject.Contact:
        CreateContactForm(IdContact);

        var openDeals = GetOpenDealByIdContact(IdContact);

        int IdDeal = 0;
        if (Request.QueryString["IdDeal"] != null)
        {
          IdDeal = Convert.ToInt32(Request.QueryString["IdDeal"]);
          log.Info(string.Format("IdDeal = {0}", IdDeal));
        }
        else if (openDeals.Count > 0)
        {
          IdDeal = openDeals.OrderByDescending(x => x.DateCreate).First().Id;
        }

        CreateDealForm(IdDeal);

        break;
    }

  }

  private List<KeyValuePair<string, string>> GetSources()
  {
    string LeadSourceListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=SOURCE", "", "GET");
    var SourceList = JsonConvert.DeserializeObject<dynamic>(LeadSourceListByJSON);

    var dataListSources = new
    {
      sort = "NAME"
    };
    var sourceSearchListJson = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=SOURCE", JsonConvert.SerializeObject(dataListSources), "POST");
    var sourceSearchList = JsonConvert.DeserializeObject<dynamic>(sourceSearchListJson);
    var it = 0;
    var sources = new List<KeyValuePair<string, string>>();
    while (it < 5)
    {
      it++;
      foreach (var source in sourceSearchList.result)
        sources.Add(new KeyValuePair<string, string>(source.NAME.ToString(), source.ID.ToString()));
      if (sourceSearchList.next != null)
      {
        sourceSearchListJson = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=SOURCE&start=" + sourceSearchList.next.ToString(), JsonConvert.SerializeObject(dataListSources), "POST");
        sourceSearchList = JsonConvert.DeserializeObject<dynamic>(sourceSearchListJson);
      }
      else break;

    }
    return sources;
  }

  protected void Page_Load(object sender, EventArgs e)
  {

  }

#region Deal

  private void CreateDealForm(int IdDeal)
  {
    PanelDeal.Visible = true;
    ButtonSaveOrUpdateDeal.Text = "Создать сделку"; 
    LabelNameDealTitle.Visible = true;
    ButtonCloseClosedDeal.Visible = false;

    var filterDealFields = IdDeal > 0 ? FilterOpenDealFields : FilterDealFields;

    

    DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    foreach (var user in Responsiblies.OrderBy(r => r.Key))
      DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));


    foreach (var source in Sources)
      DropDownListDEAL_SOURCE_ID.Items.Add(new ListItem(source.Key, source.Value));

    string leadStatusListByJSON =
        BX24.SendCommand("crm.dealcategory.stage.list", "", "", "GET");
    var statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJSON);
    foreach (var status in statusList.result)
      DropDownListDEAL_STAGE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));

    if (IdDeal>0)
    {
      DropDownListDEAL_STAGE_ID.Items.Clear();

      ButtonSaveOrUpdateDeal.Text = "Обновить сделку";
      LabelNameDealTitle.Visible = false;
      HiddenFieldIdDeal.Value = IdDeal.ToString();

      var Deal = BX24.SendCommand("crm.deal.get", "id=" + IdDeal);
      var DealByJSON = JsonConvert.DeserializeObject<dynamic>(Deal);
      TextBoxDEAL_TITLE.Text = DealByJSON.result.TITLE;
      TextBoxDEAL_OPPORTUNITY.Text = DealByJSON.result.OPPORTUNITY;
      DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue = DealByJSON.result.ASSIGNED_BY_ID;
      DropDownListDEAL_CURRENCY_ID.SelectedValue = DealByJSON.result.CURRENCY_ID;

      bool IsClosed = DealByJSON.result.CLOSED.ToString() == "Y";

      ButtonSaveOrUpdateDeal.Visible = !IsClosed;
      ButtonCloseClosedDeal.Visible = IsClosed;

      if (IsClosed)
        disabledSystemFields();

      createUserFields(filterDealFields, IsClosed);

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


      leadStatusListByJSON =
        BX24.SendCommand("crm.dealcategory.stage.list", "id=" + DealByJSON.result.CATEGORY_ID, "", "GET");
      statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJSON);
      foreach (var status in statusList.result)
        DropDownListDEAL_STAGE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));



      DropDownListDEAL_STAGE_ID.SelectedValue = DealByJSON.result.STAGE_ID;
      LabelNameDeal.Text = string.Format("Сделка №{0}", DealByJSON.result.ID);

      fillUserFields(DealByJSON, filterDealFields);
    }
    else
      createUserFields(filterDealFields, false);
  }

  private void disabledSystemFields() {
    TextBoxDEAL_TITLE.Enabled = false;
    DropDownListDEAL_SOURCE_ID.Enabled = false;
    TextBoxDEAL_COMMENTS.Enabled = false;
  }

  private List<DealInfo> GetOpenDealByIdContact(int IdContact) {
    var deals = BX24.SendCommand("crm.deal.list", "FILTER[CLOSED]=N&FILTER[CONTACT_ID]=" + IdContact + "");
    var dealsByJSON = JsonConvert.DeserializeObject<dynamic>(deals);
    var listDeals = new List<DealInfo>();
    if (dealsByJSON.result?.Count > 0)
    {
      for (int i = 0; i < dealsByJSON.result?.Count; i++) {
        var deal = dealsByJSON.result[i];
        listDeals.Add(new DealInfo() { Id = int.Parse(deal.ID.ToString()), Title = deal.TITLE.ToString(), DateCreate = DateTime.Parse(deal.DATE_CREATE.ToString(), CultureInfo.InvariantCulture) });
      }
    }
    return listDeals;
  }

  private void createUserFields(List<int> filterDealFields, bool isClosed)
  {
    var i = 10;
    BX24.FilterDealFields = filterDealFields;
    var bfields = BX24.DealFields.ToList();
    
    var fields = filterDealFields==null ? bfields: filterDealFields.Select(x=> bfields.FirstOrDefault(b=>b.ID == x)).Where(x=>x!=null).ToList();

    var tableFileds = TableDeal;

    createrFields(fields, tableFileds, DealFieldSettings, i, isClosed);
  }

  private void fillUserFields(dynamic DealByJSON, List<int> filterDealFields)
  {
    BX24.FilterDealFields = filterDealFields;
    var fields = BX24.DealFields.ToList();

    fillFields(DealByJSON, fields);
  }

  protected void ButtonSaveOrUpdateDeal_OnClick(object sender, EventArgs e)
  {
    int IdContact = int.Parse(HiddenFieldIdContact.Value);

    var data =
      new
      {
        id = (object)HiddenFieldIdDeal.Value,
        fields = new Dictionary<string, object>
        {
          {"TITLE", TextBoxDEAL_TITLE.Text},
          {"ASSIGNED_BY_ID", DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue},
      //    {"OPPORTUNITY", TextBoxDEAL_OPPORTUNITY.Text},
     //     {"CURRENCY_ID", DropDownListDEAL_CURRENCY_ID.SelectedValue},
          {"STAGE_ID", DropDownListDEAL_STAGE_ID.SelectedValue},
        //  {"BEGINDATE", TextBoxDEAL_BEGINDATE.Text},
          {"COMMENTS", TextBoxDEAL_COMMENTS.Text},
          {"CONTACT_IDS", new List<int>(){ IdContact } }
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

    //if (!string.IsNullOrEmpty(HiddenFieldDEAL_CONTACT_ID.Value))
    //{
    //  var dataContact =
    //    new
    //    {
    //      id = (object)HiddenFieldDEAL_CONTACT_ID.Value,
    //      fields = new Dictionary<string, object>
    //      {
    //        {"NAME", TextBoxDEAL_ContactInfoName.Text}
    //      }
    //    };

    //  var contentContactText = JsonConvert.SerializeObject(dataContact);
    //  var contact = BX24.SendCommand("crm.contact.update", "", contentContactText);
    //  var contactByJSON = JsonConvert.DeserializeObject<dynamic>(contact);
    //}


    var contentText = JsonConvert.SerializeObject(data);

    var IdDealOld = HiddenFieldIdDeal.Value != "" ? Convert.ToInt32(HiddenFieldIdDeal.Value) : 0;

    var Deal = IdDealOld > 0
      ? BX24.SendCommand("crm.deal.update", "", contentText)
      : BX24.SendCommand("crm.deal.add", "", contentText);
    var DealByJSON = JsonConvert.DeserializeObject<dynamic>(Deal);


    IdDealOld = IdDealOld > 0 ? IdDealOld : Convert.ToInt32(DealByJSON.result);

    Response.Redirect($"~/{RedirectUrl}?IdDeal={IdDealOld}&IdContact={HiddenFieldIdContact.Value}");
    Response.End();
  }
   

  protected void ButtonShowClosedDeal_Click(object sender, EventArgs e)
  {
    PanelClosedDeals.Visible = true;
    Sourcers.ClosedDeals = GetClosedDealByIdContact(IdContact); 
    Session.Contents["CloasedDeals"] = Sourcers.ClosedDeals;
    GridViewClosedDeals.DataBind();
  }


  protected void ButtonCloseClosedDeal_Click(object sender, EventArgs e)
  {
    Response.Redirect($"~/{RedirectUrl}?IdContact={HiddenFieldIdContact.Value}");
  }



  protected void GridViewCompanySearch_SelectedIndexChanged(object sender, EventArgs e)
  {
    DealInfo Result = null;

    var ResultSeacrh = new List<DealInfo>();
    if (Session.Contents["CloasedDeals"] != null)
      ResultSeacrh = ((List<DealInfo>)Session.Contents["CloasedDeals"]).OrderBy(r => r.Title).ToList();

    if (Result == null)
    {
      Result = ResultSeacrh[GridViewClosedDeals.SelectedIndex];
    }
    if (Result != null)
    {
      Response.Redirect($"~/{RedirectUrl}?IdDeal={Result.Id}&IdContact={HiddenFieldIdContact.Value}");
      Response.End();
    }
  }


  protected void LinqDataSourceCompamies_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var Result = new List<DealInfo>();
    if (Session.Contents["CloasedDeals"] != null)
      Result = (List<DealInfo>)Session.Contents["CloasedDeals"];
    if (Sourcers.ClosedDeals.Count > 0)
      Result = Sourcers.ClosedDeals;
    Session.Contents["CloasedDeals"] = Result;
    e.Result = Result;
  }




  private List<DealInfo> GetClosedDealByIdContact(int IdContact)
  {
    var deals = BX24.SendCommand("crm.deal.list", "FILTER[CLOSED]=Y&FILTER[CONTACT_ID]=" + IdContact + "");
    var dealsByJSON = JsonConvert.DeserializeObject<dynamic>(deals);
    var listDeals = new List<DealInfo>();
    if (dealsByJSON.result?.Count > 0)
    {
      for (int i = 0; i < dealsByJSON.result?.Count; i++)
      {
        var deal = dealsByJSON.result[i];
        listDeals.Add(new DealInfo() { Id = int.Parse(deal.ID.ToString()), Title = deal.TITLE.ToString(), DateCreate = DateTime.Parse(deal.DATE_CREATE.ToString(), CultureInfo.InvariantCulture) });
      }
    }
    return listDeals;
  }

#endregion

#region Contact
  private void CreateContactForm(int IdContact)
  {
    PanelContact.Visible = true;

    createContactFields();

    var LeadStatusListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=CONTACT_TYPE", "", "GET");
    DropDownListCONTACT_TYPE_ID.Items.Add(new ListItem("------", ""));
    var StatusList = JsonConvert.DeserializeObject<dynamic>(LeadStatusListByJSON);
    foreach (var status in StatusList.result)
      DropDownListCONTACT_TYPE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));

    DropDownListCONTACT_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    foreach (var user in Responsiblies.OrderBy(r => r.Key))
      DropDownListCONTACT_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));


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
        { CssClass = "form-control", ID = $"TextBox{category}EMAIL" + email.ID, Text = email.VALUE };
        var HiddenField = new HiddenField { ID = $"HiddenField{category}EMAIL" + email.ID, Value = email.ID };
        var DropDownListEMAIL = new DropDownList
        { ID = $"DropDownList{category}EMAIL" + email.ID, CssClass = "form-control" };
        DropDownListEMAIL.Items.AddRange(
          BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        DropDownListEMAIL.SelectedValue = email.VALUE_TYPE;
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = $"RequiredFieldValidatorTextBox{category}EMAIL" + email.ID,
          ValidationGroup = category,
          ControlToValidate = $"TextBox{category}EMAIL" + email.ID,
          ForeColor = Color.Red,
          ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic,
          Enabled = false
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
      var TextBox = new TextBox { CssClass = "form-control", ID = $"TextBox{category}EMAIL" };
      var DropDownListEMAIL = new DropDownList { ID = $"DropDownList{category}EMAIL", CssClass = "form-control" };
      DropDownListEMAIL.Items.AddRange(
        BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
      var RequiredFieldValidator = new RequiredFieldValidator
      {
        ID = $"RequiredFieldValidatorTextBox{category}EMAIL",
        ValidationGroup = category,
        ControlToValidate = $"TextBox{category}EMAIL",
        ForeColor = Color.Red,
        ErrorMessage = "Заполните поле",
        Display = ValidatorDisplay.Dynamic,
        Enabled = false
      };
      cell.Controls.Add(TextBox);
      cell.Controls.Add(RequiredFieldValidator);
      cell2.Controls.Add(DropDownListEMAIL);
      row.Cells.Add(cell);
      row.Cells.Add(cell2);
      tableEmails.Rows.Add(row);
    }
  }

  private void createContactFields()
  {
    var i = 6;
    BX24.FilterContactFields = FilterContactFields;
    var fields = BX24.ContactFields.ToList();
    var tableFileds = TableContact;
    createrFields(fields, tableFileds, null, i);
  }

  private void createrFields(List<Bitrix24.Userfield> fields, Table tableFileds, Dictionary<int, FieldSettings> fieldSettings, int i, bool isClosed = false)
  {
    foreach (var uf in fields)
    {
      var enabled = true;

      if (fieldSettings != null && fieldSettings.ContainsKey(uf.ID))
      {
        var setting = fieldSettings[uf.ID];
        enabled = !setting.Readonly;
      }

      if (isClosed)  enabled = false;

      var tr = new TableRow { ID = "TableRow" + uf.ID };
      var tc1 = new TableCell
      { ID = "TableCellLabel" + uf.ID, Text = uf.NAME + (Request.QueryString["Fields"] != null ? $" {uf.ID} {uf.USER_TYPE_ID}" : "") };
        tr.Cells.Add(tc1);
      var tc2 = new TableCell { ID = "TableCellUserfield" + uf.ID };
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var cbl = new CheckBoxList { ID = "CheckBoxListUserfield" + uf.ID, RepeatColumns = 3 };
          foreach (var item in uf.LIST)
            cbl.Items.Add(new ListItem { Text = item.VALUE, Value = item.ID.ToString() });
          cbl.Enabled = enabled;
          tc2.Controls.Add(cbl);
        }
        else
        {
          var ddl = new DropDownList { ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control" };
          ddl.Items.Add(new ListItem("-----", ""));
          foreach (var item in uf.LIST)
            ddl.Items.Add(new ListItem { Text = item.VALUE, Value = item.ID.ToString() });
          ddl.Enabled = enabled;
          tc2.Controls.Add(ddl);
        }

        tr.Cells.Add(tc2); 
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string || uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.date)
      {
        var ddl = new TextBox { ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control" };
        ddl.Enabled = enabled;
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc2); 
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        var ddl = new TextBox { ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control" };
        ddl.Enabled = enabled;
        tc2.Controls.Add(ddl);
        var ddl2 = new DropDownList { ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control" };
        ddl2.Items.Add(new ListItem { Value = "RUB", Text = "Рубль" });
        ddl2.Items.Add(new ListItem { Value = "USD", Text = "Доллар США" });
        ddl2.Enabled = enabled;
        tc2.Controls.Add(ddl2);

        tr.Cells.Add(tc2); 
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = new CheckBox { ID = "CheckBoxUserfield" + uf.ID, CssClass = "form-control" };
        ddl.Enabled = enabled;
        tc2.Controls.Add(ddl);
        
        tr.Cells.Add(tc2);
      }
      if (fieldSettings != null && fieldSettings.ContainsKey(uf.ID))
      {
        var setting = fieldSettings[uf.ID];
        if (setting.Alias != null)
        {
          tr.Cells[0].Text = setting.Alias;
        }

        var position = i++;
        if (setting.Position != null)
          position = (int)setting.Position;
         
        tableFileds.Rows.AddAt(position, tr);        

        if (setting.PreTitle != null)
        {
          var trTitle = new TableRow { ID = "TableRowPreTitle" + uf.ID };
          var tcTitle = new TableCell { ID = "TableCellLabelTitle" + uf.ID, Text = setting.PreTitle };
          tcTitle.Font.Bold = true;
          trTitle.Cells.Add(tcTitle);
          tableFileds.Rows.AddAt(position, trTitle);
          i++;
        }

      }
      else
      {
        tableFileds.Rows.AddAt(i++, tr);
      }
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
        { CssClass = "form-control", ID = $"TextBox{category}PHONE" + phone.ID, Text = phone.VALUE };
        var HiddenField = new HiddenField { ID = $"HiddenField{category}PHONE" + phone.ID, Value = phone.ID };
        var DropDownListPHONE = new DropDownList
        { ID = $"DropDownList{category}PHONE" + phone.ID, CssClass = "form-control" };
        DropDownListPHONE.Items.AddRange(
          BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        DropDownListPHONE.SelectedValue = phone.VALUE_TYPE;
        var RequiredFieldValidator = new RequiredFieldValidator
        {
          ID = $"RequiredFieldValidatorTextBox{category}PHONE" + phone.ID,
          ValidationGroup = category,
          ControlToValidate = $"TextBox{category}PHONE" + phone.ID,
          ForeColor = Color.Red,
          ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic
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
      var TextBox = new TextBox { CssClass = "form-control", ID = $"TextBox{category}PHONE" };
      var DropDownListPHONE = new DropDownList { ID = $"DropDownList{category}PHONE", CssClass = "form-control" };
      DropDownListPHONE.Items.AddRange(
        BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
      var RequiredFieldValidator = new RequiredFieldValidator
      {
        ID = $"RequiredFieldValidatorTextBox{category}PHONE",
        ValidationGroup = category,
        ControlToValidate = $"TextBox{category}PHONE",
        ForeColor = Color.Red,
        ErrorMessage = "Заполните поле",
        Display = ValidatorDisplay.Dynamic
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
            id = (object)IdContactOld,
            fields = new Dictionary<string, object>
            {
              {"NAME", TextBoxCONTACT_NAME.Text},
              {"SECOND_NAME", TextBoxCONTACT_SECOND_NAME.Text},
              {"LAST_NAME", TextBoxCONTACT_LAST_NAME.Text},
          //    {"COMMENTS", TextBoxCONTACT_COMMENTS.Text},
           //   {"ASSIGNED_BY_ID", DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue},
          //    {"TYPE_ID", DropDownListCONTACT_TYPE_ID.SelectedValue}
            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
          }
          : new
          {
            id = new object(),
            fields = new Dictionary<string, object>
            {
              {"NAME", TextBoxCONTACT_NAME.Text},
              {"SECOND_NAME", TextBoxCONTACT_SECOND_NAME.Text},
              {"LAST_NAME", TextBoxCONTACT_LAST_NAME.Text},
           //   {"COMMENTS", TextBoxCONTACT_COMMENTS.Text},
          //    {"ASSIGNED_BY_ID", DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue},
           //   {"TYPE_ID", DropDownListCONTACT_TYPE_ID.SelectedValue}
            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
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
            ID = HiddenFieldLeadPHONE.Value,
            VALUE = TextBoxLeadPHONE.Text,
            VALUE_TYPE = DropDownListLeadPHONE.SelectedValue
          });
        else
          phones.Add(new { VALUE = TextBoxLeadPHONE.Text, VALUE_TYPE = DropDownListLeadPHONE.SelectedValue });
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
            ID = HiddenFieldLeadEMAIL.Value,
            VALUE = TextBoxLeadEMAIL.Text,
            VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue
          });
        else
          emails.Add(new { VALUE = TextBoxLeadEMAIL.Text, VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue });
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
        Response.Redirect($"~/{RedirectUrl}?IdContact={IdContact}");
        Response.End();
      }
      else
      {
        AddCommentToElement(IdContact, "Контакт обновлен в КЦ Wilstream", "contact");
        log.Info(string.Format("Redirect after update IdContact = {0}", IdContact));
        Response.Redirect($"~/{RedirectUrl}?IdContact={IdContact}");
        Response.End();
      }
    }
    catch (Exception ex)
    {
      Response.Write("Ошибка сохранения лида. Возможно лид уже был удален.");
    }
  }


  protected void ButtonContactSearch_Click(object sender, EventArgs e)
  {
    PanelContactSearch.Visible = true;
    Sourcers.Contacts = GetContactsByPhone(TextBoxContactSearch.Text);
    Session.Contents["ContactSearch"] = Sourcers.Contacts;
    GridViewContactSearch.DataBind();
  }



  protected void GridViewContactSearch_SelectedIndexChanged(object sender, EventArgs e)
  {
    ContactInfo Result = null;

    var ResultSeacrh = new List<ContactInfo>();
    if (Session.Contents["ContactSearch"] != null)
      ResultSeacrh = ((List<ContactInfo>)Session.Contents["ContactSearch"]).OrderBy(r => r.Title).ToList();

    if (Result == null)
    {
      Result = ResultSeacrh[GridViewContactSearch.SelectedIndex];
    }
    if (Result != null)
    {
      Response.Redirect($"~/{RedirectUrl}?IdContact={Result.Id}");
      Response.End();
    }
  }


  protected void LinqDataSourceContactSearch_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var Result = new List<ContactInfo>();
    if (Session.Contents["ContactSearch"] != null)
      Result = (List<ContactInfo>)Session.Contents["ContactSearch"];
    if (Sourcers.ClosedDeals?.Count > 0)
      Result = Sourcers.Contacts;
    Session.Contents["ContactInfo"] = Result;
    e.Result = Result;
  }

  protected List<ContactInfo> GetContactsByPhone(string Phone)
  {
    var result = new List<ContactInfo>();
    var ids = new List<int>();
    var dataListLids = new
    {
      sort = new { ID = "desc" }
    };
    Phone = Phone.Length >10 ? Phone.Substring(Phone.Length - 10, 10): Phone;
    var strPhone = "&values[]=" + Phone + "&values[]=7" + Phone + "&values[]=8" + Phone;
    log.Info(String.Format("strPhone = {0}", strPhone));
    string ContactIds = BX24.SendCommand("crm.duplicate.findbycomm", "entity_type=CONTACT&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC", JsonConvert.SerializeObject(dataListLids), "POST");
    log.Info(String.Format("crm.duplicate.findbycomm = {0}", ContactIds));
    var ContactIdsJSON = JsonConvert.DeserializeObject<dynamic>(ContactIds);
    try
    {
      if (ContactIdsJSON.result.CONTACT.Count > 0)
      {        
        for (int i = 0; i < ContactIdsJSON.result.CONTACT.Count; i++)
        {
          ids.Add(int.Parse(ContactIdsJSON.result.CONTACT[i].ToString()));
        }
        string Contacts = BX24.SendCommand("crm.contact.list", "FILTER[ID]=" + string.Join(",", ids) + "&SELECT[]=*&SELECT[]=PHONE&SELECT[]=EMAIL", JsonConvert.SerializeObject(dataListLids), "GET");
        log.Info(String.Format("crm.contact.list = {0}", Contacts));
        var ContactsJSON = JsonConvert.DeserializeObject<dynamic>(Contacts);
        if (ContactsJSON.result.Count > 0)
        {
          for (int i = 0; i < ContactsJSON.result.Count; i++)
          {
            var contact = ContactsJSON.result[i];
            var phones = new List<string>();
            if (contact.HAS_PHONE.ToString()=="Y")
            {
              for (int j = 0; j < contact.PHONE.Count; j++)
                phones.Add(contact.PHONE[j].VALUE.ToString());
            }
            var emails = new List<string>();
            if (contact.HAS_EMAIL.ToString() == "Y")
            {
              for (int j = 0; j < contact.EMAIL.Count; j++)
                emails.Add(contact.EMAIL[j].VALUE.ToString());
            }
            result.Add(new ContactInfo() { Id = int.Parse(contact.ID.ToString()), Phones = string.Join(",", phones), Emails = string.Join(",", emails),  Name = contact.NAME.ToString(), SecondName = contact.SECOND_NAME.ToString(), LastName = contact.LAST_NAME.ToString() });
          }
        }

        }
      return result;
    }
    catch (Exception ex)
    {
      var r = ex;
      log.Error(ex);
      return result;
    }
  }


#endregion

#region Lead


  private void CreateLeadForm(int IdLead) {
    
    PanelLead.Visible = true;

    CreateLeadSystemField(StatusDefault : "115", SourceDefault : "CALL");
    CreateLeadUserFields();

    if (IdLead > 0)
    {
      string Lead = "";
      dynamic LeadByJSON = new { };
      if (IdLead > 0)
      {
        try
        {
          Lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
          LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
          log.Info(String.Format("Lead = {0}", Lead));
        }
        catch (WebException wex)
        {
          log.Error(wex);
          if (((HttpWebResponse)wex.Response).StatusCode == HttpStatusCode.BadRequest)
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
          var row = new TableRow() { };
          var cell = new TableCell() { };
          var cell2 = new TableCell() { };
          var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadPHONE" + phone.ID, Text = phone.VALUE };
          var HiddenField = new HiddenField() { ID = "HiddenFieldLeadPHONE" + phone.ID, Value = phone.ID };
          var DropDownListLeadPHONE = new DropDownList() { ID = "DropDownListLeadPHONE" + phone.ID, CssClass = "form-control" };
          DropDownListLeadPHONE.Items.AddRange(
          BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
          DropDownListLeadPHONE.SelectedValue = phone.VALUE_TYPE;
          var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadPHONE" + phone.ID, ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadPHONE" + phone.ID, ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic };
          cell.Controls.Add(TextBox);
          cell.Controls.Add(RequiredFieldValidator);
          cell2.Controls.Add(DropDownListLeadPHONE);
          cell2.Controls.Add(HiddenField);
          row.Cells.Add(cell);
          row.Cells.Add(cell2);
          TablePhones.Rows.Add(row);

          if (Session.Contents["TableContact"] != null)
          {
            var tables = (Session.Contents["TableContact"] as Dictionary<string, TableRow>);
            if (tables.ContainsKey("TableRow" + countContact))
              tables.Remove("TableRow" + countContact);
            Session.Contents["TableContact"] = tables;
          }
          countContact++;
        }
      }
      else
      {
        var row = new TableRow() { };
        var cell = new TableCell() { };
        var cell2 = new TableCell() { };
        var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadPHONE" };
        var DropDownListLeadPHONE = new DropDownList() { ID = "DropDownListLeadPHONE", CssClass = "form-control" };
        DropDownListLeadPHONE.Items.AddRange(
            BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadPHONE", ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadPHONE);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);

        if (Request.QueryString["Phone"] != null)
        {
          TextBox.Text = Request.QueryString["Phone"].ToString();
        }
        if (Request.QueryString["AbonentNumber"] != null)
        {
          TextBox.Text = Request.QueryString["AbonentNumber"].ToString();
        }
      }



      if (LeadByJSON.result.EMAIL != null)
      {
        var countContact = 0;
        foreach (var email in LeadByJSON.result.EMAIL)
        {
          var row = new TableRow() { };
          var cell = new TableCell() { };
          var cell2 = new TableCell() { };
          var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadEMAIL" + email.ID, Text = email.VALUE };
          var HiddenField = new HiddenField() { ID = "HiddenFieldLeadEMAIL" + email.ID, Value = email.ID };
          var DropDownListLeadEMAIL = new DropDownList() { ID = "DropDownListLeadEMAIL" + email.ID, CssClass = "form-control" };
          DropDownListLeadEMAIL.Items.AddRange(
          BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
          DropDownListLeadEMAIL.SelectedValue = email.VALUE_TYPE;
          var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadEMAIL" + email.ID, ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadEMAIL" + email.ID, ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic, Enabled = false };
          cell.Controls.Add(TextBox);
          cell.Controls.Add(RequiredFieldValidator);
          cell2.Controls.Add(DropDownListLeadEMAIL);
          cell2.Controls.Add(HiddenField);
          row.Cells.Add(cell);
          row.Cells.Add(cell2);
          TableEmails.Rows.Add(row);

          if (Session.Contents["TableContactEmail"] != null)
          {
            var tables = (Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>);
            if (tables.ContainsKey("TableRow" + countContact))
              tables.Remove("TableRow" + countContact);
            Session.Contents["TableContactEmail"] = tables;
          }
          countContact++;
        }
      }
      else
      {
        var row = new TableRow() { };
        var cell = new TableCell() { };
        var cell2 = new TableCell() { };
        var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadEMAIL" };
        var DropDownListLeadEMAIL = new DropDownList() { ID = "DropDownListLeadEMAIL", CssClass = "form-control" };
        DropDownListLeadEMAIL.Items.AddRange(
            BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadEMAIL", ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic, Enabled = false };
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
      TextBoxLeadSTATUS_DESCRIPTION.Text = LeadByJSON.result.STATUS_DESCRIPTION;
      DropDownListLeadASSIGNED_BY_ID.SelectedValue = LeadByJSON.result.ASSIGNED_BY_ID;
      Type t = LeadByJSON.result.GetType();
      foreach (var uf in BX24.Userfields)
      {
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var CheckBoxListUF = FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            foreach (Newtonsoft.Json.Linq.JProperty item in LeadByJSON.result)
            {
              if (item.Name == uf.FIELD_NAME)//property name
              {

                foreach (var val_ in item.Value)
                {
                  ListItem li_ = CheckBoxListUF.Items.FindByValue(val_.ToString());
                  if (li_ != null) li_.Selected = true;
                }
              }
            }
          }
          else
          {
            var DropDownListUF = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            foreach (Newtonsoft.Json.Linq.JProperty item in LeadByJSON.result)
            {
              if (item.Name == uf.FIELD_NAME)//property name
                DropDownListUF.SelectedValue = item.Value.ToString();
            }
          }

        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          foreach (Newtonsoft.Json.Linq.JProperty item in LeadByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME)//property name
              ddl.Text = item.Value.ToString();
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          foreach (Newtonsoft.Json.Linq.JProperty item in LeadByJSON.result)
          {
            if (item.Name == uf.FIELD_NAME)//property name
              ddl.Checked = item.Value.ToString() == "1";
          }
        }
      }

      HiddenFieldIdLead.Value = IdLead.ToString();
      log.Info(String.Format("Set HiddenFieldIdLead = {0}", HiddenFieldIdLead.Value));
      ButtonSaveLead.Text = "Обновить лид";
    }
    else
    {
      {
        var row = new TableRow() { };
        var cell = new TableCell() { };
        var cell2 = new TableCell() { };
        var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadPHONE" };
        var DropDownListLeadPHONE = new DropDownList() { ID = "DropDownListLeadPHONE", CssClass = "form-control" };
        DropDownListLeadPHONE.Items.AddRange(
            BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadPHONE", ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadPHONE);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);

        if (Request.QueryString["Phone"] != null)
        {
          TextBox.Text = Request.QueryString["Phone"].ToString();
        }
        if (Request.QueryString["AbonentNumber"] != null)
        {
          TextBox.Text = Request.QueryString["AbonentNumber"].ToString();
        }
      }
        ;
      {
        var row = new TableRow() { };
        var cell = new TableCell() { };
        var cell2 = new TableCell() { };
        var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadEMAIL" };
        var DropDownListLeadEMAIL = new DropDownList() { ID = "DropDownListLeadEMAIL", CssClass = "form-control" };
        DropDownListLeadEMAIL.Items.AddRange(
            BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadEMAIL", ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic, Enabled = false };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadEMAIL);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TableEmails.Rows.Add(row);
      }
    }


    if (Session.Contents["TableContact"] != null)
      foreach (var item in (Session.Contents["TableContact"] as Dictionary<string, TableRow>))
      {
        TablePhones.Controls.Add(item.Value);
      }



    if (Session.Contents["TableContactEmail"] != null)
      foreach (var item in (Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>))
      {
        TableEmails.Controls.Add(item.Value);
      }
  }

  private void CreateLeadSystemField(string StatusDefault, string SourceDefault) {

    //Статус лида
    string LeadStatusListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=STATUS", "", "GET");
    var StatusList = JsonConvert.DeserializeObject<dynamic>(LeadStatusListByJSON);
    foreach (var status in StatusList.result)
      DropDownListLeadSTATUS_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));
    if (DropDownListLeadSTATUS_ID.SelectedIndex < 1)
      DropDownListLeadSTATUS_ID.SelectedValue = StatusDefault;

    //Источник
    
    foreach (var source in Sources)
      DropDownListLeadSOURCE_ID.Items.Add(new ListItem(source.Key, source.Value));

    var li = DropDownListLeadSOURCE_ID.Items.FindByValue(SourceDefault);
    if (li != null) li.Selected = true;

    //Ответственный
    var dataListUsers = new
    {
      sort = "LAST_NAME"
    };
    var userSearchListJson = BX24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE", JsonConvert.SerializeObject(dataListUsers), "POST");
    var UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
    var it = 0;
    DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    
    foreach (var user in Responsiblies.OrderBy(r => r.Key))
      DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));

  }

  private void CreateLeadUserFields() {

    BX24.FilterUserFields = FilterUserFields;
    foreach (var uf in BX24.Userfields)
    {
      var tr = new TableRow() { ID = "TableRow" + uf.ID };
      var tc1 = new TableCell() { ID = "TableCellLabel" + uf.ID, Text = uf.NAME };
      var tc2 = new TableCell() { ID = "TableCellUserfield" + uf.ID };
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var cbl = new CheckBoxList() { ID = "CheckBoxListUserfield" + uf.ID, RepeatColumns = 3 };
          foreach (var item in uf.LIST)
            cbl.Items.Add(new ListItem() { Text = item.VALUE, Value = item.ID.ToString() });
          tc2.Controls.Add(cbl);
        }
        else
        {
          var ddl = new DropDownList() { ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control" };
          ddl.Items.Add(new ListItem("-----", ""));
          foreach (var item in uf.LIST)
            ddl.Items.Add(new ListItem() { Text = item.VALUE, Value = item.ID.ToString() });
          tc2.Controls.Add(ddl);
        }
        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2); 
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        var ddl = new TextBox() { ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control" };
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2); 
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = new CheckBox() { ID = "CheckBoxUserfield" + uf.ID, CssClass = "form-control" };
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
      }

      if (UserFieldSettings.ContainsKey(uf.ID))
      {
        var setting = UserFieldSettings[uf.ID];

        if (setting.Alias != null)
          tr.Cells[0].Text = setting.Alias;

        if (setting.Position != null) 
          TableLead.Rows.AddAt((int)setting.Position, tr);
        else
          TableLead.Rows.Add(tr);

      }
      else
      {
        TableLead.Rows.Add(tr);
      }
    }
  }

#endregion

  protected int getIdLeadByPhone(string Phone)
    { 
        var dataListLids = new
        {
            sort = new { ID = "desc" }
        };
        var strPhone = "&values[]=" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=7" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=8" + Phone.Substring(Phone.Length - 10, 10);
        log.Info(String.Format("strPhone = {0}", strPhone));
        string Leads = BX24.SendCommand("crm.duplicate.findbycomm", "entity_type=LEAD&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC", JsonConvert.SerializeObject(dataListLids), "POST");
        log.Info(String.Format("crm.duplicate.findbycomm = {0}", Leads));
        var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
        try
        {
            if (LeadsJSON.result.LEAD.Count > 0)
            {
                log.Info(String.Format("LeadsJSON.result.LEAD.Count = {0}", LeadsJSON.result.LEAD.Count)); 
                 int IdLead = (int)LeadsJSON.result.LEAD[0];
                log.Info(String.Format("Select IdLead = {0}", IdLead));
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
      sort = new { ID = "desc" }
    };
    var strPhone = "&values[]=" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=7" + Phone.Substring(Phone.Length - 10, 10) + "&values[]=8" + Phone.Substring(Phone.Length - 10, 10);
    log.Info(String.Format("strPhone = {0}", strPhone));
    string Contacts = BX24.SendCommand("crm.duplicate.findbycomm", "entity_type=CONTACT&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC", JsonConvert.SerializeObject(dataListLids), "POST");
    log.Info(String.Format("crm.duplicate.findbycomm = {0}", Contacts));
    var ContactsJSON = JsonConvert.DeserializeObject<dynamic>(Contacts);
    try
    {
      if (ContactsJSON.result.CONTACT.Count > 0)
      {
        log.Info(String.Format("ContactsJSON.result.CONTACT.Count = {0}", ContactsJSON.result.CONTACT.Count));
        int IdContact = (int)ContactsJSON.result.CONTACT[0];
        log.Info(String.Format("Select IdContact = {0}", IdContact));
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
        var userSearch = BX24.SendCommand("user.search", "", contentText, "POST");


    }

    protected void ButtonProductSearch_Click(object sender, EventArgs e)
    {
        var dataProduct = new
        {

            filter = new
            {
                NAME = TextBoxProductSearch.Text + "%"
            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
        };


        var contentTextProduct = JsonConvert.SerializeObject(dataProduct);
        string ProductListByJSON = BX24.SendCommand("crm.product.list", "", contentTextProduct, "POST");
        var ProductList = JsonConvert.DeserializeObject<dynamic>(ProductListByJSON);
        foreach (var product in ProductList.result)
            BX24.ProductSeacrh.Add(new Bitrix24.PRODUCT()
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
            Result = (List<Bitrix24.PRODUCT>)Session.Contents["productsearch"];
        if (BX24.ProductSeacrh.Count > 0)
            Result = BX24.ProductSeacrh;
        Session.Contents["productsearch"] = Result;
        e.Result = Result;

    }

    protected void LinqDataSourceLeadProducts_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        var productrows = Session.Contents["productrows"];
        if (productrows != null)
            e.Result = (List<Bitrix24.PRODUCT>)Session.Contents["productrows"];
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
            Result = (List<Bitrix24.PRODUCT>)Session.Contents["productrows"];

        var ResultSeacrh = new List<Bitrix24.PRODUCT>();
        if (Session.Contents["productsearch"] != null)
            ResultSeacrh = (List<Bitrix24.PRODUCT>)Session.Contents["productsearch"];

        if (Result.FirstOrDefault(r => r.ID == ResultSeacrh[GridViewProductSearch.SelectedIndex].ID) == null)
            Result.Add(ResultSeacrh[GridViewProductSearch.SelectedIndex]);
        Session.Contents["productrows"] = Result;
        GridViewLeadProducts.DataBind();

    }

    protected void GridViewLeadProducts_SelectedIndexChanged(object sender, EventArgs e)
    {
        var Result = new List<Bitrix24.PRODUCT>();
        if (Session.Contents["productrows"] != null)
            Result = (List<Bitrix24.PRODUCT>)Session.Contents["productrows"];

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
            log.Info(String.Format("IdLeadOld = {0}", IdLeadOld));

            if (IdLeadOld == 0)
            {
                //проверим возможно уже лид был создан пока заполняли форму
                if (String.IsNullOrEmpty(Phone) && Request.QueryString["Phone"] != null)
                {
                    Phone = Request.QueryString["Phone"].ToString(); 
                }
                if (!String.IsNullOrEmpty(Phone))
                {
                    IdLeadOld = getIdLeadByPhone(Phone);
                    log.Info(String.Format("Лид найден IdLeadOld = {0}", IdLeadOld));
                }
            }

            var data =
                IdLeadOld > 0 ?
            new
            {
                id = (Object)IdLeadOld,
                fields = new Dictionary<string, object>()
                  {

                  { "TITLE" , TextBoxLeadTITLE.Text },
                  { "NAME" , TextBoxLeadNAME.Text },
                  { "COMMENTS" , TextBoxLeadCOMMENTS.Text },
                 // { "STATUS_DESCRIPTION" , TextBoxLeadSTATUS_DESCRIPTION.Text }, 
                {  "SECOND_NAME" , TextBoxLeadSECOND_NAME.Text },
               {"ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text },
                {  "LAST_NAME" , TextBoxLeadLAST_NAME.Text },
              //  {  "STATUS_ID" , DropDownListLeadSTATUS_ID.SelectedValue },
                {  "PHONE" , new object[] {  } },
                {  "SOURCE_ID" ,  DropDownListLeadSOURCE_ID.SelectedValue },
                {  "OPENED" , "0" },
                //{  "OPENED" , CheckBoxLeadOPENED.Checked?"1":"0" },
                {  "ASSIGNED_BY_ID" , DropDownListLeadASSIGNED_BY_ID.SelectedValue },
                },
                @params = new { REGISTER_SONET_EVENT = "Y" }
            } :
            new
            {
                id = new Object(),
                fields = new Dictionary<string, object>()
                  {

                  { "TITLE" , TextBoxLeadTITLE.Text },
                  { "NAME" , TextBoxLeadNAME.Text },
                  { "COMMENTS" , TextBoxLeadCOMMENTS.Text },
              //    { "STATUS_DESCRIPTION" , TextBoxLeadSTATUS_DESCRIPTION.Text }, 
                {  "SECOND_NAME" , TextBoxLeadSECOND_NAME.Text },
                    { "ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text },
                {  "LAST_NAME" , TextBoxLeadLAST_NAME.Text },
              //  {  "STATUS_ID" , DropDownListLeadSTATUS_ID.SelectedValue },
                {  "PHONE" , new object[] { } },
                {  "SOURCE_ID" ,  DropDownListLeadSOURCE_ID.SelectedValue },
                {  "OPENED" , "0" },
              //  {  "OPENED" , CheckBoxLeadOPENED.Checked?"1":"0" },
                {  "ASSIGNED_BY_ID" , DropDownListLeadASSIGNED_BY_ID.SelectedValue },
                },
                @params = new { REGISTER_SONET_EVENT = "Y" }
            };


            var phones = new List<object>();
            foreach (TableRow row in TablePhones.Rows) {
                var TextBoxLeadPHONE = row.Cells[0].Controls[0] as TextBox;
                var RequiredFieldValidatorLeadPHONE = row.Cells[0].Controls[1] as RequiredFieldValidator;
                var DropDownListLeadPHONE = row.Cells[1].Controls[0] as DropDownList;
                HiddenField HiddenFieldLeadPHONE = null;
                if (row.Cells[1].Controls.Count>1)
                    HiddenFieldLeadPHONE = row.Cells[1].Controls[1] as HiddenField;
                if(HiddenFieldLeadPHONE!=null)
                phones.Add(new { ID = HiddenFieldLeadPHONE.Value, VALUE = TextBoxLeadPHONE.Text, VALUE_TYPE = DropDownListLeadPHONE.SelectedValue });
                else
                phones.Add(new { VALUE = TextBoxLeadPHONE.Text, VALUE_TYPE = DropDownListLeadPHONE.SelectedValue });
                    
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
                    emails.Add(new { ID = HiddenFieldLeadEMAIL.Value, VALUE = TextBoxLeadEMAIL.Text, VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue });
                else
                    emails.Add(new { VALUE = TextBoxLeadEMAIL.Text, VALUE_TYPE = DropDownListLeadEMAIL.SelectedValue });

            }
            data.fields["EMAIL"] = emails;

            Type t = data.fields.GetType();
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




            string NewLead =
                IdLeadOld > 0 ?
                BX24.SendCommand("crm.lead.update", "", contentText, "POST") :
                BX24.SendCommand("crm.lead.add", "", contentText, "POST");
            var NewLeadByJSON = JsonConvert.DeserializeObject<dynamic>(NewLead);
            Int32 IdLead = IdLeadOld > 0 ? IdLeadOld : Convert.ToInt32(NewLeadByJSON.result);


            var productrowsData = new
            {
                id = IdLead,
                rows = new List<dynamic>()
                  ,
                @params = new { REGISTER_SONET_EVENT = "Y" }
            };
            var Result = new List<Bitrix24.PRODUCT>();
            if (Session.Contents["productrows"] != null)
                Result = (List<Bitrix24.PRODUCT>)Session.Contents["productrows"];

            productrowsData.rows.AddRange(
                Result.Select(r => new { PRODUCT_ID = r.ID, PRICE = r.PRODUCT_PRICE, QUANTITY = r.PRODUCT_QUANTITY }).ToList());

            //66864

            // { "PRODUCT_ID": 689, "PRICE": 100.00, "QUANTITY": 2 },

            contentText = JsonConvert.SerializeObject(productrowsData);
            if (productrowsData.rows.Count == 0)
                contentText = contentText.Replace("[]", "null");
            BX24.SendCommand("crm.lead.productrows.set", "", contentText, "POST");

            log.Info(String.Format("contentText = {0}", contentText));

            if (IdLeadOld == 0)
            {
                AddCommentToLead(IdLead, "Лид создан в КЦ Wilstream");
                log.Info(String.Format("New IdLead = {0}", IdLead));
                Response.Redirect($"~/{RedirectUrl}?IdLead={IdLead}");
                Response.End();
            }
            else
            {
                AddCommentToLead(IdLead, "Лид обновлен в КЦ Wilstream");
                log.Info(String.Format("Redirect after update IdLead = {0}", IdLead));
                Response.Redirect($"~/{RedirectUrl}?IdLead={IdLead}");
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
            Result = (List<Bitrix24.PRODUCT>)Session.Contents["productrows"];
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
        var tableRow = CreateContectRow(count);
        if (Session.Contents["TableContact"] == null)
            Session.Contents["TableContact"] = new Dictionary<String, TableRow>();

        (Session.Contents["TableContact"] as Dictionary<String, TableRow>).Add(tableRow.ID, tableRow);
    }



    private TableRow CreateContectRow(int count)
    {
        var row = new TableRow() { ID = "TableRow" + count };
        var cell = new TableCell() { };
        var cell2 = new TableCell() { };
        var uniq = count.ToString();
        var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadPHONE" + uniq };
        var DropDownListLeadPHONE = new DropDownList() { ID = "DropDownListLeadPHONE" + uniq, CssClass = "form-control" };
        DropDownListLeadPHONE.Items.AddRange(
            BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadPHONE" + uniq, ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadPHONE" + uniq, ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadPHONE);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);
        return row;
    }

    protected void ButtonAddEmail_Click(object sender, EventArgs e)
    {


        var count = 0;
        foreach (Control c in TableEmails.Rows)
        {
            if (c is TableRow) count++;
        }
        var tableRow = CreateContectEmailRow(count);
        if (Session.Contents["TableContactEmail"] == null)
            Session.Contents["TableContactEmail"] = new Dictionary<String, TableRow>();

        (Session.Contents["TableContactEmail"] as Dictionary<String, TableRow>).Add(tableRow.ID, tableRow);
    }



    private TableRow CreateContectEmailRow(int count)
    {
        var row = new TableRow() { ID = "TableRowEmail" + count };
        var cell = new TableCell() { };
        var cell2 = new TableCell() { };
        var uniq = count.ToString();
        var TextBox = new TextBox() { CssClass = "form-control", ID = "TextBoxLeadEMAIL" + uniq };
        var DropDownListLeadEMAIL = new DropDownList() { ID = "DropDownListLeadEMAIL" + uniq, CssClass = "form-control" };
        DropDownListLeadEMAIL.Items.AddRange(
            BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadEMAIL" + uniq, ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadEMAIL" + uniq, ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic };
        cell.Controls.Add(TextBox);
        cell.Controls.Add(RequiredFieldValidator);
        cell2.Controls.Add(DropDownListLeadEMAIL);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TableEmails.Rows.Add(row);
        return row;
    }

    protected void ButtonSendSMS_Click(object sender, EventArgs e)
    {
        log.Info(String.Format("Отправка SMS"));
        int IdLead;
        if (HiddenFieldIdLead.Value != null && int.TryParse(HiddenFieldIdLead.Value, out IdLead))
        {
            if (String.IsNullOrEmpty(TextBoxSMS.Text.Trim())) {
                log.Info(String.Format("SMS не отправлено так как нет текста SMS"));
                return;
            }
            string phone = getPhoneFromForm().Trim();
            if (String.IsNullOrEmpty(phone))
            {
                log.Info(String.Format("SMS не отправлено так как нет номера для отправки"));
                return;
            }
            var message = TextBoxSMS.Text.Trim();
            message = message.Substring(0, message.Length > 60 ? 60: message.Length); 
            if (sendSMS(message, phone))
            {
                AddCommentToLead(IdLead, String.Format("Отправлено SMS на номер {0} с текстом \"{1}\"", phone, message));
                log.Info(String.Format("Отправлено SMS на номер {0} с текстом \"{1}\"", phone, message));
                Response.Write(String.Format("Отправлено SMS на номер {0} с текстом \"{1}\"", phone, message));
                return;
            }
            else
            {
                log.Info(String.Format("SMS не отправлено так как есть ошибка в отправке"));
                return;
            }
        }
        else
        { 
            log.Info(String.Format("SMS не отправлено так как нет IdLead"));
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
        string url = "https://smsc.ru/sys/send.php"; 
        var result = GET(url, "login=bitrix@avantsb.ru&psw=Veles2019&phones=" + phones + "&mes=" + message + "&sender=avantsb.ru");
        return result.Length>2 && result.Substring(0,2)== "OK";
    }
     

    private string GET(string Url, string Data)
    {
        log.Info(String.Format("Url SMS is {0}", Url + "?" + Data));
        System.Net.WebRequest req = System.Net.WebRequest.Create(Url + "?" + Data);
        System.Net.WebResponse resp = req.GetResponse();
        System.IO.Stream stream = resp.GetResponseStream();
        System.IO.StreamReader sr = new System.IO.StreamReader(stream);
        string Out = sr.ReadToEnd();
        sr.Close();
        return Out;
    }

    public void AddCommentToLead(int IdLead, string Comment)
    {
        if (IdLead == 0) return;

         

        var data =
        new
        {
            fields = new Dictionary<string, object>()
              {

                  { "ENTITY_ID" , IdLead },
                  { "ENTITY_TYPE" , "lead" },
                  { "COMMENT" , Comment }

            }
        };
        var contentText = JsonConvert.SerializeObject(data);

        var Lead = BX24.SendCommand("crm.timeline.comment.add", "", contentText, "POST");
        var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
         
    }


  private TableRow CreatePhoneRow(int count, string category, Table tablePhones)
  {
    var row = new TableRow { ID = "TableRow" + count };
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var TextBox = new TextBox { CssClass = "form-control", ID = $"TextBox{category}PHONE" + uniq };
    var DropDownListPHONE = new DropDownList { ID = $"DropDownList{category}PHONE" + uniq, CssClass = "form-control" };
    DropDownListPHONE.Items.AddRange(
      BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var RequiredFieldValidator = new RequiredFieldValidator
    {
      ID = $"RequiredFieldValidatorTextBox{category}PHONE" + uniq,
      ValidationGroup = category,
      ControlToValidate = $"TextBox{category}PHONE" + uniq,
      ForeColor = Color.Red,
      ErrorMessage = "Заполните поле",
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


  private TableRow CreateEmailRow(int count, string category, Table tableEmails)
  {
    var row = new TableRow { ID = $"TableRow{category}" + count };
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var TextBox = new TextBox { CssClass = "form-control", ID = $"TextBox{category}EMAIL" + uniq };
    var DropDownListEMAIL = new DropDownList { ID = $"DropDownList{category}EMAIL" + uniq, CssClass = "form-control" };
    DropDownListEMAIL.Items.AddRange(
      BX24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var RequiredFieldValidator = new RequiredFieldValidator
    {
      ID = $"RequiredFieldValidatorTextBox{category}EMAIL" + uniq,
      ValidationGroup = category,
      ControlToValidate = $"TextBox{category}EMAIL" + uniq,
      ForeColor = Color.Red,
      ErrorMessage = "Заполните поле",
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


  private List<KeyValuePair<string, string>> GetResponsiblies() {
    var dataListUsers = new
    {
      sort = "LAST_NAME"
    };
    var userSearchListJson = BX24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE", JsonConvert.SerializeObject(dataListUsers), "POST");
    var UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
    var it = 0;    
    var users = new List<KeyValuePair<string, string>>();
    while (it < 5)
    {
      it++;
      foreach (var user in UserSearchList.result)
        users.Add(new KeyValuePair<string, string>(user.LAST_NAME.ToString() + " " + user.NAME.ToString(), user.ID.ToString()));
      if (UserSearchList.next != null)
      {
        userSearchListJson = BX24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE&start=" + UserSearchList.next.ToString(), JsonConvert.SerializeObject(dataListUsers), "POST");
        UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
      }
      else break;

    }
    return users;
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



}

public class FieldSettings
{
  public int? Position { get; set; }
  public string Alias { get; internal set; }
  public string PreTitle { get; internal set; }
  public bool Readonly { get; internal set; }
}