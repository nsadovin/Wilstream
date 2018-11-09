using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

/// <summary>
/// Сводное описание для TaskContext
/// </summary>
public class TaskContext : DbContext
{

    public TaskContext()
        : base("INBOUNDConnectionString")
    { }

    public DbSet<Task> Tasks { get; set; }
}