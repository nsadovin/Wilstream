using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для TaskTabObject
/// </summary>
/// 
[System.ComponentModel.DataAnnotations.Schema.Table("cc_TabObject")]
public class TabObject
{

    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public int IdTab { get; set; }  
    public int IdObject { get; set; }  
    public int IdTypeObject { get; set; }  
    public int Sort { get; set; } 
    public int Active { get; set; } 
    public int Deleted { get; set; } 
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }

    [ForeignKey("IdTab")]
    public virtual TaskTab TaskTab { get; set; }

    [ForeignKey("IdTypeObject")]
    public virtual TypeObject TypeObject { get; set; }


	public TabObject()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}