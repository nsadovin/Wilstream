using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

/// <summary>
/// Сводное описание для FormFieldTextBox
/// </summary>
public class FormFieldTextBox : IFormField
{
	public FormFieldTextBox()  
	{
		//
		// TODO: добавьте логику конструктора
		//
	}

    public Control getControl(FormField Field, Page Page, string StrValue, bool IsUpdated)
    {
        Control c = new Panel() { ID = "PanelTextBoxForm" + Field.IdForm + "_" + Field.Id };

        TextBox tb = new TextBox() { ID = "FormField" + Field.IdForm + "_" + Field.Id };
        c.Controls.Add(tb);

        if (Field.Setting != null)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(typeof(FormFieldTextBoxSetting));

            System.IO.StringReader rdr = new System.IO.StringReader(Field.Setting);
            FormFieldTextBoxSetting setting = (FormFieldTextBoxSetting)x.Deserialize(rdr);
            if (setting.isMultiline)
                tb.TextMode = TextBoxMode.MultiLine;
            if (setting.rowCount > 1)
                tb.Rows = setting.rowCount;

            if (setting.isReadOnly)
                tb.ReadOnly = true;
            

			if (setting.Default !=null && HttpContext.Current.Request.QueryString[setting.Default]!=null){
                var d_value = HttpContext.Current.Request.QueryString[setting.Default].ToString();                 
                    tb.Text = d_value;  
            }
            
            
        }
        tb.Width = 550;

        if (IsUpdated)
        {
            tb.Text = StrValue;
        }



        tb.Attributes["IdFormField"] = Field.Id.ToString();
        tb.Attributes["FormId"] = Field.IdForm.ToString();
        
        if (Field.Required == 1)
        {
            RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id };
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
        }
        else if (Field.FieldRequiredRelationParents.Count() > 0) 
        {
            
            RequiredFieldValidator rfv = new RequiredFieldValidator() { ID = "RequiredFieldValidatorForm" + Field.IdForm + "_" + Field.Id };
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
            rfv.Attributes["IdFormField"] = Field.Id.ToString();
            rfv.Attributes["FormId"] = Field.IdForm.ToString();
            rfv.Load += new EventHandler(handlerAddOnFieldHandler);
            //tb.PreRender += new EventHandler(handlerAddOnFieldHandler);

            
        }

        if (Field.Description != "")
        { 
            c.Controls.Add(new LiteralControl("<br/>"));
            var l = new Label() { Text = Field.Description, ForeColor = System.Drawing.Color.Gray, ID = "FormLabel" + Field.IdForm + "_" + Field.Id };
             
            c.Controls.Add(l);

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
            foreach (FieldRequiredRelationParent frrp in Field.FieldRequiredRelationParents.ToList()) {
                Control control = (Control)findControlI(findControlParent(rfv, "PanelForm" + IdForm), "FormField" + Field.IdForm + "_" + frrp.ParentIdFormField);
                 
                if (control is DropDownList)
                {   
                    DropDownList ddl = control as DropDownList;


                    if (ddl.SelectedIndex > 0 && !rfv.Enabled)
                    {
                        rfv.Enabled = Field.FieldRequiredRelationParents.Count(
                            p => p.IdFormField == IdField && p.ParentIdFormField == frrp.ParentIdFormField && p.IdValue == Convert.ToInt32(ddl.SelectedValue) && !p.Deleted) > 0;

                        rfv.Attributes["test"] +=  "| IdFormField=" + IdField+ " ParentIdFormField=" + IdField +" IdValue = "+ ddl.SelectedValue;
                        return;
                    }


                  //  ddl.Attributes["RequiredFieldId"] = Field.Id.ToString();
                   // ddl.Attributes["RequiredFormId"] = Field.IdForm.ToString(); ddl.Attributes["SelectedValue"] = "222";
                   //  ddl.SelectedIndexChanged += new EventHandler(handlerSelectedValue);
                    //ddl.SelectedIndexChanged += new EventHandler(handlerSelectedValue);
                }
            }
    }

    private void handlerSelectedValue(object sender, EventArgs e)
    {
        var ddl = sender as DropDownList;
        int RequiredFieldId = Convert.ToInt32(ddl.Attributes["RequiredFieldId"]);
        int IdField = Convert.ToInt32(ddl.Attributes["IdFormField"]);
        int IdForm = Convert.ToInt32(ddl.Attributes["RequiredFormId"]);
            
        if(ddl.SelectedIndex>0) {

            ddl.Attributes["SelectedValue"] = "RequiredFieldValidatorForm" + IdForm + "_" + RequiredFieldId;
            FormContext db = new FormContext();
            var ff = db.FormFields.Find(IdField);
            RequiredFieldValidator rfv = (RequiredFieldValidator)findControlParent(findControlParent(ddl, "PanelForm" + IdForm), "RequiredFieldValidatorForm" + IdForm + "_" + RequiredFieldId);
            //if(rfv!=null)
            rfv.Enabled = ff.FieldRequiredRelationParents.Count(p => p.IdFormField == IdField && p.ParentIdFormField == IdField && p.IdValue == Convert.ToInt32(ddl.SelectedValue) && !p.Deleted) > 0;
            
        }
    }

    public void handlerResult(FormField ff, FormResult fr, Page Page)
    {
        TextBox tb = (TextBox)findControlI(Page, "FormField" + ff.IdForm + "_" + ff.Id);
        fr.IdValue = 0;
        fr.Value = tb.Text;
        fr.Note = "";
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
                var rs = findControlI(c, ID);
                if (rs != null) return rs;
            }
        }
        return null;
    }
}