using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Сводное описание для FormRender
/// </summary>
public static class FormRender
{
    static Page _Page;
    static int IdTask;
    static int IdProject;
    static HttpRequest Request;
    static string Operator;
    static int IdPopupLoad;
    private static bool IsUpdated;

    public static Control renderObjectForm(TabObject FormObject, bool IsUpdated, int IdPopupLoad, Page Page, int IdTask, int IdProject, HttpRequest Request)
    {
        int IdForm = FormObject.IdObject;
        Control c = new UpdatePanel() { ID = "UpdatePanelContact" + IdForm };
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(createForm(IdForm, IsUpdated, IdPopupLoad, Page, IdTask, IdProject, Request));
        return c;
    }


    public static Control renderObjectForm(int IdForm, bool IsUpdated, int IdPopupLoad, Page Page, int IdTask, int IdProject, HttpRequest Request)
    { 
        Control c = new UpdatePanel() { ID = "UpdatePanelContact" + IdForm };
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(createForm(IdForm, IsUpdated, IdPopupLoad, Page, IdTask, IdProject, Request));
        return c;
    }

    public static Control createForm(int IdForm, bool IsUpdated, int IdPopupLoad, Page page, int IdTask, int IdProject, HttpRequest Request)
    {
        _Page = page;
        FormRender.IdTask = IdTask;
        FormRender.Request = Request;
        FormRender.IdPopupLoad = IdPopupLoad;
        FormRender.Operator = Request.QueryString["Operator"];
        FormContext db = new FormContext();
        Form Form = db.Forms.Find(IdForm);
        if (Form == null) return null;
        Control c = new Panel() { ID = "PanelForm" + IdForm };
        c.Controls.Add(new Label() { ID = "FormDescription" + IdForm, Visible = true, Text = Form.Description });
        c.Controls.Add(new Label() { ID = "MessagerForm" + IdForm, Visible = false, Text = "" });

        List<FormField> FormFields = Form.FormFields.Where(p => p.Active == 1 && p.Deleted == 0).OrderBy(p => p.Sort).ToList();
        Table table = new Table() { ID = "TableForm" + IdForm };

        List<FormResult> frs = new List<FormResult>();
        if (IsUpdated)
        {
            FormResult fr = db.FormResults.FirstOrDefault(row => row.IdPopupLoad == IdPopupLoad);
            frs = db.FormResults.Where(row => row.IdFormSaved == fr.IdFormSaved).ToList();
            //Response.Write(frs.Count);
        }

        // object Obj = Activator.CreateInstance(T);

        foreach (FormField Field in FormFields)
        {
            TableRow tr = new TableRow();
            tr.Cells.Add(new TableCell() { Text = Field.Title, VerticalAlign = VerticalAlign.Top });

            System.Type T = null;
            if (Field.FormTypeField.SystemTitle != "")
            {
                try { T = System.Web.Compilation.BuildManager.GetType("FormField" + Field.FormTypeField.SystemTitle, true); }
                catch (Exception e) { };
            };
            if (T == null)
                switch (Field.FormTypeField.Id)
                {
                    case 2:
                        int IdValue = -1;
                        if (IsUpdated)
                        {
                            var fr = frs.FirstOrDefault(row => row.IdField == Field.Id);
                            if (fr != null)
                                IdValue = fr.IdValue;
                        };
                        TableCell td = new TableCell(); td.Controls.Add(getControlFormDropDownList(Field, table, IdValue)); tr.Cells.Add(td);

                        break;
                }
            else
            {
                string StrValue = "";
                if (IsUpdated)
                {
                    var fr = frs.FirstOrDefault(row => row.IdField == Field.Id);
                    if (fr != null)
                        StrValue = fr.Value;
                };

                object Obj = Activator.CreateInstance(T);
                Control cObj = (Control)Obj.GetType().InvokeMember("getControl", System.Reflection.BindingFlags.Default | System.Reflection.BindingFlags.InvokeMethod, null, Obj, new object[] { Field, _Page, StrValue, IsUpdated });
                TableCell td1 = new TableCell();

                //Response.Write("FormField" + Field.FormTypeField.SystemTitle);
                //Response.End();

                td1.Controls.Add(cObj); tr.Cells.Add(td1);
            }
            if (Field.TitleNote != null && Field.TitleNote != "")
            {
                var tr_caption = new TableRow();
                var td_caption = new TableCell() { ColumnSpan = 2 };
                td_caption.Controls.Add(new LiteralControl("<b>" + Field.TitleNote + "<b>"));
                tr_caption.Cells.Add(td_caption);
                table.Rows.Add(tr_caption);
            }
            table.Rows.Add(tr);
        };
        if (Form.HasSaveButton == 1)
        {
            TableRow tr = new TableRow();
            tr.Cells.Add(new TableCell());
            TableCell td = new TableCell();
            Button btnSaverForm = new Button() { ID = "ButtonSaverForm" + IdForm, Text = Form.SendToEmail == 1 ? "ОТПРАВИТЬ" : "СОХРАНИТЬ" };
            btnSaverForm.Click += new EventHandler(btnSaverFormClick);
            btnSaverForm.Attributes["IdForm"] = IdForm.ToString();
            btnSaverForm.ValidationGroup = "ValidationGroupForm" + IdForm.ToString();
            td.Controls.Add(btnSaverForm);
            tr.Cells.Add(td);
            table.Rows.Add(tr);
        }

        if (Form.SendToEmail == 1 || Form.HasSendEmailButton == 1)
        {
            HiddenField hf = new HiddenField() { ID = "PanelFormHiddenFieldEmail" + IdForm, Value = Form.Email };
            if (Form.HasSendEmailButton == 1 && setting("EMAIL_MAIN") != "")
                hf.Value = setting("EMAIL_MAIN");
            c.Controls.Add(hf);
        }

        c.Controls.Add(table);

        if (Form.HasSendEmailButton == 1)
        {
            Button btnEmailForm = new Button() { ID = "ButtonEmailForm" + IdForm, Text = "ОТПРАВИТЬ ПИСЬМО" };
            btnEmailForm.Click += new EventHandler(btnEmailFormClick);
            btnEmailForm.Attributes["IdForm"] = IdForm.ToString();
            //add new 17032017
            if (Form.ShowSubjectField != 1 && Form.ShowMessageField != 1)
                btnEmailForm.ValidationGroup = "ValidationGroupForm" + IdForm.ToString();

            c.Controls.Add(btnEmailForm);

            Panel PanelFormEmail = new Panel() { ID = "PanelFormEmail" + IdForm, Visible = false };
            Table tableFormEmail = new Table() { ID = "TableFormEmail" + IdForm };
            if (Form.ShowSubjectField == 1)
            {
                TableRow tr = new TableRow();
                tr.Cells.Add(new TableCell() { Text = "Тема письма", VerticalAlign = VerticalAlign.Top });
                TableCell td = new TableCell();


                td.Controls.Add(new TextBox() { ID = "TableFormEmailSubject" + IdForm, Width = 500 });

                {
                    RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + IdForm + "_subject" };
                    rfv.ErrorMessage = "Поле обязательно к заполнению";
                    rfv.Display = ValidatorDisplay.Dynamic;
                    rfv.CssClass = "error";
                    rfv.ControlToValidate = "TableFormEmailSubject" + IdForm;
                    if (Form.HasSaveButton == 1) rfv.ValidationGroup = "ValidationGroupForm" + IdForm.ToString();
                    else rfv.ValidationGroup = "closedPupup";
                    rfv.EnableClientScript = true;
                    rfv.Enabled = false;
                    td.Controls.Add(rfv);
                }

                tr.Cells.Add(td);
                tableFormEmail.Rows.Add(tr);
            }

            if (Form.ShowMessageField == 1)
            {
                TableRow tr2 = new TableRow();
                tr2.Cells.Add(new TableCell() { Text = "Суть вопроса", VerticalAlign = VerticalAlign.Top });
                TableCell td2 = new TableCell();
                td2.Controls.Add(new TextBox() { ID = "TableFormEmailMessage" + IdForm, TextMode = TextBoxMode.MultiLine, Width = 498, Height = 50 });

                {
                    RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + IdForm + "_Message" };
                    rfv.ErrorMessage = "Поле обязательно к заполнению";
                    rfv.Display = ValidatorDisplay.Dynamic;
                    rfv.CssClass = "error";
                    rfv.ControlToValidate = "TableFormEmailMessage" + IdForm;
                    if (Form.HasSaveButton == 1) rfv.ValidationGroup = "ValidationGroupForm" + IdForm.ToString();
                    else rfv.ValidationGroup = "closedPupup";
                    rfv.EnableClientScript = true;
                    rfv.Enabled = false;
                    td2.Controls.Add(rfv);
                }
                tr2.Cells.Add(td2);
                tableFormEmail.Rows.Add(tr2);
            }

