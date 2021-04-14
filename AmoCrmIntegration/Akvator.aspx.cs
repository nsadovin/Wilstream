using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Spoofi.AmoCrmIntegration;
using Spoofi.AmoCrmIntegration.AmoCrmEntity;
using Spoofi.AmoCrmIntegration.Dtos.Request;
using Spoofi.AmoCrmIntegration.Dtos.Response;
using Spoofi.AmoCrmIntegration.Interface;
using Spoofi.AmoCrmIntegration.Service;

public partial class Akvator : Page
{
    private static readonly AmoCrmConfig Config = new AmoCrmConfig("akvatorsamara", "danko@akvator.su",
        "ff1d486361e94e2f6a75bf7199ce80f373e68513", 10);


    private readonly IAmoCrmService _service = new AmoCrmService(Config);
    private readonly List<long> ContactFields = new List<long> { 492101, 492103, 245417 };

    private readonly List<long> LeadFields = new List<long> { 497355 , 497357 , 497443 };

    private long IdFieldPhone = 245417;
    private long IdFieldPhoneLead = 497357;

    private Dictionary<long, string> PipelinesStatus = new Dictionary<long, string>();

    protected void ButtonClear_Click(object sender, EventArgs e)
    {
        TableSearch.Rows.Clear();
        Session.Contents["SearchResult"] = null;
    }

    protected void ButtonSearch_Click(object sender, EventArgs e)
    {
        Search();
    }

    private void Search(bool isinit = false)
    {
        var contacts = new List<CrmContact>();
        if (TextBoxWordSearch.Text != "")
            contacts =
                _service.GetContacts(TextBoxWordSearch.Text).OrderByDescending(r => r.DateCreate).Take(10).ToList();
        else if (Session.Contents["SearchResult"] != null)
            contacts = Session.Contents["SearchResult"] as List<CrmContact>;
        foreach (var contact in contacts)
        {
            if (contact.leads == null) continue;
            if (contact.leads.Ids == null) continue;
            if (contact.leads.Ids.Count == 0) continue;
            var tr = new TableRow();
            var tc1 = new TableCell();
            tc1.Text = contact.Name;
            var tc2 = new TableCell {Width = 100};
            var btn = new Button
            {
                ID = "BtnContact" + contact.Id, ViewStateMode = ViewStateMode.Enabled, EnableViewState = true,
                ToolTip = contact.leads.Ids.FirstOrDefault().ToString(), Text = "Перейти к лиду"
            };
            btn.Click += ButtonGoToLead_Click;
            tc2.Controls.Add(btn);
            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);
            TableSearch.Rows.Add(tr);
        }

