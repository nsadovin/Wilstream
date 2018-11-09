using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для Html
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_Html")]
public class Html
{
    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public string Title { get; set; }
    public string HTML { get; set; } 
    public bool Active { get; set; }
    public bool Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }

	public Html()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}