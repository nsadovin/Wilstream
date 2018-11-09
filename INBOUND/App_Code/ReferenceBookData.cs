using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для ReferenceBookData
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_ReferenceBookData")]
public class ReferenceBookData
{

    public int Id { get; set; }
    public int IdReferenceBook { get; set; }
    public int IdParent { get; set; }
    public int IdParent2 { get; set; }
    public string Title { get; set; }
    public string Value { get; set; }
    public int Sort { get; set; }
    public int Active { get; set; } 
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }


    [ForeignKey("IdReferenceBook")]
    public virtual ReferenceBook ReferenceBook { get; set; }

	public ReferenceBookData()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}