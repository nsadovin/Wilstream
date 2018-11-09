<%@ WebHandler Language="C#" Class="Chart2" %>

using System;
using System.Web; 
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.IO;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;






public class Chart2 : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
 
        
        context.Response.ContentType = "image/pjpeg";
        context.Response.AddHeader("Content-Disposition", "attachment; filename=\"chart2.Jpeg\"");
        context.Response.Flush();
        var chart1 = new Chart();

        chart1.Height = 300;
        chart1.Width = 1200;
        chart1.BorderWidth = 1; 
        chart1.BorderlineDashStyle = ChartDashStyle.Solid;
        chart1.BackColor = System.Drawing.Color.FromArgb(91, 155, 213); 
        chart1.BorderlineColor = System.Drawing.Color.Gray;
        chart1.ChartAreas.Add(new ChartArea() { Name = "ChartArea1" });

        chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
        chart1.ChartAreas[0].AxisX.MinorGrid.Enabled = false;
        chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
        chart1.ChartAreas[0].AxisY.MinorGrid.Enabled = false;
        chart1.ChartAreas[0].AxisY.TitleForeColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisY.LineColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisX.LineColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisX.LabelStyle.ForeColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisY.LabelStyle.ForeColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisY.MajorTickMark.LineColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisX.MajorTickMark.LineColor = System.Drawing.Color.White;
        chart1.ChartAreas[0].AxisX.Interval = 1; 
        
        //chart1.Legends.Add(new Legend() { Name = "Legend1" });
        chart1.ChartAreas[0].BorderWidth = 1;
        chart1.ChartAreas[0].BackColor = System.Drawing.Color.FromArgb(91, 155, 213);

        chart1.Titles.Add(new Title() { Text = "Количество звонков в цикле", ForeColor = System.Drawing.Color.White, Font = new System.Drawing.Font("Arial", 16, System.Drawing.FontStyle.Bold) });
        var seriesToplivo = new Series() { Name = "1", BorderColor = System.Drawing.Color.White, ChartTypeName = "Line", Legend = "Legend1", IsValueShownAsLabel = true };
 
        var rslt = GetData(context.Request.QueryString["Date"].ToString());
        foreach(KeyValuePair<string,string> item in rslt)
            seriesToplivo.Points.AddXY(item.Key, item.Value);
         
        seriesToplivo.Color = System.Drawing.Color.White;
        chart1.Series.Add(seriesToplivo);
        chart1.Series[0].Color = System.Drawing.Color.White;
        chart1.Series[0].LabelForeColor = System.Drawing.Color.White;
        chart1.Series[0].MarkerColor = System.Drawing.Color.White;
        chart1.Series[0].MarkerBorderColor = System.Drawing.Color.White;
          
        
       chart1.SaveImage(context.Response.OutputStream,ChartImageFormat.Jpeg);
         
         
    }

    private Dictionary<string, string> GetData(string dt) {

         
        
        
        //сохраняем общую инфу звонка
        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["oktell_ccwsConnectionString"];

        var userData = new Dictionary<string, string>();
         
         
 
        try
        { 

            SqlConnection myConnection = new SqlConnection(settings.ConnectionString);
            SqlCommand myCommand = new SqlCommand("exec [dbo].[gazprom_dashboard_count_and_len] @Report =  'chart2', @StartDate = @dt, @EndDate = @dt", myConnection);
            myCommand.CommandType = CommandType.Text;
            myCommand.Parameters.Add("@dt", dt);

            myCommand.Connection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myReader.Read())
            {
                userData.Add(myReader.GetValue(0).ToString(), myReader.GetValue(1).ToString().Replace(",",".")); 
            }
            myReader.Close();
            myConnection.Close();

        }
        catch (SqlException SqlEx)
        {

            throw new Exception("An error occurred while transaction", SqlEx);

        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }
        return userData;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}