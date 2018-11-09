using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для TypeObject
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_TypeObject")]
public class TypeObject
{

    public int Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public string SystemTitle { get; set; }  
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }

	public TypeObject()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}