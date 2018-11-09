using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для ReferenceBook
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_ReferenceBook")]
public class ReferenceBook
{

    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public string Title { get; set; }
    public string Description { get; set; } 
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }



    //[ForeignKey("Id")]
    //public virtual FieldDropDownListReferenceBookRelation FieldDropDownListReferenceBookRelation { get; set; }


    public virtual ICollection<ReferenceBookData> ReferenceBookDatas { get; set; }


	public ReferenceBook()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}