        if (!isinit)
            Session.Contents["SearchResult"] = contacts;
    }

    protected void ButtonGoToLead_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/obmen.aspx?IdLead=" + (sender as Button).ToolTip);
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        var account_info = _service.GetAccountInfo();
        var lead_fields = _service.GetAccountInfo().CustomFields.Leads;
        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        var users = _service.GetAccountInfo().Users.ToList();


        var IdLead = Request.QueryString["IdLead"] != null ? Request.QueryString["IdLead"] : "";
        var phone = Request.QueryString["phone"] != null ? Request.QueryString["phone"] : "";
        if (phone == "")
            phone = Request.QueryString["anumber"] != null ? Request.QueryString["anumber"] : "";

        if (phone.Length > 10)
            phone = phone.Substring(phone.Length - 10, 10);

        // Search(true);


        foreach (var option in users.OrderBy(r => r.Name))
        {
            DropDownListResponsibleUserId.Items.Add(new ListItem {Value = option.Id.ToString(), Text = option.Name});
            DropDownListResponsibleUsers.Items.Add(new ListItem {Value = option.Id.ToString(), Text = option.Name});
        }

        ;

        var pipelines = _service.GetPipelines();
        {
            foreach (var option in pipelines.OrderBy(r => r.Name))
                DropDownListPipeline.Items.Add(new ListItem {Value = option.id.ToString(), Text = option.Name});
            ;
            foreach (var option in pipelines.FirstOrDefault().CrmLeadStatus.OrderBy(r => r.Value.Name))
                DropDownListStatuses.Items.Add(new ListItem
                {
                    Value = option.Value.Id.ToString(), Selected = option.Value.Id == 24732799, Text = option.Value.Name
                });
            ;


            /*foreach (var pipeline in _service.GetAccountInfo().LeadsStatuses)
            {
                var lb = new LinkButton()
                {
                    ID = "LinkButtonPipeLine" + pipeline.Id.ToString(),
                    Text = pipeline.Name,
                    CssClass = "btn btn-outline-info btn-lg",
                    CommandArgument = pipeline.Id.ToString()
                };
                lb.Attributes["style"] = "margin-right: 10px;margin-bottom: 10px; height: 50px;";
                lb.Click += lb_Click;
                PanelPipeLineButtons.Controls.Add(lb);
            }*/
        }

        var lead =
                phone != ""
                    ? null
                    : (
                    IdLead!=""?
                    //_service.GetLeads(phone).OrderByDescending(r => r.DateCreate).FirstOrDefault() :
                    _service.GetLead(Convert.ToInt64(IdLead))
                     : null )
            ;


        if (lead == null)
        {
            PanelPipeLine.Visible = true;
            LabelLeadId.Text = "Новая";
            PanelInfoLead.Visible = true;
            //DropDownListResponsibleUsers.Items.Add(new ListItem() { Value = "", Text = "-----" });

            PanelPipeLine.Visible = false;

            foreach (var LeadField in lead_fields.Where(r => LeadFields.Count == 0 || LeadFields.Contains(r.Id))
                .ToList())
            {
                var valueFields = new List<CrmCustomField>();
                if (IdFieldPhoneLead > 0 && IdFieldPhoneLead == LeadField.Id)
                {
                    valueFields.Add(new CrmCustomField() { Id = IdFieldPhoneLead, Values = new List<CrmCustomFieldValue>() { new CrmCustomFieldValue() { Value = "+7" + phone } } });
                }

                TableLead.Rows.Add(CreateRowForCustomField(TypeField.Lead, "Lead", valueFields,
                    LeadField));
            }

            ;

            PanelMainContact.Visible = true;
            CrmContact contact_search = null;
            //if(phone!="")
            //  contact_search =_service.GetContacts(phone).OrderByDescending(r => r.DateCreate).FirstOrDefault();
            if (contact_search != null)
            {
                PanelMainContact.Visible = true;
                HiddenFieldMainContactId.Value = contact_search.Id.ToString();
                TextBoxMainContactName.Text = contact_search.Name;
                TextBoxMainCampaignName.Text = contact_search.CompanyName;
                foreach (var ContactField in contact_fields
                    .Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id)).ToList())
                    TableMainContact.Rows.Add(CreateRowForCustomField(TypeField.Lead, "MainContact",
                        contact_search.CustomFields, ContactField));
            }
            else
            {
                foreach (var ContactField in contact_fields
                    .Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id)).ToList())
                {
                    var valueFields = new List<CrmCustomField>();
                    if (IdFieldPhone > 0 && IdFieldPhone == ContactField.Id && ContactField.TypeId == 8)
                    {
                        valueFields.Add(new CrmCustomField(){ Id  = IdFieldPhone, Values =  new List<CrmCustomFieldValue>(){ new CrmCustomFieldValue() { Value = "+7"+ phone } }});
                    }
                    

                    TableMainContact.Rows.Add(CreateRowForCustomField(TypeField.Lead, "MainContact",
                        valueFields, ContactField, "LeadSave"));
                }
                    
            }

            DropDownListResponsibleUsers.SelectedValue = "6154417";
            DropDownListStatuses.SelectedValue = "34200082";
        }
        else
        {
            //var lead = _service.GetLead(Convert.ToInt64(IdLead));

            //lead = _service.GetLead(lead.Id);
            PanelMainContact.Visible = true;

            if (lead != null)
            {
                HiddenFieldLeadJson.Value = JsonConvert.SerializeObject(lead);

                // PanelPipeLine.Visible = true;
                LabelLeadId.Text = lead.Id.ToString();
                TextBoxTags.Text = string.Join(",", lead.Tags.Select(r => r.Name).ToArray());
                TextBoxPrice.Text = lead.Price.ToString();

                var notes = _service.GetNotes(lead.Id);

                foreach (var note in notes)
                {
                    var tr = new TableRow();
                    tr.Cells.Add(new TableCell {Text = "Текст"});
                    tr.Cells.Add(new TableCell {Text = note.Text});
                    TableNotes.Rows.Add(tr);
                }

                var contact = lead.MainContactId != null && lead.MainContactId > 0
                    ? _service.GetContact(lead.MainContactId)
                    : null;

                if (lead.Pipeline != null)
                {
                    DropDownListPipeline.SelectedValue = lead.Pipeline.id.ToString();

                    DropDownListStatuses.Items.Clear();
                    foreach (var option in pipelines
                        .FirstOrDefault(r => r.id.ToString() == DropDownListPipeline.SelectedValue).CrmLeadStatus
                        .OrderBy(r => r.Value.Name))
                        DropDownListStatuses.Items.Add(new ListItem
                            {Value = option.Value.Id.ToString(), Text = option.Value.Name});
                    ;
                    DropDownListStatuses.SelectedValue = lead.StatusId.ToString();


                    if (DropDownListStatuses.Items.FindByValue(lead.StatusId.ToString()) != null)
                        DropDownListStatuses.SelectedValue = lead.StatusId.ToString();
                    else
                        DropDownListStatuses.SelectedValue = "34200082";
                }

                if (contact != null)
                {
                    PanelMainContact.Visible = true;
                    TextBoxMainContactName.Text = contact.Name;
                    TextBoxMainCampaignName.Text = contact.CompanyName;
                    foreach (var ContactField in contact_fields
                        .Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id)).ToList())
                        TableMainContact.Rows.Add(CreateRowForCustomField(TypeField.Lead, "MainContact",
                            contact.CustomFields, ContactField));
                }
                else
                {
                    foreach (var ContactField in contact_fields
                        .Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id)).ToList())
                        TableMainContact.Rows.Add(CreateRowForCustomField(TypeField.Lead, "MainContact",
                            new List<CrmCustomField>(), ContactField));
                }

                var countContact = 0;
                if (lead.Contacts != null && lead.Contacts.Ids != null)
                    foreach (var contact_id in lead.Contacts.Ids)
                        if (contact_id != lead.MainContactId)
                        {
                            countContact++;
                            var _contact = _service.GetContact(contact_id);
                            CreateTableContact(countContact, contact_id, _contact.Name, _contact.CompanyName,
                                _contact.CustomFields);
                            if (Session.Contents["TableContact"] != null)
                            {
                                var tables = Session.Contents["TableContact"] as Dictionary<string, Table>;
                                if (tables.ContainsKey("TableContact" + countContact))
                                    tables.Remove("TableContact" + countContact);
                                Session.Contents["TableContact"] = tables;
                            }
                        }

                if (Session.Contents["TableContact"] != null)
                    foreach (var item in Session.Contents["TableContact"] as Dictionary<string, Table>)
                        PanelContacts.Controls.Add(item.Value);

                PanelInfoLead.Visible = true;
                TextBoxLeadName.Text = lead.Name;
                TextBoxPrice.Text = lead.Price.ToString();
                TextBoxDateCreate.Text = lead.DateCreate.ToString();
                //DropDownListResponsibleUsers.Items.Add(new ListItem() { Value = "", Text = "-----" });

                if (DropDownListResponsibleUsers.Items.FindByValue(lead.ResponsibleUserId.ToString()) != null)
                    DropDownListResponsibleUsers.SelectedValue = lead.ResponsibleUserId.ToString();
                else
                    DropDownListResponsibleUsers.SelectedValue = "6154417";


                foreach (var LeadField in lead_fields.Where(r => LeadFields.Count == 0 || LeadFields.Contains(r.Id))
                    .ToList())
                    TableLead.Rows.Add(CreateRowForCustomField(TypeField.Lead, "Lead", lead.CustomFields, LeadField));
                ;
                PanelNotes.Visible = false;
                //TableNotes.
            }
        }
    }

    private void lb_Click(object sender, EventArgs e)
    {
        var lb = sender as LinkButton;
        var request = new AddOrUpdateLeadRequest();
        var crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        var lead = new AddOrUpdateCrmLead();
        lead.Id = crmLead.Id;
        lead.Name = TextBoxLeadName.Text;
        int.TryParse(TextBoxPrice.Text, out lead.Price);
        lead.ResponsibleUserId = Convert.ToInt64(DropDownListResponsibleUsers.SelectedValue);
        lead.DateCreateTimestamp = crmLead.DateCreateTimestamp;
        lead.Tags = string.Join(",", crmLead.Tags);
        lead.StatusId = lb.CommandArgument;
        lead.CustomFields = GetCustomFieldsValues<AddLeadCustomField>(TypeField.Lead, "Lead");
        request.Update = new List<AddOrUpdateCrmLead>();
        request.Update.Add(lead);
        _service.AddOrUpdateLead(request);
        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Установлен статус " + lb.Text;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HiddenFieldIdChain.Value = Request.QueryString["IdChain"] != null ? Request.QueryString["IdChain"] : "";
            HiddenFieldIdAbonent.Value = Request.QueryString["IdAbonent"] != null ? Request.QueryString["IdAbonent"] : "";
            HiddenFieldPlatform.Value = Request.QueryString["platform"] != null ? Request.QueryString["platform"] : "";
            HiddenFieldCallDirection.Value = Request.QueryString["call_direction"] != null ? Request.QueryString["call_direction"] : "";

      TextBoxMainCampaignName.Text =
                Request.QueryString["Column_3"] != null ? Request.QueryString["Column_3"] : "";
        }

        ;
    }

    private TableRow CreateRowForCustomField(TypeField typeField, string group, List<CrmCustomField> valueFields,
        CustomFieldDto Field, String validationGroup = null)
    {
        var tr = new TableRow {ID = "TableRow" + group + Field.Id};
        var tcName = new TableCell {ID = "TableCellName" + group + Field.Id};
        var labelName = new Label
        {
            ID = "LabelFieldName" + group + Field.Id,
            Text = Field.Name
            //    + "_" + Field.TypeId   
        };
        tcName.Controls.Add(labelName);
        tr.Cells.Add(tcName);
        var tcValue = new TableCell {ID = "TableCellValue" + group + Field.Id};
        var hfIdField = new HiddenField {ID = "HiddenFieldIdField" + group + Field.Id, Value = Field.Id.ToString()};
        tcValue.Controls.Add(hfIdField);
        var hfGroup = new HiddenField {ID = "HiddenFieldGroupField" + group + Field.Id, Value = group};
        tcValue.Controls.Add(hfGroup);
        var hfTypeField = new HiddenField
            {ID = "HiddenFieldTypeField" + group + Field.Id, Value = Field.TypeId.ToString()};
        tcValue.Controls.Add(hfTypeField);

        switch (Field.TypeId)
        {
            case 5:
            {
                var selectValue = new CheckBoxList {ID = "CheckBoxListFieldValue" + group + Field.Id};
                var enums = JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                foreach (var option in enums)
                    selectValue.Items.Add(new ListItem {Value = option.Key, Text = option.Value});
                ;
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                if (selectedValue != null)
                    foreach (var _val in selectedValue.Values)
                    {
                        var option = selectValue.Items.FindByValue(_val.Enum);
                        if (option != null)
                            option.Selected = true;
                    }

                ;
                tcValue.Controls.Add(selectValue);
            }
                break;
            case 4:
            {
                var selectValue = new DropDownList
                    {ID = "DropDownListFieldValue" + group + Field.Id, CssClass = "form-control"};
                var enums = JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                selectValue.Items.Add(new ListItem {Value = "", Text = "-----"});
                foreach (var option in enums)
                    selectValue.Items.Add(new ListItem {Value = option.Key, Text = option.Value});
                ;
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                if (selectedValue != null &&
                    selectValue.Items.FindByValue(selectedValue.Values.FirstOrDefault().Enum) != null)
                    selectValue.SelectedValue = selectedValue.Values.FirstOrDefault().Enum;
                ;
                tcValue.Controls.Add(selectValue);
            }
                break;
            case 2:
            {
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                var val = selectedValue != null && selectedValue.Values != null &&
                          selectedValue.Values.FirstOrDefault() != null
                    ? selectedValue.Values.FirstOrDefault().Value
                    : "";
                var numValue = new TextBox
                {
                    ID = "TextBoxFieldValue" + group + Field.Id, Text = val, TextMode = TextBoxMode.Number,
                    CssClass = "form-control"
                };
                tcValue.Controls.Add(numValue);
            }
                break;
            case 1:
            {
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                var val = selectedValue != null && selectedValue.Values != null &&
                          selectedValue.Values.FirstOrDefault() != null
                    ? selectedValue.Values.FirstOrDefault().Value
                    : "";
                var numValue = new TextBox
                {
                    ID = "TextBoxFieldValue" + group + Field.Id, Text = val, TextMode = TextBoxMode.SingleLine,
                    CssClass = "form-control"
                };
                tcValue.Controls.Add(numValue);
            }
                break;
            case 3:
            {
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                var val = selectedValue != null && selectedValue.Values != null &&
                          selectedValue.Values.FirstOrDefault() != null
                    ? selectedValue.Values.FirstOrDefault().Value
                    : "";

                var numValue = new CheckBox {ID = "CheckBoxFieldValue" + group + Field.Id, Checked = val == "True"};
                tcValue.Controls.Add(numValue);
            }
                break;
            case 8:
            {
                if (Session.Contents["MultiFields" + group + Field.Id] == null)
                    Session.Contents["MultiFields" + group + Field.Id] = new Dictionary<string, Panel>();
                var sessionFields = Session.Contents["MultiFields" + group + Field.Id] as Dictionary<string, Panel>;

                var it = 0;
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                var vals = selectedValue != null && selectedValue.Values != null
                    ? selectedValue.Values
                    : new List<CrmCustomFieldValue>();
                foreach (var val in vals)
                {
                    var lc = new Panel {ID = "Panel" + group + Field.Id + it, CssClass = "input-group"};

                    var ddl = new DropDownList
                    {
                        ID = "DropDownListValue" + group + Field.Id + it, Width = 100, CssClass = "input-group-prepend"
                    };
                    var enums = JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                    foreach (var option in enums) ddl.Items.Add(new ListItem {Value = option.Key, Text = option.Value});
                    ;
                    ddl.SelectedValue = val.Enum;
                    lc.Controls.Add(ddl);
                    var numValue = new TextBox
                        {ID = "TextBoxFieldValue" + group + Field.Id + it, ValidationGroup = group ,Text = val.Value, CssClass = "form-control"};
                    lc.Controls.Add(numValue);
                    if (validationGroup != null)
                    {
                        var reqValue = new RequiredFieldValidator
                        {
                            ID = "RequiredFieldValidatorFieldValue" + group + Field.Id + it, ValidationGroup = validationGroup,
                            ControlToValidate = "TextBoxFieldValue" + group + Field.Id + it,
                            ForeColor = System.Drawing.Color.Red, ErrorMessage = "Заполните поле",
                            Display = ValidatorDisplay.Dynamic
                        };
                        lc.Controls.Add(reqValue);
                    }

                    var addValue = new Button
                    {
                        ID = "ButtonFieldValue" + group + Field.Id + it, Text = "+",
                        CssClass = "input-group-append input-group-text"
                    };

                    addValue.Click += addValue_Click;
                    addValue.CommandArgument = JsonConvert.SerializeObject(Field);

                    lc.Controls.Add(addValue);
                    if (sessionFields.ContainsKey(lc.ID) != null) sessionFields.Remove(lc.ID);
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
                    var lc = new Panel {ID = "Panel" + group + Field.Id + it, CssClass = "input-group"};

                    var ddl = new DropDownList
                    {
                        ID = "DropDownListValue" + group + Field.Id + it, Width = 100, CssClass = "input-group-prepend"
                    };
                    var enums = JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
                    foreach (var option in enums) ddl.Items.Add(new ListItem {Value = option.Key, Text = option.Value});
                    ;
                    ddl.SelectedIndex = 0;
                    lc.Controls.Add(ddl);
                    var numValue = new TextBox
                        {ID = "TextBoxFieldValue" + group + Field.Id + it, Text = "", CssClass = "form-control"};
                    lc.Controls.Add(numValue);
                    var addValue = new Button
                    {
                        ID = "ButtonFieldValue" + group + Field.Id + it, Text = "+",
                        CssClass = "input-group-append input-group-text"
                    };
                    addValue.Click += addValue_Click;
                    lc.Controls.Add(addValue);
                    tcValue.Controls.Add(lc);
                }

                Session.Contents["MultiFields" + group + Field.Id] = sessionFields;
            }
                break;
            case 9:
            {
                var selectedValue = valueFields.FirstOrDefault(r => r.Id == Field.Id);
                var val = selectedValue != null && selectedValue.Values != null &&
                          selectedValue.Values.FirstOrDefault() != null
                    ? selectedValue.Values.FirstOrDefault().Value
                    : "";
                var numValue = new TextBox
                {
                    ID = "TextBoxFieldValue" + group + Field.Id, Text = val, TextMode = TextBoxMode.MultiLine,
                    CssClass = "form-control"
                };
                tcValue.Controls.Add(numValue);
            }
                break;
        }

        tr.Cells.Add(tcValue);
        return tr;
    }


    private void addValue_Click(object sender, EventArgs e)
    {
        var it = 0;
        var tcValue = (sender as Button).Parent.Parent as TableCell;
        long IdField = 0;
        long TypeField = 0;
        var group = "";
        foreach (Control c in tcValue.Controls)
        {
            if (c is Panel) it++;
            if (c is HiddenField)
            {
                if (c.ID.Contains("HiddenFieldIdField"))
                    IdField = Convert.ToInt64(((HiddenField) c).Value);
                if (c.ID.Contains("HiddenFieldTypeField"))
                    TypeField = Convert.ToInt64(((HiddenField) c).Value);
                if (c.ID.Contains("HiddenFieldGroupField"))
                    group = ((HiddenField) c).Value;
            }
        }

        var Field = JsonConvert.DeserializeObject<CustomFieldDto>((sender as Button).CommandArgument);

        var lc = new Panel {ID = "Panel" + group + Field.Id + it, CssClass = "input-group"};

        var ddl = new DropDownList
            {ID = "DropDownListValue" + group + Field.Id + it, Width = 100, CssClass = "input-group-prepend"};
        var enums = JsonConvert.DeserializeObject<Dictionary<string, string>>(Field.Enums.ToString());
        foreach (var option in enums) ddl.Items.Add(new ListItem {Value = option.Key, Text = option.Value});
        ;

        ddl.SelectedIndex = 0;
        lc.Controls.Add(ddl);
        var numValue = new TextBox
            {ID = "TextBoxFieldValue" + group + Field.Id + it, Text = "", CssClass = "form-control"};
        lc.Controls.Add(numValue);
        var addValue = new Button
        {
            ID = "ButtonFieldValue" + group + Field.Id + it, Text = "+",
            CssClass = "input-group-append input-group-text"
        };
        addValue.Click += addValue_Click;
        lc.Controls.Add(addValue);
        if (Session.Contents["MultiFields" + group + Field.Id] == null)
            Session.Contents["MultiFields" + group + Field.Id] = new Dictionary<string, Panel>();
        (Session.Contents["MultiFields" + group + Field.Id] as Dictionary<string, Panel>).Add(lc.ID, lc);
        tcValue.Controls.Add(lc);
    }

    protected void ButtonUpdateAddLead_Click(object sender, EventArgs e)
    {
        if (HiddenFieldLeadJson.Value != "")
        {
           // var IdContact = CreateContacts();
            var request = new AddOrUpdateLeadRequest();
            var crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
            var lead = new AddOrUpdateCrmLead();
            lead.Id = crmLead.Id;
            lead.Name = TextBoxLeadName.Text;
            lead.StatusId = DropDownListStatuses.SelectedValue;
            lead.PipelineId = DropDownListPipeline.SelectedValue;
            lead.Tags = TextBoxTags.Text;
            int.TryParse(TextBoxPrice.Text, out lead.Price);
            lead.ResponsibleUserId = Convert.ToInt64(DropDownListResponsibleUsers.SelectedValue);
            lead.DateCreateTimestamp = crmLead.DateCreateTimestamp;
            lead.Tags = TextBoxTags.Text;
           //lead.MainContactId = IdContact;
            //lead.StatusId = crmLead.StatusId.ToString();
            lead.CustomFields = GetCustomFieldsValues<AddLeadCustomField>(TypeField.Lead, "Lead");
            request.Request = new AddOrUpdateLeadObject();
            request.Request.Leads = new AddOrUpdateCrmLeads();
            request.Request.Leads.Update = new List<AddOrUpdateCrmLead>();

            request.Request.Leads.Update.Add(lead);
            _service.AddOrUpdateLead(request);
        }
        else
        {

          //  var IdContact = CreateContacts();
            var request = new AddOrUpdateLeadRequest();
            var lead = new AddOrUpdateCrmLead();
            lead.Name = TextBoxLeadName.Text;
            lead.ResponsibleUserId = Convert.ToInt64(DropDownListResponsibleUsers.SelectedValue);
            lead.DateCreate = DateTime.Now;
            lead.Tags = TextBoxTags.Text;
            lead.StatusId = DropDownListStatuses.SelectedValue;
            lead.PipelineId = DropDownListPipeline.SelectedValue;
            int.TryParse(TextBoxPrice.Text, out lead.Price);
        //    lead.MainContactId = IdContact;
            // lead.MainContact = new CrmMainContact() { id = IdContact };
            //   lead.StatusId = crmLead.StatusId.ToString();
            lead.CustomFields = GetCustomFieldsValues<AddLeadCustomField>(TypeField.Lead, "Lead");
            request.Request = new AddOrUpdateLeadObject();

            request.Request.Leads = new AddOrUpdateCrmLeads();
            request.Request.Leads.Add = new List<AddOrUpdateCrmLead>();
            request.Request.Leads.Add.Add(lead);
            var newLead = _service.AddOrUpdateLead(request);

            

            if (newLead.Count > 0)
            {
                if (HiddenFieldIdChain.Value != null)
                {
                    var requestNote = new AddOrUpdateNoteRequest();
                    requestNote.Update = new List<AddOrUpdateCrmNote>();
                    requestNote.Add = new List<AddOrUpdateCrmNote>();
                    {
                        var _note = new AddOrUpdateCrmNote();
                        _note.ElementId = newLead.FirstOrDefault().Id;
                        _note.ElementType = 2;
                        _note.Text = "CallId:" + HiddenFieldIdChain.Value;
                        _note.ResponsibleUserId = Convert.ToInt64(6154417);
                        _note.NoteType = 4;
                        requestNote.Add.Add(_note);
                    }


                    //_service.AddOrUpdateNote(requestNote);
                }

                if (!String.IsNullOrWhiteSpace(HiddenFieldIdAbonent.Value))
                {
                  SaveIdLeadInTable(HiddenFieldCallDirection.Value ,HiddenFieldPlatform.Value, HiddenFieldIdAbonent.Value, newLead.FirstOrDefault().Id);
                }

                //а теперь финт ушами, делаем все тоже но в новом API
                //lead.Id = newLead.FirstOrDefault().Id;
                //request = new AddOrUpdateLeadRequest();
                //request.Update = new List<AddOrUpdateCrmLead>(); 
                //request.Update.Add(lead);
                //var updateLead = _service.AddOrUpdateLeadV2(request);

                Response.Redirect("~/Akvator.aspx?IdLead=" + newLead.FirstOrDefault().Id);
            }
        }

        PanelNotes.Visible = false;
        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Данные по лиду обновлены";
    }

    private void SaveIdLeadInTable(string callDirection, string platform, string IdAbonent, long IdLead )
    {
    try
    {
      System.Data.SqlClient.SqlConnection conn = null;

      System.Configuration.ConnectionStringSettings settings =
        System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];
      //if(platform.Equals("1905"))  settings =           System.Configuration.ConfigurationManager.ConnectionStrings["oktell1905ConnectionString"];

      SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

      var SqlStr = " Update   "+(platform.Equals("1905")?"[OKTELL_DB1.WILSTREAM.RU].[oktell].":"")+ (callDirection.Equals("callback") ? "dbo.[A_TaskManager_LocalList_4c591d60-8399-40eb-99cd-55c425a3cffe_0]" : "[dbo].[WS_Akvator]") + "  Set  IdLead = " + IdLead.ToString() + " Where Id = " + IdAbonent + "  ";

      
      SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
      myOdbcCommand.CommandType = CommandType.Text;
      myOdbcCommand.Connection.Open();
      SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

      myOdbcReader.Close();
      myOdbcConnection.Close();

    }
    catch (Exception ex)
    { 
    }
  }

    private List<T> GetCustomFieldsValues<T>(TypeField typeField, string group) where T : class, IAddCustomField, new()
    {
        var CustomFields = new List<T>();
        var table = (Table) FindControl("Table" + group);
        foreach (TableRow tr in table.Rows)
        {
            long IdField = 0;
            long TypeField = 0;
            foreach (Control c in tr.Cells[1].Controls)
                if (c is HiddenField)
                {
                    if (c.ID.Contains("HiddenFieldIdField"))
                        IdField = Convert.ToInt64(((HiddenField) c).Value);
                    if (c.ID.Contains("HiddenFieldTypeField"))
                        TypeField = Convert.ToInt64(((HiddenField) c).Value);
                }

            if (IdField > 0)
                switch (TypeField)
                {
                    case 4:
                    {
                        var _value = "";
                        foreach (Control c in tr.Cells[1].Controls)
                            if (c is DropDownList && ((DropDownList) c).SelectedIndex > -1)
                                _value = ((DropDownList) c).SelectedValue;
                        CustomFields.Add(new T
                            {Id = IdField, Values = new List<object> {new AddCustomFieldValues {Value = _value}}});
                    }
                        break;
                    case 5:
                    {
                        var _values = new List<object>();

                        foreach (Control c in tr.Cells[1].Controls)
                            if (c is CheckBoxList)
                                foreach (ListItem Item in (c as CheckBoxList).Items)
                                    if (Item.Selected)
                                        _values.Add(Item.Value);
                        CustomFields.Add(new T {Id = IdField, Values = _values});
                    }
                        break;
                    case 8:
                    {
                        foreach (Control c in tr.Cells[1].Controls)
                            if (c is Panel)
                            {
                                var _value = "";
                                var _code = "";
                                var _panel = (Panel) c;
                                foreach (Control cp in _panel.Controls)
                                {
                                    if (cp is TextBox) _value = ((TextBox) cp).Text;
                                    if (cp is DropDownList) _code = ((DropDownList) cp).SelectedItem.Text;
                                }

                                if (_value != "")
                                    CustomFields.Add(new T
                                    {
                                        Id = IdField,
                                        Values = new List<object>
                                            {new AddCustomFieldValuesEnum {Value = _value, Enum = _code}}
                                    });
                            }
                    }
                        break;
                    case 9:
                    case 2:
                    case 1:
                    {
                        var _value = "";
                        foreach (Control c in tr.Cells[1].Controls)
                            if (c is TextBox)
                                _value = ((TextBox) c).Text;
                        CustomFields.Add(new T
                            {Id = IdField, Values = new List<object> {new AddCustomFieldValues {Value = _value}}});
                    }
                        break;
                }
        }

        return CustomFields;
    }

    protected void ButtonUpdateMainContact_Click(object sender, EventArgs e)
    {
        CreateContacts();
        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Данные по контактам обновлены";
    }

    private long CreateContacts(long LeadId = 0)
    {
        var request = new AddOrUpdateContactRequest();
        var crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        request.Update = new List<AddOrUpdateCrmContact>();
        request.Add = new List<AddOrUpdateCrmContact>();
        {
            var _contact = new AddOrUpdateCrmContact();
            if (crmLead != null && crmLead.MainContactId > 0)
                _contact.Id = crmLead.MainContactId;
            if (HiddenFieldMainContactId.Value != "")
            {
                var contact_search = _service.GetContact(Convert.ToInt64(HiddenFieldMainContactId.Value));
                _contact.Id = Convert.ToInt64(HiddenFieldMainContactId.Value);
                if (contact_search != null && contact_search.leads.Ids != null)
                    _contact.LeadsId = string.Join(",", contact_search.leads.Ids);
            }

            _contact.Name = TextBoxMainContactName.Text;
            if (LeadId > 0)
            {
                if (!string.IsNullOrEmpty(_contact.LeadsId))
                {
                    var leads = _contact.LeadsId.Split(',').ToList().Select(r => Convert.ToInt64(r)).ToList();
                    leads.Add(LeadId);
                    _contact.LinkedLeadsIds = leads;
                    _contact.LeadsId = string.Join(",", leads);
                }
                else
                {
                    _contact.LinkedLeadsIds = new List<long> {LeadId};
                    _contact.LeadsId = LeadId.ToString();
                }
            }

            _contact.CompanyName = TextBoxMainCampaignName.Text;
            _contact.CustomFields = GetCustomFieldsValues<AddContactCustomField>(TypeField.Lead, "MainContact");
            if (crmLead != null && crmLead.MainContactId > 0 || HiddenFieldMainContactId.Value != "")
                request.Update.Add(_contact);
            else
                request.Add.Add(_contact);
        }

        var countContact = 0;
        //а теперь обойдем дополнительные контакты
        foreach (Control c in PanelContacts.Controls)
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

                    foreach (Control cc in tableContact.Rows[2].Cells[1].Controls)
                    {
                        if (cc is TextBox)
                            _contact.CompanyName = (cc as TextBox).Text;
                        if (cc is HiddenField)
                            _contact.Id = Convert.ToInt64((cc as HiddenField).Value);
                    }

                    _contact.LeadsId = crmLead.Id.ToString();
                    _contact.CustomFields =
                        GetCustomFieldsValues<AddContactCustomField>(TypeField.Contact,
                            tableContact.ID.Replace("Table", ""));
                    if (_contact.Id != null && _contact.Id > 0)
                        request.Update.Add(_contact);
                    else
                        request.Add.Add(_contact);
                }
            }

        var rslt = _service.AddOrUpdateContact(request);

        if (rslt.FirstOrDefault() != null)
        {
            HiddenFieldMainContactId.Value = rslt.FirstOrDefault().Id.ToString();
            return rslt.FirstOrDefault().Id;
        }

        return 0;
    }

    protected void ButtonAddContact_Click(object sender, EventArgs e)
    {
        var count = 0;
        foreach (Control c in PanelContacts.Controls)
            if (c is Table)
                count++;
        var table = CreateTableContact(count, 0, "", "", new List<CrmCustomField>());
        if (Session.Contents["TableContact"] == null)
            Session.Contents["TableContact"] = new Dictionary<string, Table>();

        (Session.Contents["TableContact"] as Dictionary<string, Table>).Add(table.ID, table);
    }

    private Table CreateTableContact(int count, long ContactId, string FIO, string CompanyName,
        List<CrmCustomField> fields)
    {
        var table = new Table {ID = "TableContact" + count, CssClass = "table-borderless"};
        var th = new TableHeaderRow();
        th.Cells.Add(new TableHeaderCell {Text = "Поле"});
        th.Cells.Add(new TableHeaderCell {Text = "Значение"});
        table.Rows.Add(th);
        var tr = new TableRow();
        tr.Cells.Add(new TableCell {Text = "ФИО:"});
        var tc = new TableCell();
        tc.Controls.Add(new TextBox
            {ID = "TextBoxContact" + count, Text = FIO, Width = 400, CssClass = "form-control"});
        if (ContactId > 0)
            tc.Controls.Add(new HiddenField {ID = "HiddenFieldContact" + count, Value = ContactId.ToString()});
        tr.Cells.Add(tc);
        table.Rows.Add(tr);

        var trCompany = new TableRow();
        trCompany.Cells.Add(new TableCell {Text = "Компания:"});
        var tcCompany = new TableCell();
        tcCompany.Controls.Add(new TextBox
            {ID = "TextBoxCampaignName" + count, Text = CompanyName, Width = 400, CssClass = "form-control"});
        trCompany.Cells.Add(tcCompany);
        table.Rows.Add(trCompany);


        var contact_fields = _service.GetAccountInfo().CustomFields.Contacts;
        foreach (var ContactField in contact_fields.Where(r => ContactFields.Count == 0 || ContactFields.Contains(r.Id))
            .ToList()) table.Rows.Add(CreateRowForCustomField(TypeField.Lead, "Contact" + count, fields, ContactField));
        PanelContacts.Controls.Add(table);
        return table;
    }

    protected void ButtonAddTask_Click(object sender, EventArgs e)
    {
        var request = new AddOrUpdateTaskRequest();
        var crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        request.Update = new List<AddOrUpdateCrmTask>();
        request.Add = new List<AddOrUpdateCrmTask>();
        {
            var _task = new AddOrUpdateCrmTask();
            _task.ElementId = crmLead.Id;
            _task.ElementType = 2;
            _task.Text = TextBoxText.Text;
            _task.IsCompleted = CheckBoxIsCompleted.Checked;
            _task.ResponsibleUserId = Convert.ToInt64(DropDownListResponsibleUserId.SelectedValue);
            _task.TaskType = Convert.ToInt32(DropDownListTaskType.SelectedValue);
            if (TextBoxCompleteTillAt.Text != "")
                _task.CompleteTillAt = DateTime.Parse(TextBoxCompleteTillAt.Text);
            request.Add.Add(_task);
        }


        _service.AddOrUpdateTask(request);

        TextBoxText.Text = "";
        CheckBoxIsCompleted.Checked = false;


        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Задача создана";
    }

    protected void ButtonAddNote_Click(object sender, EventArgs e)
    {
        var request = new AddOrUpdateNoteRequest();
        var crmLead = JsonConvert.DeserializeObject<CrmLead>(HiddenFieldLeadJson.Value);
        request.Update = new List<AddOrUpdateCrmNote>();
        request.Add = new List<AddOrUpdateCrmNote>();
        {
            var _note = new AddOrUpdateCrmNote();
            _note.ElementId = crmLead.Id;
            _note.ElementType = 2;
            _note.Text = TextBoxTextNote.Text;
            _note.ResponsibleUserId = Convert.ToInt64(6154417);
            _note.NoteType = 4;
            request.Add.Add(_note);
        }


        _service.AddOrUpdateNote(request);


        Response.Redirect("~/avgis.aspx?IdLead=" + crmLead.Id);

        TextBoxTextNote.Text = "";


        LabelMsg.Visible = true;
        LabelMsg.CssClass = "alert alert-success";
        LabelMsg.Text = "Примечание добавлено";
    }

    protected void DropDownListPipeline_SelectedIndexChanged(object sender, EventArgs e)
    {
        var pipelines = _service.GetPipelines();
        DropDownListStatuses.Items.Clear();
        foreach (var option in pipelines.FirstOrDefault(r => r.id.ToString() == DropDownListPipeline.SelectedValue)
            .CrmLeadStatus.OrderBy(r => r.Value.Name))
            DropDownListStatuses.Items.Add(new ListItem {Value = option.Value.Id.ToString(), Text = option.Value.Name});
        ;
    }
}