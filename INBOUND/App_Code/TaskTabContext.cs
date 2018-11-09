using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

/// <summary>
/// Сводное описание для TaskTabRelationContext
/// </summary>
public class TaskTabContext : DbContext
{
	public TaskTabContext()
        : base("INBOUNDConnectionString")
    { }

    public DbSet<TaskTab> TaskTabs { get; set; }
}