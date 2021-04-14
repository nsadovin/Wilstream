using log4net;
using log4net.Config;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ruscs : System.Web.UI.Page
{
    Bitrix24 BX24;
    Int32 IdLead = 0;
    Int32 IdTask = 0;
    Int32 IdDeal = 0;
    string Phone = "";

    private static ILog log = LogManager.GetLogger("LOGGER");


    public List<int> FilterUserFields = new List<int>() { 763};


    public List<int> FilterDealFields = null;//new List<int>() {533, 643, 1913, 1859 , 1591,  1869};


    protected void Page_Init(object sender, EventArgs e)
    {
        XmlConfigurator.Configure();

        PanelSMS.Visible = false;
        if (Request.QueryString["IdLead"] != null)
        {
            IdLead = Convert.ToInt32(Request.QueryString["IdLead"]);
            PanelSMS.Visible = true;
            log.Info(String.Format("IdLead = {0}", IdLead));
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

        BX24 = new Bitrix24(HttpContext.Current, "local.5f5152a38ec396.58226980", "2ewCV2mY2QVcQFuHiTWIhCMBi3L74xt1E4UEUS0WByjidoLUsy", "https://ruscs.bitrix24.ru", "https://oauth.bitrix.info", "mail@ruscs.ru", "qwerty15986");



        if (!IsPostBack)
        {
            Session.Contents["productrows"] = null;
            Session.Contents["productsearch"] = null;
            Session.Contents["companysearch"] = null;
            Session.Contents["company"] = null;
        }

        

        string LeadStatusListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=STATUS", "", "GET");
        var StatusList = JsonConvert.DeserializeObject<dynamic>(LeadStatusListByJSON);
        foreach (var status in StatusList.result)
            DropDownListLeadSTATUS_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));
        if(DropDownListLeadSTATUS_ID.SelectedIndex<1)
        DropDownListLeadSTATUS_ID.SelectedValue = "115";


         
 


        string LeadSourceListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=SOURCE", "", "GET");
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
        var userSearchListJson = BX24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE", JsonConvert.SerializeObject(dataListUsers), "POST");
        var UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
        var it = 0;
        DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
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
                users.Add(new KeyValuePair<string, string>(user.LAST_NAME.ToString() + " " + user.NAME.ToString(), user.ID.ToString()));
            if (UserSearchList.next != null)
            {
                userSearchListJson = BX24.SendCommand("user.search", "FILTER[ACTIVE]=TRUE&start=" + UserSearchList.next.ToString(), JsonConvert.SerializeObject(dataListUsers), "POST");
                UserSearchList = JsonConvert.DeserializeObject<dynamic>(userSearchListJson);
            }
            else break;

        }
        foreach (var user in users.OrderBy(r => r.Key))
        {
            DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListTASK_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListDEAL_ASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListTASK_AUDITOR_1.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListTASK_AUDITOR_2.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListTASK_AUDITOR_3.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListTASK_AUDITOR_4.Items.Add(new ListItem(user.Key, user.Value));
            DropDownListTASK_AUDITOR_5.Items.Add(new ListItem(user.Key, user.Value));
        }

        //doTaskCreate();


        //doDealCreateOrUpdate();

        //return;
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
                TableLead.Rows.Add(tr);
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
            {
                var ddl = new TextBox() { ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control" };
                tc2.Controls.Add(ddl);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableLead.Rows.Add(tr);
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
            {
                var ddl = new CheckBox() { ID = "CheckBoxUserfield" + uf.ID, CssClass = "form-control" };
                tc2.Controls.Add(ddl);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableLead.Rows.Add(tr);
            }
        }

        if (IdLead == 0 && Phone != "")
            {
            IdLead = getIdLeadByPhone(Phone);
             
            try
            {
                if (IdLead > 0)
                {
                     
                    var Lead = BX24.SendCommand("crm.lead.get", "ID=" + IdLead, "", "GET");
                    var LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
                    PanelSMS.Visible = true;
                }
            }
            catch (Exception ex) {
                var r = ex; 
                log.Error(ex);
            }
        }



        if (IdLead > 0)
        {
            string Lead = "";
            dynamic LeadByJSON = new {  };
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
                        Response.Write("Ошибка в запросе. Возможно лид "+ IdLead + " был удален из CRM системы");
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
                    var TextBox = new TextBox() { CssClass = "form-control" , ID = "TextBoxLeadPHONE"+ phone.ID, Text = phone.VALUE };
                    var HiddenField = new HiddenField() {   ID = "HiddenFieldLeadPHONE" + phone.ID, Value = phone.ID };
                    var DropDownListLeadPHONE = new DropDownList() { ID = "DropDownListLeadPHONE" + phone.ID, CssClass = "form-control"  };
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
                var row =  new TableRow() { };
                var cell =  new TableCell() { };
                var cell2 = new TableCell() { };
                var TextBox = new TextBox() { CssClass = "form-control" , ID = "TextBoxLeadPHONE"};
                var DropDownListLeadPHONE = new DropDownList() { ID = "DropDownListLeadPHONE", CssClass = "form-control" };
                DropDownListLeadPHONE.Items.AddRange(
                    BX24.PhoneTypes.Select(r => new ListItem(r.Value, r.Key)).ToArray());
                var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadPHONE", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadPHONE" , ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic };
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
                var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadEMAIL", ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic , Enabled = false};
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
                    var ddl = FindControl( "TextBoxUserfield" + uf.ID) as TextBox;
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
                var RequiredFieldValidator = new RequiredFieldValidator() { ID = "RequiredFieldValidatorTextBoxLeadEMAIL", ValidationGroup = "Lead", ControlToValidate = "TextBoxLeadEMAIL", ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле", Display = ValidatorDisplay.Dynamic , Enabled = false};
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

        //string LeadListByJSON = BX24.SendCommand("crm.lead.list", "", "", "GET");
        //string LeadListByJSON = BX24.SendCommand("crm.lead.add", "", contentText, "POST");

        // string UFListByJSON = BX24.SendCommand("crm.lead.userfield.list", "", "", "POST");
        //string LeadProductListByJSON = BX24.SendCommand("crm.lead.productrows.get", "id=", "", "GET");


    }


    protected void Page_Load(object sender, EventArgs e)
    {

    }


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
                {  "SECOND_NAME" , TextBoxLeadSECOND_NAME.Text },
               {"ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text },
                {  "LAST_NAME" , TextBoxLeadLAST_NAME.Text },
                {  "STATUS_ID" , DropDownListLeadSTATUS_ID.SelectedValue },
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
                {  "SECOND_NAME" , TextBoxLeadSECOND_NAME.Text },
                    { "ADDRESS_CITY", TextBoxLeadADDRESS_CITY.Text },
                {  "LAST_NAME" , TextBoxLeadLAST_NAME.Text },
                {  "STATUS_ID" , DropDownListLeadSTATUS_ID.SelectedValue },
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

            if (IdLeadOld == 0)
            {
                AddCommentToLead(IdLead, "Лид создан в КЦ Wilstream");
                log.Info(String.Format("New IdLead = {0}", IdLead));
                Response.Redirect("~/Ruscs.aspx?IdLead=" + IdLead);
                Response.End();
            }
            else
            {
                AddCommentToLead(IdLead, "Лид обновлен в КЦ Wilstream");
                log.Info(String.Format("Redirect after update IdLead = {0}", IdLead));
                Response.Redirect("~/Ruscs.aspx?IdLead=" + IdLead);
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

    protected void ButtonSaveOrUpdateTask_Click(object sender, EventArgs e)
    {
        addTask();
    }


    public void addTask()
    {
        List<int> auditors = new List<int>();
        if (DropDownListTASK_AUDITOR_1.SelectedValue != "") auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_1.SelectedValue));
        if (DropDownListTASK_AUDITOR_2.SelectedValue != "") auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_2.SelectedValue));
        if (DropDownListTASK_AUDITOR_3.SelectedValue != "") auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_3.SelectedValue));
        if (DropDownListTASK_AUDITOR_4.SelectedValue != "") auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_4.SelectedValue));
        if (DropDownListTASK_AUDITOR_5.SelectedValue != "") auditors.Add(Convert.ToInt32(DropDownListTASK_AUDITOR_5.SelectedValue));
        var data =
        new
        {
            fields = new Dictionary<string, object>()
              {

                  { "TITLE" , TextBoxTASK_TITLE.Text },
                  { "DESCRIPTION" , TextBoxTASK_DESCRIPTION.Text },
                  { "RESPONSIBLE_ID" , DropDownListTASK_ASSIGNED_BY_ID.SelectedValue },
                  { "AUDITORS" , auditors.ToArray()},
                  { "DEADLINE" , TextBoxTASK_DEADLINE.Text },
                  { "UF_CRM_TASK" , new string[] {"CO_"+HiddenFieldTASK_UF_CRM_TASK.Value.Replace("CO_","") } }

            }
        }; 
        var contentText = JsonConvert.SerializeObject(data);

        var Task = Request.QueryString["IdTask"] != null ? BX24.SendCommand("tasks.task.update", "taskId=" + Request.QueryString["IdTask"].ToString(), contentText, "POST"): BX24.SendCommand("tasks.task.add", "", contentText, "POST");
        var TaskByJSON = JsonConvert.DeserializeObject<dynamic>(Task); 
        Int32 IdTask =   Convert.ToInt32(TaskByJSON.result.task.id);

        Response.Redirect("~/Dcoffee.aspx?IdTask=" + IdTask);
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
            @params = new { REGISTER_SONET_EVENT = "Y" }
        }; 

        var contentTextCompany = JsonConvert.SerializeObject(dataCompany);
        contentTextCompany = contentTextCompany.Replace("TITLE", "%TITLE");
        string CompanyListByJSON = BX24.SendCommand("crm.company.list", "", contentTextCompany, "POST");
        var CompanyList = JsonConvert.DeserializeObject<dynamic>(CompanyListByJSON);
        foreach (var company in CompanyList.result)
        { 
            if(company.TITLE.ToString().Contains(TextBoxNameCompany.Text))
            BX24.CompanySeacrh.Add(new Bitrix24.COMPANY()
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
            @params = new { REGISTER_SONET_EVENT = "Y" }
        };

        contentTextCompany = JsonConvert.SerializeObject(dataCompanyByAddress);
        contentTextCompany = contentTextCompany.Replace("ADDRESS", "%ADDRESS");
        CompanyListByJSON = BX24.SendCommand("crm.company.list", "", contentTextCompany, "POST");
        var CompanyByAddressList = JsonConvert.DeserializeObject<dynamic>(CompanyListByJSON);
        foreach (var company in CompanyByAddressList.result)
        {
            if (company.TITLE.ToString().Contains(TextBoxNameCompany.Text))
                BX24.CompanySeacrh.Add(new Bitrix24.COMPANY()
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
            ResultSeacrh = ((List<Bitrix24.COMPANY>)Session.Contents["companysearch"]).OrderBy(r=>r.TITLE).ToList();

        if (Result == null)
        {
            Result = ResultSeacrh[GridViewCompanySearch.SelectedIndex]; 
        }
        LabelTASK_UF_CRM_TASK.Text = String.Format("({0}) {1}", Result.ID, Result.TITLE);
        HiddenFieldTASK_UF_CRM_TASK.Value =   Result.ID.ToString();
        Session.Contents["company"] = Result;
        GridViewLeadProducts.DataBind();

    }


    protected void LinqDataSourceCompamies_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        var Result = new List<Bitrix24.COMPANY>();
        if (Session.Contents["companysearch"] != null)
            Result = (List<Bitrix24.COMPANY>)Session.Contents["companysearch"];
        if (BX24.CompanySeacrh.Count > 0)
            Result = BX24.CompanySeacrh;
        Session.Contents["companysearch"] = Result;
        e.Result = Result;

    }

    private void doDealCreateOrUpdate()
    {
        createUserFields();



        if (Request.QueryString["IdDeal"] != null)
        {
            IdDeal = Convert.ToInt32(Request.QueryString["IdDeal"]);
            log.Info(String.Format("IdDeal = {0}", IdDeal));

            HiddenFieldIdDeal.Value = IdDeal.ToString();


            var Deal = BX24.SendCommand("crm.deal.get", "id=" + IdDeal, "", "POST");
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
                LabelDEAL_ContactInfoPhone.Text =  phones;
            }

            TextBoxDEAL_BEGINDATE.Text = DealByJSON.result.BEGINDATE;
            TextBoxDEAL_COMMENTS.Text = DealByJSON.result.COMMENTS;

            string leadStatusListByJSON = BX24.SendCommand("crm.dealcategory.stage.list", "id="+ DealByJSON.result.CATEGORY_ID, "", "GET");
            var statusList = JsonConvert.DeserializeObject<dynamic>(leadStatusListByJSON);
            foreach (var status in statusList.result)
                DropDownListDEAL_STAGE_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));



            DropDownListDEAL_STAGE_ID.SelectedValue = DealByJSON.result.STAGE_ID;
            LabelNameDeal.Text = String.Format("Сделка №{0}", DealByJSON.result.ID); 

            fillUserFields(DealByJSON);
        }
        else
        { 
        }
    }

    private void fillUserFields(dynamic DealByJSON)
    {  
        BX24.FilterDealFields = FilterDealFields; 
        var fields = BX24.DealFields.ToList();
        foreach (var uf in fields)
        { 
            if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
            {
                if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
                {
                    var CheckBoxListUF = FindControl("CheckBoxListUserfield" + uf.ID) as CheckBoxList;
                    foreach (Newtonsoft.Json.Linq.JProperty item in DealByJSON.result)
                    {
                        if (item.Name == uf.FIELD_NAME) //property name
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
                    foreach (Newtonsoft.Json.Linq.JProperty item in DealByJSON.result)
                    {
                        if (item.Name == uf.FIELD_NAME && item.Value.ToString()!="") //property name
                            DropDownListUF.SelectedValue = item.Value.ToString();
                    }
                }
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
            {
                var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
                foreach (Newtonsoft.Json.Linq.JProperty item in DealByJSON.result)
                {
                    if (item.Name == uf.FIELD_NAME) //property name
                        ddl.Text = item.Value.ToString();
                }
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
            {
                var ddl = FindControl("TextBoxUserfield" + uf.ID) as TextBox;
                var ddl2 = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
                foreach (Newtonsoft.Json.Linq.JProperty item in DealByJSON.result)
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
                foreach (Newtonsoft.Json.Linq.JProperty item in DealByJSON.result)
                {
                    if (item.Name == uf.FIELD_NAME) //property name
                        ddl.Checked = item.Value.ToString() == "1";
                }
            }
        }
    }

    private void createUserFields()
    {
        int i = 7;
        BX24.FilterDealFields = FilterDealFields;
        var fields = BX24.DealFields.ToList();  
        foreach (var uf in fields)
        { 
            var tr = new TableRow() {ID = "TableRow" + uf.ID};
            var tc1 = new TableCell() {ID = "TableCellLabel" + uf.ID, Text = uf.NAME};
            var tc2 = new TableCell() {ID = "TableCellUserfield" + uf.ID};
            if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
            {
                if (uf.MULTIPLE == Bitrix24.MULTIPLE.Y)
                {
                    var cbl = new CheckBoxList() {ID = "CheckBoxListUserfield" + uf.ID, RepeatColumns = 3};
                    foreach (var item in uf.LIST)
                        cbl.Items.Add(new ListItem() {Text = item.VALUE, Value = item.ID.ToString()});
                    tc2.Controls.Add(cbl);
                }
                else
                {
                    var ddl = new DropDownList() {ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control"};
                    ddl.Items.Add(new ListItem("-----", ""));
                    foreach (var item in uf.LIST)
                        ddl.Items.Add(new ListItem() {Text = item.VALUE, Value = item.ID.ToString()});
                    tc2.Controls.Add(ddl);
                }

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableDeal.Rows.AddAt(i++,tr);
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
            {
                var ddl = new TextBox() {ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control"};
                tc2.Controls.Add(ddl);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableDeal.Rows.AddAt(i++, tr);
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.money)
            {
                var ddl = new TextBox() {ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control"};
                tc2.Controls.Add(ddl);
                var ddl2 = new DropDownList() { ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control" };
                ddl2.Items.Add(new ListItem() { Value = "RUB", Text = "Рубль" });
                ddl2.Items.Add(new ListItem() { Value = "USD", Text = "Доллар США" });
                tc2.Controls.Add(ddl2);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableDeal.Rows.AddAt(i++, tr);
            }
            else if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.boolean)
            {
                var ddl = new CheckBox() {ID = "CheckBoxUserfield" + uf.ID, CssClass = "form-control"};
                tc2.Controls.Add(ddl);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableDeal.Rows.AddAt(i++, tr);
            }
        }
    }

    private void doTaskCreate()
    {

        if (Request.QueryString["IdTask"] != null)
        {
            IdTask = Convert.ToInt32(Request.QueryString["IdTask"]);
            log.Info(String.Format("IdTask = {0}", IdTask));



            var Task = BX24.SendCommand("tasks.task.get", "taskId=" + IdTask, "", "POST");
            var TaskByJSON = JsonConvert.DeserializeObject<dynamic>(Task);
            TextBoxTASK_TITLE.Text = TaskByJSON.result.task.title;
            TextBoxTASK_DESCRIPTION.Text = TaskByJSON.result.task.description;
            DropDownListTASK_ASSIGNED_BY_ID.SelectedValue = TaskByJSON.result.task.responsibleId;
            int i = 1;
            if (TaskByJSON.result.task.auditors != null)
                foreach (int auditor in TaskByJSON.result.task.auditors)
                {
                    switch (i)
                    {
                        case 1: DropDownListTASK_AUDITOR_1.SelectedValue = auditor.ToString(); break;
                        case 2: DropDownListTASK_AUDITOR_2.SelectedValue = auditor.ToString(); break;
                        case 3: DropDownListTASK_AUDITOR_3.SelectedValue = auditor.ToString(); break;
                        case 4: DropDownListTASK_AUDITOR_4.SelectedValue = auditor.ToString(); break;
                        case 5: DropDownListTASK_AUDITOR_5.SelectedValue = auditor.ToString(); break;
                    }
                    i++;
                };
            TextBoxTASK_DEADLINE.Text = TaskByJSON.result.task.deadline;
            if (TaskByJSON.result.task.ufCrmTask.Count > 0)
            {
                LabelTASK_UF_CRM_TASK.Text = String.Format("({0}) {1}", TaskByJSON.result.task.ufCrmTask[0], "");
                HiddenFieldTASK_UF_CRM_TASK.Value = TaskByJSON.result.task.ufCrmTask[0];
            }
            LabelNameTask.Text = String.Format("Задача №{0}", TaskByJSON.result.task.id);
        }
        else
        { 
            TextBoxTASK_TITLE.Text = String.Format("{0}, ", DateTime.Now);
            if (Request.QueryString["Phone"] != null)
            {
                Phone = Request.QueryString["Phone"].ToString();
                log.Info(String.Format("Phone = {0}", Phone));
                TextBoxTASK_DESCRIPTION.Text = String.Format("Телефон: {0}{1}",  Phone, Environment.NewLine);
            }
            else
            {
               
            }
        }
    }

    protected void ButtonSaveOrUpdateDeal_OnClick(object sender, EventArgs e)
    {
            
        
            var data =
            new
            {
                id = (Object)HiddenFieldIdDeal.Value,
                fields = new Dictionary<string, object>()
                { 
                    { "TITLE" , TextBoxDEAL_TITLE.Text }, 
                    { "ASSIGNED_BY_ID" , DropDownListDEAL_ASSIGNED_BY_ID.SelectedValue }, 
                    { "OPPORTUNITY" , TextBoxDEAL_OPPORTUNITY.Text },
                    { "CURRENCY_ID" , DropDownListDEAL_CURRENCY_ID.SelectedValue },
                    { "STAGE_ID" , DropDownListDEAL_STAGE_ID.SelectedValue },
                    { "BEGINDATE" , TextBoxDEAL_BEGINDATE.Text },
                    { "COMMENTS" , TextBoxDEAL_COMMENTS.Text }, 
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

            if (!String.IsNullOrEmpty(HiddenFieldDEAL_CONTACT_ID.Value) != null)
            {
                var dataContact =
                    new
                    {
                        id = (Object)HiddenFieldDEAL_CONTACT_ID.Value,
                        fields = new Dictionary<string, object>()
                        {
                            { "NAME" , TextBoxDEAL_ContactInfoName.Text }, 
                        }
                    };

                var contentContactText = JsonConvert.SerializeObject(dataContact);
                var contact = BX24.SendCommand("crm.contact.update", "", contentContactText, "POST");
                var contactByJSON = JsonConvert.DeserializeObject<dynamic>(contact);
                  
            }
             



        var contentText = JsonConvert.SerializeObject(data);

        var Deal = Request.QueryString["IdDeal"] != null ? BX24.SendCommand("crm.deal.update", "", contentText, "POST") 
            : BX24.SendCommand("crm.deal.add", "", contentText, "POST");
        var DealByJSON = JsonConvert.DeserializeObject<dynamic>(Deal);
         
        Response.Redirect("~/Modultron.aspx?IdDeal=" + HiddenFieldIdDeal.Value);
        Response.End();
    }
}