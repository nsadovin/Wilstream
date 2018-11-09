using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;
 
//using Schema = System.ComponentModel.DataAnnotations.Schema;


/// <summary>
/// Сводное описание для TaskSetting
/// </summary>
[System.ComponentModel.DataAnnotations.Schema.Table("cc_TaskSetting")]
public class TaskSetting
{
     
	public int Id { get; set; }
    public int IdProject { get; set; }
    public int IdTask { get; set; }
    public int IdSetting { get; set; }
    public string Value { get; set; }
	
    public TaskSetting()
	{
        //
		// TODO: добавьте логику конструктора
		//
	} 

}