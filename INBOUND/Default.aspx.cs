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
using System.Collections.Generic;
using System.Web.Configuration;
using System.Net;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    public PopupLoad pl; 
    public bool IsUpdated; 

    private int savePopupLoad()
    {
        PopupLoadContext db = new PopupLoadContext();

        PopupLoad pl = new PopupLoad();
        IsUpdated = Request.QueryString["IsUpdated"]!=null;
        if (Request.QueryString["IdPopupLoad"] != null && Request.QueryString["IdPopupLoad"].ToString()!="0")
        {
            
            
            pl = db.PopupLoads.Find(Convert.ToInt32(Request.QueryString["IdPopupLoad"]));
        }
        else
        {

            pl.AbonentNumber = Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : "";
            pl.IdTask = IdTask;
            pl.CalledNumber = Request.QueryString["CalledNumber"] != null ? Request.QueryString["CalledNumber"].ToString() : "";
            pl.Oktell_IdInList =  Request.QueryString["Oktell_IdInList"] != null ? Convert.ToInt32(Request.QueryString["Oktell_IdInList"]) : 0;
            pl.IdProject = IdProject;
            pl.IdOperator = Request.QueryString["IdOperator"] != null ? Guid.Parse(Request.QueryString["IdOperator"]) : Guid.Empty;
            pl.Operator = Request.QueryString["Operator"];
            pl.Oktell_IdProject = Request.QueryString["Oktell_IdProject"] != null ? Guid.Parse(Request.QueryString["Oktell_IdProject"]) : Guid.Empty;
            pl.Oktell_IdTask = Request.QueryString["Oktell_IdTask"] != null ? Guid.Parse(Request.QueryString["Oktell_IdTask"]) : Guid.Empty;
            pl.Oktell_IdConn = Request.QueryString["Oktell_IdConn"] != null ? Guid.Parse(Request.QueryString["Oktell_IdConn"]) : Guid.Empty;
            pl.Oktell_IdChain = Request.QueryString["Oktell_IdChain"] != null ? Guid.Parse(Request.QueryString["Oktell_IdChain"]) :
                (Request.QueryString["Oketll_IdChain"] != null ? Guid.Parse(Request.QueryString["Oketll_IdChain"]) :
                Guid.Empty);
            pl.Oktell_IdEffort = Request.QueryString["Oktell_IdEffort"] != null ? Guid.Parse(Request.QueryString["Oktell_IdEffort"]) : Guid.Empty;
            pl.Opened = DateTime.Now;
            pl.Deleted = Request.QueryString["debug"] != null ?1:0;
            db.PopupLoads.Add(pl);
            db.SaveChanges();
        }
        this.pl = pl;
        return pl.Id;
         
    }


    public int IdPopupLoad { get {
        return Session.Contents["IdPopupLoad"] != null ?
            Convert.ToInt32(Session.Contents["IdPopupLoad"]) : -1; 
    }
        set { HiddenFieldIdPopupLoad.Value = value.ToString(); Session.Contents["IdPopupLoad"] = value.ToString(); }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        saveGetParam();
        if (!IsPostBack)
        {
            IdPopupLoad = savePopupLoad();
            setMainSettings();

        };
        createTabs();
    }

    private void createTabs()
    {
       
        TaskTabContext db = new TaskTabContext();
        IEnumerable<TaskTab> TaskTabs = db.TaskTabs.Where(p => p.IdTask == IdTask && p.Active == 1 && p.Deleted == 0).OrderBy(p=>p.Sort);
        List<TaskTab> tt = TaskTabs.ToList();
        foreach (TaskTab p in tt)
        {
            
            var tab = new AjaxControlToolkit.TabPanel();
            tab.ID = "TabPanel" + (TabContainerMain.Tabs.Count+1);
            tab.HeaderText = p.Title;
            var objects = p.TabObjects.Where(to=>to.Active==1).OrderBy(to=>to.Sort).ToList();
            foreach (TabObject o in objects)
            { 
               Control c = getControlTab(o);
               tab.Controls.Add(c);  
            }
            TabContainerMain.Tabs.Add(tab); 
        }


        
        
    }


    private Control getControlTab(TabObject Object)
    { 
        Control c = new LiteralControl("");
        switch (Object.TypeObject.SystemTitle)
        {
            case "FORM": c = renderObjectForm(Object); break;
            case "FAQ": c = renderObjectFAQ(Object); break;
            case "SCENARIO": c = renderObjectScenario(Object); break;
            case "CONTACT": c = renderObjectContact(Object); break;
            case "CONTACT2": c = renderObjectContact2(Object); break;
            case "HTML": c = renderObjectHTML(Object); break;
            case "IFRAME": c = renderObjectIFRAME(Object); break;
        }
        return c;
    }

    private Control renderObjectIFRAME(TabObject Object)
    {
        PopupLoadContext db = new PopupLoadContext();
        var Iframe = db.Iframes.Find(Object.IdObject);
        var QueryString = "";
        foreach (var param in Request.QueryString.AllKeys)
        {
            QueryString += "&" + param + "=" + Request.QueryString[param].ToString();
        };
        Control c = new LiteralControl("<iframe src=\"" + Iframe.Url + "?IdTask="+ IdTask + QueryString + "\" width=\"100%\" height=\"600\"></iframe>");
        return c; 
    }

    private Control renderObjectHTML(TabObject Object)
    {
        Control c = new UpdatePanel() { ID = "UpdatePanelObject" + Object.Id };
        PopupLoadContext db = new PopupLoadContext();
        var Html = db.Htmls.Find(Object.IdObject);
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(new Label() { ID = "ObjectData" + Object.Id, Visible = true, Text = Html.HTML });  
        return c;
    }

    private Control renderObjectContact(TabObject Object)
    {

        Control c = new UpdatePanel() { ID = "UpdatePanelContact" + Object.Id };
        
        int FormId = setting("EMAIL_FORM_ID")!=""?Convert.ToInt32(setting("EMAIL_FORM_ID")):0;
        ContactContext db = new ContactContext();
        List<ContactTypeProperty> ContactTypeProperties = db.ContactTypeProperties.Where(p => p.IdTask == IdTask && p.Active == 1 && p.Deleted == 0).ToList();
        if(ContactTypeProperties.Count>0){
            Table table = new Table() { ID = "TableContactFilter" + Object.Id };
            
            foreach (ContactTypeProperty ctp in ContactTypeProperties)
            {
                TableRow tr = new TableRow();
                tr.Cells.Add(new TableCell() { Text = ctp.Title });
                TableCell td = new TableCell();
                DropDownList ddl = new DropDownList() { ID = "DropDownListContactPropery" + Object.Id + "_" + ctp.Id };
                List<ReferenceBookData> ReferenceBookDatas = new List<ReferenceBookData>();
                ddl.Attributes["ObjectId"] = Object.Id.ToString();
                ddl.Attributes["PropertyId"] = ctp.Id.ToString();
                ddl.Attributes["FormFieldId"] = ctp.IdFormField.ToString();
                 
                ddl.Attributes["FormId"] = FormId.ToString();
                ReferenceBookDatas = ctp.ReferenceBook.ReferenceBookDatas.Where(p=>p.Active==1 && p.Deleted==0).ToList();
                ddl.Items.Add("");
                foreach (ReferenceBookData Data in ReferenceBookDatas)
                {
                    var li = new ListItem(Data.Title, Data.Id.ToString()); 
                    ddl.Items.Add(li);
                }
                ddl.SelectedIndexChanged += new EventHandler(ContactFilterDropDownListSelectedIndexChanged);
                ddl.SelectedIndexChanged += new EventHandler(ContactFilterDropDownListSelectedIndexChanged2);
                ddl.Load += new EventHandler(ContactFilterDropDownListSelectedIndexChanged);
                ddl.AutoPostBack = true;
                td.Controls.Add(ddl); tr.Cells.Add(td); 
                table.Rows.Add(tr);
            }
            (c as UpdatePanel).ContentTemplateContainer.Controls.Add(table);
        }

        Table table_contacts = new Table() { ID = "TableContacts" + Object.Id };
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(table_contacts);

        Timer timer = new Timer() { ID = "TimerContact" + Object.Id };
        timer.Interval = 1000;
        timer.Tick += timerCheckStatusCalling;
        timer.Enabled = false; 
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(timer);

        var TRANSFERED_PHONE = setting("TRANSFERED_PHONE"); 
        Control HiddenFieldTP = new LiteralControl("<input type=\"hidden\" id=\"HiddenFieldTP" + Object.Id + "\" value=\"" + TRANSFERED_PHONE + "\"/>");
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(HiddenFieldTP);


        var TRANSFERED_QUEUE = setting("TRANSFERED_QUEUE");
        Control HiddenFieldTQ = new LiteralControl("<input type=\"hidden\" id=\"HiddenFieldTQ" + Object.Id + "\" value=\"" + TRANSFERED_QUEUE + "\"/>");
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(HiddenFieldTQ);

        
        
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(renderFormSendEmail(Object.Id, FormId));

        //fillingContact(table_contacts, Object.Id);

        return c;

    }



    private void btnProperty_Click(object sender, EventArgs e)
    {
        var btnProperty = (sender as Button);
        string ObjectId = btnProperty.Attributes["ObjectId"];
        string PropertyId = btnProperty.Attributes["PropertyId"];
        UpdatePanel c = (UpdatePanel)findControlI(Page, "UpdatePanelContact2" + ObjectId);
        c.ContentTemplateContainer.Controls.Clear();

        renderObjectContact2(ObjectId, c, PropertyId);
        //int i =  c.Parent.Controls.IndexOf(c);
       // c.Parent.Controls.RemoveAt(i);
       // c.Parent.
        //    i = 0;
    }

    private Control renderObjectContact2(String ObjectId, UpdatePanel c, String PropertyId)
    { 
        var Object = new TabObject();
        Object.Id = Convert.ToInt32(ObjectId);
        return renderObjectContact2(Object, c, Convert.ToInt32(PropertyId));
    }

    private Control renderObjectContact2(TabObject Object, UpdatePanel up = null, int? PropertyId = null)
    {
        Control c;
        if(up != null)
            c = up as Control;
        else 
            c = new UpdatePanel() { ID = "UpdatePanelContact2" + Object.Id };

        TimeSpan ts = DateTime.Now.TimeOfDay;

        ContactContext db = new ContactContext();

        List<ContactPersonPropertyType> ContactPersonPropertyTypies = db.ContactPersonPropertyTypies.Where(p => p.IdTask == IdTask && p.Active == 1 && p.Deleted == 0).ToList();
        if (ContactPersonPropertyTypies.Count > 0)
        {
            Table table_property_sort = new Table() { ID = "TableContactPersonsProperty" + Object.Id };
            table_property_sort.CellPadding = 5;
            var th = new TableRow();
            var tc = new TableCell(); 
            var btn = new Button() { Text = "По сотрудникам" };
            tc.Controls.Add(btn);
            th.Cells.Add(tc);

            foreach (ContactPersonPropertyType ctp in ContactPersonPropertyTypies)
            {
                var btnProperty = new Button() { Text = ctp.Title };
                btnProperty.Click -= btnProperty_Click;
                btnProperty.Click += btnProperty_Click;
                btnProperty.Attributes["ObjectId"] = Object.Id.ToString();
                btnProperty.Attributes["PropertyId"] = ctp.Id.ToString();
                var tcp = new TableCell();
                tcp.Controls.Add(btnProperty);
                th.Cells.Add(tcp); 
            }
            table_property_sort.Rows.Add(th);
            (c as UpdatePanel).ContentTemplateContainer.Controls.Add(table_property_sort);
            
        }

        List<ContactPerson> ContactPersons = db.ContactPersons.Where(p => p.IdTask == IdTask && p.Active == 1 && p.Deleted == 0).ToList();
        if (ContactPersons.Count > 0)
        {
            Table table_contacts = new Table() { ID = "TableContactPersons" + Object.Id };
            table_contacts.BorderWidth = 1;
            table_contacts.GridLines = GridLines.Both;
           // table_contacts.Width = 1000;
            table_contacts.CellPadding = 5;

            if (PropertyId != null)
            {

                foreach (ContactPersonPropertyType ctp in ContactPersonPropertyTypies)
                {
                    if (ctp.Id == PropertyId)
                    {
                        foreach (var data in ctp.ReferenceBook.ReferenceBookDatas.Where(p => p.Active == 1).OrderBy(p=>p.Sort))
                        {

                            var thp = new TableHeaderRow();
                            var tcp = new TableCell() { Text = data.Title };
                            tcp.Font.Size = 20;
                            tcp.HorizontalAlign = HorizontalAlign.Center;
                            tcp.ColumnSpan = 5;
                            thp.Cells.Add(tcp);
                            table_contacts.Rows.Add(thp);
                            var th = new TableHeaderRow();
                            th.Cells.Add(new TableHeaderCell() { Text = "ФИО Сотрудника" });
                            th.Cells.Add(new TableHeaderCell() { Text = " внутренний номер" });
                            th.Cells.Add(new TableHeaderCell() { Text = " Режим работы" });
                            th.Cells.Add(new TableHeaderCell() { Text = " Почта" });
                            th.Cells.Add(new TableHeaderCell() { Text = " Должность" });
                            table_contacts.Rows.Add(th);
                            foreach (ContactPerson cp in ContactPersons)
                            {
                                if (cp.ContactPersonProperties == null) continue;
                                if (cp.ContactPersonProperties.Count(p => p.IdProperty==PropertyId && p.IdPropertyValue == data.Id) == 0) continue;
                                var tr = new TableRow();
                                tr.Cells.Add(new TableCell() { Text = cp.FIO });
                                string contacts = "";
                                var tdPhone = new TableCell() { HorizontalAlign = HorizontalAlign.Center };
                                foreach (var contact in cp.Contacts.Where(p => p.IdType == 1 && p.Active == 1 && p.Deleted == 0))
                                {
                                    contacts += (contacts != "" ? ", " : "") + contact.ContactValue;
                                    var btn = new Button() { Text = contact.ContactValue, CssClass = "oktell_transfer" };
                                    btn.Attributes["prefix"] = setting("TRANSFERED_PREFIX");
                                    tdPhone.Controls.Add(btn);
                                }

                                

                                tr.Cells.Add(tdPhone);

                                var cell = new TableCell() { Text = cp.StartTimeWork.ToString().Substring(0, 5) + " - " + cp.EndTimeWork.ToString().Substring(0, 5) };
                                if (ts >= cp.StartTimeWork && ts <= cp.EndTimeWork)
                                {
                                    cell.ForeColor = System.Drawing.Color.Green;
                                    cell.Font.Bold = true;
                                }
                                else
                                    cell.ForeColor = System.Drawing.Color.Red;
                                cell.HorizontalAlign = HorizontalAlign.Center;
                                tr.Cells.Add(cell);
                                contacts = "";
                                foreach (var contact in cp.Contacts.Where(p => p.IdType == 2 && p.Active == 1 && p.Deleted == 0))
                                {
                                    contacts += (contacts != "" ? ", " : "") + contact.ContactValue;
                                }
                                tr.Cells.Add(new TableCell() { Text = contacts });
                                tr.Cells.Add(new TableCell() { Text = cp.Post });
                                table_contacts.Rows.Add(tr);
                            }
                        }
                        break;
                    }
                }
            }
            else
            {
                
                var th = new TableHeaderRow();
                th.Cells.Add(new TableHeaderCell() { Text = "ФИО Сотрудника" });
                th.Cells.Add(new TableHeaderCell() { Text = " внутренний номер" });
                th.Cells.Add(new TableHeaderCell() { Text = " Режим работы" });
                th.Cells.Add(new TableHeaderCell() { Text = " Почта" });
                th.Cells.Add(new TableHeaderCell() { Text = " Должность" });
                table_contacts.Rows.Add(th);
                foreach (ContactPerson cp in ContactPersons)
                {
                    var tr = new TableRow();
                    tr.Cells.Add(new TableCell() { Text = cp.FIO });
                    string contacts = "";
                    var tdPhone = new TableCell() { HorizontalAlign = HorizontalAlign.Center };
                    foreach (var contact in cp.Contacts.Where(p => p.IdType == 1 && p.Active == 1 && p.Deleted == 0))
                    {
                        contacts += (contacts != "" ? ", " : "") + contact.ContactValue;
                        var btn = new Button() { Text = contact.ContactValue, CssClass = "oktell_transfer" };
                        btn.Attributes["prefix"] = setting("TRANSFERED_PREFIX");
                        tdPhone.Controls.Add(btn);
                    }



                    tr.Cells.Add(tdPhone);
                    var cell = new TableCell() { Text = cp.StartTimeWork.ToString().Substring(0, 5) + " - " + cp.EndTimeWork.ToString().Substring(0, 5) };
                    if (ts >= cp.StartTimeWork && ts <= cp.EndTimeWork)
                    {
                        cell.ForeColor = System.Drawing.Color.Green;
                        cell.Font.Bold = true;
                    }
                    else
                        cell.ForeColor = System.Drawing.Color.Red;
                    cell.HorizontalAlign = HorizontalAlign.Center;
                    tr.Cells.Add(cell);
                    contacts = "";
                    foreach (var contact in cp.Contacts.Where(p => p.IdType == 2 && p.Active == 1 && p.Deleted == 0))
                    {
                        contacts += (contacts != "" ? ", " : "") + contact.ContactValue;
                    }
                    tr.Cells.Add(new TableCell() { Text = contacts });
                    tr.Cells.Add(new TableCell() { Text = cp.Post });
                    table_contacts.Rows.Add(tr);
                }
            }
            (c as UpdatePanel).ContentTemplateContainer.Controls.Add(table_contacts);
        }

        
        


        
        //fillingContact(table_contacts, Object.Id);

        return c;

    }

    private void ContactFilterDropDownListSelectedIndexChanged2(object sender, EventArgs e)
    {
        string ObjectId = (sender as DropDownList).Attributes["ObjectId"];
        string FormId = (sender as DropDownList).Attributes["FormId"];
        string IDPanelContactEmailForm = "PanelForm" + FormId;
        Panel PanelContactEmailForm = (Panel)findControlI(Page, IDPanelContactEmailForm);
        if (PanelContactEmailForm!=null)
        PanelContactEmailForm.Visible = false;
    }

    private Control renderFormSendEmail(int ObjectId, int IdForm)
    {  
        Control c = createForm(IdForm);
        c.Visible = false;
        return c;
    }


    private Control createForm(int IdForm)
    {
        FormContext db = new FormContext();
        Form Form = db.Forms.Find(IdForm);
        if (Form == null) return null;
        Control c = new Panel() { ID = "PanelForm" + IdForm };
        c.Controls.Add(new Label() { ID = "FormDescription" + IdForm, Visible = true, Text = Form.Description });
        c.Controls.Add(new Label() { ID = "MessagerForm" + IdForm, Visible = false, Text = "" });  

        List<FormField> FormFields = Form.FormFields.Where(p => p.Active == 1 && p.Deleted == 0).OrderBy(p => p.Sort).ToList();
        Table table = new Table() { ID = "TableForm" + IdForm };
        
        List<FormResult> frs = new List<FormResult>();
        if(IsUpdated)
        {  
           FormResult fr = db.FormResults.FirstOrDefault(row=>row.IdPopupLoad==IdPopupLoad);            
           frs = db.FormResults.Where(row=>row.IdFormSaved==fr.IdFormSaved).ToList();            
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
                try {   T = System.Web.Compilation.BuildManager.GetType("FormField" + Field.FormTypeField.SystemTitle, true);  }
                catch (Exception e) { }; 
            };
            if (T == null)
                switch (Field.FormTypeField.Id)
                { 
                    case 2: 
                        int IdValue = -1;
                        if(IsUpdated){
                            var fr  = frs.FirstOrDefault(row=>row.IdField == Field.Id);
                            if(fr!=null)
                                IdValue = fr.IdValue;
                        };
                        TableCell td = new TableCell(); td.Controls.Add(getControlFormDropDownList(Field, table, IdValue)); tr.Cells.Add(td); 
                        
                        break;
                }
            else
            { 
                string StrValue = "";
                        if(IsUpdated){
                            var fr  = frs.FirstOrDefault(row=>row.IdField == Field.Id);
                            if(fr!=null)
                                StrValue = fr.Value;
                        };
              
                object Obj = Activator.CreateInstance(T);
                Control cObj = (Control)Obj.GetType().InvokeMember("getControl", System.Reflection.BindingFlags.Default | System.Reflection.BindingFlags.InvokeMethod, null, Obj, new object[] { Field, Page, StrValue, IsUpdated });
                TableCell td1 = new TableCell();
                
                //Response.Write("FormField" + Field.FormTypeField.SystemTitle);
                //Response.End();

                td1.Controls.Add(cObj); tr.Cells.Add(td1);   
            }
            if (Field.TitleNote != null && Field.TitleNote != "")
                { 
                    var tr_caption = new TableRow();
                    var td_caption  = new TableCell(){  ColumnSpan=2 };
                    td_caption.Controls.Add(new LiteralControl("<b>"+Field.TitleNote+"<b>"));
                    tr_caption.Cells.Add(td_caption);
                    table.Rows.Add(tr_caption);
                }
            table.Rows.Add(tr);
        };
        if (Form.HasSaveButton==1) {
            TableRow tr = new TableRow();
            tr.Cells.Add(new TableCell());
            TableCell td = new TableCell();
            Button btnSaverForm = new Button() { ID = "ButtonSaverForm" + IdForm , Text = Form.SendToEmail==1? "ОТПРАВИТЬ":"СОХРАНИТЬ"};
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
            if (Form.HasSendEmailButton == 1 && setting("EMAIL_MAIN")!="")
                hf.Value = setting("EMAIL_MAIN");
            c.Controls.Add(hf);
        }

        c.Controls.Add(table);

        if (Form.HasSendEmailButton==1)
        {
            Button btnEmailForm = new Button() { ID = "ButtonEmailForm" + IdForm, Text = "ОТПРАВИТЬ ПИСЬМО" };
            btnEmailForm.Click += new EventHandler(btnEmailFormClick);
            btnEmailForm.Attributes["IdForm"] = IdForm.ToString();
            //add new 17032017
            if (Form.ShowSubjectField!=1 && Form.ShowMessageField!=1)
                btnEmailForm.ValidationGroup = "ValidationGroupForm" + IdForm.ToString();

            c.Controls.Add(btnEmailForm);

            Panel PanelFormEmail = new Panel() { ID = "PanelFormEmail" + IdForm, Visible = false };
            Table tableFormEmail = new Table() { ID = "TableFormEmail" + IdForm };
            if (Form.ShowSubjectField==1)
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

             if (Form.ShowMessageField==1)
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


    private void btnEmailSendFormClick(object sender, EventArgs e)
    {
        var btnEmailSendForm = sender as Button;
        int IdForm = Convert.ToInt32(btnEmailSendForm.Attributes["IdForm"]); 
        sendForm(IdForm); 
    }


    private void btnEmailFormClick(object sender, EventArgs e)
    {
        var btnEmailForm = sender as Button;
        int IdForm = Convert.ToInt32(btnEmailForm.Attributes["IdForm"]); 
        var PanelFormEmail = ((Panel)findControlI(Page, "PanelFormEmail" + IdForm));
       
        if(((RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + IdForm + "_subject"))!=null  && ((RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + IdForm + "_Message"))!=null)
        PanelFormEmail.Visible = !((Panel)findControlI(Page, "PanelFormEmail" + IdForm)).Visible;
        else
        { 
            
            sendForm(IdForm); 
            return;
        }
        if(((RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + IdForm + "_subject"))!=null)
        ((RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + IdForm + "_subject")).Enabled = PanelFormEmail.Visible;
        if(((RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + IdForm + "_Message"))!=null)
        ((RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + IdForm + "_Message")).Enabled = PanelFormEmail.Visible;
    }

    private void btnSaverFormClick(object sender, EventArgs e)
    {
        var btnSaverForm = sender as Button;
        int IdForm = Convert.ToInt32(btnSaverForm.Attributes["IdForm"]);
        saveForm(IdForm); 
        //((Panel)findControlI(Page, "PanelForm" + IdForm)).Visible = false;  
    }
     
    private void fillingContact(Table TableContacts, int ObjectId)
    {
        ContactContext db = new ContactContext();
        List<ContactTypeProperty> ContactTypeProperties = db.ContactTypeProperties.Where(p => p.IdTask == IdTask && p.Active == 1 && p.Deleted == 0).ToList();
        bool IsSelectedAll = true;
        int k = 0;
        foreach (ContactTypeProperty ctp in ContactTypeProperties)
        {
            string ID = "DropDownListContactPropery" + ObjectId.ToString() + "_" + ctp.Id;
            Control c = findControlI(Page, ID);
            if (c != null && c is DropDownList)
            {
                k++;
                if ((c as DropDownList).SelectedIndex < 1) IsSelectedAll = false;
            }
        }
        if (IsSelectedAll&&k>0)
        {
            int FormId = Convert.ToInt32(setting("EMAIL_FORM_ID"));

            

            var ContactProperties = db.ContactProperties.Where(p => p.IdTask == IdTask && p.Active == 1 && p.Deleted == 0);
            List<string> Where = new List<string>();
            foreach (ContactTypeProperty ctp in ContactTypeProperties)
            {
                string ID = "DropDownListContactPropery" + ObjectId + "_" + ctp.Id;
                Control c = findControlI(Page, ID);
                if (c != null && c is DropDownList)
                {
                    var ddl2 = c as DropDownList;
                    if (ddl2.SelectedIndex > 0)
                    {
                        int PropertyId = Convert.ToInt32(ddl2.Attributes["PropertyId"]);
                        int IdValue = Convert.ToInt32(ddl2.SelectedValue);
                        Where.Add(" ( IdProperty = " + PropertyId + " and IdValue  = " + ddl2.SelectedValue + " )");
                        int FormFieldId = Convert.ToInt32(ddl2.Attributes["FormFieldId"]);

                        string IDFormddl = "FormField" + FormId + "_" + FormFieldId;
                        DropDownList FormDdl = (DropDownList)findControlI(Page, IDFormddl);
                        FormDdl.SelectedIndex = -1;
                        ListItem li = FormDdl.Items.FindByValue(ddl2.SelectedValue);
                        if (li != null)
                            li.Selected = true;
                        FormDdl.Enabled = false;
                        // ContactProperties.Where(p => p.IdProperty == PropertyId && p.IdValue == IdValue);
                    }
                }
            };
            string SQL = "select * from cc_Contact with(nolock) Where IdTask = " + IdTask + " and Active = 1 and Deleted = 0 and Id in ";
            SQL += " (select IdContact from (select IdContact,count(*) cnt from cc_ContactProperty with(nolock) Where IdTask = " + IdTask + " and Active = 1 and Deleted = 0 and (" + String.Join(" OR ", Where) + ") group by IdContact) t where t.cnt  = " + Where.Count.ToString() + ") ";
           // Response.Write(SQL);
           // Response.End();
             
            TableContacts.Rows.Clear();
            TableContacts.CssClass = "table-contacts table-contacts-" + ObjectId;
            var Contacts = db.Contacts.SqlQuery(SQL).ToList();
            if (Contacts.Count > 0)
            {
                TableRow trH = new TableRow();
                trH.Cells.Add(new TableHeaderCell() { Text = "Найдено: " + Contacts.Count.ToString(), HorizontalAlign = HorizontalAlign.Left });
                var thc = new TableHeaderCell() { HorizontalAlign = HorizontalAlign.Left };

                if (Contacts.Where(p => p.ContactType.SystemTitle == "EXTSTATION").ToList().Count > 0)
                { 
                    var btnCaller = new Button() { Text = "ДОЗВОН", ID = "ButtonCaller" + ObjectId };
                    btnCaller.CssClass = "button-caller";
                    btnCaller.Attributes["ObjectId"] = ObjectId.ToString();
                    btnCaller.Click += new EventHandler(btnCallerClick);
                    btnCaller.Visible = false;
                    thc.Controls.Add(btnCaller);
                }

                if (Contacts.Where(p => p.ContactType.SystemTitle == "EMAIL").ToList().Count > 0)
                {
                    var btnEmailer = new Button() { Text = "ОТПРАВИТЬ EMAIL", ID = "ButtonEmailer" + ObjectId
                    //    , Enabled = false 
                    };
                    btnEmailer.CssClass = "button-emailer";
                    btnEmailer.Attributes["ObjectId"] = ObjectId.ToString(); 
                    btnEmailer.Attributes["FormId"] = FormId.ToString();
                    btnEmailer.Click += new EventHandler(btnEmailerClick);
                    thc.Controls.Add(btnEmailer);


                    //Panel pf = (Panel)findControlI(Page, "PanelForm" + FormId);  
                    HiddenField hf = (HiddenField)findControlI(Page, "PanelFormHiddenFieldEmail" + FormId);
                    IEnumerable<Contact> contacts = Contacts.Where(p => p.ContactType.SystemTitle == "EMAIL").ToList();
                    hf.Value = "";
                    foreach (Contact contact in contacts)
                    {
                        hf.Value = (hf.Value!=""?",":"") + contact.ContactValue;
                    }
                    

                }
                trH.Cells.Add(thc);
                TableContacts.Rows.Add(trH);
                foreach (Contact contact in Contacts)
                {
                    TableRow tr = new TableRow();
                    tr.Cells.Add(new TableCell() { Text = contact.Title });
                    tr.Cells.Add(new TableCell() { Text = contact.ContactValue, CssClass = contact.ContactType.SystemTitle == "EXTSTATION" ? "ext-station" : "" });

                    if (contact.ContactType.SystemTitle == "EXTSTATION")
                    {
                        var btnCaller = new Button() { Text = contact.ContactValue + "", ID = "ButtonCaller" + ObjectId + "_" + contact.Id };
                        btnCaller.CssClass = "button-caller button-caller-one-phone";
                        btnCaller.Attributes["ObjectId"] = ObjectId.ToString();
                        btnCaller.Attributes["PhoneId"] = contact.Id.ToString();
                        btnCaller.Attributes["ExtStation"] = contact.ContactValue.ToString();
                        btnCaller.Click += new EventHandler(btnCallerOnePhoneClick);
                        thc.Controls.Add(btnCaller);
                        tr.Cells[1].Controls.Add(btnCaller);
                    }
                    tr.Attributes["type"] = contact.ContactType.SystemTitle;

                    TableContacts.Rows.Add(tr);
                }
            }
            else
            {
                TableRow tr = new TableRow();
                tr.Cells.Add(new TableCell() { Text = "Ничего не найдено. Попробуйте другие параметры поиска!" });
                TableContacts.Rows.Add(tr);
            }


        } 
    }

    private void btnCallerOnePhoneClick(object sender, EventArgs e)
    {
        return;
        var btnCaller = sender as Button;
        string ObjectId = (sender as Button).Attributes["ObjectId"];
        var Oktell = new OktellCall(IdOperator); 

        string State = Oktell.linestate();
      //  if (State == "32")
     //   {
            var TRANSFERED_PHONE = setting("TRANSFERED_PHONE");
            string ExtStation = btnCaller.Attributes["ExtStation"]; 
            string PHONE = TRANSFERED_PHONE + "zw" + clearPhone(ExtStation);
            Oktell.wp_flash();
          //  Oktell.wp_switchcall(PHONE); 
      //  }
    }

    private void btnEmailerClick(object sender, EventArgs e)
    {
        string ObjectId = (sender as Button).Attributes["ObjectId"];
        string FormId = (sender as Button).Attributes["FormId"];
        string IDPanelContactEmailForm = "PanelForm" + FormId;
        Panel PanelContactEmailForm = (Panel)findControlI(Page, IDPanelContactEmailForm);
        PanelContactEmailForm.Visible = true;
    }



    private void btnCallerClick(object sender, EventArgs e)
    {
        
        string ObjectId = (sender as Button).Attributes["ObjectId"];
        var Oktell = new OktellCall(IdOperator);

        string State = Oktell.linestate();
         
        //только если скоммутировано
        if (State == "32")
        {
            var TRANSFERED_PHONE = setting("TRANSFERED_PHONE");
            string IDTableContacts = "TableContacts" + ObjectId;
            Table TableContacts = (Table)findControlI(Page, IDTableContacts);
            if (TableContacts.Rows.Count > 1 && CountExtStations(TableContacts.Rows)>0)
            {

                string ExtStation = getNextExtStation(TableContacts.Rows, "");
                Session.Contents["start_calling"] = DateTime.Now;
                Session.Contents["extstation"] = ExtStation;
                Session.Contents["ContactObjectId"] = ObjectId;
                Session.Contents["ext_number"] = 1;
                Session.Contents["count_call_number"] = 1;
                string PHONE = TRANSFERED_PHONE +"zw" + clearPhone(ExtStation);
                Session.Contents["PHONE"] = PHONE;
                Oktell.wp_switchcall(PHONE);
                 

                string IDtimer = "TimerContact" + ObjectId;
                Timer timer = (Timer)findControlI(Page, IDtimer);
                timer.Enabled = true;
            }
        } 
         
    }

    private string clearPhone(string Phone)
    {
        System.Text.StringBuilder sbSt = new System.Text.StringBuilder();
        for (int i = 0; i < Phone.Length; i++)
            if (Char.IsDigit(Phone, i)) sbSt.Append(Phone.Substring(i, 1));
        return sbSt.ToString();
    }

    private string getNextExtStation(TableRowCollection tableRowCollection, string ExtStation)
    {
        int ext_number = ExtStation == "" ? -1 : getNumRowByExtStation(tableRowCollection, ExtStation);
        
        //Response.End();
        for(int i = 0; i < tableRowCollection.Count; i++)
        {
            TableRow tr = tableRowCollection[i];
            if (i > ext_number && tr.Attributes["type"] == "EXTSTATION" && ExtStation != tr.Cells[1].Text)
            {
                return tr.Cells[1].Text;
            }
        }
        return "";
    }

    private int getNumRowByExtStation(TableRowCollection tableRowCollection, string ExtStation)
    {
        
        for (int i = 0; i < tableRowCollection.Count; i++)
        {
            TableRow tr = tableRowCollection[i];
            if (ExtStation == tr.Cells[1].Text && tr.Attributes["type"] == "EXTSTATION")
            {
                Response.Write(i);
                return i;
            }
        }
        return -1;
    }

    private int CountExtStations(TableRowCollection tableRowCollection)
    {
        int k = 0;
        foreach (TableRow tr in tableRowCollection)
            if (tr.Attributes["type"] == "EXTSTATION") k++;
        return k;
    }

    private void timerCheckStatusCalling(object sender, EventArgs e)
    {    
        string ExtStation = Session.Contents["extstation"].ToString();
        int ext_number = Convert.ToInt32(Session.Contents["ext_number"]);
        var Oktell = new OktellCall(IdOperator); 
        string State = Oktell.linestate();
      //  Response.Write(State);
     //   Response.End();
        if(State=="64") {
            var TRANSFERED_QUEUE = Convert.ToInt32(setting("TRANSFERED_QUEUE"));
            var TRANSFERED_COUNT_CALL = Convert.ToInt32(setting("TRANSFERED_COUNT_CALL"));
            var start_calling = (DateTime)Session.Contents["start_calling"];
            TimeSpan ts = DateTime.Now - start_calling;
            if (ts.Seconds >= TRANSFERED_QUEUE)
            {
                
                if (Convert.ToInt32(Session.Contents["count_call_number"]) < TRANSFERED_COUNT_CALL)
                {
                    //Oktell.wp_flash();
                    Session.Contents["start_calling"] = DateTime.Now;
                    Session.Contents["count_call_number"] = Convert.ToInt32(Session.Contents["count_call_number"]) + 1;
                    Oktell.wp_switchcall(Session.Contents["PHONE"].ToString());
                }
                else
                {
                    var TRANSFERED_PHONE = setting("TRANSFERED_PHONE");
                    string IDTableContacts = "TableContacts" + Session.Contents["ContactObjectId"];
                    Table TableContacts = (Table)findControlI(Page, IDTableContacts);

                    if (TableContacts.Rows.Count > 1 && CountExtStations(TableContacts.Rows) > 0)
                    {
                         
                        ExtStation = getNextExtStation(TableContacts.Rows, ExtStation);

                        if (ExtStation != "")
                        { 
                            Session.Contents["start_calling"] = DateTime.Now;
                            Session.Contents["extstation"] = ExtStation;
                            Session.Contents["ext_number"] = getNumRowByExtStation(TableContacts.Rows, ExtStation);
                            Session.Contents["count_call_number"] = 1;
                            string PHONE = TRANSFERED_PHONE + "zw" + clearPhone(ExtStation);
                            Session.Contents["PHONE"] = PHONE;
                            //Oktell.wp_flash();
                            Oktell.wp_switchcall(PHONE);
                        }
                        else {
                            Oktell.wp_return_to_abonent(); 
                            (sender as Timer).Enabled = false;
                            Session.Contents["start_calling"] = null;
                            Session.Contents["extstation"] = null;
                            Session.Contents["ext_number"] = null;
                            Session.Contents["count_call_number"] = null;
                            Session.Contents["PHONE"] = null;

                            string ObjectId = Session.Contents["ContactObjectId"].ToString();
                            string IDButtonCaller = "ButtonCaller" + ObjectId;
                            string IDButtonEmailer = "ButtonEmailer" + ObjectId;
                            Button btnEmailer = (Button)findControlI(Page, IDButtonEmailer);
                            Button btnCaller = (Button)findControlI(Page, IDButtonCaller);
                            
                            if (btnEmailer!=null) 
                            {
                                btnEmailer.Enabled = true;
                            }
                            if (btnCaller != null)
                            {
                                btnCaller.Enabled = false;
                            }
                        }
                    }

                    
                }
            }
        }
        else if (State == "32" || State == "4")
        {
            (sender as Timer).Enabled = false;
            Session.Contents["start_calling"] = null;
            Session.Contents["extstation"] = null;
            Session.Contents["ext_number"] = null;
            Session.Contents["count_call_number"] = null;
            Session.Contents["PHONE"] = null;
        }
        
    } 
     

    private void ContactFilterDropDownListSelectedIndexChanged(object sender, EventArgs e)
    { 
        var ddl = sender as DropDownList;
        string IDTableContacts = "TableContacts" + ddl.Attributes["ObjectId"] ;
        Table TableContacts = (Table)findControlI(Page, IDTableContacts);
        fillingContact(TableContacts,  Convert.ToInt32(ddl.Attributes["ObjectId"])); 
    }

    private Control renderObjectScenario(TabObject Object)
    {
        var QueryString = "";
        foreach (var param in Request.QueryString.AllKeys)
        {
            QueryString += "&" + param + "=" + Request.QueryString[param].ToString();
        };
        Control c = new LiteralControl("<iframe src=\"/player/Default.aspx?IdScenario=" + Object.IdObject + "&IdSession="+IdPopupLoad.ToString() + QueryString + "\" width=\"100%\" height=\"600\"></iframe>");
        return c;
    }

    private Control renderObjectFAQ(TabObject Object)
    {
        Control c = new LiteralControl("<iframe src=\"/player/FAQ.aspx?IdSection=" + Object.IdObject + "\" width=\"100%\" height=\"600\" ></iframe>");
        return c;
    }

    private Control renderObjectForm(TabObject FormObject)
    { 
        int IdForm = FormObject.IdObject;
        Control c = new UpdatePanel() { ID = "UpdatePanelContact" + IdForm };
        (c as UpdatePanel).ContentTemplateContainer.Controls.Add(createForm(IdForm));  
        return c;
    }

    // Производный класс от EventArgs
    class MyEventArgs : EventArgs
    {
        public string SelectedValue;
    }



    private Control getControlFormDropDownList(FormField Field, Table table, int IdValue = -1)
    {
        Control c = new Panel() { ID = "PanelDropDownListForm"+ Field.IdForm + "_" + Field.Id };
        int ParentIdFormField = Field.FieldDropDownListReferenceBookRelations.Count > 0  ? Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ParentIdFormField : 0;
        int ParentIdFormField2 = Field.FieldDropDownListReferenceBookRelations.Count > 0 ? Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ParentIdFormField2 : 0;
        List<ReferenceBookData> ReferenceBookDatas = new List<ReferenceBookData>();
       // Response.Write(Field.Title);
        if (ParentIdFormField == 0 && Field.FieldDropDownListReferenceBookRelations.Count > 0)
        {
           // Response.Write("-");
            //Response.Write(Field.FieldDropDownListReferenceBookRelation.IdReference);
            ReferenceBookDatas = Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ReferenceBook.ReferenceBookDatas.Where(p=>p.Active==1 && p.Deleted == 0).ToList();
        }
        else if (Field.FieldDropDownListReferenceBookRelations.Count > 0 )
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
            if(Field.Id == 484){
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
            if(IdValue>-1){
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
 
        if(IdValue>-1)
        {
            if(ddl.Items.FindByValue(IdValue.ToString())!=null)
                ddl.SelectedValue=IdValue.ToString(); 
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
            if (Field.Form.HasSaveButton == 1 || (Field.Form.HasSendEmailButton == 1 && Field.Form.ShowSubjectField!=1 && Field.Form.ShowMessageField!=1))
                rfv.ValidationGroup = "ValidationGroupForm" + Field.IdForm.ToString();
            else
                rfv.ValidationGroup = "closedPupup";
            rfv.EnableClientScript = true;
            c.Controls.Add(rfv);
            rfv.Enabled = false;
        }

        if (Field.Required == 1) {
            RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id };
            rfv.ErrorMessage = "Поле обязательно к заполнению";
            rfv.Display = ValidatorDisplay.Dynamic;
            rfv.CssClass = "error";
            rfv.ControlToValidate = ddl.ID;             
            //add new 17032017 
            if (Field.Form.HasSaveButton == 1 || (Field.Form.HasSendEmailButton == 1 && Field.Form.ShowSubjectField!=1 && Field.Form.ShowMessageField!=1))
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
            if (Field.Form.HasSaveButton == 1 || (Field.Form.HasSendEmailButton == 1 && Field.Form.ShowSubjectField!=1 && Field.Form.ShowMessageField!=1))
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


    private void handlerAddOnFieldHandler(object sender, EventArgs e)
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



    public Control findControlParent(Control Ctrl, string ID)
    {
        if (Ctrl.Parent == null) return null;
        if (Ctrl.Parent.ID == ID) return Ctrl.Parent;
        else return findControlParent(Ctrl.Parent, ID);
    }


    private void formFieldDropDownListDataBinding(object sender, EventArgs e)
    {
        var ddl = sender as DropDownList;
        Control pddl = findControlI(Page, ddl.Attributes["ParentIdFormField"]);
        string SelectedValue = ddl.Attributes["SelectedValue"]!=null?ddl.Attributes["SelectedValue"].ToString():null;
        Control pddl2 = null;
        if(ddl.Attributes["ParentIdFormField2"]!="")
            pddl2  = findControlI(Page, ddl.Attributes["ParentIdFormField2"]);

        
        
        if (pddl != null && (pddl as DropDownList).SelectedIndex>0)
        {

            var IdParent = Convert.ToInt32((pddl as DropDownList).SelectedValue);
            
            
            
            int IdFormField = Convert.ToInt32(ddl.Attributes["IdFormField"]);

            //Response.Write(IdParent);
            //Response.Write(ddl.Attributes["IdParent"]);

            FormContext db = new FormContext();
            FormField Field = db.FormFields.Find(IdFormField);
            int IdParent2 = 0;
            
            if (pddl2 != null && pddl2  is DropDownList )
            { 
                IdParent2 = (pddl2 as DropDownList).SelectedIndex > 0?Convert.ToInt32((pddl2 as DropDownList).SelectedValue):0;
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
            
            if (pddl2 != null && pddl2  is DropDownList )
            {

                ReferenceBookDatas = Field.FieldDropDownListReferenceBookRelations.ToList()[0].ReferenceBook.ReferenceBookDatas.Where(p => p.IdParent == IdParent && p.IdParent2 == IdParent2).ToList();
                if(ReferenceBookDatas.Count==0)
                    ReferenceBookDatas = Field.FieldDropDownListReferenceBookRelations.ToList()[0].ReferenceBook.ReferenceBookDatas.Where(p => p.IdParent == IdParent && p.IdParent2 == 0).ToList();
            }
             else
            {
                var ReferenceBookId = Field.FieldDropDownListReferenceBookRelations.FirstOrDefault().ReferenceBook.Id;
                ReferenceBookDatas = db.ReferenceBookDatas.Where(p => p.IdReferenceBook == ReferenceBookId  && p.IdParent == IdParent).ToList(); 
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
            if(SelectedValue!=null && ddl.Items.FindByValue(SelectedValue)!=null)
            {
                ddl.SelectedValue = SelectedValue;
            }

            if (Field.Required == 1)
            { 
                RequiredFieldValidator rfv = (RequiredFieldValidator)findControlI(Page, "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id);
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
        else if (pddl != null && (pddl as DropDownList).SelectedIndex==0)
        {
            
            ddl.Items.Clear();
            ddl.Items.Add("");
        }
    }


    public Control findControlI(Control Ctrl, string ID)
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
                var rs =  findControlI(c, ID);
                if (rs != null) return rs;
            }
        }
        return null;
    }

    private void formFieldDropDownListSelectedIndexChanged(object sender, EventArgs e)
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
        if (TextBoxNote !=null)
        foreach (Control c in ddl.Parent.Controls){
            if (c is RequiredFieldValidator)
            {
                if ((c as RequiredFieldValidator).ControlToValidate == TextBoxNote.ID)
                {
                    RequiredFieldValidator rfv = (RequiredFieldValidator)c;
                    rfv.Enabled = TextBoxNote.Visible && ddl.SelectedItem.Attributes["required"]=="1";
                }

            }
        }
    }

    private void saveGetParam()
    {
        IdTask = Convert.ToInt32(Request.QueryString["IdTask"]); 
        Operator = Request.QueryString["Operator"];
        IdOperator = Request.QueryString["IdOperator"]!=null?Request.QueryString["IdOperator"]:"";
        TaskContext db = new TaskContext();
        var  task =  db.Tasks.Find(IdTask);
        IdProject = task.IdProject; 
    }


    private void setMainSettings()
    { 
        LabelWelcome.Text = handlerParam(setting("WELCOME"));
        ImageLogo.ImageUrl = setting("LOGO"); 
    }

    private string handlerParam(string p)
    { 
        p = p.Replace("[OPERATOR]", Operator);

        foreach (var param in Request.QueryString.AllKeys)
        {
             p = p.Replace("["+param+"]", Request.QueryString[param].ToString()); 
        };
        return p;
    }

    public string Operator { get { return HiddenFieldOperator.Value; } set { HiddenFieldOperator.Value = value; } }


    public string setting(string code) {
         
        using (TaskSettingContext db = new TaskSettingContext())
        {
            var settings = db.TaskSettings.SqlQuery("SELECT * FROM [INBOUND].[dbo].[cc_TaskSetting] WITH(NOLOCK) WHERE IdTask = " + IdTask + " AND [IdSetting] = (SELECT Id FROM [dbo].[cc_TypeSetting] WITH(NOLOCK) WHERE [SystemTitle] = '" + code + "')");

            return settings.Count() > 0 ? settings.First().Value : "";
        } 
    }

    public int IdTask { get { return Convert.ToInt32(HiddenFieldIdTask.Value!=""?HiddenFieldIdTask.Value:"0"); } set { HiddenFieldIdTask.Value = value.ToString(); } }
    public int IdProject { get { return Convert.ToInt32(HiddenFieldIdProject.Value); } set { HiddenFieldIdProject.Value = value.ToString(); } }
    public string IdOperator { get { return HiddenFieldIdOperator.Value; } set { HiddenFieldIdOperator.Value = value.ToString(); } }




    protected void ButtonClosePopup_Click(object sender, EventArgs e)
    {
        saveForms();
        closedPopupLoad();
        Response.Redirect("~/ClosedPopup.aspx");
    }

    private void closedPopupLoad()
    { 
        PopupLoadContext db = new PopupLoadContext();
        PopupLoad pl = db.PopupLoads.Find(IdPopupLoad);
        pl.Closed = DateTime.Now;
        db.SaveChanges();
    }

    private void saveForms()
    {
        FormContext db = new FormContext(); 
        List<Form> Forms = db.Forms.Where(p=>p.IdTask==IdTask&&p.Deleted==0&&p.HasSaveButton==0&&!(p.HasSendEmailButton == 1 && p.ShowSubjectField!=1 && p.ShowMessageField!=1)).ToList();
        foreach (Form f in Forms) {
            saveForm(f.Id); 
        }
        
    }

    
    
    class EmailTemplate
    {
        string _template = "";
        public EmailTemplate(string template){
            _template = template;
        }

        Dictionary<string, string> _params = new Dictionary<string, string>();

        public void AddParam(string place, string value){
            if(!_params.ContainsKey(place))
                _params.Add(place, value);
            else
                _params[place]= value;
        }
        public void AddParam(string value){
            _params.Add(value,value);
        }
        
        public string GetFullBody(){
            var body = _template;
            foreach (KeyValuePair<string, string> item in _params)
            {
                body = body.Replace("[" + item.Key + "]", item.Value);
            }
            return body;
        }

    }


    private void saveForm(int IdForm)
    {
        FormContext db = new FormContext();
        Form f = db.Forms.Find(IdForm);
        Control pf = findControlI(Page, "PanelForm" + IdForm);
        String EmailTo = "";
        String Subject = "";
        string ValueToSubject = "";

        IsUpdated = Request.QueryString["IsUpdated"]!=null;
         
        
        List<FormResult> frs = new List<FormResult>();
        FormResult fr1 = new FormResult();
        if(IsUpdated)
        {  
           fr1 = db.FormResults.FirstOrDefault(row=>row.IdPopupLoad==IdPopupLoad && row.Deleted == 0);            
           frs = db.FormResults.Where(row=>row.IdFormSaved==fr1.IdFormSaved).ToList();   
            
        } 
        

        FormSaved fs = new FormSaved();

        if (pf != null)
        {
            if(!IsUpdated)
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

            var ET = new EmailTemplate(f.EmailTemplate==null?"":f.EmailTemplate);

             

            string result = "";
            result += setting("EMAIL_PRETEXT") + Environment.NewLine;
            result += "ОБРАЩЕНИЕ №: " + fs.Id + Environment.NewLine;
            ET.AddParam("АОН",(Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : ""));
            result += "АОН: " + (Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : "") + Environment.NewLine;
            ET.AddParam("Дата и время обращения",DateTime.Now.ToString());
            result += "Дата и время обращения: " + DateTime.Now + Environment.NewLine; 
            ET.AddParam("Оператор",Operator);
            result += "Оператор: " + Operator + Environment.NewLine;
            if (f.IdTask == 4)
            {
                result += getFramePath();
            }
            List<FormField> FormFields = f.FormFields.Where(p=>p.Active == 1 && p.Deleted == 0).ToList();

            foreach(FormField ff in FormFields){


                FormResult fr = new FormResult();
                if(IsUpdated)
                    fr = frs.FirstOrDefault(row=>row.IdField == ff.Id);
                else
                    fr = new FormResult() { Deleted = Request.QueryString["debug"] != null ?1:0 , IdFormSaved = fs.Id, IdPopupLoad = IdPopupLoad, IdField = ff.Id, IdForm =  ff.IdForm, IdTask = IdTask, IdProject = IdProject, Active = 1,  Created = DateTime.Now, Updated = DateTime.Now};

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
                    Control cObj = (Control)Obj.GetType().InvokeMember("handlerResult", System.Reflection.BindingFlags.Default | System.Reflection.BindingFlags.InvokeMethod, null, Obj, new object[] { ff, fr, Page });
                } 
                result += ff.Title +": " + fr.Value + (fr.Note!=""?", ":"")+ fr.Note + Environment.NewLine;
                
                ET.AddParam(ff.Title,fr.Value + (fr.Note!=""?", ":"")+ fr.Note);
                
                if(!IsUpdated)
                db.FormResults.Add(fr);

                if (ff.InSubjectEmail == true)
                    ValueToSubject += (ValueToSubject != "" ? " -> " : "") + fr.Value + (fr.Note != "" ? ", " : "") + fr.Note; 
            }

            db.SaveChanges();

            if (f.SendToEmail == 1) {
                
                HiddenField hf = (HiddenField)findControlI(Page, "PanelFormHiddenFieldEmail" + IdForm);
                string emails = hf.Value;
                Label Messager = (Label)findControlI(Page, "MessagerForm" + IdForm);
                if (EmailTo != "") emails += (emails!=""?",":"") + EmailTo;
                
                try
                {
                    if (emails != "")
                    {
                        if(f.IsBodyHtml)
                        result = result.Replace(Environment.NewLine, "<br/>");
                        
                        if(f.EmailTemplate!=null && f.EmailTemplate!="" && f.IsBodyHtml)
                            result = ET.GetFullBody();

                        sendEmail(emails, result, (Subject != "" ? Subject : f.Title) +(ValueToSubject != "" ? (" : " + ValueToSubject) : ""), true, f.Id, f.IsBodyHtml);

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
                    Label Messager = (Label)findControlI(Page, "MessagerForm" + IdForm);
                    Messager.Text = "Форма сохранена";
                    Messager.Visible = true;
                    Messager.ForeColor = System.Drawing.Color.Green; 
                }
                if(!IsUpdated)
                foreach (FormField ff in FormFields)
                {
                    switch (ff.FormTypeField.Id)
                    {
                        case 1: ((TextBox)findControlI(Page, "FormField" + ff.IdForm + "_" + ff.Id)).Text = ""; break;
                        case 2:
                            DropDownList ddl = (DropDownList)findControlI(Page, "FormField" + ff.IdForm + "_" + ff.Id);
                            if (ddl.Enabled)
                                ddl.SelectedIndex = -1;
                            TextBox tb = (TextBox)findControlI(Page, "TextBoxForm" + ff.IdForm + "_" + ff.Id);
                            if (tb != null)
                                tb.Text = "";
                            break;
                    }

                }
            }
            
         }
    }

    private string getFramePath()
    {
        return "Фрейм: " + getFramePathFromSQL() + Environment.NewLine;
    }

    protected string getFramePathFromSQL()
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






    private void sendForm(int IdForm)
    {
        FormContext db = new FormContext();
        Form f = db.Forms.Find(IdForm);
        Control pf = findControlI(Page, "PanelForm" + IdForm);  

        if (pf != null)
        {
             

            var ET = new EmailTemplate(f.EmailTemplate==null?"":f.EmailTemplate);

            string result = ""; 
            result += "Дата и время: " + DateTime.Now + Environment.NewLine;
            
            ET.AddParam("АОН",(Request.QueryString["AbonentNumber"] != null ? Request.QueryString["AbonentNumber"].ToString() : "")); 
            ET.AddParam("Дата и время обращения",DateTime.Now.ToString()); 
            ET.AddParam("Оператор",Operator);

            List<FormField> FormFields = f.FormFields.ToList();


            string ValueToSubject = "";

            foreach(FormField ff in FormFields){

                FormResult fr = new FormResult() { Deleted=  Request.QueryString["debug"] != null ?1:0 , IdFormSaved = 0, IdPopupLoad = IdPopupLoad, IdField = ff.Id, IdForm =  ff.IdForm, IdTask = IdTask, IdProject = IdProject, Active = 1,  Created = DateTime.Now, Updated = DateTime.Now};
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
                    Control cObj = (Control)Obj.GetType().InvokeMember("handlerResult", System.Reflection.BindingFlags.Default | System.Reflection.BindingFlags.InvokeMethod, null, Obj, new object[] { ff, fr, Page });
                } 
                result += ff.Title +": " + fr.Value + (fr.Note!=""?", ":"")+ fr.Note + Environment.NewLine;
                ET.AddParam(ff.Title,fr.Value + (fr.Note!=""?", ":"")+ fr.Note);

                if (ff.InSubjectEmail == true)
                    ValueToSubject += (ValueToSubject != "" ? " -> " : "") + fr.Value + (fr.Note != "" ? ", " : "") + fr.Note; 
            }


             

            var TextBoxMessage = (TextBox)findControlI(Page, "TableFormEmailMessage" + IdForm);
            var TextBoxSubject = (TextBox)findControlI(Page, "TableFormEmailSubject" + IdForm);
            
            if(TextBoxMessage!=null)
            result += "Суть вопроса: " + TextBoxMessage.Text+ Environment.NewLine;
            
                HiddenField hf = (HiddenField)findControlI(Page, "PanelFormHiddenFieldEmail" + IdForm);
                string emails = hf.Value;
                Label Messager = (Label)findControlI(Page, "MessagerForm" + IdForm);
                try
                {
                    result = result.Replace(Environment.NewLine, "<br/>");
                    if(f.EmailTemplate!=null && f.EmailTemplate!="" && f.IsBodyHtml)
                            result = ET.GetFullBody();
                    sendEmail(emails, result, (TextBoxSubject!=null&&TextBoxSubject.Text!=""? TextBoxSubject.Text: f.Title) + (ValueToSubject!=""?(" : "+ValueToSubject):"") , true, f.Id, f.IsBodyHtml); 
                    Messager.Text = "Форма отправлена";
                    Messager.Visible = true;
                    Messager.ForeColor = System.Drawing.Color.Green; 
                }
                catch (Exception err)
                {
                    Messager.Text = err.Message.ToString()  ;
                    Messager.Visible = true;
                    Messager.ForeColor = System.Drawing.Color.Red;
                }

           
             
            
         }
    }

     
    private void sendEmail(string emails, string body, string subject, bool SaveInHystory = false, int IdForm = 0, bool IsBodyHtml = false)
    { 

        if (SaveInHystory)
        {
            
            string EMAIL_COPY = setting("EMAIL_COPY");
            string from = setting("EMAIL_FROM");

            PopupLoadContext db = new PopupLoadContext();
            EmailHistory eh = new EmailHistory()
            {
                Body = body,
                Copy = EMAIL_COPY,
                From = from,
                Subject = subject,
                To = emails,
                DTCreated = DateTime.Now,
                IdType  = 1 ,
                MessageArrived = "",
                MessageID = "",
                ParentID = 0,
                IdTask = IdTask,
                IdProject = IdProject,
                IdPopupLoad = IdPopupLoad,
                IdForm = IdForm
            };
            db.EmailHistorys.Add(eh);
            db.SaveChanges();
            subject =  "[" + eh.Id + "] " + subject;
            eh.Subject = subject;
            db.SaveChanges(); 
        } 
        
        string className = "BaseSendEmail_" + IdForm;
        //string className = "BaseSendEmail" ;
        //Response.Write(className);

        System.Type t = null; 
                    try { t = System.Web.Compilation.BuildManager.GetType(className, true); }
                    catch (Exception e) { };
         
        if (t != null)
        {  
            var senderEmail =  (BaseSendEmail)Activator.CreateInstance(t);  
            senderEmail.send(emails, body, subject,IdTask, SaveInHystory ,  IdForm,  IsBodyHtml );
        }
        else { 

            var senderEmail = new BaseSendEmail(); 
            senderEmail.send(emails, body, subject,IdTask, SaveInHystory ,  IdForm,  IsBodyHtml );
        }
    }
     



    private void handlerFieldDropDownList(FormResult fr, FormField ff)
    {
        DropDownList ddl = (DropDownList)findControlI(Page, "FormField" + ff.IdForm + "_" + ff.Id);
        TextBox tb = (TextBox)findControlI(Page, "TextBoxForm" + ff.IdForm + "_" + ff.Id);
        fr.IdValue = ddl.SelectedIndex > 0 ? Convert.ToInt32(ddl.SelectedValue) : 0;
        fr.Value = ddl.SelectedIndex > 0 ? ddl.SelectedItem.Text : "";
        fr.Note = ddl.SelectedItem.Attributes["note"] == "note" && tb.Visible ? tb.Text : "";
    }




   
} 
