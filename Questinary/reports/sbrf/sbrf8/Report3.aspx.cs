using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Data.Odbc;
using System.Web.Configuration;
using System.Text;
 


public partial class reports_ResultsAnketa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        ConnectionStringSettings settings =
       ConfigurationManager.ConnectionStrings["CCAConnectionString"];



        //config = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Server.MapPath(".").Replace(AppDomain.CurrentDomain.BaseDirectory, "~/") + "/");

         
  
        SqlConnection myConnection = new SqlConnection(settings.ConnectionString);
        SqlCommand myCommand = new SqlCommand("SET DATEFORMAT dmY; exec [dbo].[sberbank8_reports] @report ,@DateBegin, @DateEnd ", myConnection);
        myCommand.CommandType = CommandType.Text;
        myCommand.Parameters.Add("@DateBegin", Calendar1.SelectedDate);
        myCommand.Parameters.Add("@DateEnd", Calendar2.SelectedDate);
        myCommand.Parameters.Add("@report", Request.QueryString["report"]);
        myCommand.Connection.Open(); 
        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
         
         

        Random R = new Random();
        string NameBlank = "report_" + R.Next(5000000);  
        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=" + NameBlank + ".csv"); 

        while (myReader.Read())
        {
            
             
            for (int i = 0; i < 10; i++)
            {
                if (Convert.ToString(myReader.GetValue(i)) != "")
                {

                    Response.Write(Convert.ToString(myReader.GetValue(i)) + (i < 9 ? ";" : ""));
                }
                
                 
            }
            Response.Write(System.Environment.NewLine);
           
        }
        myReader.Close();
        myConnection.Close();


        Response.End();
       
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //Оставить пустым
    }

    protected void SqlDataSource_SetTimeout(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.CommandTimeout = 12000;
    }
}