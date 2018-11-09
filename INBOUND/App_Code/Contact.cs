using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;

/// <summary>
/// Сводное описание для Contact
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_Contact")]
public class Contact
{
    public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public int IdPerson { get; set; }
    public string Title { get; set; }
    public string ContactValue { get; set; }
    public int IdType { get; set; }
    public int Active { get; set; }
    public int Deleted { get; set; }
    public DateTime Created { get; set; }
    public DateTime Updated { get; set; }


    public virtual ICollection<ContactProperty> ContactProperties { get; set; }


    [ForeignKey("IdType")]
    public virtual ContactType ContactType { get; set; }


    [ForeignKey("IdPerson")]
    public virtual ContactPerson ContactPerson { get; set; }

	public Contact()
	{
		//
		// TODO: добавьте логику конструктора
		//
	}
}