using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для Task
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_Task")]
public class Task
{

    public int Id { get; set; } 
    public string Title { get; set; }
    public string Description { get; set; }
    public int IdProject { get; set; }
    public Guid? Oktell_IdTask { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }
    
	public Task()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}