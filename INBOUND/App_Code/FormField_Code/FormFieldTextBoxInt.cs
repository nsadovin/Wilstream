using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity; 

/// <summary>
/// Сводное описание для FormFieldTextBoxPhone
/// </summary>
public class FormFieldTextBoxInt : FormFieldTextBox
{
    public FormFieldTextBoxInt()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}

    public Control getControl(FormField Field, Page Page, string StrValue, bool IsUpdated)
    {
        string _setting = "";
        if (Field.Setting != "")
        {
            _setting = Field.Setting;
            Field.Setting = null;
        }
        Control c = base.getControl(Field, Page, StrValue, IsUpdated); 
        TextBox tb = (TextBox)findControlI(c, "FormField" + Field.IdForm + "_" + Field.Id);
        
        
        if (_setting != null)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(typeof(FormFieldTextBoxIntSetting));

            System.IO.StringReader rdr = new System.IO.StringReader(_setting);
            FormFieldTextBoxIntSetting setting = (FormFieldTextBoxIntSetting)x.Deserialize(rdr);  
        };

        


        tb.CssClass = "int-" + Field.IdForm + "-" + Field.Id;
        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "mask-int-" + Field.IdForm + "-" + Field.Id, "  jQuery(function($){ $('." + "int-" + Field.IdForm + "-" + Field.Id + "').maskNumber({integer: true,decimal: '',thousands:''}); }); ", true);
        return c;
    }



    public void handlerResult(FormField ff, FormResult fr, Page Page)
    {
        base.handlerResult(ff,  fr, Page);
        fr.Value = clearPhone(fr.Value); 
    }


    private string clearPhone(string Phone)
    {
        System.Text.StringBuilder sbSt = new System.Text.StringBuilder();
        for (int i = 0; i < Phone.Length; i++)
            if (Char.IsDigit(Phone, i)) sbSt.Append(Phone.Substring(i, 1));
        return sbSt.ToString();
    }
    
}