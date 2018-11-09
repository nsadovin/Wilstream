using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;


/// <summary>
/// Сводное описание для ContactProperty
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_ContactProperty")]
public class ContactProperty
{

    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public int IdContact { get; set; }
    public int IdProperty { get; set; }
    public int IdValue { get; set; } 
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }


    [ForeignKey("IdContact")]
    public virtual Contact Contact { get; set; }

	public ContactProperty()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}