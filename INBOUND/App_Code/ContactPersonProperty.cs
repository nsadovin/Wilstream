using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;


/// <summary>
/// Сводное описание для ContactPersonProperty
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_ContactPersonProperty")]
public class ContactPersonProperty
{
    public int Id { get; set; }
    public int IdContactPerson { get; set; }
    public int IdProperty { get; set; }
    public int? IdPropertyValue { get; set; } 
    public DateTime Created { get; set; }



    [ForeignKey("IdContactPerson")]
    public virtual ContactPerson ContactPerson { get; set; }



    [ForeignKey("IdProperty")]
    public virtual ContactPersonPropertyType ContactPersonPropertyType { get; set; }


	public ContactPersonProperty()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}