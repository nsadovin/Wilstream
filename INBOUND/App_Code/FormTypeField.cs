using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Сводное описание для FormTypeField
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FormTypeField")]
public class FormTypeField
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string SystemTitle { get; set; }
    public string Description { get; set; }
    public int Active { get; set; } 
    public int Deleted { get; set; } 

	public FormTypeField()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}