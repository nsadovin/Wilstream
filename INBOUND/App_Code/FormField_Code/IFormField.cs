using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Сводное описание для Field
/// </summary>
public interface IFormField
{
    Control getControl(FormField Field, Page Page, string StrValue, bool IsUpdated);
    void handlerResult(FormField ff, FormResult fr, Page Page);
	 
}