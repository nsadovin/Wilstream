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
public class FormFieldTextBoxPhone : FormFieldTextBox
{
	public FormFieldTextBoxPhone()
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
        
        string FormatPhone = "+7 (999) 999-9999";
        if (_setting != null)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(typeof(FormFieldTextBoxPhoneSetting));

            System.IO.StringReader rdr = new System.IO.StringReader(_setting);
            FormFieldTextBoxPhoneSetting setting = (FormFieldTextBoxPhoneSetting)x.Deserialize(rdr);
            if (setting.DefaultAon && HttpContext.Current.Request.QueryString["AbonentNumber"]!=null){
                var phone = HttpContext.Current.Request.QueryString["AbonentNumber"].ToString();
                if (phone.Length >= 10 && !IsUpdated)
                    tb.Text = "7"+ phone.Substring(phone.Length-10, 10);  
            }

            if (setting.Format != null)
                FormatPhone = setting.Format;        

            

        };

        


        tb.CssClass = "phone-" + Field.IdForm + "-" + Field.Id;
        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "mask-phone-" + Field.IdForm + "-" + Field.Id, "  jQuery(function($){ $('." + "phone-" + Field.IdForm + "-" + Field.Id + "').mask(\"" + FormatPhone + "\"); }); ", true);
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