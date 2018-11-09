using System;
using System.Collections.Generic;
using System.Linq;
using System.Web; 

/// <summary>
/// Сводное описание для TaskTabRelation
/// </summary>
/// 
[System.ComponentModel.DataAnnotations.Schema.Table("cc_TaskTab")]
public class TaskTab 
{
    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; } 
    public string Title { get; set; }
    public string Description { get; set; }
    public int Sort { get; set; } 
    public int Active { get; set; } 
    public int Deleted { get; set; } 
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }

    public virtual ICollection<TabObject> TabObjects { get; set; }
     
	public TaskTab()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}