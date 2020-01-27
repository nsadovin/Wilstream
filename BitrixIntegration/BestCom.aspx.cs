using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BestCom : System.Web.UI.Page
{
    Bitrix24 BX24;
    Int32 IdLead = 0;
    string Phone = "";




    public List<int> FilterUserFields =  new List<int>();


    protected void Page_Init(object sender, EventArgs e)
    {
        if (Request.QueryString["IdLead"] != null)
            IdLead = Convert.ToInt32(Request.QueryString["IdLead"]);

        if (Request.QueryString["Phone"] != null)
        {
            Phone = Request.QueryString["Phone"].ToString();
        }
        if (Request.QueryString["AbonentNumber"] != null)
        {
            Phone = Request.QueryString["AbonentNumber"].ToString();
        }
        
        BX24 = new Bitrix24(HttpContext.Current, "local.5e2197fe17aad4.81768834", "YMHv21gyMTwYjtPnkABt29UHpKvXsGLdPrZh2oGSKQQh7VAXJZ", "https://bestcom.bitrix24.ru", "https://oauth.bitrix.info", "willstream@bestcom.moscow", "Cde3Cde3");
     


        if (!IsPostBack)
        {
            Session.Contents["productrows"] = null;
            Session.Contents["productsearch"] = null;            
        }


        string LeadStatusListByJSON = BX24.SendCommand("crm.status.list", "FILTER[ENTITY_ID]=STATUS", "", "GET");
        var StatusList = JsonConvert.DeserializeObject<dynamic>(LeadStatusListByJSON);
        foreach (var status in StatusList.result)
            DropDownListLeadSTATUS_ID.Items.Add(new ListItem(status.NAME.ToString(), status.STATUS_ID.ToString()));

        //DropDownListLeadSTATUS_ID.SelectedValue = "5";

        

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
        var it  = 0;
        DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem("-----", ""));
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
                DropDownListLeadASSIGNED_BY_ID.Items.Add(new ListItem(user.Key, user.Value));

        BX24.FilterUserFields = FilterUserFields;
        foreach (var uf in BX24.Userfields)
        {
            var tr = new TableRow() { ID = "TableRow" + uf.ID };
            var tc1 = new TableCell() { ID = "TableCellLabel" + uf.ID, Text = uf.NAME };
            var tc2 = new TableCell() { ID = "TableCellUserfield" + uf.ID };
            if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
            {
                var ddl = new DropDownList() { ID = "DropDownListUserfield" + uf.ID, CssClass = "form-control" };
                ddl.Items.Add(new ListItem("-----", ""));
                foreach (var item in uf.LIST)
                    ddl.Items.Add(new ListItem() { Text = item.VALUE, Value = item.ID.ToString() });
                tc2.Controls.Add(ddl);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableLead.Rows.Add(tr);
            }
            else  if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.@string)
            {
                var ddl = new TextBox() { ID = "TextBoxUserfield" + uf.ID, CssClass = "form-control" };                 
                tc2.Controls.Add(ddl);

                tr.Cells.Add(tc1);
                tr.Cells.Add(tc2);
                TableLead.Rows.Add(tr);
            }
        }

        if (IdLead == 0 && Phone != "")
            {
            var dataListLids = new
            {
                sort = new { ID = "desc" }
            };

            string Lead = "";
            dynamic LeadByJSON = new { };

            string Leads = BX24.SendCommand("crm.lead.list", "FILTER[PHONE]=" + Phone + "&ORDER[ID]=DESC", JsonConvert.SerializeObject(dataListLids), "POST");
            var LeadsJSON = JsonConvert.DeserializeObject<dynamic>(Leads);
            if (LeadsJSON.total > 0)
            {
                Lead = BX24.SendCommand("crm.lead.get", "ID=" + LeadsJSON.result[0].ID, "", "GET");
                LeadByJSON = JsonConvert.DeserializeObject<dynamic>(Lead);
                IdLead = (int)LeadsJSON.result[0].ID;
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
                }
                catch (WebException wex)
                { 
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
            //DropDownListLeadSTATUS_ID.SelectedValue = LeadByJSON.result.STATUS_ID; 
            if (LeadByJSON.result.PHONE != null)
            {
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
            DropDownListLeadSOURCE_ID.SelectedValue = LeadByJSON.result.SOURCE_ID;
            CheckBoxLeadOPENED.Checked = LeadByJSON.result.OPENED == "1";
            TextBoxLeadCOMMENTS.Text = LeadByJSON.result.COMMENTS;
            DropDownListLeadASSIGNED_BY_ID.SelectedValue = LeadByJSON.result.ASSIGNED_BY_ID;
            Type t = LeadByJSON.result.GetType();

            BX24.FilterUserFields = FilterUserFields;

            foreach (var uf in BX24.Userfields)
            {
                if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
                {
                    var DropDownListUF = FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
                    foreach (Newtonsoft.Json.Linq.JProperty item in LeadByJSON.result)
                    {
                        if (item.Name == uf.FIELD_NAME)//property name
                            DropDownListUF.SelectedValue = item.Value.ToString();
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
            ButtonSaveLead.Text = "Обновить лид";
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

        //string LeadListByJSON = BX24.SendCommand("crm.lead.list", "", "", "GET");
        //string LeadListByJSON = BX24.SendCommand("crm.lead.add", "", contentText, "POST");

        // string UFListByJSON = BX24.SendCommand("crm.lead.userfield.list", "", "", "POST");
        //string LeadProductListByJSON = BX24.SendCommand("crm.lead.productrows.get", "id=", "", "GET");


    }
    protected void Page_Load(object sender, EventArgs e)
    {

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
                {  "OPENED" , CheckBoxLeadOPENED.Checked?"1":"0" },
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
                {  "OPENED" , CheckBoxLeadOPENED.Checked?"1":"0" },
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
            Type t = data.fields.GetType();
            BX24.FilterUserFields = FilterUserFields;
            foreach (var uf in BX24.Userfields)
            {
                if (uf.USER_TYPE_ID == Bitrix24.USER_TYPE_ID.enumeration)
                {
                    var ddl = Page.FindControl("DropDownListUserfield" + uf.ID) as DropDownList;
                    if (ddl != null)
                    {
                        data.fields.Add(uf.FIELD_NAME, ddl.SelectedValue);
                        //t.GetProperty(uf.FIELD_NAME).SetValue(data.fields, ddl.SelectedValue);
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
                Response.Redirect("~/BestComm.aspx?IdLead=" + IdLead);
                Response.End();
            }
            else {
                LabelMSG.Visible = true;
                LabelMSG.Text = "Данные по лиду обновлены";
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
}