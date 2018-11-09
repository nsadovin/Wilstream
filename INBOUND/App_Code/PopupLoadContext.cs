using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

/// <summary>
/// Сводное описание для PopupLoadContext
/// </summary>
public class PopupLoadContext : DbContext
{
    public PopupLoadContext()
        : base("INBOUNDConnectionString")
    { }

    public DbSet<PopupLoad> PopupLoads { get; set; }
    public DbSet<Html> Htmls { get; set; }
    public DbSet<EmailHistory> EmailHistorys { get; set; }
    public DbSet<Iframe> Iframes { get; set; }
}