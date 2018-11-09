using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


/// <summary>
/// Сводное описание для FormResult
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_FormResult")]
public class FormResult
{

    public int Id { get; set; }
     
    public int IdFormSaved { get; set; }
    [Required]
    public int IdPopupLoad { get; set; }
    [Required]
    public int IdForm { get; set; }
    [Required]
    public int IdProject { get; set; }
    [Required]
    public int IdTask { get; set; }
    [Required]
    public int IdField { get; set; }
    public int IdValue { get; set; }
    public string Value { get; set; }
    public string Note { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; } 

	public FormResult()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}