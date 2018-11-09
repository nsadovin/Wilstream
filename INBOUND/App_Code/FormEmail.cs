using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;


/// <summary>
/// Сводное описание для FormEmail
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FormEmail")]
public class FormEmail
{
    [System.ComponentModel.DataAnnotations.Key]
    //[ForeignKey("FieldDropDownListReferenceBookRelation")]
    public int Id { get; set; }
    public int IdForm { get; set; }
    public int IdFormField { get; set; }
    public int IdReferenceBook { get; set; }
    public int IdReferenceBookData { get; set; }
    public string Subject { get; set; }
    public string Email { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }  
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }


    [ForeignKey("IdFormField")]
    public virtual FormField FormField { get; set; }

    /*
    [ForeignKey("IdForm")]
    public virtual Form Form { get; set; }


    [ForeignKey("IdReferenceBook")]
    public virtual ReferenceBook ReferenceBook { get; set; }

    [ForeignKey("IdReferenceBookData")]
    public virtual ReferenceBook ReferenceBookData { get; set; }
    */
  
	public FormEmail()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}