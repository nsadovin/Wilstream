using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для ContactTypeProperty
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_ContactTypeProperty")]
public class ContactTypeProperty
{
    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public int IdReference { get; set; }
    public int IdFormField { get; set; }
    public int IsFilter { get; set; }
    public int Sort { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }
     
    [ForeignKey("IdReference")]
    public virtual ReferenceBook ReferenceBook { get; set; }


	public ContactTypeProperty()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}