using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для Iframe
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_Iframe")]
public class Iframe
{

    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public string Title { get; set; }
    public string Url { get; set; }
    public bool Active { get; set; }
    public bool Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }

	public Iframe()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}