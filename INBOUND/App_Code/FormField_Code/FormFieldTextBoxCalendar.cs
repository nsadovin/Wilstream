using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

/// <summary>
/// Сводное описание для FormFieldTextBoxCalendar
/// </summary>
public class FormFieldTextBoxCalendar : FormFieldTextBox
{

	public FormFieldTextBoxCalendar()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}

    //<?xml version="1.0" encoding="utf-16"?><FormFieldTextBoxCalendarSetting xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><timepicker>false</timepicker></FormFieldTextBoxCalendarSetting>


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
        tb.CssClass = "calendar-" + Field.IdForm + "-" + Field.Id;

        /* var setting = new FormFieldTextBoxCalendarSetting();
        setting.timepicker = false;
        setting.minDate = "0";
        setting.maxDate = "'+1970/01/30'";

       
        System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(setting.GetType());
         
        System.Xml.XmlDocument doc = new System.Xml.XmlDocument();

        System.IO.StringWriter sww = new System.IO.StringWriter();
        System.Xml.XmlWriter writer = System.Xml.XmlWriter.Create(sww);
        x.Serialize(writer, setting);
        var xml = sww.ToString(); // Your xml

        FormContext db = new FormContext();
        var ff = db.FormFields.Find(Field.Id);

        ff.Setting = xml;
        db.SaveChanges();
        */

        if (_setting != null)
        {
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(typeof(FormFieldTextBoxCalendarSetting));

            System.IO.StringReader rdr = new System.IO.StringReader(_setting);
            FormFieldTextBoxCalendarSetting setting = (FormFieldTextBoxCalendarSetting)x.Deserialize(rdr);
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "calendar-" + Field.IdForm + "-" + Field.Id, "  jQuery(function($){ $('." + "calendar-" + Field.IdForm + "-" + Field.Id + "').datetimepicker({ format: '" + (setting.datepicker.ToString().ToLower() == "true" ? "d.m.Y" : "") + (setting.datepicker.ToString().ToLower() == "true"&&setting.timepicker.ToString().ToLower() == "true" ? " " : "") + (setting.timepicker.ToString().ToLower() == "true" ? "H:i" : "") + "', lang: 'ru' ,datepicker: " + setting.datepicker.ToString().ToLower() + ", timepicker:" + setting.timepicker.ToString().ToLower() + ", minDate:" + setting.minDate + ", maxDate: " + setting.maxDate + " }); }); ", true);
        }
        else
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "calendar-" + Field.IdForm + "-" + Field.Id, "  jQuery(function($){ $('." + "calendar-" + Field.IdForm + "-" + Field.Id + "').datetimepicker({ format: 'd.m.Y', lang: 'ru' ,  timepicker:false  }); }); ", true);
        return c;
    }



}