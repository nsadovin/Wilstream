using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для FieldDropDownListReferenceBookRelation
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FieldDropDownListReferenceBookRelation")]
public class FieldDropDownListReferenceBookRelation
{

    public int Id { get; set; }
    public int IdFormField { get; set; }
    public int IdReference { get; set; }
    public int ParentIdFormField { get; set; }
    public int ParentIdFormField2 { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }


    [ForeignKey("IdFormField")] 
    public virtual FormField FormField { get; set; }
    //[ForeignKey("Id")] 
   // public virtual ICollection<FormField> FormFields { get; set; }

    [ForeignKey("IdReference")] 
    public virtual ReferenceBook ReferenceBook { get; set; }


	public FieldDropDownListReferenceBookRelation()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}