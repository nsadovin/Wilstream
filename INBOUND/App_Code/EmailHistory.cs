using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для EmailHistory
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_EmailHistory")]
public class EmailHistory
{

    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public int IdPopupLoad { get; set; }
    public int IdForm { get; set; }
    public int? IdType { get; set; }
    public int? ParentID { get; set; }
    public string To { get; set; }
    public string Copy { get; set; }
    public string From { get; set; }
    public string Subject { get; set; }
    public string Body { get; set; } 
    public DateTime DTCreated { get; set; } 
    public string MessageID { get; set; } 
    public string MessageArrived { get; set; }   

	public EmailHistory()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}