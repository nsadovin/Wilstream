using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для FormField
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FormField")]
public class FormField
{
    [System.ComponentModel.DataAnnotations.Key]
    //[ForeignKey("FieldDropDownListReferenceBookRelation")]
    public int Id { get; set; }
    public int IdForm { get; set; } 
    public string Title { get; set; }
    public string TitleNote { get; set; }
    public string Description { get; set; }
    public int Required { get; set; }
    public int Sort { get; set; }
    public int Active { get; set; }
    public int IdTypeField { get; set; }
    public string Setting { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }
    public int? Position { get; set; } //1 - top , 2 - right , 3 - bottom , 4 - right
    public bool? InSubjectEmail { get; set; } 


    [ForeignKey("IdForm")]
    public virtual Form Form { get; set; }

     


    [ForeignKey("IdTypeField")]
    public virtual FormTypeField FormTypeField { get; set; }

    //[ForeignKey("Id")]
   // [ForeignKey("Id"), Column("IdFormField")]

    public virtual ICollection<FormEmail> FormEmails { get; set; }
    public virtual ICollection<FieldDropDownListReferenceBookRelation> FieldDropDownListReferenceBookRelations { get; set; }
    public virtual ICollection<FieldRequiredRelationParent> FieldRequiredRelationParents { get; set; }
    //public virtual FieldDropDownListReferenceBookRelation FieldDropDownListReferenceBookRelation { get; set; } 

    public virtual ICollection<FieldDropDownListValueNote> FieldDropDownListValueNotes { get; set; }

	public FormField()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}