using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

/// <summary>
/// Сводное описание для TaskSettingContext
/// </summary>
public class TaskSettingContext : DbContext
{
    public TaskSettingContext()
        : base("INBOUNDConnectionString")
    { }

    public DbSet<TaskSetting> TaskSettings { get; set; }
}