﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.Service;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;
public partial class _Default : System.Web.UI.Page
{
    private static readonly AmoCrmConfig Config = new AmoCrmConfig("gvg", "dl@gvg.ru", "5d9f21a8823fc059b2785f89c7c1c938",10);


    private readonly IAmoCrmService _service = new AmoCrmService(Config);

    private List<Int64> LeadFields = new List<Int64>() { 1923194, 1961779, 1970719, 1970729 };
    private List<Int64> ContactFields = new List<Int64>() { 1896658, 1896660, 1896662 };
    private Dictionary<Int64, String> PipelinesStatus = new Dictionary<Int64, String>() { 
        {17968951, "не целевой УДАЛИТЬ"}, 
        {19304602, "аренда офиса до 100 м2" }, 
        {18369013, "НЕ УДАЛОСЬ СОЕДИНИТЬ, ОЖИДАЕТ ЗВОНКА" }, 
        {14341525, "ОФИСЫ БОЛЕЕ 100 м2 , звонок перевели, <br/>перед нажатием этой кнопки указать на кого перевели " }, 
        {16370356, "СКЛАД ЗВОНОК ПЕРЕВЕЛИ, перед нажатием <br/> этой кнопки указать на кого перевели" }, 
        {19327084, "ПОД КОФЕ" }};
    protected void Page_Init(object sender, EventArgs e)
    {
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();

        var phone = Request.QueryString["phone"] != null ? Request.QueryString["phone"].ToString() : "";
        if (phone=="")
            phone = Request.QueryString["anumber"] != null ? Request.QueryString["anumber"].ToString() : "";

        if (phone.Length > 10)
            phone = phone.Substring(phone.Length - 10, 10);

        var lead = _service.GetLeads(phone).OrderByDescending(r => r.DateCreate).FirstOrDefault();

        //lead = _service.GetLead(lead.Id);


        if (lead != null)
        {
            HiddenFieldLeadJson.Value = JsonConvert.SerializeObject(lead);

            PanelPipeLine.Visible = true;
            LabelLeadId.Text = lead.Id.ToString();

            var contact = lead.MainContactId != null ? _service.GetContact(lead.MainContactId) : null;

            {
                foreach (var pipeline in PipelinesStatus)
                {
                    var lb = new LinkButton()
                    {
                        ID = "LinkButtonPipeLine" + pipeline.Key.ToString(),
                        Text = pipeline.Value,
                        CssClass = "btn btn-outline-info btn-lg",
                        CommandArgument = pipeline.Key.ToString()
                    };
                    lb.Attributes["style"] = "margin-right: 10px;margin-bottom: 10px; height: 80px;";
                    lb.Click += lb_Click;
                    PanelPipeLineButtons.Controls.Add(lb);
                }
            }

            if (contact != null)
            {
                PanelMainContact.Visible = true;
                TextBoxMainContactName.Text = contact.Name;
                foreach (var ContactField in contact_fields.Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id)).ToList())
                {
                    TableMainContact.Rows.Add(CreateRowForCustomField(TypeField.Lead, "MainContact", contact.CustomFields, ContactField));
                }
            }
            var countContact = 0;
            foreach (var contact_id in lead.Contacts.Ids)
            {
                if (contact_id != lead.MainContactId)
                {
                    countContact++;
                    var _contact = _service.GetContact(contact_id);
                    CreateTableContact(countContact, contact_id, _contact.Name, _contact.CustomFields);
                    if (Session.Contents["TableContact"] != null)
                    {
                        var tables = (Session.Contents["TableContact"] as Dictionary<string, Table>);
                        if (tables.ContainsKey("TableContact" + countContact))
                            tables.Remove("TableContact" + countContact);
                        Session.Contents["TableContact"] = tables;
                    }
                }
            }

            if (Session.Contents["TableContact"] != null)
                foreach (var item in (Session.Contents["TableContact"] as Dictionary<string, Table>))
                {
                    PanelContacts.Controls.Add(item.Value);
                }

            PanelInfoLead.Visible = true;
            TextBoxLeadName.Text = lead.Name;
            TextBoxDateCreate.Text = lead.DateCreate.ToString();
            //DropDownListResponsibleUsers.Items.Add(new ListItem() { Value = "", Text = "-----" });
            foreach (var option in users)
            {
                DropDownListResponsibleUsers.Items.Add(new ListItem() { Value = option.Id.ToString(), Text = option.Name });
            };
            if (DropDownListResponsibleUsers.Items.FindByValue(lead.ResponsibleUserId.ToString()) != null)
                DropDownListResponsibleUsers.SelectedValue = lead.ResponsibleUserId.ToString();

