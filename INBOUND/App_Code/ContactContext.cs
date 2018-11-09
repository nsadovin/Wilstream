using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

/// <summary>
/// Сводное описание для ContactContext
/// </summary>
public class ContactContext : DbContext
{
    public ContactContext()
        : base("INBOUNDConnectionString")
    { }

    public DbSet<ContactPerson> ContactPersons { get; set; }
    public DbSet<Contact> Contacts { get; set; }
    public DbSet<ContactTypeProperty> ContactTypeProperties { get; set; }
    public DbSet<ContactPersonPropertyType> ContactPersonPropertyTypies { get; set; }
    public DbSet<ContactType> ContactTypies { get; set; }
    public DbSet<ContactProperty> ContactProperties { get; set; } 
}