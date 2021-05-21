using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
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

public partial class Avantsb2 : Page
{
  private static readonly ILog Log = LogManager.GetLogger("LOGGER");
  private const string RedirectUrl = "Avantsb2.aspx";
  private Bitrix24 _bx24;

  public Dictionary<int, FieldSettings> DealFieldSettings = new Dictionary<int, FieldSettings>
  {
    {777, new FieldSettings {Position = 1}},
    {778, new FieldSettings {Position = 5, Alias = "Направление", Readonly = true}},
    {269, new FieldSettings {PreTitle = "АДРЕС ДОСТАВКИ"}},
    {270, new FieldSettings {Readonly = true}},
    {271, new FieldSettings {Readonly = true}},
    {272, new FieldSettings {Readonly = true}},
    {166, new FieldSettings {Readonly = true, PreTitle = "ПТС И ДКП - ДОСТАВКА"}},
    {273, new FieldSettings {Readonly = true}},
    {274, new FieldSettings {Readonly = true}},
    {275, new FieldSettings {Readonly = true}},
    {277, new FieldSettings {Readonly = true}}
  };


  public Dictionary<int, FieldSettings> NewDealFieldSettings = new Dictionary<int, FieldSettings>
  {
    {777, new FieldSettings {Position = 1}},
    {778, new FieldSettings {Position = 5, Alias = "Направление", IsRequired = true}},
    {269, new FieldSettings {PreTitle = "АДРЕС ДОСТАВКИ"}},
    {270, new FieldSettings {Readonly = true}},
    {271, new FieldSettings {Readonly = true}},
    {272, new FieldSettings {Readonly = true}},
    {166, new FieldSettings {Readonly = true, PreTitle = "ПТС И ДКП - ДОСТАВКА"}},
    {273, new FieldSettings {Readonly = true}},
    {274, new FieldSettings {Readonly = true}},
    {275, new FieldSettings {Readonly = true}},
    {277, new FieldSettings {Readonly = true}}
  };

  public List<int> FilterContactFields = new List<int>();
  public List<int> FilterDealFields = new List<int> {777, 778};
  public List<int> FilterOpenDealFields = new List<int> {777, 269, 270, 271, 272, 273, 166, 274, 275, 276, 277, 778};


  public List<int> FilterUserFields = new List<int> {654, 776};
  private int _idContact;
  private int _idLead;
  private string _phone = "";
  private List<KeyValuePair<string, string>> _responsiblies;
  private readonly Sourcers _sourcers = new Sourcers();
  private List<KeyValuePair<string, string>> _sources;

  public Dictionary<int, FieldSettings> UserFieldSettings = new Dictionary<int, FieldSettings>
  {
    {776, new FieldSettings {Position = 1}},
    {654, new FieldSettings {Position = 11, Alias = "Направление ЛИД", IsRequired = true}}
  };

  protected void Page_Init(object sender, EventArgs e)
  {
    XmlConfigurator.Configure();

    if (Request.QueryString["IdLead"] != null)
    {
      _idLead = Convert.ToInt32(Request.QueryString["IdLead"]);
      Log.Info($"IdLead = {_idLead}");
    }

    if (Request.QueryString["IdContact"] != null)
    {
      _idContact = Convert.ToInt32(Request.QueryString["IdContact"]);
      Log.Info($"IdContact = {_idContact}");
    }

    if (Request.QueryString["Phone"] != null)
    {
      _phone = Request.QueryString["Phone"];
      Log.Info($"Phone = {_phone}");
    }

    if (Request.QueryString["AbonentNumber"] != null)
    {
      _phone = Request.QueryString["AbonentNumber"];
      Log.Info($"AbonentNumber = {_phone}");
    }

    _bx24 = new Bitrix24(HttpContext.Current, "local.6062e98e18b1c1.59172320",
      "aXYiuqGbyT029ll19EN4tVv8KwTW3Ate5cD8qDbqQqtyrYnSUl", "https://crm.veles24.com", "https://oauth.bitrix.info",
      "CCW", "cc@avantsb.ruZ10");

    _responsiblies = GetResponsiblies();
    _sources = GetSources();


    if (!IsPostBack)
    {
      Session.Contents["productrows"] = null;
      Session.Contents["productsearch"] = null;
    }

    var show = TypeObject.Undefined;

    if (_idLead > 0)
    {
      show = TypeObject.Lead;
    }
    else if (_idContact > 0)
    {
      show = TypeObject.Contact;
    }
    else if (_phone != "")
    {
      _idContact = GetIdContactByPhone(_phone);

      if (_idContact > 0)
      {
        show = TypeObject.Contact;
      }
      else
      {
        _idLead = GetIdLeadByPhone(_phone);
        show = TypeObject.Lead;
      }
    }


    switch (show)
    {
      case TypeObject.Lead:
        CreateLeadForm(_idLead);
        break;

      case TypeObject.Contact:
        var idCompany = 0;
        CreateContactForm(_idContact, out idCompany);

        if(idCompany > 0)
          CreateCompanyForm(idCompany);

        var openDeals = GetOpenDealByIdContact(_idContact);

        var idDeal = 0;
        if (Request.QueryString["IdDeal"] != null)
        {
          idDeal = Convert.ToInt32(Request.QueryString["IdDeal"]);
          Log.Info($"IdDeal = {idDeal}");
        }
        else if (openDeals.Count > 0)
        {
          idDeal = openDeals.OrderByDescending(x => x.DateCreate).First().Id;
        }

        CreateDealForm(idDeal);

        break;
    }
  }


  private List<KeyValuePair<string, string>> GetSources()
  {
    var dataListSources = new
    {
      sort = "NAME"
    };
    var sourceSearchListJson = _bx24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=SOURCE",
      JsonConvert.SerializeObject(dataListSources));
    var sourceSearchList = JsonConvert.DeserializeObject<dynamic>(sourceSearchListJson);
    var it = 0;
    var sources = new List<KeyValuePair<string, string>>();
    while (it < 5)
    {
      it++;
      foreach (var source in sourceSearchList.result)
        sources.Add(new KeyValuePair<string, string>(source.NAME.ToString(), source.STATUS_ID.ToString()));
      if (sourceSearchList.next != null)
      {
        sourceSearchListJson = _bx24.SendCommand("crm.status.list",
          "FILTER[ENTITY_ID]=SOURCE&start=" + sourceSearchList.next.ToString(),
          JsonConvert.SerializeObject(dataListSources), "POST");
        sourceSearchList = JsonConvert.DeserializeObject<dynamic>(sourceSearchListJson);
      }
      else
      {
        break;
      }
    }