            foreach (var LeadField in lead_fields.Where(r => LeadFields.Count == 0 || LeadFields.Contains(r.Id)).ToList())
            {
                TableLead.Rows.Add(CreateRowForCustomField(TypeField.Lead, "Lead", lead.CustomFields, LeadField));
            };

        }
        else {
            Response.Write("Лид с номером "+ phone + " не найден");
            Response.End();
        }
    }

    private void lb_Click(object sender, EventArgs e)
    {
        var lb = sender as LinkButton;
        var request = new AddOrUpdateLeadRequest();
        CrmLead crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        var lead = new AddOrUpdateCrmLead();
        lead.Id = crmLead.Id;
        lead.Name = TextBoxLeadName.Text;
        lead.ResponsibleUserId = Convert.ToInt64(DropDownListResponsibleUsers.SelectedValue);
        lead.DateCreateTimestamp = crmLead.DateCreateTimestamp;
        lead.Tags = String.Join(",", crmLead.Tags);
        lead.StatusId = lb.CommandArgument;         
        lead.CustomFields = GetCustomFieldsValues<AddLeadCustomField>(TypeField.Lead, "Lead");
        request.Update = new List<AddOrUpdateCrmLead>();
        request.Update.Add(lead);
        _service.AddOrUpdateLead(request);
        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Установлен статус "+lb.Text;

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack){
            
        };
         
    }

    private TableRow CreateRowForCustomField(TypeField typeField, string group , List<CrmCustomField> valueFields, CustomFieldDto Field)
    {
        var tr = new TableRow() { ID = "TableRow" + group + Field.Id };
        var tcName = new TableCell() { ID = "TableCellName" + group + Field.Id };
        var labelName = new Label() { ID = "LabelFieldName" + group + Field.Id, Text = Field.Name 
        //    + "_" + Field.TypeId   
        };
        tcName.Controls.Add(labelName);
        tr.Cells.Add(tcName);
        var tcValue = new TableCell() { ID = "TableCellValue" + group + Field.Id };
        var hfIdField = new HiddenField() { ID = "HiddenFieldIdField" + group + Field.Id, Value = Field.Id.ToString() };
        tcValue.Controls.Add(hfIdField);
        var hfGroup = new HiddenField() { ID = "HiddenFieldGroupField" + group + Field.Id, Value = group };
        tcValue.Controls.Add(hfGroup);
        var hfTypeField = new HiddenField() { ID = "HiddenFieldTypeField" + group + Field.Id, Value = Field.TypeId.ToString() };
        tcValue.Controls.Add(hfTypeField);

        switch (Field.TypeId)
        {
            case 5:
                {
                    var selectValue = new CheckBoxList() { ID = "CheckBoxListFieldValue" + group + Field.Id };
                    var enums = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                    foreach (var option in enums)
                    {
                        selectValue.Items.Add(new ListItem() { Value = option.Key.ToString(), Text = option.Value });
                    };
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    if (selectedValue != null)
                    {
                        foreach (var _val in selectedValue.Values)
                        {
                            var option = selectValue.Items.FindByValue(_val.Enum);
                            if (option != null)
                                option.Selected = true;
                        }
                    };
                    tcValue.Controls.Add(selectValue);
                }
                break;
            case 4:
                {
                    var selectValue = new DropDownList() { ID = "DropDownListFieldValue" + group + Field.Id, CssClass = "form-control" };
                    var enums = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                    selectValue.Items.Add(new ListItem() { Value = "", Text = "-----" });
                    foreach (var option in enums)
                    {
                        selectValue.Items.Add(new ListItem() { Value = option.Key.ToString(), Text = option.Value });
                    };
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    if (selectedValue != null && selectValue.Items.FindByValue(selectedValue.Values.FirstOrDefault().Enum) != null)
                    {
                        selectValue.SelectedValue = selectedValue.Values.FirstOrDefault().Enum;
                    };
                    tcValue.Controls.Add(selectValue);
                }
                break;
            case 2:
                {
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    var val = selectedValue != null && selectedValue.Values != null && selectedValue.Values.FirstOrDefault() != null ? selectedValue.Values.FirstOrDefault().Value : "";
                    var numValue = new TextBox() { ID = "TextBoxFieldValue" + group + Field.Id, Text = val, TextMode = TextBoxMode.Number, CssClass = "form-control" };
                    tcValue.Controls.Add(numValue);
                }
                break;
            case 1:
                {
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    var val = selectedValue!=null&&selectedValue.Values != null && selectedValue.Values.FirstOrDefault() != null ? selectedValue.Values.FirstOrDefault().Value : "";
                    var numValue = new TextBox() { ID = "TextBoxFieldValue" + group + Field.Id, Text = val, TextMode = TextBoxMode.SingleLine, CssClass = "form-control" };
                    tcValue.Controls.Add(numValue);
                }
                break;
            case 3:
                {
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    var val = selectedValue != null && selectedValue.Values != null && selectedValue.Values.FirstOrDefault() != null ? selectedValue.Values.FirstOrDefault().Value : "";

                    var numValue = new CheckBox() { ID = "CheckBoxFieldValue" + group + Field.Id, Checked = val=="True" };
                    tcValue.Controls.Add(numValue);
                }
                break;
            case 8:
                {
                    if (Session.Contents["MultiFields" + group + Field.Id.ToString()] == null)
                        Session.Contents["MultiFields" + group + Field.Id.ToString()] = new Dictionary<String, Panel>();
                    var sessionFields = (Session.Contents["MultiFields" + group + Field.Id.ToString()] as Dictionary<String, Panel>);

                    var it = 0;
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    var vals = selectedValue != null && selectedValue.Values != null ? selectedValue.Values : new List<CrmCustomFieldValue>();
                    foreach (var val in vals)
                    {
                        var lc = new Panel() { ID = "Panel" + group + Field.Id + it, CssClass = "input-group" };

                        var ddl = new DropDownList() { ID = "DropDownListValue" + group + Field.Id + it, Width = 100, CssClass = "input-group-prepend" };
                        var enums = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                        foreach (var option in enums)
                        {
                            ddl.Items.Add(new ListItem() { Value = option.Key.ToString(), Text = option.Value });
                        };
                        ddl.SelectedValue = val.Enum;
                        lc.Controls.Add(ddl);
                        var numValue = new TextBox() { ID = "TextBoxFieldValue" + group + Field.Id + it, Text = val.Value, CssClass = "form-control" };
                        lc.Controls.Add(numValue);
                        var addValue = new Button() { ID = "ButtonFieldValue" + group + Field.Id + it, Text = "+", CssClass = "input-group-append input-group-text" };

                        addValue.Click += addValue_Click;
                        addValue.CommandArgument = JsonConvert.SerializeObject(Field);
                          
                        lc.Controls.Add(addValue);
                        if (sessionFields.ContainsKey(lc.ID) != null)
                        {
                            sessionFields.Remove(lc.ID);
                        }
                        tcValue.Controls.Add(lc);
                        it++;
                    }
                    foreach (var panel in sessionFields)
                    {
                        tcValue.Controls.Add(panel.Value);
                        it++;
                    }
                    if (it == 0)
                    {
                        var lc = new Panel() { ID = "Panel" + group + Field.Id + it, CssClass = "input-group" };

                        var ddl = new DropDownList() { ID = "DropDownListValue" + group + Field.Id + it, Width = 100, CssClass = "input-group-prepend" };
                        var enums = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                        foreach (var option in enums)
                        {
                            ddl.Items.Add(new ListItem() { Value = option.Key.ToString(), Text = option.Value });
                        }; 
                        ddl.SelectedIndex = 0;
                        lc.Controls.Add(ddl);
                        var numValue = new TextBox() { ID = "TextBoxFieldValue" + group + Field.Id + it, Text = "", CssClass = "form-control" };
                        lc.Controls.Add(numValue); 
                        var addValue = new Button() { ID = "ButtonFieldValue" + group + Field.Id + it, Text = "+", CssClass = "input-group-append input-group-text" };
                        addValue.Click += addValue_Click;
                        lc.Controls.Add(addValue);
                        tcValue.Controls.Add(lc);
                    }
                    Session.Contents["MultiFields" + group + Field.Id.ToString()] = sessionFields;
                }
                break;
            case 9:
                {
                    var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                    var val = selectedValue != null && selectedValue.Values != null && selectedValue.Values.FirstOrDefault() != null ? selectedValue.Values.FirstOrDefault().Value : "";
                    var numValue = new TextBox() { ID = "TextBoxFieldValue" + group + Field.Id, Text = val, TextMode = TextBoxMode.MultiLine, CssClass = "form-control" };
                    tcValue.Controls.Add(numValue);
                }
                break;
        }
        tr.Cells.Add(tcValue);
        return tr;
    }
     

    private void addValue_Click(object sender, EventArgs e)
    {
        var  it = 0;
        TableCell tcValue = ((sender as Button).Parent.Parent as TableCell);
        long IdField = 0;
        long TypeField = 0;
        string group = "";
        foreach (Control c in tcValue.Controls)
        {
            if (c is Panel)
            {
                it++;
            }
            if (c is HiddenField)
            {
                if (c.ID.Contains("HiddenFieldIdField"))
                    IdField = Convert.ToInt64(((HiddenField)c).Value);
                if (c.ID.Contains("HiddenFieldTypeField"))
                    TypeField = Convert.ToInt64(((HiddenField)c).Value);
                if (c.ID.Contains("HiddenFieldGroupField"))
                    group = ((HiddenField)c).Value;
            }
        } 

        var Field = JsonConvert.DeserializeObject<CustomFieldDto>((sender as Button).CommandArgument);

        var lc = new Panel() { ID = "Panel" + group + Field.Id + it, CssClass = "input-group" };

        var ddl = new DropDownList() { ID = "DropDownListValue" + group + Field.Id + it, Width = 100, CssClass = "input-group-prepend" };
        var enums = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
        foreach (var option in enums)
        {
            ddl.Items.Add(new ListItem() { Value = option.Key.ToString(), Text = option.Value });
        };
         
        ddl.SelectedIndex = 0;
        lc.Controls.Add(ddl);
        var numValue = new TextBox() { ID = "TextBoxFieldValue" + group + Field.Id + it, Text = "", CssClass = "form-control" };
        lc.Controls.Add(numValue); 
        var addValue = new Button() { ID = "ButtonFieldValue" + group + Field.Id + it, Text = "+", CssClass = "input-group-append input-group-text" };
        addValue.Click += addValue_Click;
        lc.Controls.Add(addValue);
        if (Session.Contents["MultiFields" + group + Field.Id.ToString()] == null)
            Session.Contents["MultiFields" + group + Field.Id.ToString()] = new Dictionary<String, Panel>();
        (Session.Contents["MultiFields" + group + Field.Id.ToString()] as Dictionary<String, Panel>).Add(lc.ID, lc);
        tcValue.Controls.Add(lc);
    }
    protected void ButtonUpdateLead_Click(object sender, EventArgs e)
    {
        var request = new AddOrUpdateLeadRequest();
        CrmLead crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        var lead = new AddOrUpdateCrmLead();
        lead.Id = crmLead.Id;
        lead.Name = TextBoxLeadName.Text;
        lead.ResponsibleUserId = Convert.ToInt64(DropDownListResponsibleUsers.SelectedValue);
        lead.DateCreateTimestamp = crmLead.DateCreateTimestamp;
        lead.Tags = String.Join(",", crmLead.Tags);      
        lead.StatusId = crmLead.StatusId.ToString();
        lead.CustomFields = GetCustomFieldsValues<AddLeadCustomField>(TypeField.Lead, "Lead");
        request.Update = new List<AddOrUpdateCrmLead>();
        request.Update.Add(lead);
        _service.AddOrUpdateLead(request);
        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Данные по лиду обновлены";
    }

    private List<T> GetCustomFieldsValues<T>(TypeField typeField, string group)  where T: class, IAddCustomField, new()
    {
        var CustomFields = new List<T>();
        var table = (Table)FindControl("Table" + group);
        foreach (TableRow tr in table.Rows)
        {
            Int64 IdField = 0;
            Int64 TypeField = 0;
            foreach (Control c in tr.Cells[1].Controls)
            {
                if (c is HiddenField)
                {
                    if (c.ID.Contains("HiddenFieldIdField"))
                        IdField = Convert.ToInt64(((HiddenField)c).Value);
                    if (c.ID.Contains("HiddenFieldTypeField"))
                        TypeField = Convert.ToInt64(((HiddenField)c).Value);
                }
            }
            if (IdField > 0)
            {
                switch (TypeField)
                {
                    case 4:
                        {
                            var _value = "";
                            foreach (Control c in tr.Cells[1].Controls)
                            {
                                if (c is DropDownList && ((DropDownList)c).SelectedIndex > -1) _value = ((DropDownList)c).SelectedValue;
                            }
                            CustomFields.Add(new T() { Id = IdField, Values = new List<Object> { new AddCustomFieldValues() { Value = _value } } });
                        }
                        break;
                    case 5:
                        {
                            var _values = new List<Object>();

                            foreach (Control c in tr.Cells[1].Controls)
                            {
                                if (c is CheckBoxList)
                                {
                                    foreach (ListItem Item in (c as CheckBoxList).Items)
                                        if (Item.Selected)
                                            _values.Add(Item.Value);
                                }
                            }
                            CustomFields.Add(new T() { Id = IdField, Values = _values });
                        }
                        break;
                    case 8:
                        {
                            
                            foreach (Control c in tr.Cells[1].Controls)
                            {
                                if (c is Panel)
                                {
                                    var _value = "";
                                    var _code = "";
                                    var _panel = ((Panel)c);
                                    foreach (Control cp in _panel.Controls)
                                    {
                                        if (cp is TextBox) _value = ((TextBox)cp).Text;
                                        if (cp is DropDownList) _code = ((DropDownList)cp).SelectedItem.Text;
                                    }
                                    if (_value!="")
                                    CustomFields.Add(new T() { Id = IdField, Values = new List<Object> { new AddCustomFieldValuesEnum() { Value = _value, Enum = _code } } });
                                }
                            } 
                        }
                        break;
                    case 9:
                    case 2:
                    case 1:
                        {
                            var _value = "";
                            foreach (Control c in tr.Cells[1].Controls)
                            {
                                if (c is TextBox) _value = ((TextBox)c).Text;
                            }
                            CustomFields.Add(new T() { Id = IdField, Values = new List<Object> { new AddCustomFieldValues() { Value = _value } } });
                        }
                        break;
                }

            }
        }
        return CustomFields;
    }
    protected void ButtonUpdateMainContact_Click(object sender, EventArgs e)
    {
        var request = new AddOrUpdateContactRequest();
        CrmLead crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        request.Update = new List<AddOrUpdateCrmContact>();
        request.Add = new List<AddOrUpdateCrmContact>();
        {
            var _contact = new AddOrUpdateCrmContact();
            _contact.Id = crmLead.MainContactId;
            _contact.Name = TextBoxMainContactName.Text;
            _contact.CustomFields = GetCustomFieldsValues<AddContactCustomField>(TypeField.Lead, "MainContact");
            request.Update.Add(_contact);
        }

        var countContact = 0;
        //а теперь обойдем дополнительные контакты
        foreach (Control c in PanelContacts.Controls)
        {
            if (c is Table)
            {
                countContact++;
                var tableContact = c as Table;
                if (tableContact.ID != "TableMainContact")
                {
                    var _contact = new AddOrUpdateCrmContact();  
                    foreach (Control cc in tableContact.Rows[1].Cells[1].Controls)
                    {
                        if (cc is TextBox)
                            _contact.Name = (cc as TextBox).Text;
                        if (cc is HiddenField)
                            _contact.Id = Convert.ToInt64((cc as HiddenField).Value);
                    }
                    _contact.LeadsId = crmLead.Id.ToString();
                    _contact.CustomFields = GetCustomFieldsValues<AddContactCustomField>(TypeField.Contact, tableContact.ID.Replace("Table",""));
                    if (_contact.Id != null && _contact.Id>0)
                        request.Update.Add(_contact);
                    else
                        request.Add.Add(_contact);
                }
            }
        }

        _service.AddOrUpdateContact(request);

        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Данные по контактам обновлены";
    }
    protected void ButtonAddContact_Click(object sender, EventArgs e)
    {
        
        var count = 0;
        foreach (Control c in PanelContacts.Controls)
        {
            if (c is Table) count++;
        }
        var table = CreateTableContact(count,0, "", new List<CrmCustomField>());
        if (Session.Contents["TableContact"] == null)
            Session.Contents["TableContact"] = new Dictionary<String, Table>();
         
        (Session.Contents["TableContact"] as Dictionary<String, Table>).Add(table.ID, table);
    }

    private Table CreateTableContact(int count, long ContactId, string FIO, List<CrmCustomField> fields)
    {
        
        var table = new Table() { ID = "TableContact" + count, CssClass = "table-borderless" };
        var th = new TableHeaderRow();
        th.Cells.Add(new TableHeaderCell() { Text = "Поле" });
        th.Cells.Add(new TableHeaderCell() { Text = "Значение" });
        table.Rows.Add(th);
        var tr = new TableRow();
        tr.Cells.Add(new TableCell() { Text = "ФИО:" });
        var tc = new TableCell();
        tc.Controls.Add(new TextBox() { ID = "TextBoxContact" + count, Text = FIO, Width = 400, CssClass = "form-control" });
        if (ContactId > 0)
            tc.Controls.Add(new HiddenField() { ID = "HiddenFieldContact" + count, Value = ContactId.ToString() });
        tr.Cells.Add(tc);
        table.Rows.Add(tr);
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        foreach (var ContactField in contact_fields.Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id)).ToList())
        {
            table.Rows.Add(CreateRowForCustomField(TypeField.Lead, "Contact" + count, fields, ContactField));
        }
        PanelContacts.Controls.Add(table);
        return table;
    }
}