            TableRow tr3 = new TableRow();
            tr3.Cells.Add(new TableCell());
            Button btnEmailSendForm = new Button() { ID = "btnEmailSendForm" + IdForm, Text = "ОТПРАВИТЬ" };
            btnEmailSendForm.Click += new EventHandler(btnEmailSendFormClick);
            btnEmailSendForm.Attributes["IdForm"] = IdForm.ToString();
            if (Form.HasSaveButton == 1)
                btnEmailSendForm.ValidationGroup = "ValidationGroupForm" + IdForm.ToString();
            else
                btnEmailSendForm.ValidationGroup = "closedPupup";
            TableCell td3 = new TableCell();
            td3.Controls.Add(btnEmailSendForm);
            tr3.Cells.Add(td3);
            tableFormEmail.Rows.Add(tr3);

            PanelFormEmail.Controls.Add(tableFormEmail);
            c.Controls.Add(PanelFormEmail);

        }

        return c;
    }


    private static Control getControlFormDropDownList(FormField Field, Table table, int IdValue = -1)
    {
        Control c = new Panel() { ID = "PanelDropDownListForm" + Field.IdForm + "_" + Field.Id };
        int ParentIdFormField = Field.FieldDropDownListReferenceBookRelations.Count > 0 ? Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ParentIdFormField : 0;
        int ParentIdFormField2 = Field.FieldDropDownListReferenceBookRelations.Count > 0 ? Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ParentIdFormField2 : 0;
        List<ReferenceBookData> ReferenceBookDatas = new List<ReferenceBookData>();
        // Response.Write(Field.Title);
        if (ParentIdFormField == 0 && Field.FieldDropDownListReferenceBookRelations.Count > 0)
        {
            // Response.Write("-");
            //Response.Write(Field.FieldDropDownListReferenceBookRelation.IdReference);
            ReferenceBookDatas = Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ReferenceBook.ReferenceBookDatas.Where(p => p.Active == 1 && p.Deleted == 0).ToList();
        }
        else if (Field.FieldDropDownListReferenceBookRelations.Count > 0)
        {
            // Response.Write("+");
            //var Pddl = (table.Rows[0].Cells[1].Controls[0].FindControl("DropDownListForm" + ParentIdFormField) as DropDownList);
            //   var Pddl = (table.Rows[0].Cells[1].Controls[0].Controls[0] as DropDownList);
            //Response.Write(table.Rows[0].Cells[1].Controls[0].Controls[0].ID);
            //Response.Write(Pddl.SelectedIndex);
            //  Response.End();
            //int IdParent = Pddl!=null&&Pddl.SelectedIndex > 0 ? Convert.ToInt32(Pddl.SelectedValue) : 0;
            int IdParent = 0;
            // ReferenceBookDatas =     Field.FieldDropDownListReferenceBookRelations  .FirstOrDefault().ReferenceBook.ReferenceBookDatas.  Where(p => p.Id==1 && p.Active==1&& p.IdParent == IdParent).ToList();
            if (Field.Id == 484)
            {
                //  ReferenceBookDatas.Clear();
                // Response.Write(ReferenceBookDatas.Count);
                // Response.End();
            }
        }
        //List<FieldDropDownListValueNote> ValueNotes = Field.FieldDropDownListValueNotes.Count;

        //Response.Write("|");

        DropDownList ddl = new DropDownList() { ID = "FormField" + Field.IdForm + "_" + Field.Id };

        c.Controls.Add(ddl);

        ddl.Attributes["IdFormField"] = Field.Id.ToString();

        if (ParentIdFormField > 0)
        {
            ddl.Attributes["ParentIdFormField"] = "FormField" + Field.IdForm + "_" + ParentIdFormField;
            if (ParentIdFormField2 > 0)
            {
                ddl.Attributes["ParentIdFormField2"] = "FormField" + Field.IdForm + "_" + ParentIdFormField2;
            }
            if (IdValue > -1)
            {
                ddl.Attributes["SelectedValue"] = IdValue.ToString();
            }
            ddl.Load += new EventHandler(formFieldDropDownListDataBinding);
        }

        ddl.Items.Add("");
        foreach (ReferenceBookData Data in ReferenceBookDatas.Where(p => p.Active == 1).OrderBy(r => r.Sort).ThenBy(r2 => r2.Title).ToList())
        {

            var li = new ListItem(Data.Title, Data.Id.ToString());
            li.Attributes["IdParent"] = Data.IdParent.ToString();
            ddl.Items.Add(li);
        }

        if (IdValue > -1)
        {
            if (ddl.Items.FindByValue(IdValue.ToString()) != null)
                ddl.SelectedValue = IdValue.ToString();
            //Response.Write(IdValue.ToString());
        }

        ddl.AutoPostBack = true;
        if (Field.FieldDropDownListValueNotes.Count > 0)
        {
            ddl.SelectedIndexChanged += new EventHandler(formFieldDropDownListSelectedIndexChanged);


            TextBox tb = new TextBox() { ID = "TextBoxForm" + Field.IdForm + "_" + Field.Id, Visible = false };

            c.Controls.Add(tb);

            foreach (FieldDropDownListValueNote Value in Field.FieldDropDownListValueNotes)
            {
                var item = ddl.Items.FindByValue(Value.IdReferenceBookData.ToString());
                if (item != null)
                {
                    item.Attributes["note"] = "note";
                    item.Attributes["required"] = Value.Required.ToString();
                }
            }

            RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorFormDDLNote" + Field.IdForm + "_" + Field.Id };
            rfv.ErrorMessage = "Поле обязательно к заполнению";
            rfv.Display = ValidatorDisplay.Dynamic;
            rfv.CssClass = "error";
            rfv.ControlToValidate = tb.ID;
            //add new 17032017 
            if (Field.Form.HasSaveButton == 1 || (Field.Form.HasSendEmailButton == 1 && Field.Form.ShowSubjectField != 1 && Field.Form.ShowMessageField != 1))
                rfv.ValidationGroup = "ValidationGroupForm" + Field.IdForm.ToString();
            else
                rfv.ValidationGroup = "closedPupup";
            rfv.EnableClientScript = true;
            c.Controls.Add(rfv);
            rfv.Enabled = false;
        }

        if (Field.Required == 1)
        {
            RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id };
            rfv.ErrorMessage = "Поле обязательно к заполнению";
            rfv.Display = ValidatorDisplay.Dynamic;
            rfv.CssClass = "error";
            rfv.ControlToValidate = ddl.ID;
            //add new 17032017 
            if (Field.Form.HasSaveButton == 1 || (Field.Form.HasSendEmailButton == 1 && Field.Form.ShowSubjectField != 1 && Field.Form.ShowMessageField != 1))
                rfv.ValidationGroup = "ValidationGroupForm" + Field.IdForm.ToString();
            else
                rfv.ValidationGroup = "closedPupup";
            rfv.EnableClientScript = true;
            c.Controls.Add(rfv);
            rfv.Enabled = ddl.Items.Count > 1;
        }

        else if (Field.FieldRequiredRelationParents.Count() > 0)
        {

            RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id };
            rfv.ErrorMessage = "Поле обязательно к заполнению";
            rfv.Display = ValidatorDisplay.Dynamic;
            rfv.CssClass = "error";
            rfv.ControlToValidate = ddl.ID;
            //add new 17032017 
            if (Field.Form.HasSaveButton == 1 || (Field.Form.HasSendEmailButton == 1 && Field.Form.ShowSubjectField != 1 && Field.Form.ShowMessageField != 1))
                rfv.ValidationGroup = "ValidationGroupForm" + Field.IdForm.ToString();
            else
                rfv.ValidationGroup = "closedPupup";

            rfv.EnableClientScript = true;

            c.Controls.Add(rfv);
            rfv.Attributes["IdFormField"] = Field.Id.ToString();
            rfv.Attributes["FormId"] = Field.IdForm.ToString();
            rfv.Load += new EventHandler(handlerAddOnFieldHandler);
            //tb.PreRender += new EventHandler(handlerAddOnFieldHandler);


        }



        return c;
    }


    private static void btnEmailSendFormClick(object sender, EventArgs e)
    {
        var btnEmailSendForm = sender as Button;
        int IdForm = Convert.ToInt32(btnEmailSendForm.Attributes["IdForm"]);
        sendForm(IdForm);
    }


    private static void btnSaverFormClick(object sender, EventArgs e)
    {
        var btnSaverForm = sender as Button;
        int IdForm = Convert.ToInt32(btnSaverForm.Attributes["IdForm"]);
        saveForm(IdForm);
        //((Panel)findControlI(Page, "PanelForm" + IdForm)).Visible = false;  
    }


    public static string setting(string code)
    {

        using (TaskSettingContext db = new TaskSettingContext())
        {
            var settings = db.TaskSettings.SqlQuery("SELECT * FROM [INBOUND].[dbo].[cc_TaskSetting] WITH(NOLOCK) WHERE IdTask = " + IdTask + " AND [IdSetting] = (SELECT Id FROM [dbo].[cc_TypeSetting] WITH(NOLOCK) WHERE [SystemTitle] = '" + code + "')");

            return settings.Count() > 0 ? settings.First().Value : "";
        }
    }


    private static void btnEmailFormClick(object sender, EventArgs e)
    {
        var btnEmailForm = sender as Button;
        int IdForm = Convert.ToInt32(btnEmailForm.Attributes["IdForm"]);
        var PanelFormEmail = ((Panel)findControlI(_Page, "PanelFormEmail" + IdForm));

        if (((RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + IdForm + "_subject")) != null && ((RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + IdForm + "_Message")) != null)
            PanelFormEmail.Visible = !((Panel)findControlI(_Page, "PanelFormEmail" + IdForm)).Visible;
        else
        {

            sendForm(IdForm);
            return;
        }
        if (((RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + IdForm + "_subject")) != null)
            ((RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + IdForm + "_subject")).Enabled = PanelFormEmail.Visible;
        if (((RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + IdForm + "_Message")) != null)
            ((RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + IdForm + "_Message")).Enabled = PanelFormEmail.Visible;
    }


    private static void formFieldDropDownListDataBinding(object sender, EventArgs e)
    {
        var ddl = sender as DropDownList;
        Control pddl = findControlI(_Page, ddl.Attributes["ParentIdFormField"]);
        string SelectedValue = ddl.Attributes["SelectedValue"] != null ? ddl.Attributes["SelectedValue"].ToString() : null;
        Control pddl2 = null;
        if (ddl.Attributes["ParentIdFormField2"] != "")
            pddl2 = findControlI(_Page, ddl.Attributes["ParentIdFormField2"]);



        if (pddl != null && (pddl as DropDownList).SelectedIndex > 0)
        {

            var IdParent = Convert.ToInt32((pddl as DropDownList).SelectedValue);



            int IdFormField = Convert.ToInt32(ddl.Attributes["IdFormField"]);

            //Response.Write(IdParent);
            //Response.Write(ddl.Attributes["IdParent"]);

            FormContext db = new FormContext();
            FormField Field = db.FormFields.Find(IdFormField);
            int IdParent2 = 0;

            if (pddl2 != null && pddl2 is DropDownList)
            {
                IdParent2 = (pddl2 as DropDownList).SelectedIndex > 0 ? Convert.ToInt32((pddl2 as DropDownList).SelectedValue) : 0;
            }

            if (ddl.Attributes["IdParent"] == IdParent.ToString() && ddl.Attributes["IdParent2"] == IdParent2.ToString())
            {
                if (Field.FieldDropDownListValueNotes.Count > 0)
                {

                    foreach (FieldDropDownListValueNote Value in Field.FieldDropDownListValueNotes)
                    {
                        var item = ddl.Items.FindByValue(Value.IdReferenceBookData.ToString());
                        if (item != null)
                        {
                            item.Attributes["note"] = "note";
                            item.Attributes["required"] = Value.Required.ToString();
                        }
                    }
                }
                return;
            }

            ddl.Attributes["IdParent"] = IdParent.ToString();
            ddl.Attributes["IdParent2"] = IdParent2.ToString();
            List<ReferenceBookData> ReferenceBookDatas;

            if (pddl2 != null && pddl2 is DropDownList)
            {

                ReferenceBookDatas = Field.FieldDropDownListReferenceBookRelations.ToList()[0].ReferenceBook.ReferenceBookDatas.Where(p => p.IdParent == IdParent && p.IdParent2 == IdParent2).ToList();
                if (ReferenceBookDatas.Count == 0)
                    ReferenceBookDatas = Field.FieldDropDownListReferenceBookRelations.ToList()[0].ReferenceBook.ReferenceBookDatas.Where(p => p.IdParent == IdParent && p.IdParent2 == 0).ToList();
            }
            else
            {
                var ReferenceBookId = Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ReferenceBook.Id;
                ReferenceBookDatas = db.ReferenceBookDatas.Where(p => p.IdReferenceBook == ReferenceBookId && p.IdParent == IdParent).ToList();
            }

            ddl.Items.Clear();
            ddl.Items.Add("");

            foreach (ReferenceBookData Data in ReferenceBookDatas.OrderBy(r => r.Sort).ThenBy(r2 => r2.Title).ToList())
            {
                var li = new ListItem(Data.Title, Data.Id.ToString());
                li.Attributes["IdParent"] = Data.IdParent.ToString();
                ddl.Items.Add(li);
            }
            //Response.Write(11);
            if (SelectedValue != null && ddl.Items.FindByValue(SelectedValue) != null)
            {
                ddl.SelectedValue = SelectedValue;
            }

            if (Field.Required == 1)
            {
                RequiredFieldValidator rfv = (RequiredFieldValidator)findControlI(_Page, "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id);
                rfv.Enabled = ddl.Items.Count > 1;

            }

            foreach (Control c in ddl.Parent.Controls)
            {
                if (c is TextBox)
                {
                    (c as TextBox).Visible = ddl.SelectedItem.Attributes["note"] == "note";
                    (c as TextBox).Text = ddl.SelectedItem.Attributes["note"] == "note" ? (c as TextBox).Text : "";
                }
            }

        }
        else if (pddl != null && (pddl as DropDownList).SelectedIndex == 0)
        {

            ddl.Items.Clear();
            ddl.Items.Add("");
        }
    }


    private static void formFieldDropDownListSelectedIndexChanged(object sender, EventArgs e)
    {
        var ddl = sender as DropDownList;
        TextBox TextBoxNote = null;
        foreach (Control c in ddl.Parent.Controls)
        {
            if (c is TextBox)
            {
                TextBoxNote = c as TextBox;
                TextBoxNote.Visible = ddl.SelectedItem.Attributes["note"] == "note";
                TextBoxNote.Text = ddl.SelectedItem.Attributes["note"] == "note" ? TextBoxNote.Text : "";



            }
        }
        if (TextBoxNote != null)
            foreach (Control c in ddl.Parent.Controls)
            {
                if (c is RequiredFieldValidator)
                {
                    if ((c as RequiredFieldValidator).ControlToValidate == TextBoxNote.ID)
                    {
                        RequiredFieldValidator rfv = (RequiredFieldValidator)c;
                        rfv.Enabled = TextBoxNote.Visible && ddl.SelectedItem.Attributes["required"] == "1";
                    }

                }
            }
    }


    private static void handlerAddOnFieldHandler(object sender, EventArgs e)
    {
        var rfv = sender as RequiredFieldValidator;
        rfv.Enabled = false;
        int IdField = Convert.ToInt32(rfv.Attributes["IdFormField"]);
        int IdForm = Convert.ToInt32(rfv.Attributes["FormId"]);
        FormContext db = new FormContext();
        var Field = db.FormFields.Find(IdField);
        foreach (FieldRequiredRelationParent frrp in Field.FieldRequiredRelationParents.ToList())
        {
            Control control = (Control)findControlI(findControlParent(rfv, "PanelForm" + IdForm), "FormField" + Field.IdForm + "_" + frrp.ParentIdFormField);

            if (control is DropDownList)
            {
                DropDownList ddl = control as DropDownList;


                if (ddl.SelectedIndex > 0 && !rfv.Enabled)
                {
                    rfv.Enabled = Field.FieldRequiredRelationParents.Count(
                        p => p.IdFormField == IdField && p.ParentIdFormField == frrp.ParentIdFormField && p.IdValue == Convert.ToInt32(ddl.SelectedValue) && !p.Deleted) > 0;

                    rfv.Attributes["test"] += "| IdFormField=" + IdField + " ParentIdFormField=" + IdField + " IdValue = " + ddl.SelectedValue;
                    return;
                }
            }
        }
    }

    private static void sendForm(int IdForm)
    {
        FormContext db = new FormContext();
        Form f = db.Forms.Find(IdForm);
        Control pf = findControlI(_Page, "PanelForm" + IdForm);

        if (pf != null)
        {


            var ET = new EmailTemplate(f.EmailTemplate == null ? "" : f.EmailTemplate);

            string result = "";
            result += "Дата и время: " + DateTime.Now + Environment.NewLine;

            ET.AddParam("АОН", (Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : ""));
            ET.AddParam("Дата и время обращения", DateTime.Now.ToString());
            ET.AddParam("Оператор", Operator);

            List<FormField> FormFields = f.FormFields.ToList();


            string ValueToSubject = "";

            foreach (FormField ff in FormFields)
            {

                FormResult fr = new FormResult() { Deleted = Request.QueryString["debug"] != null ? 1 : 0, IdFormSaved = 0, IdPopupLoad = IdPopupLoad, IdField = ff.Id, IdForm = ff.IdForm, IdTask = IdTask, IdProject = IdProject, Active = 1, Created = DateTime.Now, Updated = DateTime.Now };
                System.Type T = null;
                if (ff.FormTypeField.SystemTitle != "")
                {
                    try { T = System.Web.Compilation.BuildManager.GetType("FormField" + ff.FormTypeField.SystemTitle, true); }
                    catch (Exception e) { };
                };
                if (T == null)
                    switch (ff.FormTypeField.Id)
                    {
                        case 2: handlerFieldDropDownList(fr, ff); break;
                    }
                else
                {
                    object Obj = Activator.CreateInstance(T);
                    Control cObj = (Control)Obj.GetType().InvokeMember("handlerResult", System.Reflection.BindingFlags.Default | System.Reflection.BindingFlags.InvokeMethod, null, Obj, new object[] { ff, fr, _Page });
                }
                result += ff.Title + ": " + fr.Value + (fr.Note != "" ? ", " : "") + fr.Note + Environment.NewLine;
                ET.AddParam(ff.Title, fr.Value + (fr.Note != "" ? ", " : "") + fr.Note);

                if (ff.InSubjectEmail == true)
                    ValueToSubject += (ValueToSubject != "" ? " -> " : "") + fr.Value + (fr.Note != "" ? ", " : "") + fr.Note;
            }




            var TextBoxMessage = (TextBox)findControlI(_Page, "TableFormEmailMessage" + IdForm);
            var TextBoxSubject = (TextBox)findControlI(_Page, "TableFormEmailSubject" + IdForm);

            if (TextBoxMessage != null)
                result += "Суть вопроса: " + TextBoxMessage.Text + Environment.NewLine;

            HiddenField hf = (HiddenField)findControlI(_Page, "PanelFormHiddenFieldEmail" + IdForm);
            string emails = hf.Value;
            Label Messager = (Label)findControlI(_Page, "MessagerForm" + IdForm);
            try
            {
                result = result.Replace(Environment.NewLine, "<br/>");
                if (f.EmailTemplate != null && f.EmailTemplate != "" && f.IsBodyHtml)
                    result = ET.GetFullBody();
                EmailSender.sendEmail(emails, result, (TextBoxSubject != null && TextBoxSubject.Text != "" ? TextBoxSubject.Text : f.Title) + (ValueToSubject != "" ? (" : " + ValueToSubject) : ""),IdTask,IdProject,IdPopupLoad, true, f.Id, f.IsBodyHtml  );
                Messager.Text = "Форма отправлена";
                Messager.Visible = true;
                Messager.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception err)
            {
                Messager.Text = err.Message.ToString();
                Messager.Visible = true;
                Messager.ForeColor = System.Drawing.Color.Red;
            }




        }
    }


    private static void saveForm(int IdForm)
    {
        FormContext db = new FormContext();
        Form f = db.Forms.Find(IdForm);
        Control pf = findControlI(_Page, "PanelForm" + IdForm);
        String EmailTo = "";
        String Subject = "";
        string ValueToSubject = "";

        FormRender.IsUpdated = Request.QueryString["IsUpdated"] != null? Convert.ToBoolean(Request.QueryString["IsUpdated"]):false;


        List<FormResult> frs = new List<FormResult>();
        FormResult fr1 = new FormResult();
        if (IsUpdated)
        {
            fr1 = db.FormResults.FirstOrDefault(row => row.IdPopupLoad == IdPopupLoad && row.Deleted == 0);
            frs = db.FormResults.Where(row => row.IdFormSaved == fr1.IdFormSaved).ToList();

        }


        FormSaved fs = new FormSaved();

        if (pf != null)
        {
            if (!IsUpdated)
            {
                fs = new FormSaved();
                fs.Created = DateTime.Now;
                db.FormSaveds.Add(fs);
                db.SaveChanges();
            }
            else
            {
                fs = db.FormSaveds.Find(fr1.IdFormSaved);

            }

            var ET = new EmailTemplate(f.EmailTemplate == null ? "" : f.EmailTemplate);



            string result = "";
            result += setting("EMAIL_PRETEXT") + Environment.NewLine;
            result += "ОБРАЩЕНИЕ №: " + fs.Id + Environment.NewLine;
            ET.AddParam("АОН", (Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : ""));
            result += "АОН: " + (Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : "") + Environment.NewLine;
            ET.AddParam("Дата и время обращения", DateTime.Now.ToString());
            result += "Дата и время обращения: " + DateTime.Now + Environment.NewLine;
            ET.AddParam("Оператор", Operator);
            result += "Оператор: " + Operator + Environment.NewLine;
            if (f.IdTask == 4)
            {
                result += getFramePath();
            }
            List<FormField> FormFields = f.FormFields.Where(p => p.Active == 1 && p.Deleted == 0).ToList();

            foreach (FormField ff in FormFields)
            {


                FormResult fr = new FormResult();
                if (IsUpdated)
                    fr = frs.FirstOrDefault(row => row.IdField == ff.Id);
                else
                    fr = new FormResult() { Deleted = Request.QueryString["debug"] != null ? 1 : 0, IdFormSaved = fs.Id, IdPopupLoad = IdPopupLoad, IdField = ff.Id, IdForm = ff.IdForm, IdTask = IdTask, IdProject = IdProject, Active = 1, Created = DateTime.Now, Updated = DateTime.Now };

                System.Type T = null;
                if (ff.FormTypeField.SystemTitle != "")
                {
                    try { T = System.Web.Compilation.BuildManager.GetType("FormField" + ff.FormTypeField.SystemTitle, true); }
                    catch (Exception e) { };
                };
                if (T == null)
                    switch (ff.FormTypeField.Id)
                    {
                        case 2:
                            handlerFieldDropDownList(fr, ff);
                            if (ff.FormEmails.Count(p => p.IdReferenceBookData == fr.IdValue) > 0)
                            {
                                var objEmail = ff.FormEmails.First(p => p.IdReferenceBookData == fr.IdValue);
                                if (objEmail != null)
                                {
                                    EmailTo += (EmailTo == "" ? "" : ", ") + objEmail.Email;
                                    Subject += (Subject == "" ? "" : ", ") + objEmail.Subject;

                                };
                            };
                            break;
                    }
                else
                {
                    object Obj = Activator.CreateInstance(T);
                    Control cObj = (Control)Obj.GetType().InvokeMember("handlerResult", System.Reflection.BindingFlags.Default | System.Reflection.BindingFlags.InvokeMethod, null, Obj, new object[] { ff, fr, _Page });
                }
                result += ff.Title + ": " + fr.Value + (fr.Note != "" ? ", " : "") + fr.Note + Environment.NewLine;

                ET.AddParam(ff.Title, fr.Value + (fr.Note != "" ? ", " : "") + fr.Note);

                if (!IsUpdated)
                    db.FormResults.Add(fr);

                if (ff.InSubjectEmail == true)
                    ValueToSubject += (ValueToSubject != "" ? " -> " : "") + fr.Value + (fr.Note != "" ? ", " : "") + fr.Note;
            }

            db.SaveChanges();

            if (f.SendToEmail == 1)
            {

                HiddenField hf = (HiddenField)findControlI(_Page, "PanelFormHiddenFieldEmail" + IdForm);
                string emails = hf.Value;
                Label Messager = (Label)findControlI(_Page, "MessagerForm" + IdForm);
                if (EmailTo != "") emails += (emails != "" ? "," : "") + EmailTo;

                try
                {
                    if (emails != "")
                    {
                        if (f.IsBodyHtml)
                            result = result.Replace(Environment.NewLine, "<br/>");

                        if (f.EmailTemplate != null && f.EmailTemplate != "" && f.IsBodyHtml)
                            result = ET.GetFullBody();

                        EmailSender.sendEmail(emails, result, (Subject != "" ? Subject : f.Title) + (ValueToSubject != "" ? (" : " + ValueToSubject) : ""),IdTask,IdProject,IdPopupLoad, true, f.Id, f.IsBodyHtml);

                        Messager.Text = "Форма отправлена";
                        Messager.Visible = true;
                        Messager.ForeColor = System.Drawing.Color.Green;
                    }
                }
                catch (Exception err)
                {
                    Messager.Text = err.Message.ToString();
                    Messager.Visible = true;
                    Messager.ForeColor = System.Drawing.Color.Red;
                }

            };

            if (f.HasSaveButton == 1)
            {
                if (f.SendToEmail == 0)
                {
                    Label Messager = (Label)findControlI(_Page, "MessagerForm" + IdForm);
                    Messager.Text = "Форма сохранена";
                    Messager.Visible = true;
                    Messager.ForeColor = System.Drawing.Color.Green;
                }
                if (!IsUpdated)
                    foreach (FormField ff in FormFields)
                    {
                        switch (ff.FormTypeField.Id)
                        {
                            case 1: ((TextBox)findControlI(_Page, "FormField" + ff.IdForm + "_" + ff.Id)).Text = ""; break;
                            case 2:
                                DropDownList ddl = (DropDownList)findControlI(_Page, "FormField" + ff.IdForm + "_" + ff.Id);
                                if (ddl.Enabled)
                                    ddl.SelectedIndex = -1;
                                TextBox tb = (TextBox)findControlI(_Page, "TextBoxForm" + ff.IdForm + "_" + ff.Id);
                                if (tb != null)
                                    tb.Text = "";
                                break;
                        }

                    }
            }

        }
    }


    public static void saveForms()
    {
        FormContext db = new FormContext();
        List<Form> Forms = db.Forms.Where(p => p.IdTask == IdTask && p.Deleted == 0 && p.HasSaveButton == 0 && !(p.HasSendEmailButton == 1 && p.ShowSubjectField != 1 && p.ShowMessageField != 1)).ToList();
        foreach (Form f in Forms)
        {
            saveForm(f.Id);
        }

    }



    public static Control findControlI(Control Ctrl, string ID)
    {
        //iterate parent control
        foreach (Control c in Ctrl.Controls)
        {

            if (c.ID == ID)
            {
                return c;
            }
            //iterate childlren
            if (c.Controls.Count != 0)
            {
                var rs = findControlI(c, ID);
                if (rs != null) return rs;
            }
        }
        return null;
    }



    public static Control findControlParent(Control Ctrl, string ID)
    {
        if (Ctrl.Parent == null) return null;
        if (Ctrl.Parent.ID == ID) return Ctrl.Parent;
        else return findControlParent(Ctrl.Parent, ID);
    }



    private static void handlerFieldDropDownList(FormResult fr, FormField ff)
    {
        DropDownList ddl = (DropDownList)findControlI(_Page, "FormField" + ff.IdForm + "_" + ff.Id);
        TextBox tb = (TextBox)findControlI(_Page, "TextBoxForm" + ff.IdForm + "_" + ff.Id);
        fr.IdValue = ddl.SelectedIndex > 0 ? Convert.ToInt32(ddl.SelectedValue) : 0;
        fr.Value = ddl.SelectedIndex > 0 ? ddl.SelectedItem.Text : "";
        fr.Note = ddl.SelectedItem.Attributes["note"] == "note" && tb.Visible ? tb.Text : "";
    }



    private static string getFramePath()
    {
        return "Фрейм: " + getFramePathFromSQL() + Environment.NewLine;
    }

    static string getFramePathFromSQL()
    {


        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["INBOUNDConnectionString"];

        string FramePath = "";

        try
        {


            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("SELECT STUFF(( SELECT '::' + Convert(varchar(200), a.Answer) + '' FROM [Questionary].[dbo].[crm_scenario_Saved_Answers] WITH(NOLOCK)  , [Questionary].dbo.crm_scenario_Answers a WHERE [IdSession] = @IdSession and [IdAnswer] = a.ID AND [IsBack] = 0  FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)'), 1, 2, '')", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@IdSession", IdPopupLoad);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            if (myOdbcReader.Read())
            {
                FramePath = myOdbcReader.GetValue(0).ToString();
            }
            myOdbcReader.Close();
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



        return FramePath;

    }





}