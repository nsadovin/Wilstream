using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

/// <summary>
/// Сводное описание для FormContext
/// </summary>
public class FormContext : DbContext
{
    public FormContext()
        : base("INBOUNDConnectionString")
    {
        Configuration.LazyLoadingEnabled = true;
    }

    public DbSet<Form> Forms { get; set; }
    public DbSet<FormField> FormFields { get; set; }
    public DbSet<FormResult> FormResults { get; set; }
    public DbSet<FormSaved> FormSaveds { get; set; }
    public DbSet<FormEmail> FormEmails { get; set; }
    public DbSet<ReferenceBookData> ReferenceBookDatas { get; set; }
}