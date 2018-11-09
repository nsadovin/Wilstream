using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.ComponentModel.DataAnnotations.Schema;


/// <summary>
/// Сводное описание для ContactPerson
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_ContactPerson")]
public class ContactPerson
{
    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public string FIO { get; set; }
    public string Post { get; set; }
    public TimeSpan StartTimeWork { get; set; }
    public TimeSpan EndTimeWork { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }


    public virtual ICollection<ContactPersonProperty> ContactPersonProperties { get; set; }

    public virtual ICollection<Contact> Contacts { get; set; }

	public ContactPerson()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}