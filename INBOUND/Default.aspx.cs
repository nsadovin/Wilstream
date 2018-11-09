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
            foreach (TabObject o in p.TabObjects.Where(to=>to.Active==1).OrderBy(to=>to.Sort).ToList())
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
            case "FORM": c = FormRender.renderObjectForm(Object, IsUpdated,IdPopupLoad, Page, IdTask, IdProject, Request); break;
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
        Control c = FormRender.createForm(IdForm,IsUpdated,IdPopupLoad,Page, IdTask, IdProject, Request);
        c.Visible = false;
        return c;
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
        Control c = new LiteralControl("<iframe src=\"/player/Default.aspx?IdScenario=" + Object.IdObject + "&IsUpdated="+IsUpdated+ "&IdPopupLoad=" + IdPopupLoad+"&IdSession="+IdPopupLoad.ToString() + QueryString + "\" width=\"100%\" height=\"600\"></iframe>");
        return c;
    }

    private Control renderObjectFAQ(TabObject Object)
    {
        Control c = new LiteralControl("<iframe src=\"/player/FAQ.aspx?IdSection=" + Object.IdObject + "\" width=\"100%\" height=\"600\" ></iframe>");
        return c;
    }
     

    // Производный класс от EventArgs
    class MyEventArgs : EventArgs
    {
        public string SelectedValue;
    }


     


    public Control findControlParent(Control Ctrl, string ID)
    {
        if (Ctrl.Parent == null) return null;
        if (Ctrl.Parent.ID == ID) return Ctrl.Parent;
        else return findControlParent(Ctrl.Parent, ID);
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
        FormRender.saveForms();
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


    



     




   
} 
