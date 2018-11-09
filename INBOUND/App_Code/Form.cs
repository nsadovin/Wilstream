using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для Form
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_Form")]
public class Form
{

    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public string Email { get; set; }
    public int? ShowSubjectField { get; set; }
    public int? ShowMessageField { get; set; }
    public int? HasSendEmailButton { get; set; }
    public int SendToEmail { get; set; }
    public bool IsBodyHtml { get; set; }
    public int HasSaveButton { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }
    public string EmailTemplate { get; set; }

    public virtual ICollection<FormField> FormFields { get; set; }

	public Form()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}