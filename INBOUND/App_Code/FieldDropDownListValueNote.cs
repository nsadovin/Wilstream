using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для FieldDropDownListValueNote
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FieldDropDownListValueNote")]
public class FieldDropDownListValueNote
{

    public int Id { get; set; }
    public int IdFormField { get; set; }
    public int IdReferenceBookData { get; set; }
    public int Required { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }

      

    //[ForeignKey("IdReferenceBookData")]
    //public virtual ReferenceBookData ReferenceBookData { get; set; }

    [ForeignKey("IdFormField")]
    public virtual FormField FormField { get; set; }


	public FieldDropDownListValueNote()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}