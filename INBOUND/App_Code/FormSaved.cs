using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для FormSaved
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FormSaved")]
public class FormSaved
{

    public int Id { get; set; } 
    public DateTime Created { get; set; } 
	public FormSaved()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}