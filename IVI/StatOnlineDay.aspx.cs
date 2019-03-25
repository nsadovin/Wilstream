using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StatOnlineDay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var cur_date = DateTime.Parse(DateTime.Now.ToShortDateString());
            while (cur_date < DateTime.Now.AddMinutes(-15))
            {
                DropDownListStartDate.Items.Insert(0, new ListItem(cur_date.ToString("HH:mm"), cur_date.ToString("yyyy-MM-dd HH:mm")));
                cur_date = cur_date.AddMinutes(15);
            };

            DropDownListStartDate.Items[0].Selected = true;


        }
    /*    var chartQueueData = GetChartData("queue");
        var script = "";
        var json =  "[ [\"Время\", \"Вызовов\", { role: \"style\" } ],";
        foreach (var item in chartQueueData)
        {
            json += "['" + item[1].ToString() + "', " + item[0].ToString() + ", '" + item[2].ToString() + "'],";
        }
        json += "]";
        script += "ajaxDrawChart('Очередь', 'chart_div_queue', " + json + "); "; 

        var chartAbondonedData = GetChartData("abondoned");
        json = "[ [\"Время\", \"Вызовов\", { role: \"style\" } ],";
        foreach (var item in chartAbondonedData)
        {
            json += "['" + item[1].ToString() + "', " + item[0].ToString() + ", '" + item[2].ToString() + "'],";
        }
        json += "]";
        script += " ajaxDrawChart('Пропущенные', 'chart_div_abondoned', " + json + ");";
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(),
            "charts", "<script>function drawChartAll(){ "+ script + " };   </script>");*/
    }


    private List<Object[]> GetChartData(string Name)
    {
        var rslt = new List<Object[]>();
        try
        {
            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktell_ccwsConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString); 

            SqlCommand myOdbcCommand = new SqlCommand();
            myOdbcCommand.Connection = myOdbcConnection;
            myOdbcCommand.CommandType = CommandType.StoredProcedure;
            myOdbcCommand.CommandText = "ivi_stat_online_day";
            myOdbcCommand.Parameters.AddWithValue("@report", Name);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                var row = new Object[3];
                row[0] = myOdbcReader.GetInt32(0);
                row[1] = myOdbcReader.GetString(1).ToString();
                row[2] = myOdbcReader.GetString(2).ToString();
                rslt.Add(row);
            }

            myOdbcReader.Close();
            myOdbcConnection.Close();
            return rslt;
        }
        catch (Exception ex)
        {
            return new List<Object[]>();
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
   //     Page.ClientScript.RegisterClientScriptBlock(this.GetType(),  "chartsUpdate", "<script>  drawChartAll();   </script>");
    }
}