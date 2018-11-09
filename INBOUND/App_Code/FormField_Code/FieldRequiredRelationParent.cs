using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для FieldRequiredRelationParent
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FieldRequiredRelationParent")]
public class FieldRequiredRelationParent
{

    public int Id { get; set; }
    public int IdFormField { get; set; }
    public int ParentIdFormField { get; set; }
    public int IdValue { get; set; } 
    public bool Deleted { get; set; }
    public DateTime Created { get; set; }


    [ForeignKey("IdFormField")]
    public virtual FormField FormField { get; set; }
     

	public FieldRequiredRelationParent()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}