    return sources;
  }

  protected void Page_Load(object sender, EventArgs e)
  {
  }

  protected int GetIdLeadByPhone(string phone)
  {
    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };
    var strPhone = "&values[]=" + phone.Substring(phone.Length - 10, 10) + "&values[]=7" +
                   phone.Substring(phone.Length - 10, 10) + "&values[]=8" + phone.Substring(phone.Length - 10, 10);
    Log.Info($"strPhone = {strPhone}");
    var leads = _bx24.SendCommand("crm.duplicate.findbycomm",
      "entity_type=LEAD&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC",
      JsonConvert.SerializeObject(dataListLids));
    Log.Info($"crm.duplicate.findbycomm = {leads}");
    var leadsJson = JsonConvert.DeserializeObject<dynamic>(leads);
    try
    {
      if (leadsJson.result.LEAD.Count > 0)
      {
        Log.Info(string.Format("LeadsJSON.result.LEAD.Count = {0}", leadsJson.result.LEAD.Count));
        var idLead = (int) leadsJson.result.LEAD[0];
        Log.Info($"Select IdLead = {idLead}");
        return idLead;
      }

      return 0;
    }
    catch (Exception ex)
    {
      var r = ex;
      Log.Error(ex);
      return 0;
    }
  }


  protected int GetIdContactByPhone(string phone)
  {
    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };
    var strPhone = "&values[]=" + phone.Substring(phone.Length - 10, 10) + "&values[]=7" +
                   phone.Substring(phone.Length - 10, 10) + "&values[]=8" + phone.Substring(phone.Length - 10, 10);
    Log.Info($"strPhone = {strPhone}");
    var contacts = _bx24.SendCommand("crm.duplicate.findbycomm",
      "entity_type=CONTACT&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC",
      JsonConvert.SerializeObject(dataListLids));
    Log.Info($"crm.duplicate.findbycomm = {contacts}");
    var contactsJson = JsonConvert.DeserializeObject<dynamic>(contacts);
    try
    {
      if (contactsJson.result.CONTACT.Count > 0)
      {
        Log.Info(string.Format("ContactsJSON.result.CONTACT.Count = {0}", contactsJson.result.CONTACT.Count));
        var idContact = (int) contactsJson.result.CONTACT[0];
        Log.Info($"Select IdContact = {idContact}");
        return idContact;
      }

      return 0;
    }
    catch (Exception ex)
    {
      var r = ex;
      Log.Error(ex);
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
    var userSearch = _bx24.SendCommand("user.search", "", contentText);
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
    var productListByJson = _bx24.SendCommand("crm.product.list", "", contentTextProduct);
    var productList = JsonConvert.DeserializeObject<dynamic>(productListByJson);
    foreach (var product in productList.result)
      _bx24.ProductSeacrh.Add(new Bitrix24.PRODUCT
      {
        NAME = product.NAME.ToString(),
        ID = Convert.ToInt32(product.ID.ToString())
      });
    GridViewProductSearch.DataBind();
    Session.Contents["productsearch"] = _bx24.ProductSeacrh;
  }

  protected void LinqDataSourceProducts_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productsearch"] != null)
      result = (List<Bitrix24.PRODUCT>) Session.Contents["productsearch"];
    if (_bx24.ProductSeacrh.Count > 0)
      result = _bx24.ProductSeacrh;
    Session.Contents["productsearch"] = result;
    e.Result = result;
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
    var result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productrows"] != null)
      result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];

    var resultSeacrh = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productsearch"] != null)
      resultSeacrh = (List<Bitrix24.PRODUCT>) Session.Contents["productsearch"];

    if (result.FirstOrDefault(r => r.ID == resultSeacrh[GridViewProductSearch.SelectedIndex].ID) == null)
      result.Add(resultSeacrh[GridViewProductSearch.SelectedIndex]);
    Session.Contents["productrows"] = result;
    GridViewLeadProducts.DataBind();
  }

  protected void GridViewLeadProducts_SelectedIndexChanged(object sender, EventArgs e)
  {
    var result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productrows"] != null)
      result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];

    if (result.FirstOrDefault(r => r.ID == Convert.ToInt32(GridViewLeadProducts.SelectedValue)) != null)
      result.Remove(result.FirstOrDefault(r => r.ID == Convert.ToInt32(GridViewLeadProducts.SelectedValue)));
    Session.Contents["productrows"] = result;
    GridViewLeadProducts.DataBind();
  }

  protected void ButtonSaveLead_Click(object sender, EventArgs e)
  {
    try
    {
      var idLeadOld = HiddenFieldIdLead.Value != "" ? Convert.ToInt32(HiddenFieldIdLead.Value) : 0;
      Log.Info($"IdLeadOld = {idLeadOld}");

      if (idLeadOld == 0)
      {
        //проверим возможно уже лид был создан пока заполняли форму
        if (string.IsNullOrEmpty(_phone) && Request.QueryString["Phone"] != null) _phone = Request.QueryString["Phone"];
        if (!string.IsNullOrEmpty(_phone))
        {
          idLeadOld = GetIdLeadByPhone(_phone);
          Log.Info($"Лид найден IdLeadOld = {idLeadOld}");
        }
      }

      var data =
        idLeadOld > 0
          ? new
          {
            id = (object) idLeadOld,
            fields = new Dictionary<string, object>
            {
              {"TITLE", TextBoxLeadTITLE.Text},
              {"NAME", TextBoxLeadNAME.Text},
              {"COMMENTS", TextBoxLeadCOMMENTS.Text},
              // { "STATUS_DESCRIPTION" , TextBoxLeadSTATUS_DESCRIPTION.Text }, 
              {"SECOND_NAME", TextBoxLeadSECOND_NAME.Text},
              {"ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text},
              {"LAST_NAME", TextBoxLeadLAST_NAME.Text},
              //  {  "STATUS_ID" , DropDownListLeadSTATUS_ID.SelectedValue },
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
              //    { "STATUS_DESCRIPTION" , TextBoxLeadSTATUS_DESCRIPTION.Text }, 
              {"SECOND_NAME", TextBoxLeadSECOND_NAME.Text},
              {"ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text},
              {"LAST_NAME", TextBoxLeadLAST_NAME.Text},
              //  {  "STATUS_ID" , DropDownListLeadSTATUS_ID.SelectedValue },
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
        var textBoxLeadPhone = row.Cells[0].Controls[0] as TextBox;
        var requiredFieldValidatorLeadPhone = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var dropDownListLeadPhone = row.Cells[1].Controls[0] as DropDownList;
        HiddenField hiddenFieldLeadPhone = null;
        if (row.Cells[1].Controls.Count > 1)
          hiddenFieldLeadPhone = row.Cells[1].Controls[1] as HiddenField;
        if (hiddenFieldLeadPhone != null)
          phones.Add(new
          {
            ID = hiddenFieldLeadPhone.Value, VALUE = textBoxLeadPhone.Text,
            VALUE_TYPE = dropDownListLeadPhone.SelectedValue
          });
        else
          phones.Add(new {VALUE = textBoxLeadPhone.Text, VALUE_TYPE = dropDownListLeadPhone.SelectedValue});
      }

      data.fields["PHONE"] = phones;


      var emails = new List<object>();
      foreach (TableRow row in TableEmails.Rows)
      {
        var textBoxLeadEmail = row.Cells[0].Controls[0] as TextBox;
        var requiredFieldValidatorLeadEmail = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var dropDownListLeadEmail = row.Cells[1].Controls[0] as DropDownList;
        HiddenField hiddenFieldLeadEmail = null;
        if (row.Cells[1].Controls.Count > 1)
          hiddenFieldLeadEmail = row.Cells[1].Controls[1] as HiddenField;
        if (hiddenFieldLeadEmail != null)
          emails.Add(new
          {
            ID = hiddenFieldLeadEmail.Value, VALUE = textBoxLeadEmail.Text,
            VALUE_TYPE = dropDownListLeadEmail.SelectedValue
          });
        else
          emails.Add(new {VALUE = textBoxLeadEmail.Text, VALUE_TYPE = dropDownListLeadEmail.SelectedValue});
      }

      data.fields["EMAIL"] = emails;

      var t = data.fields.GetType();
      foreach (var uf in _bx24.Userfields)
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var cbl = Page.FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            if (cbl != null)
            {
              var sel = new List<string>();

              foreach (ListItem item in cbl.Items)
                if (item.Selected)
                  sel.Add(item.Value);
              data.fields.Add(uf.FIELD_NAME, sel);
            }
          }
          else
          {
            var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.Text);
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = Page.FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.Checked);
        }


      var contentText = JsonConvert.SerializeObject(data);
      if (idLeadOld == 0)
        contentText = contentText.Replace("\"id\":{},", "");


      var newLead =
        idLeadOld > 0
          ? _bx24.SendCommand("crm.lead.update", "", contentText)
          : _bx24.SendCommand("crm.lead.add", "", contentText);
      var newLeadByJson = JsonConvert.DeserializeObject<dynamic>(newLead);
      int idLead = idLeadOld > 0 ? idLeadOld : Convert.ToInt32(newLeadByJson.result);


      var productrowsData = new
      {
        id = idLead,
        rows = new List<dynamic>(),
        @params = new {REGISTER_SONET_EVENT = "Y"}
      };
      var result = new List<Bitrix24.PRODUCT>();
      if (Session.Contents["productrows"] != null)
        result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];

      productrowsData.rows.AddRange(
        result.Select(r => new {PRODUCT_ID = r.ID, PRICE = r.PRODUCT_PRICE, QUANTITY = r.PRODUCT_QUANTITY}).ToList());

      //66864

      // { "PRODUCT_ID": 689, "PRICE": 100.00, "QUANTITY": 2 },

      contentText = JsonConvert.SerializeObject(productrowsData);
      if (productrowsData.rows.Count == 0)
        contentText = contentText.Replace("[]", "null");
      _bx24.SendCommand("crm.lead.productrows.set", "", contentText);

      Log.Info($"contentText = {contentText}");

      if (idLeadOld == 0)
      {
        AddCommentToLead(idLead, "Лид создан в КЦ Wilstream");
        Log.Info($"New IdLead = {idLead}");
        Response.Redirect($"~/{RedirectUrl}?IdLead={idLead}");
        Response.End();
      }
      else
      {
        AddCommentToLead(idLead, "Лид обновлен в КЦ Wilstream");
        Log.Info($"Redirect after update IdLead = {idLead}");
        Response.Redirect($"~/{RedirectUrl}?IdLead={idLead}");
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
    var result = new List<Bitrix24.PRODUCT>();
    if (Session.Contents["productrows"] != null)
      result = (List<Bitrix24.PRODUCT>) Session.Contents["productrows"];
    var index = 0;
    foreach (GridViewRow tr in GridViewLeadProducts.Rows)
    {
      var hiddenField1 = tr.Cells[2].FindControl("HiddenField1") as HiddenField;
      var textBox1 = tr.Cells[2].FindControl("TextBox1") as TextBox;
      var product = result.FirstOrDefault(r => r.ID == Convert.ToInt32(hiddenField1.Value));
      if (product != null)
      {
        if (textBox1 != null && result[index] != null)
          product.PRODUCT_PRICE = textBox1.Text;

        var textBox2 = tr.Cells[3].FindControl("TextBox2") as TextBox;
        if (textBox2 != null && result[index] != null)
          product.PRODUCT_QUANTITY = textBox2.Text;
      }

      index++;
    }

    Session.Contents["productrows"] = result;
  }


  protected void ButtonAddPhone_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TablePhones.Rows)
      if (c is TableRow)
        count++;
    var tableRow = CreateContectRow(count);
    if (Session.Contents["TableContact"] == null)
      Session.Contents["TableContact"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContact"] as Dictionary<string, TableRow>)?.Add(tableRow.ID, tableRow);
  }


  private TableRow CreateContectRow(int count)
  {
    var row = new TableRow {ID = "TableRow" + count};
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE" + uniq};
    var dropDownListLeadPhone = new DropDownList {ID = "DropDownListLeadPHONE" + uniq, CssClass = "form-control"};
    dropDownListLeadPhone.Items.AddRange(
      _bx24.PhoneTypes.Where(x=>!x.Key.Equals("MOBILE") && !x.Key.Equals("OTHER")).Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var requiredFieldValidator = new RequiredFieldValidator
    {
      ID = "RequiredFieldValidatorTextBoxLeadPHONE" + uniq, ValidationGroup = "Lead",
      ControlToValidate = "TextBoxLeadPHONE" + uniq, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
      Display = ValidatorDisplay.Dynamic
    };
    cell.Controls.Add(textBox);
    cell.Controls.Add(requiredFieldValidator);
    cell2.Controls.Add(dropDownListLeadPhone);
    row.Cells.Add(cell);
    row.Cells.Add(cell2);
    TablePhones.Rows.Add(row);
    return row;
  }

  protected void ButtonAddEmail_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableEmails.Rows)
      if (c is TableRow)
        count++;
    var tableRow = CreateContectEmailRow(count);
    if (Session.Contents["TableContactEmail"] == null)
      Session.Contents["TableContactEmail"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>)?.Add(tableRow.ID, tableRow);
  }


  private TableRow CreateContectEmailRow(int count)
  {
    var row = new TableRow {ID = "TableRowEmail" + count};
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL" + uniq};
    var dropDownListLeadEmail = new DropDownList {ID = "DropDownListLeadEMAIL" + uniq, CssClass = "form-control"};
    dropDownListLeadEmail.Items.AddRange(
      _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var requiredFieldValidator = new RequiredFieldValidator
    {
      ID = "RequiredFieldValidatorTextBoxLeadEMAIL" + uniq, ValidationGroup = "Lead",
      ControlToValidate = "TextBoxLeadEMAIL" + uniq, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
      Display = ValidatorDisplay.Dynamic
    };
    cell.Controls.Add(textBox);
    cell.Controls.Add(requiredFieldValidator);
    cell2.Controls.Add(dropDownListLeadEmail);
    row.Cells.Add(cell);
    row.Cells.Add(cell2);
    TableEmails.Rows.Add(row);
    return row;
  }

  protected void ButtonSendSMS_Click(object sender, EventArgs e)
  {
    Log.Info("Отправка SMS");
    int idLead;
    if (HiddenFieldIdLead.Value != null && int.TryParse(HiddenFieldIdLead.Value, out idLead))
    {
      if (string.IsNullOrEmpty(TextBoxSMS.Text.Trim()))
      {
        Log.Info("SMS не отправлено так как нет текста SMS");
        return;
      }

      var phone = GetPhoneFromForm().Trim();
      if (string.IsNullOrEmpty(phone))
      {
        Log.Info("SMS не отправлено так как нет номера для отправки");
        return;
      }

      var message = TextBoxSMS.Text.Trim();
      message = message.Substring(0, message.Length > 60 ? 60 : message.Length);
      if (SendSms(message, phone))
      {
        AddCommentToLead(idLead, $"Отправлено SMS на номер {phone} с текстом \"{message}\"");
        Log.Info($"Отправлено SMS на номер {phone} с текстом \"{message}\"");
        Response.Write($"Отправлено SMS на номер {phone} с текстом \"{message}\"");
      }
      else
      {
        Log.Info("SMS не отправлено так как есть ошибка в отправке");
      }
    }
    else
    {
      Log.Info("SMS не отправлено так как нет IdLead");
    }
  }

  private string GetPhoneFromForm()
  {
    var phones = new List<string>();
    foreach (TableRow row in TablePhones.Rows)
    {
      var textBoxLeadPhone = row.Cells[0].Controls[0] as TextBox;
      if (textBoxLeadPhone != null) phones.Add(textBoxLeadPhone.Text);
    }

    return phones.FirstOrDefault();
  }

  private bool SendSms(string message, string phones)
  {
    var url = "https://smsc.ru/sys/send.php";
    var result = Get(url,
      "login=bitrix@avantsb.ru&psw=Veles2019&phones=" + phones + "&mes=" + message + "&sender=avantsb.ru");
    return result.Length > 2 && result.Substring(0, 2) == "OK";
  }


  private string Get(string url, string data)
  {
    Log.Info($"Url SMS is {url + "?" + data}");
    var req = WebRequest.Create(url + "?" + data);
    var resp = req.GetResponse();
    var stream = resp.GetResponseStream();
    // ReSharper disable once AssignNullToNotNullAttribute
    var sr = new StreamReader(stream);
    var @out = sr.ReadToEnd();
    sr.Close();
    return @out;
  }

  public void AddCommentToLead(int idLead, string comment)
  {
    if (idLead == 0) return;


    var data =
      new
      {
        fields = new Dictionary<string, object>
        {
          {"ENTITY_ID", idLead},
          {"ENTITY_TYPE", "lead"},
          {"COMMENT", comment}
        }
      };
    var contentText = JsonConvert.SerializeObject(data);

    var lead = _bx24.SendCommand("crm.timeline.comment.add", "", contentText);
    //var leadByJson = JsonConvert.DeserializeObject<dynamic>(lead);
  }


  private TableRow CreatePhoneRow(int count, string category, Table tablePhones)
  {
    var row = new TableRow {ID = "TableRow" + count};
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var textBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}PHONE" + uniq};
    var dropDownListPhone = new DropDownList {ID = $"DropDownList{category}PHONE" + uniq, CssClass = "form-control"};
    dropDownListPhone.Items.AddRange(
      _bx24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var requiredFieldValidator = new RequiredFieldValidator
    {
      ID = $"RequiredFieldValidatorTextBox{category}PHONE" + uniq,
      ValidationGroup = category,
      ControlToValidate = $"TextBox{category}PHONE" + uniq,
      ForeColor = Color.Red,
      ErrorMessage = "Заполните поле",
      Display = ValidatorDisplay.Dynamic
    };
    cell.Controls.Add(textBox);
    cell.Controls.Add(requiredFieldValidator);
    cell2.Controls.Add(dropDownListPhone);
    row.Cells.Add(cell);
    row.Cells.Add(cell2);
    tablePhones.Rows.Add(row);
    return row;
  }


  private TableRow CreateEmailRow(int count, string category, Table tableEmails)
  {
    var row = new TableRow {ID = $"TableRow{category}" + count};
    var cell = new TableCell();
    var cell2 = new TableCell();
    var uniq = count.ToString();
    var textBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}EMAIL" + uniq};
    var dropDownListEmail = new DropDownList {ID = $"DropDownList{category}EMAIL" + uniq, CssClass = "form-control"};
    dropDownListEmail.Items.AddRange(
      _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
    var requiredFieldValidator = new RequiredFieldValidator
    {
      ID = $"RequiredFieldValidatorTextBox{category}EMAIL" + uniq,
      ValidationGroup = category,
      ControlToValidate = $"TextBox{category}EMAIL" + uniq,
      ForeColor = Color.Red,
      ErrorMessage = "Заполните поле",
      Display = ValidatorDisplay.Dynamic
    };
    cell.Controls.Add(textBox);
    cell.Controls.Add(requiredFieldValidator);
    cell2.Controls.Add(dropDownListEmail);
    row.Cells.Add(cell);
    row.Cells.Add(cell2);
    tableEmails.Rows.Add(row);
    return row;
  }


  private List<KeyValuePair<string, string>> GetResponsiblies()
  {
    var dataListUsers = new
    {
      sort = "LAST_NAME"
    };
    var userSearchListJson =
      _bx24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE", JsonConvert.SerializeObject(dataListUsers));
    var userSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
    var it = 0;
    var users = new List<KeyValuePair<string, string>>();
    while (it < 5)
    {
      it++;
      foreach (var user in userSearchList.result)
        users.Add(new KeyValuePair<string, string>(user.LAST_NAME.ToString() + " " + user.NAME.ToString(),
          user.ID.ToString()));
      if (userSearchList.next != null)
      {
        userSearchListJson = _bx24.SendCommand("user.search",
          "FILTER[ACTIVE]=TRUE&start=" + userSearchList.next.ToString(), JsonConvert.SerializeObject(dataListUsers),
          "POST");
        userSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
      }
      else
      {
        break;
      }
    }

    return users;
  }

  public void AddCommentToElement(int idElement, string comment, string type = "lead")
  {
    if (idElement == 0) return;


    var data =
      new
      {
        fields = new Dictionary<string, object>
        {
          {"ENTITY_ID", idElement},
          {"ENTITY_TYPE", type},
          {"COMMENT", comment}
        }
      };
    var contentText = JsonConvert.SerializeObject(data);

    var lead = _bx24.SendCommand("crm.timeline.comment.add", "", contentText);
    //var leadByJson = JsonConvert.DeserializeObject<dynamic>(lead);
  }

  private enum TypeObject
  {
    Undefined,
    Lead,
    Contact
  }

  #region Deal

  private void CreateDealForm(int idDeal)
  {
    PanelDeal.Visible = true;
    ButtonSaveOrUpdateDeal.Text = "Создать сделку";
    LabelNameDealTitle.Visible = true;
    ButtonCloseClosedDeal.Visible = false;

    var filterDealFields = idDeal > 0 ? FilterOpenDealFields : FilterDealFields;


    DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    foreach (var user in _responsiblies.OrderBy(r => r.Key))
      DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));


    foreach (var source in _sources)
      DropDownListDEAL_SOURCE_ID.Items.Add(new ListItem(source.Key, source.Value));

    var leadStatusListByJson =
      _bx24.SendCommand("crm.dealcategory.stage.list", "", "", "GET");
    var statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJson);
    foreach (var status in statusList.result)
      DropDownListDEAL_STAGE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));

    var dealTypes = GetDealTypes();
    DropDownListDEAL_TYPE_ID.Items.Add(new ListItem("-----", ""));
    foreach (var status in dealTypes)
      DropDownListDEAL_TYPE_ID.Items.Add(new ListItem(status.Key, status.Value));



    if (idDeal > 0)
    {
      DropDownListDEAL_STAGE_ID.Items.Clear();

      ButtonSaveOrUpdateDeal.Text = "Обновить сделку";
      LabelNameDealTitle.Visible = false;
      HiddenFieldIdDeal.Value = idDeal.ToString();

      var deal = _bx24.SendCommand("crm.deal.get", "id=" + idDeal);
      var dealByJson = JsonConvert.DeserializeObject<dynamic>(deal);
      TextBoxDEAL_TITLE.Text = dealByJson.result.TITLE;
      TextBoxDEAL_OPPORTUNITY.Text = dealByJson.result.OPPORTUNITY;
      DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue = dealByJson.result.ASSIGNED_BY_ID;
      DropDownListDEAL_CURRENCY_ID.SelectedValue = dealByJson.result.CURRENCY_ID;
      DropDownListDEAL_TYPE_ID.SelectedValue = dealByJson.result.TYPE_ID;
      DropDownListDEAL_TYPE_ID.Enabled = false;

      bool isClosed = dealByJson.result.CLOSED.ToString() == "Y";

      ButtonSaveOrUpdateDeal.Visible = !isClosed;
      ButtonCloseClosedDeal.Visible = isClosed;

      if (isClosed)
        DisabledSystemFields();

      CreateUserFields(filterDealFields, isClosed, false);

      if (dealByJson.result.CONTACT_ID != null)
      {
        HiddenFieldDEAL_CONTACT_ID.Value = dealByJson.result.CONTACT_ID.ToString();
        var contact = _bx24.SendCommand("crm.contact.get", "id=" + dealByJson.result.CONTACT_ID, "", "POST");
        var contactByJson = JsonConvert.DeserializeObject<dynamic>(contact);
        var phones = "";
        if (contactByJson.result.PHONE != null)
          foreach (var phone in contactByJson.result.PHONE)
            phones += (phones != "" ? "," : "") + phone.VALUE;

        TextBoxDEAL_ContactInfoName.Text = contactByJson.result.NAME;
        LabelDEAL_ContactInfoPhone.Text = phones;
      }

      TextBoxDEAL_BEGINDATE.Text = dealByJson.result.BEGINDATE;
      TextBoxDEAL_COMMENTS.Text = dealByJson.result.COMMENTS;


      leadStatusListByJson =
        _bx24.SendCommand("crm.dealcategory.stage.list", "id=" + dealByJson.result.CATEGORY_ID, "", "GET");
      statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJson);
      foreach (var status in statusList.result)
        DropDownListDEAL_STAGE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));


      DropDownListDEAL_STAGE_ID.SelectedValue = dealByJson.result.STAGE_ID;
      LabelNameDeal.Text = string.Format("Сделка №{0}", dealByJson.result.ID);

      FillUserFields(dealByJson, filterDealFields);
    }
    else
    {
      CreateUserFields(filterDealFields, false, true);
    }
  }

  private void DisabledSystemFields()
  {
    TextBoxDEAL_TITLE.Enabled = false;
    DropDownListDEAL_SOURCE_ID.Enabled = false;
    TextBoxDEAL_COMMENTS.Enabled = false;
  }

  private List<KeyValuePair<string, string>> GetDealTypes()
  {
    var dataListSources = new
    {
      sort = "NAME"
    };
    var dealTypesSearchListJson = _bx24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=DEAL_TYPE",
      JsonConvert.SerializeObject(dataListSources));
    var dealTypesSearchList = JsonConvert.DeserializeObject<dynamic>(dealTypesSearchListJson);
    var it = 0;
    var sources = new List<KeyValuePair<string, string>>();
    while (it < 5)
    {
      it++;
      foreach (var source in dealTypesSearchList.result)
        sources.Add(new KeyValuePair<string, string>(source.NAME.ToString(), source.STATUS_ID.ToString()));
      if (dealTypesSearchList.next != null)
      {
        dealTypesSearchListJson = _bx24.SendCommand("crm.status.list",
          "FILTER[ENTITY_ID]=DEAL_TYPE&start=" + dealTypesSearchList.next.ToString(),
          JsonConvert.SerializeObject(dataListSources), "POST");
        dealTypesSearchList = JsonConvert.DeserializeObject<dynamic>(dealTypesSearchListJson);
      }
      else
      {
        break;
      }
    }

    return sources;
  }



  private List<DealInfo> GetOpenDealByIdContact(int idContact)
  {
    var deals = _bx24.SendCommand("crm.deal.list", "FILTER[CLOSED]=N&FILTER[CONTACT_ID]=" + idContact + "");
    var dealsByJson = JsonConvert.DeserializeObject<dynamic>(deals);
    var listDeals = new List<DealInfo>();
    if (dealsByJson.result?.Count > 0)
      for (var i = 0; i < dealsByJson.result?.Count; i++)
      {
        var deal = dealsByJson.result[i];
        listDeals.Add(new DealInfo
        {
          Id = int.Parse(deal.ID.ToString()), Title = deal.TITLE.ToString(),
          DateCreate = DateTime.Parse(deal.DATE_CREATE.ToString(), CultureInfo.GetCultureInfo("ru-RU"))
        });
      }

    return listDeals;
  }

  private void CreateUserFields(List<int> filterDealFields, bool isClosed, bool isNew)
  {
    var i = 10;
    _bx24.FilterDealFields = filterDealFields;
    var bfields = _bx24.DealFields.ToList();

    var fields = filterDealFields == null
      ? bfields
      : filterDealFields.Select(x => bfields.FirstOrDefault(b => b.ID == x)).Where(x => x != null).ToList();

    var tableFileds = TableDeal;

    CreaterFields(fields, tableFileds, isNew ? NewDealFieldSettings : DealFieldSettings, i, isClosed);
  }

  private void FillUserFields(dynamic dealByJson, List<int> filterDealFields)
  {
    _bx24.FilterDealFields = filterDealFields;
    var fields = _bx24.DealFields.ToList();

    FillFields(dealByJson, fields);
  }

  protected void ButtonSaveOrUpdateDeal_OnClick(object sender, EventArgs e)
  {
    var idContact = int.Parse(HiddenFieldIdContact.Value);

    var data =
      new
      {
        id = (object) HiddenFieldIdDeal.Value,
        fields = new Dictionary<string, object>
        {
          {"TITLE", TextBoxDEAL_TITLE.Text},
          {"ASSIGNED_BY_ID", DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue},
          //    {"OPPORTUNITY", TextBoxDEAL_OPPORTUNITY.Text},
          //     {"CURRENCY_ID", DropDownListDEAL_CURRENCY_ID.SelectedValue},
          {"STAGE_ID", DropDownListDEAL_STAGE_ID.SelectedValue},
          {"TYPE_ID", DropDownListDEAL_TYPE_ID.SelectedValue},
          //  {"BEGINDATE", TextBoxDEAL_BEGINDATE.Text},
          {"COMMENTS", TextBoxDEAL_COMMENTS.Text},
          {"CONTACT_IDS", new List<int> {idContact}}
        }
      };


    var idDealOld = HiddenFieldIdDeal.Value != "" ? Convert.ToInt32(HiddenFieldIdDeal.Value) : 0;
    var filterDealFields = idDealOld > 0 ? FilterOpenDealFields : FilterDealFields;
    _bx24.FilterDealFields = filterDealFields;
    foreach (var uf in _bx24.DealFields)
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var cbl = Page.FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
          if (cbl != null)
          {
            var sel = new List<string>();

            foreach (ListItem item in cbl.Items)
              if (item.Selected)
                sel.Add(item.Value);

            data.fields.Add(uf.FIELD_NAME, sel);
          }
        }
        else
        {
          var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
          if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.Text);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        var ddl2 = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
        if (ddl != null)
          if (ddl2 != null)
            data.fields.Add(uf.FIELD_NAME, ddl.Text + "|" + ddl2.SelectedValue);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = Page.FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
        if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.Checked);
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


    var deal = idDealOld > 0
      ? _bx24.SendCommand("crm.deal.update", "", contentText)
      : _bx24.SendCommand("crm.deal.add", "", contentText);
    var dealByJson = JsonConvert.DeserializeObject<dynamic>(deal);


    idDealOld = idDealOld > 0 ? idDealOld : Convert.ToInt32(dealByJson.result);

    Response.Redirect($"~/{RedirectUrl}?IdDeal={idDealOld}&IdContact={HiddenFieldIdContact.Value}");
    Response.End();
  }


  protected void ButtonShowClosedDeal_Click(object sender, EventArgs e)
  {
    PanelClosedDeals.Visible = true;
    _sourcers.ClosedDeals = GetClosedDealByIdContact(_idContact);
    Session.Contents["CloasedDeals"] = _sourcers.ClosedDeals;
    GridViewClosedDeals.DataBind();
  }


  protected void ButtonCloseClosedDeal_Click(object sender, EventArgs e)
  {
    Response.Redirect($"~/{RedirectUrl}?IdContact={HiddenFieldIdContact.Value}");
  }


  protected void GridViewCompanySearch_SelectedIndexChanged(object sender, EventArgs e)
  {
    DealInfo result = null;

    var resultSeacrh = new List<DealInfo>();
    if (Session.Contents["CloasedDeals"] != null)
      resultSeacrh = ((List<DealInfo>) Session.Contents["CloasedDeals"]).OrderBy(r => r.Title).ToList();

    result = resultSeacrh[GridViewClosedDeals.SelectedIndex];
    if (result != null)
    {
      Response.Redirect($"~/{RedirectUrl}?IdDeal={result.Id}&IdContact={HiddenFieldIdContact.Value}");
      Response.End();
    }
  }


  protected void LinqDataSourceCompamies_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var result = new List<DealInfo>();
    if (Session.Contents["CloasedDeals"] != null)
      result = (List<DealInfo>) Session.Contents["CloasedDeals"];
    if (_sourcers.ClosedDeals.Count > 0)
      result = _sourcers.ClosedDeals;
    Session.Contents["CloasedDeals"] = result;
    e.Result = result;
  }


  private List<DealInfo> GetClosedDealByIdContact(int idContact)
  {
    var deals = _bx24.SendCommand("crm.deal.list", "FILTER[CLOSED]=Y&FILTER[CONTACT_ID]=" + idContact + "");
    var dealsByJson = JsonConvert.DeserializeObject<dynamic>(deals);
    var listDeals = new List<DealInfo>();
    if (dealsByJson.result?.Count > 0)
      for (var i = 0; i < dealsByJson.result?.Count; i++)
      {
        var deal = dealsByJson.result[i];
        listDeals.Add(new DealInfo
        {
          Id = int.Parse(deal.ID.ToString()), Title = deal.TITLE.ToString(),
          DateCreate = DateTime.Parse(deal.DATE_CREATE.ToString(), CultureInfo.GetCultureInfo("ru-RU"))
        });
      }

    return listDeals;
  }

  #endregion

  #region Contact

  private void CreateContactForm(int idContact, out int idCompany)
  {
    idCompany = 0;
    PanelContact.Visible = true;

    CreateContactFields();

    var leadStatusListByJson = _bx24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=CONTACT_TYPE", "", "GET");
    DropDownListCONTACT_TYPE_ID.Items.Add(new ListItem("------", ""));
    var statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJson);
    foreach (var status in statusList.result)
      DropDownListCONTACT_TYPE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));

    DropDownListCONTACT_ASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
    foreach (var user in _responsiblies.OrderBy(r => r.Key))
      DropDownListCONTACT_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));


    if (idContact > 0)
    {
      Log.Info($"IdContact = {idContact}");


      ButtonSaveContact.Text = "Обновить контакт";

      HiddenFieldIdContact.Value = idContact.ToString();

      var contact = _bx24.SendCommand("crm.contact.get", "id=" + idContact);
      var valueByJson = JsonConvert.DeserializeObject<dynamic>(contact);
      if(valueByJson.result.COMPANY_ID != null)
        idCompany = valueByJson.result.COMPANY_ID;
      LabelNameContact.Text = TextBoxCONTACT_NAME.Text = valueByJson.result.NAME;
      TextBoxCONTACT_SECOND_NAME.Text = valueByJson.result.SECOND_NAME;
      TextBoxCONTACT_LAST_NAME.Text = valueByJson.result.LAST_NAME;

      var category = "Contact";
      var tablePhones = TableContactPhones;

      CreaterAndFillPhones(valueByJson, category, tablePhones);

      var tableEmails = TableContactEmails;

      CreaterAndFillEmails(valueByJson, category, tableEmails);

      TextBoxCONTACT_COMMENTS.Text = valueByJson.result.COMMENTS;
      DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue = valueByJson.result.ASSIGNED_BY_ID;
      DropDownListCONTACT_TYPE_ID.SelectedValue = valueByJson.result.TYPE_ID;

      FillContactUserFields(valueByJson);
    }
  }

  private void FillContactUserFields(dynamic valueByJson)
  {
    _bx24.FilterContactFields = FilterContactFields;
    var fields = _bx24.ContactFields.ToList();
    FillFields(valueByJson, fields);
  }

  private void FillFields(dynamic valueByJson, List<Bitrix24.Userfield> fields)
  {
    foreach (var uf in fields)
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          var checkBoxListUf = FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
          foreach (JProperty item in valueByJson.result)
            if (item.Name == uf.FIELD_NAME) //property name
              foreach (var val in item.Value)
              {
                var li = checkBoxListUf.Items.FindByValue(val.ToString());
                if (li != null) li.Selected = true;
              }
        }
        else
        {
          var dropDownListUf = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
          foreach (JProperty item in valueByJson.result)
            if (item.Name == uf.FIELD_NAME && item.Value.ToString() != "") //property name
              dropDownListUf.SelectedValue = item.Value.ToString();
        }
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string || uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.date)
      {
        var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        if (ddl != null)
          foreach (JProperty item in valueByJson.result)
            if (item.Name == uf.FIELD_NAME) //property name
              ddl.Text = item.Value.ToString();
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
        var ddl2 = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
        foreach (JProperty item in valueByJson.result)
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
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        var ddl = FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
        foreach (JProperty item in valueByJson.result)
          if (item.Name == uf.FIELD_NAME) //property name
            ddl.Checked = item.Value.ToString() == "1";
      }
  }

  private void CreaterAndFillEmails(dynamic valueByJson, string category, Table tableEmails)
  {
    if (valueByJson.result.EMAIL != null)
    {
      var countContact = 0;
      foreach (var email in valueByJson.result.EMAIL)
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var textBox = new TextBox
          {CssClass = "form-control", ID = $"TextBox{category}EMAIL" + email.ID, Text = email.VALUE};
        var hiddenField = new HiddenField {ID = $"HiddenField{category}EMAIL" + email.ID, Value = email.ID};
        var dropDownListEmail = new DropDownList
          {ID = $"DropDownList{category}EMAIL" + email.ID, CssClass = "form-control"};
        dropDownListEmail.Items.AddRange(
          _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        dropDownListEmail.SelectedValue = email.VALUE_TYPE;
        var requiredFieldValidator = new RequiredFieldValidator
        {
          ID = $"RequiredFieldValidatorTextBox{category}EMAIL" + email.ID,
          ValidationGroup = category,
          ControlToValidate = $"TextBox{category}EMAIL" + email.ID,
          ForeColor = Color.Red,
          ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic,
          Enabled = false
        };
        cell.Controls.Add(textBox);
        cell.Controls.Add(requiredFieldValidator);
        cell2.Controls.Add(dropDownListEmail);
        cell2.Controls.Add(hiddenField);
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
      var textBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}EMAIL"};
      var dropDownListEmail = new DropDownList {ID = $"DropDownList{category}EMAIL", CssClass = "form-control"};
      dropDownListEmail.Items.AddRange(
        _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
      var requiredFieldValidator = new RequiredFieldValidator
      {
        ID = $"RequiredFieldValidatorTextBox{category}EMAIL",
        ValidationGroup = category,
        ControlToValidate = $"TextBox{category}EMAIL",
        ForeColor = Color.Red,
        ErrorMessage = "Заполните поле",
        Display = ValidatorDisplay.Dynamic,
        Enabled = false
      };
      cell.Controls.Add(textBox);
      cell.Controls.Add(requiredFieldValidator);
      cell2.Controls.Add(dropDownListEmail);
      row.Cells.Add(cell);
      row.Cells.Add(cell2);
      tableEmails.Rows.Add(row);
    }
  }

  private void CreateContactFields()
  {
    var i = 6;
    _bx24.FilterContactFields = FilterContactFields;
    var fields = _bx24.ContactFields.ToList();
    var tableFileds = TableContact;
    CreaterFields(fields, tableFileds, null, i);
  }

  private void CreaterFields(List<Bitrix24.Userfield> fields, Table tableFileds,
    Dictionary<int, FieldSettings> fieldSettings, int i, bool isClosed = false)
  {
    foreach (var uf in fields)
    {
      var enabled = true;
      var controlId = "";

      if (fieldSettings != null && fieldSettings.ContainsKey(uf.ID))
      {
        var setting = fieldSettings[uf.ID];
        enabled = !setting.Readonly;
      }

      if (isClosed) enabled = false;

      var tr = new TableRow {ID = "TableRow" + uf.ID};
      var tc1 = new TableCell
      {
        ID = "TableCellLabel" + uf.ID,
        Text = uf.NAME + (Request.QueryString["Fields"] != null ? $" {uf.ID} {uf.USER_TYPE_ID}" : "")
      };
      tr.Cells.Add(tc1);
      var tc2 = new TableCell {ID = "TableCellUserfield" + uf.ID};
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          controlId = "CheckBoxListUserfield" + uf.ID;
           var cbl = new CheckBoxList {ID = controlId, RepeatColumns = 3};
          foreach (var item in uf.LIST)
            cbl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          cbl.Enabled = enabled;
          tc2.Controls.Add(cbl);
        }
        else
        {
          controlId = "DropDownListUserfield" + uf.ID;
           var ddl = new DropDownList {ID = controlId, CssClass = "form-control"};
          ddl.Items.Add(new ListItem("-----", ""));
          foreach (var item in uf.LIST)
            ddl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          ddl.Enabled = enabled;
          tc2.Controls.Add(ddl);
        }

        tr.Cells.Add(tc2);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string || uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.date)
      {
        controlId = "TextBoxUserfield" + uf.ID;
         var ddl = new TextBox {ID = controlId, CssClass = "form-control"};
        ddl.Enabled = enabled;
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc2);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
      {
        controlId = "TextBoxUserfield" + uf.ID;
        var ddl = new TextBox {ID = controlId, CssClass = "form-control"};
        ddl.Enabled = enabled;
        tc2.Controls.Add(ddl);
        var ddl2 = new DropDownList {ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control"};
        ddl2.Items.Add(new ListItem {Value = "RUB", Text = "Рубль"});
        ddl2.Items.Add(new ListItem {Value = "USD", Text = "Доллар США"});
        ddl2.Enabled = enabled;
        tc2.Controls.Add(ddl2);

        tr.Cells.Add(tc2);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        controlId = "CheckBoxUserfield" + uf.ID;
        var ddl = new CheckBox {ID = controlId, CssClass = "form-control"};
        ddl.Enabled = enabled;
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc2);
      }

      if (fieldSettings != null && fieldSettings.ContainsKey(uf.ID))
      {
        var setting = fieldSettings[uf.ID];

        if (setting.Alias != null) 
          tr.Cells[0].Text = setting.Alias;

        if (setting.IsRequired)
        {
          var rfv = new RequiredFieldValidator
          {
            ID = "RequiredFieldValidatorLead" + uf.ID,
            ValidationGroup = "Deal",
            ControlToValidate = controlId,
            ForeColor = Color.Red,
            ErrorMessage = "Заполните поле",
            Display = ValidatorDisplay.Dynamic
          };
          tc2.Controls.Add(rfv);
        }

        var position = i++;
        if (setting.Position != null)
          position = (int) setting.Position;

        tableFileds.Rows.AddAt(position, tr);

        if (setting.PreTitle != null)
        {
          var trTitle = new TableRow {ID = "TableRowPreTitle" + uf.ID};
          var tcTitle = new TableCell {ID = "TableCellLabelTitle" + uf.ID, Text = setting.PreTitle};
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

  private void CreaterAndFillPhones(dynamic valueByJson, string category, Table tablePhones)
  {
    if (valueByJson.result.PHONE != null)
    {
      var countContact = 0;
      foreach (var phone in valueByJson.result.PHONE)
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var textBox = new TextBox
          {CssClass = "form-control", ID = $"TextBox{category}PHONE" + phone.ID, Text = phone.VALUE};
        var hiddenField = new HiddenField {ID = $"HiddenField{category}PHONE" + phone.ID, Value = phone.ID};
        var dropDownListPhone = new DropDownList
          {ID = $"DropDownList{category}PHONE" + phone.ID, CssClass = "form-control"};
        dropDownListPhone.Items.AddRange(
          _bx24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        dropDownListPhone.SelectedValue = phone.VALUE_TYPE;
        var requiredFieldValidator = new RequiredFieldValidator
        {
          ID = $"RequiredFieldValidatorTextBox{category}PHONE" + phone.ID,
          ValidationGroup = category,
          ControlToValidate = $"TextBox{category}PHONE" + phone.ID,
          ForeColor = Color.Red,
          ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic,
          Enabled = false
        };
        cell.Controls.Add(textBox);
        cell.Controls.Add(requiredFieldValidator);
        cell2.Controls.Add(dropDownListPhone);
        cell2.Controls.Add(hiddenField);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        tablePhones.Rows.Add(row);

        if (Session.Contents[$"TableContact{category}"] != null)
        {
          var tables = Session.Contents[$"TableContact{category}"] as Dictionary<string, TableRow>;
          if (tables != null && tables.ContainsKey("TableRow" + countContact))
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
      var textBox = new TextBox {CssClass = "form-control", ID = $"TextBox{category}PHONE"};
      var dropDownListPhone = new DropDownList {ID = $"DropDownList{category}PHONE", CssClass = "form-control"};
      dropDownListPhone.Items.AddRange(
        _bx24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
      var requiredFieldValidator = new RequiredFieldValidator
      {
        ID = $"RequiredFieldValidatorTextBox{category}PHONE",
        ValidationGroup = category,
        ControlToValidate = $"TextBox{category}PHONE",
        ForeColor = Color.Red,
        ErrorMessage = "Заполните поле",
        Display = ValidatorDisplay.Dynamic
      };
      cell.Controls.Add(textBox);
      cell.Controls.Add(requiredFieldValidator);
      cell2.Controls.Add(dropDownListPhone);
      row.Cells.Add(cell);
      row.Cells.Add(cell2);
      tablePhones.Rows.Add(row);

      if (Request.QueryString["Phone"] != null) textBox.Text = Request.QueryString["Phone"];

      if (Request.QueryString["AbonentNumber"] != null) textBox.Text = Request.QueryString["AbonentNumber"];
    }
  }

  protected void ButtonContactAddPhone_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableContactPhones.Rows)
      if (c is TableRow)
        count++;

    var tableRow = CreatePhoneRow(count, "Contact", TableContactPhones);
    if (Session.Contents["TableContactContact"] == null)
      Session.Contents["TableContactContact"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContactContact"] as Dictionary<string, TableRow>)?.Add(tableRow.ID, tableRow);
  }

  protected void ButtonContactAddEmail_Click(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableContactEmails.Rows)
      if (c is TableRow)
        count++;

    var tableRow = CreateEmailRow(count, "Contact", TableContactEmails);
    if (Session.Contents["TableContactContactEmail"] == null)
      Session.Contents["TableContactContactEmail"] = new Dictionary<string, TableRow>();

    (Session.Contents["TableContactContactEmail"] as Dictionary<string, TableRow>)?.Add(tableRow.ID, tableRow);
  }

  protected void ButtonSaveContact_OnClick(object sender, EventArgs e)
  {
    try
    {
      var idContactOld = HiddenFieldIdContact.Value != "" ? Convert.ToInt32(HiddenFieldIdContact.Value) : 0;
      Log.Info($"IdContactOld = {idContactOld}");

      if (idContactOld == 0)
      {
        //проверим возможно уже контакт был создан пока заполняли форму
        if (string.IsNullOrEmpty(_phone) && Request.QueryString["Phone"] != null) _phone = Request.QueryString["Phone"];

        if (!string.IsNullOrEmpty(_phone))
        {
          idContactOld = GetIdContactByPhone(_phone);
          Log.Info($"Лид найден IdLeadOld = {idContactOld}");
        }
      }


      var data =
        idContactOld > 0
          ? new
          {
            id = (object) idContactOld,
            fields = new Dictionary<string, object>
            {
              {"NAME", TextBoxCONTACT_NAME.Text},
              {"SECOND_NAME", TextBoxCONTACT_SECOND_NAME.Text},
              {"LAST_NAME", TextBoxCONTACT_LAST_NAME.Text}
              //    {"COMMENTS", TextBoxCONTACT_COMMENTS.Text},
              //   {"ASSIGNED_BY_ID", DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue},
              //    {"TYPE_ID", DropDownListCONTACT_TYPE_ID.SelectedValue}
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
              {"LAST_NAME", TextBoxCONTACT_LAST_NAME.Text}
              //   {"COMMENTS", TextBoxCONTACT_COMMENTS.Text},
              //    {"ASSIGNED_BY_ID", DropDownListCONTACT_ASSIGNED_BY_ID.SelectedValue},
              //   {"TYPE_ID", DropDownListCONTACT_TYPE_ID.SelectedValue}
            },
            @params = new {REGISTER_SONET_EVENT = "Y"}
          };


      var phones = new List<object>();
      foreach (TableRow row in TableContactPhones.Rows)
      {
        var textBoxLeadPhone = row.Cells[0].Controls[0] as TextBox;
        //var requiredFieldValidatorLeadPhone = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var dropDownListLeadPhone = row.Cells[1].Controls[0] as DropDownList;
        HiddenField hiddenFieldLeadPhone = null;
        if (row.Cells[1].Controls.Count > 1)
          hiddenFieldLeadPhone = row.Cells[1].Controls[1] as HiddenField;
        if (hiddenFieldLeadPhone != null)
          phones.Add(new
          {
            ID = hiddenFieldLeadPhone.Value,
            VALUE = textBoxLeadPhone.Text,
            VALUE_TYPE = dropDownListLeadPhone.SelectedValue
          });
        else
          phones.Add(new {VALUE = textBoxLeadPhone.Text, VALUE_TYPE = dropDownListLeadPhone.SelectedValue});
      }

      data.fields["PHONE"] = phones;


      var emails = new List<object>();
      foreach (TableRow row in TableContactEmails.Rows)
      {
        var textBoxLeadEmail = row.Cells[0].Controls[0] as TextBox;
        //var requiredFieldValidatorLeadEmail = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var dropDownListLeadEmail = row.Cells[1].Controls[0] as DropDownList;
        HiddenField hiddenFieldLeadEmail = null;
        if (row.Cells[1].Controls.Count > 1)
          hiddenFieldLeadEmail = row.Cells[1].Controls[1] as HiddenField;
        if (hiddenFieldLeadEmail != null)
        {
          if (textBoxLeadEmail != null)
            if (dropDownListLeadEmail != null)
              emails.Add(new
              {
                ID = hiddenFieldLeadEmail.Value,
                VALUE = textBoxLeadEmail.Text,
                VALUE_TYPE = dropDownListLeadEmail.SelectedValue
              });
        }
        else if (textBoxLeadEmail != null)
          if (dropDownListLeadEmail != null)
            emails.Add(new {VALUE = textBoxLeadEmail.Text, VALUE_TYPE = dropDownListLeadEmail.SelectedValue});
      }

      data.fields["EMAIL"] = emails;

      //var t = data.fields.GetType();
      foreach (var uf in _bx24.ContactFields)
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var cbl = Page.FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            if (cbl != null)
            {
              var sel = new List<string>();

              foreach (ListItem item in cbl.Items)
                if (item.Selected)
                  sel.Add(item.Value);

              data.fields.Add(uf.FIELD_NAME, sel);
            }
          }
          else
          {
            var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = Page.FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.Text);
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = Page.FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          if (ddl != null) data.fields.Add(uf.FIELD_NAME, ddl.Checked);
        }


      var contentText = JsonConvert.SerializeObject(data);
      if (idContactOld == 0)
        contentText = contentText.Replace("\"id\":{},", "");


      var newLead =
        idContactOld > 0
          ? _bx24.SendCommand("crm.contact.update", "", contentText)
          : _bx24.SendCommand("crm.contact.add", "", contentText);
      var newLeadByJson = JsonConvert.DeserializeObject<dynamic>(newLead);
      int idContact = idContactOld > 0 ? idContactOld : Convert.ToInt32(newLeadByJson.result);

      if (idContact == 0)
      {
        AddCommentToElement(idContact, "Контакт создан в КЦ Wilstream", "contact");
        Log.Info($"New IdContact = {idContact}");
        Response.Redirect($"~/{RedirectUrl}?IdContact={idContact}");
        Response.End();
      }
      else
      {
        AddCommentToElement(idContact, "Контакт обновлен в КЦ Wilstream", "contact");
        Log.Info($"Redirect after update IdContact = {idContact}");
        Response.Redirect($"~/{RedirectUrl}?IdContact={idContact}");
        Response.End();
      }
    }
    catch (Exception)
    {
      Response.Write("Ошибка сохранения лида. Возможно лид уже был удален.");
    }
  }


  protected void ButtonContactSearch_Click(object sender, EventArgs e)
  {
    PanelContactSearch.Visible = true;
    _sourcers.Contacts = GetContactsByPhone(TextBoxContactSearch.Text);
    Session.Contents["ContactSearch"] = _sourcers.Contacts;
    GridViewContactSearch.DataBind();
  }


  protected void GridViewContactSearch_SelectedIndexChanged(object sender, EventArgs e)
  {
    ContactInfo result = null;

    var resultSeacrh = new List<ContactInfo>();
    if (Session.Contents["ContactSearch"] != null)
      resultSeacrh = ((List<ContactInfo>) Session.Contents["ContactSearch"]).OrderBy(r => r.Title).ToList();

    result = resultSeacrh[GridViewContactSearch.SelectedIndex];
    if (result != null)
    {
      Response.Redirect($"~/{RedirectUrl}?IdContact={result.Id}");
      Response.End();
    }
  }


  protected void LinqDataSourceContactSearch_Selecting(object sender, LinqDataSourceSelectEventArgs e)
  {
    var result = new List<ContactInfo>();
    if (Session.Contents["ContactSearch"] != null)
      result = (List<ContactInfo>) Session.Contents["ContactSearch"];
    if (_sourcers.ClosedDeals?.Count > 0)
      result = _sourcers.Contacts;
    Session.Contents["ContactInfo"] = result;
    e.Result = result;
  }

  protected List<ContactInfo> GetContactsByPhone(string phone)
  {
    var result = new List<ContactInfo>();
    var ids = new List<int>();
    var dataListLids = new
    {
      sort = new {ID = "desc"}
    };
    phone = phone.Length > 10 ? phone.Substring(phone.Length - 10, 10) : phone;
    var strPhone = "&values[]=" + phone + "&values[]=7" + phone + "&values[]=8" + phone;
    Log.Info($"strPhone = {strPhone}");
    var contactIds = _bx24.SendCommand("crm.duplicate.findbycomm",
      "entity_type=CONTACT&type=PHONE&values[]=" + strPhone + "&ORDER[ID]=DESC",
      JsonConvert.SerializeObject(dataListLids));
    Log.Info($"crm.duplicate.findbycomm = {contactIds}");
    var contactIdsJson = JsonConvert.DeserializeObject<dynamic>(contactIds);
    try
    {
      if (contactIdsJson.result.CONTACT.Count > 0)
      {
        for (var i = 0; i < contactIdsJson.result.CONTACT.Count; i++)
          ids.Add(int.Parse(contactIdsJson.result.CONTACT[i].ToString()));
        var contacts = _bx24.SendCommand("crm.contact.list",
          "FILTER[ID]=" + string.Join(",", ids) + "&SELECT[]=*&SELECT[]=PHONE&SELECT[]=EMAIL",
          JsonConvert.SerializeObject(dataListLids), "GET");
        Log.Info($"crm.contact.list = {contacts}");
        var contactsJson = JsonConvert.DeserializeObject<dynamic>(contacts);
        if (contactsJson.result.Count > 0)
          for (var i = 0; i < contactsJson.result.Count; i++)
          {
            var contact = contactsJson.result[i];
            var phones = new List<string>();
            if (contact.HAS_PHONE.ToString() == "Y")
              for (var j = 0; j < contact.PHONE.Count; j++)
                phones.Add(contact.PHONE[j].VALUE.ToString());
            var emails = new List<string>();
            if (contact.HAS_EMAIL.ToString() == "Y")
              for (var j = 0; j < contact.EMAIL.Count; j++)
                emails.Add(contact.EMAIL[j].VALUE.ToString());
            result.Add(new ContactInfo
            {
              Id = int.Parse(contact.ID.ToString()), Phones = string.Join(",", phones),
              Emails = string.Join(",", emails), Name = contact.NAME.ToString(),
              SecondName = contact.SECOND_NAME.ToString(), LastName = contact.LAST_NAME.ToString()
            });
          }
      }

      return result;
    }
    catch (Exception ex)
    {
      Log.Error(ex);
      return result;
    }
  }

  #endregion

  #region Lead

  private void CreateLeadForm(int idLead)
  {
    PanelLead.Visible = true;

    CreateLeadSystemField("115", "CALL");
    CreateLeadUserFields();

    if (idLead > 0)
    {
      string lead;
      dynamic leadByJson = new { };
      try
      {
        lead = _bx24.SendCommand("crm.lead.get", "ID=" + idLead, "", "GET");
        leadByJson = JsonConvert.DeserializeObject<dynamic>(lead);
        Log.Info($"Lead = {lead}");
      }
      catch (WebException wex)
      {
        Log.Error(wex);
        if (((HttpWebResponse) wex.Response).StatusCode == HttpStatusCode.BadRequest)
        {
          Response.Write("Ошибка в запросе. Возможно лид " + idLead + " был удален из CRM системы");
          Response.End();
        }
      }

      LabelNameLead.Text = leadByJson.result.TITLE;
      TextBoxLeadTITLE.Text = leadByJson.result.TITLE;
      TextBoxLeadNAME.Text = leadByJson.result.NAME;
      TextBoxLeadSECOND_NAME.Text = leadByJson.result.SECOND_NAME;
      TextBoxLeadADDRESS_CITY.Text = leadByJson.result.ADDRESS_CITY;
      TextBoxLeadLAST_NAME.Text = leadByJson.result.LAST_NAME;
      DropDownListLeadSTATUS_ID.SelectedValue = leadByJson.result.STATUS_ID;
      if (leadByJson.result.PHONE != null)
      {
        var countContact = 0;
        foreach (var phone in leadByJson.result.PHONE)
        {
          var row = new TableRow();
          var cell = new TableCell();
          var cell2 = new TableCell();
          var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE" + phone.ID, Text = phone.VALUE};
          var hiddenField = new HiddenField {ID = "HiddenFieldLeadPHONE" + phone.ID, Value = phone.ID};
          var dropDownListLeadPhone = new DropDownList
            {ID = "DropDownListLeadPHONE" + phone.ID, CssClass = "form-control", Visible = countContact > 0 };
          dropDownListLeadPhone.Items.AddRange(
            _bx24.PhoneTypes.Where(x => !x.Key.Equals("MOBILE") && !x.Key.Equals("OTHER")).Select(r => new ListItem(r.Value, r.Key)).ToArray());
          dropDownListLeadPhone.SelectedValue = phone.VALUE_TYPE;
          var requiredFieldValidator = new RequiredFieldValidator
          {
            ID = "RequiredFieldValidatorTextBoxLeadPHONE" + phone.ID, ValidationGroup = "Lead",
            ControlToValidate = "TextBoxLeadPHONE" + phone.ID, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
            Display = ValidatorDisplay.Dynamic
          };
          cell.Controls.Add(textBox);
          cell.Controls.Add(requiredFieldValidator);
          cell2.Controls.Add(dropDownListLeadPhone);
          cell2.Controls.Add(hiddenField);
          row.Cells.Add(cell);
          row.Cells.Add(cell2);
          TablePhones.Rows.Add(row);

          if (Session.Contents["TableContact"] != null)
          {
            var tables = Session.Contents["TableContact"] as Dictionary<string, TableRow>;
            if (tables != null && tables.ContainsKey("TableRow" + countContact))
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
        var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE"};
        var dropDownListLeadPhone = new DropDownList {ID = "DropDownListLeadPHONE", CssClass = "form-control"};
        dropDownListLeadPhone.Items.AddRange(
          _bx24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var requiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadPHONE", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic
        };
        cell.Controls.Add(textBox);
        cell.Controls.Add(requiredFieldValidator);
        cell2.Controls.Add(dropDownListLeadPhone);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);

        if (Request.QueryString["Phone"] != null) textBox.Text = Request.QueryString["Phone"];
        if (Request.QueryString["AbonentNumber"] != null) textBox.Text = Request.QueryString["AbonentNumber"];
      }


      if (leadByJson.result.EMAIL != null)
      {
        var countContact = 0;
        foreach (var email in leadByJson.result.EMAIL)
        {
          var row = new TableRow();
          var cell = new TableCell();
          var cell2 = new TableCell();
          var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL" + email.ID, Text = email.VALUE};
          var hiddenField = new HiddenField {ID = "HiddenFieldLeadEMAIL" + email.ID, Value = email.ID};
          var dropDownListLeadEmail = new DropDownList
            {ID = "DropDownListLeadEMAIL" + email.ID, CssClass = "form-control"};
          dropDownListLeadEmail.Items.AddRange(
            _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
          dropDownListLeadEmail.SelectedValue = email.VALUE_TYPE;
          var requiredFieldValidator = new RequiredFieldValidator
          {
            ID = "RequiredFieldValidatorTextBoxLeadEMAIL" + email.ID, ValidationGroup = "Lead",
            ControlToValidate = "TextBoxLeadEMAIL" + email.ID, ForeColor = Color.Red, ErrorMessage = "Заполните поле",
            Display = ValidatorDisplay.Dynamic, Enabled = false
          };
          cell.Controls.Add(textBox);
          cell.Controls.Add(requiredFieldValidator);
          cell2.Controls.Add(dropDownListLeadEmail);
          cell2.Controls.Add(hiddenField);
          row.Cells.Add(cell);
          row.Cells.Add(cell2);
          TableEmails.Rows.Add(row);

          if (Session.Contents["TableContactEmail"] != null)
          {
            var tables = Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>;
            if (tables != null && tables.ContainsKey("TableRow" + countContact))
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
        var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL"};
        var dropDownListLeadEmail = new DropDownList {ID = "DropDownListLeadEMAIL", CssClass = "form-control"};
        dropDownListLeadEmail.Items.AddRange(
          _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var requiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadEMAIL", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic, Enabled = false
        };
        cell.Controls.Add(textBox);
        cell.Controls.Add(requiredFieldValidator);
        cell2.Controls.Add(dropDownListLeadEmail);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TableEmails.Rows.Add(row);
      }

      DropDownListLeadSOURCE_ID.SelectedValue = leadByJson.result.SOURCE_ID;
      CheckBoxLeadOPENED.Checked = leadByJson.result.OPENED == "1";
      TextBoxLeadCOMMENTS.Text = leadByJson.result.COMMENTS;
      TextBoxLeadSTATUS_DESCRIPTION.Text = leadByJson.result.STATUS_DESCRIPTION;
      DropDownListLeadASSIGNED_BY_ID.SelectedValue = leadByJson.result.ASSIGNED_BY_ID;
     // Type t = leadByJson.result.GetType();
      foreach (var uf in _bx24.Userfields)
        if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
        {
          if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
          {
            var checkBoxListUf = FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
            foreach (JProperty item in leadByJson.result)
              if (item.Name == uf.FIELD_NAME) //property name
                foreach (var val in item.Value)
                {
                  var li = checkBoxListUf.Items.FindByValue(val.ToString());
                  if (li != null) li.Selected = true;
                }
          }
          else
          {
            var dropDownListUf = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
            foreach (JProperty item in leadByJson.result)
              if (item.Name == uf.FIELD_NAME) //property name
                dropDownListUf.SelectedValue = item.Value.ToString();
          }
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
        {
          var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
          foreach (JProperty item in leadByJson.result)
            if (item.Name == uf.FIELD_NAME) //property name
              ddl.Text = item.Value.ToString();
        }
        else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
        {
          var ddl = FindControl("CheckBoxUserfield" + uf.ID) as CheckBox;
          foreach (JProperty item in leadByJson.result)
            if (item.Name == uf.FIELD_NAME) //property name
              ddl.Checked = item.Value.ToString() == "1";
        }

      HiddenFieldIdLead.Value = idLead.ToString();
      Log.Info($"Set HiddenFieldIdLead = {HiddenFieldIdLead.Value}");
      ButtonSaveLead.Text = "Обновить лид";
    }
    else
    {
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadPHONE"};
        var dropDownListLeadPhone = new DropDownList {ID = "DropDownListLeadPHONE", CssClass = "form-control", Visible = false};
        dropDownListLeadPhone.Items.AddRange(
          _bx24.PhoneTypes.Where(x=>!x.Key.Equals("MOBILE")&& !x.Key.Equals("OTHER")).Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var requiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadPHONE", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic
        };
        cell.Controls.Add(textBox);
        cell.Controls.Add(requiredFieldValidator);
        cell2.Controls.Add(dropDownListLeadPhone);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TablePhones.Rows.Add(row);

        if (Request.QueryString["Phone"] != null) textBox.Text = Request.QueryString["Phone"];
        if (Request.QueryString["AbonentNumber"] != null) textBox.Text = Request.QueryString["AbonentNumber"];
      }
      ;
      {
        var row = new TableRow();
        var cell = new TableCell();
        var cell2 = new TableCell();
        var textBox = new TextBox {CssClass = "form-control", ID = "TextBoxLeadEMAIL"};
        var dropDownListLeadEmail = new DropDownList {ID = "DropDownListLeadEMAIL", CssClass = "form-control"};
        dropDownListLeadEmail.Items.AddRange(
          _bx24.EmailTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
        var requiredFieldValidator = new RequiredFieldValidator
        {
          ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead",
          ControlToValidate = "TextBoxLeadEMAIL", ForeColor = Color.Red, ErrorMessage = "Заполните поле",
          Display = ValidatorDisplay.Dynamic, Enabled = false
        };
        cell.Controls.Add(textBox);
        cell.Controls.Add(requiredFieldValidator);
        cell2.Controls.Add(dropDownListLeadEmail);
        row.Cells.Add(cell);
        row.Cells.Add(cell2);
        TableEmails.Rows.Add(row);
      }
    }


    if (Session.Contents["TableContact"] != null)
      foreach (var item in Session.Contents["TableContact"] as Dictionary<string, TableRow>)
        TablePhones.Controls.Add(item.Value);


    if (Session.Contents["TableContactEmail"] != null)
      foreach (var item in Session.Contents["TableContactEmail"] as Dictionary<string, TableRow>)
        TableEmails.Controls.Add(item.Value);
  }

  private void CreateLeadSystemField(string statusDefault, string sourceDefault)
  {
    //Статус лида
    var leadStatusListByJson = _bx24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=STATUS", "", "GET");
    var statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJson);
    foreach (var status in statusList.result)
      DropDownListLeadSTATUS_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));
    if (DropDownListLeadSTATUS_ID.SelectedIndex < 1)
      DropDownListLeadSTATUS_ID.SelectedValue = statusDefault;

    //Источник

    foreach (var source in _sources)
      DropDownListLeadSOURCE_ID.Items.Add(new ListItem(source.Key, source.Value));

    var li = DropDownListLeadSOURCE_ID.Items.FindByValue(sourceDefault);
    if (li != null) li.Selected = true;

    //Ответственный
    var dataListUsers = new
    {
      sort = "LAST_NAME"
    };
    var userSearchListJson =
      _bx24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE", JsonConvert.SerializeObject(dataListUsers));
    var userSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
    var it = 0;
    DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));

    foreach (var user in _responsiblies.OrderBy(r => r.Key))
      DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
  }

  private void CreateLeadUserFields()
  {
    _bx24.FilterUserFields = FilterUserFields;
    foreach (var uf in _bx24.Userfields)
    {
      var tr = new TableRow {ID = "TableRow" + uf.ID};
      var tc1 = new TableCell {ID = "TableCellLabel" + uf.ID, Text = uf.NAME};
      var tc2 = new TableCell {ID = "TableCellUserfield" + uf.ID};
      var controlId = "";
      if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
      {
        if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
        {
          controlId = "CheckBoxListUserfield" + uf.ID;
           var cbl = new CheckBoxList {ID = controlId, RepeatColumns = 3};
          foreach (var item in uf.LIST)
            cbl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          tc2.Controls.Add(cbl);
        }
        else
        {
          controlId = "DropDownListUserfield" + uf.ID;
           var ddl = new DropDownList {ID = controlId, CssClass = "form-control"};
          ddl.Items.Add(new ListItem("-----", ""));
          foreach (var item in uf.LIST)
            ddl.Items.Add(new ListItem {Text = item.VALUE, Value = item.ID.ToString()});
          tc2.Controls.Add(ddl);
        }

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
      {
        controlId = "TextBoxUserfield" + uf.ID;
         var ddl = new TextBox {ID = controlId, CssClass = "form-control"};
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
      }
      else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
      {
        controlId = "CheckBoxUserfield" + uf.ID;
        var ddl = new CheckBox {ID = controlId, CssClass = "form-control"};
        tc2.Controls.Add(ddl);

        tr.Cells.Add(tc1);
        tr.Cells.Add(tc2);
      }

      if (UserFieldSettings.ContainsKey(uf.ID))
      {
        var setting = UserFieldSettings[uf.ID];

        if (setting.Alias != null)
          tr.Cells[0].Text = setting.Alias;

        if (setting.IsRequired)
        {
          var rfv = new RequiredFieldValidator { 
            ID = "RequiredFieldValidatorLead" + uf.ID ,
            ValidationGroup = "Lead",
            ControlToValidate = controlId,
            ForeColor = Color.Red,
            ErrorMessage = "Заполните поле",
            Display = ValidatorDisplay.Dynamic
          };
          tc2.Controls.Add(rfv);
        }

        if (setting.Position != null)
          TableLead.Rows.AddAt((int) setting.Position, tr);
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

  #region Company


  private void CreateCompanyForm(int idCompany)
  {
    PanelCompany.Visible = true;

    if (idCompany > 0)
    {
      Log.Info($"IdCompany = {idCompany}");


      ButtonSaveCompany.Text = "Обновить компанию";

      HiddenFieldIdCompany.Value = idCompany.ToString();

      var company = _bx24.SendCommand("crm.company.get", "id=" + idCompany);
      var valueByJson = JsonConvert.DeserializeObject<dynamic>(company);
      TextBoxCompanyTITLE.Text = valueByJson.result.TITLE; 

      var category = "Company";
      var tablePhones = TableCompanyPhones;

      CreaterAndFillPhones(valueByJson, category, tablePhones);

      var tableEmails = TableCompanyEmails;

      CreaterAndFillEmails(valueByJson, category, tableEmails);
    }

    if (Session.Contents["TableContactCompany"] != null)
      foreach (var item in Session.Contents["TableContactCompany"] as Dictionary<string, TableRow>)
        TableCompanyPhones.Controls.Add(item.Value);


    if (Session.Contents["TableContactCompanyEmail"] != null)
      foreach (var item in Session.Contents["TableContactCompanyEmail"] as Dictionary<string, TableRow>)
        TableCompanyEmails.Controls.Add(item.Value);

  }

  protected void ButtonCompanyAddPhone_OnClick(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableCompanyPhones.Rows)
      if (c is TableRow)
        count++;

    var tableRow = CreatePhoneRow(count, "Company", TableCompanyPhones);
    if (Session.Contents["TableContactCompany"] == null)
      Session.Contents["TableContactCompany"] = new Dictionary<string, TableRow>();


    var list = (Session.Contents["TableContactCompany"] as Dictionary<string, TableRow>);
    if (list != null && !list.ContainsKey(tableRow.ID))
      list.Add(tableRow.ID, tableRow);
  }

  protected void ButtonCompanyAddEmail_OnClick(object sender, EventArgs e)
  {
    var count = 0;
    foreach (Control c in TableCompanyEmails.Rows)
      if (c is TableRow)
        count++;

    var tableRow = CreateEmailRow(count, "Company", TableCompanyEmails);
    if (Session.Contents["TableContactCompanyEmail"] == null)
      Session.Contents["TableContactCompanyEmail"] = new Dictionary<string, TableRow>();

    var list = (Session.Contents["TableContactCompanyEmail"] as Dictionary<string, TableRow>);
    if(list != null && !list.ContainsKey(tableRow.ID))
      list.Add(tableRow.ID, tableRow);
  }

  protected void ButtonSaveCompany_OnClick(object sender, EventArgs e)
  {
    try
    {
      var idCompanyOld = HiddenFieldIdCompany.Value != "" ? Convert.ToInt32(HiddenFieldIdCompany.Value) : 0;
      Log.Info($"IdCompanyOld = {idCompanyOld}");

      
      var data =
        idCompanyOld > 0
          ? new
          {
            id = (object)idCompanyOld,
            fields = new Dictionary<string, object>
            {
              {"TITLE", TextBoxCompanyTITLE.Text}
            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
          }
          : new
          {
            id = new object(),
            fields = new Dictionary<string, object>
            {
              {"TITLE", TextBoxCompanyTITLE.Text}
            },
            @params = new { REGISTER_SONET_EVENT = "Y" }
          };


      var phones = new List<object>();
      foreach (TableRow row in TableCompanyPhones.Rows)
      {
        var textBoxLeadPhone = row.Cells[0].Controls[0] as TextBox;
        //var requiredFieldValidatorLeadPhone = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var dropDownListLeadPhone = row.Cells[1].Controls[0] as DropDownList;
        HiddenField hiddenFieldLeadPhone = null;
        if (row.Cells[1].Controls.Count > 1)
          hiddenFieldLeadPhone = row.Cells[1].Controls[1] as HiddenField;
        if (hiddenFieldLeadPhone != null)
          phones.Add(new
          {
            ID = hiddenFieldLeadPhone.Value,
            VALUE = textBoxLeadPhone.Text,
            VALUE_TYPE = dropDownListLeadPhone.SelectedValue
          });
        else
          phones.Add(new { VALUE = textBoxLeadPhone.Text, VALUE_TYPE = dropDownListLeadPhone.SelectedValue });
      }

      data.fields["PHONE"] = phones;


      var emails = new List<object>();
      foreach (TableRow row in TableCompanyEmails.Rows)
      {
        var textBoxLeadEmail = row.Cells[0].Controls[0] as TextBox;
        //var requiredFieldValidatorLeadEmail = row.Cells[0].Controls[1] as RequiredFieldValidator;
        var dropDownListLeadEmail = row.Cells[1].Controls[0] as DropDownList;
        HiddenField hiddenFieldLeadEmail = null;
        if (row.Cells[1].Controls.Count > 1)
          hiddenFieldLeadEmail = row.Cells[1].Controls[1] as HiddenField;
        if (hiddenFieldLeadEmail != null)
        {
          if (textBoxLeadEmail != null)
            if (dropDownListLeadEmail != null)
              emails.Add(new
              {
                ID = hiddenFieldLeadEmail.Value,
                VALUE = textBoxLeadEmail.Text,
                VALUE_TYPE = dropDownListLeadEmail.SelectedValue
              });
        }
        else if (textBoxLeadEmail != null)
          if (dropDownListLeadEmail != null)
            emails.Add(new { VALUE = textBoxLeadEmail.Text, VALUE_TYPE = dropDownListLeadEmail.SelectedValue });
      }

      data.fields["EMAIL"] = emails;
       


      var contentText = JsonConvert.SerializeObject(data);
      if (idCompanyOld == 0)
        contentText = contentText.Replace("\"id\":{},", "");


      var newCompany =
        idCompanyOld > 0
          ? _bx24.SendCommand("crm.company.update", "", contentText)
          : _bx24.SendCommand("crm.company.add", "", contentText);
      var newCompanyByJson = JsonConvert.DeserializeObject<dynamic>(newCompany);
      int idCompany = idCompanyOld > 0 ? idCompanyOld : Convert.ToInt32(newCompanyByJson.result);

      var idContact = HiddenFieldIdContact.Value != "" ? Convert.ToInt32(HiddenFieldIdContact.Value) : 0;

      if (idCompany == 0)
      {
        AddCommentToElement(idCompany, "Компания создана в КЦ Wilstream", "company");
        Log.Info($"New IdCompany = {idCompany}");
        Response.Redirect($"~/{RedirectUrl}?IdContact={idContact}");
        Response.End();
      }
      else
      {
        AddCommentToElement(idCompany, "Компания обновлена в КЦ Wilstream", "company");
        Log.Info($"Redirect after update IdContact = {idContact}");
        Response.Redirect($"~/{RedirectUrl}?IdContact={idContact}");
        Response.End();
      }
    }
    catch (Exception)
    {
      Response.Write("Ошибка сохранения компании.");
    }
  }

  #endregion
}

public class FieldSettings
{
  public int? Position { get; set; }
  public string Alias { get; internal set; }
  public string PreTitle { get; internal set; }
  public bool Readonly { get; internal set; }
  public bool IsRequired { get; internal set; }
}