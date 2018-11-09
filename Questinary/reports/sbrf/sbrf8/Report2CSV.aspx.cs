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
        string NameBlank = "reportDB_" + R.Next(5000000);
       Response.Clear();
       Response.ContentEncoding = Encoding.GetEncoding(1251); // Encoding.ASCII;// Encoding.ASCII;//Encoding.UTF32;
        Response.Charset = "Windows-1251";
        Response.AddHeader("Content-Disposition", "attachment; filename=" + NameBlank + ".csv");

         
using (System.IO.StreamWriter writer = new System.IO.StreamWriter(Response.OutputStream, Encoding.GetEncoding(1251)))
                    {
       
        while (myReader.Read())
        {
             
            for (int i = 0; i < 18; i++)
            {
                 
                    Encoding ANSI = Encoding.GetEncoding(1251);
                    Encoding UTF8 = Encoding.UTF8;
                    byte[] utf8_bytes, ansi_bytes;

                    utf8_bytes = UTF8.GetBytes(Convert.ToString(myReader.GetValue(i)));
                    ansi_bytes = Encoding.Convert(UTF8, ANSI, utf8_bytes);

                    string ansi_str = ANSI.GetString(ansi_bytes);

                    writer.Write(Convert.ToString(myReader.GetValue(i)), Encoding.GetEncoding(1251));
                        writer.Write((i < 17 ? ";" : ""));  
               

            }
            writer.Write(System.Environment.NewLine);

        }

                   
        myReader.Close();
        myConnection.Close();
        writer.Close();
  } 
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