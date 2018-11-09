using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form : System.Web.UI.Page
{
    private int IdPopupLoad;
    private bool IsUpdated;
    private int IdForm;
    private int IdTask;
    private string Operator;
    private string IdOperator;
    private int IdProject;

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void Page_Init(object sender, EventArgs e)
    {
        saveGetParam();
        PanelForm.Controls.Add(FormRender.renderObjectForm(IdForm, IsUpdated, IdPopupLoad, Page, IdTask, IdProject, Request));
    }

    private void saveGetParam()
    {
        IdPopupLoad = Convert.ToInt32(Request.QueryString["IdPopupLoad"]);
        IsUpdated = Convert.ToBoolean(Request.QueryString["IsUpdated"]);
        IdForm = Convert.ToInt32(Request.QueryString["IdForm"]);
        IdTask = Convert.ToInt32(Request.QueryString["IdTask"]);
        Operator = Request.QueryString["Operator"];
        IdOperator = Request.QueryString["IdOperator"] != null ? Request.QueryString["IdOperator"] : "";
        TaskContext db = new TaskContext();
        var task = db.Tasks.Find(IdTask);
        IdProject = task.IdProject;
    }
}