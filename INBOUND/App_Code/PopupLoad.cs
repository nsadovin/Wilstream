using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для PopupLoad
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_PopupLoad")]
public class PopupLoad
{
    public int Id { get; set; } 
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public Guid? Oktell_IdChain { get; set; }
    public Guid? Oktell_IdEffort { get; set; }
    public Guid? Oktell_IdConn { get; set; }
    public Guid? Oktell_IdProject { get; set; }
    public Guid? Oktell_IdTask { get; set; }
    public string Operator { get; set; }
    public Guid? IdOperator { get; set; }
    public string AbonentNumber { get; set; }
    public string CalledNumber { get; set; } 
    public int Deleted { get; set; }
    public DateTime Opened { get; set; }
    public DateTime? Closed { get; set; }
    public int Oktell_IdInList { get; set; } 
       

	public PopupLoad()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}