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


using Excel = Microsoft.Office.Interop.Excel;


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
        SqlCommand myCommand = new SqlCommand("SET DATEFORMAT dmY; exec [dbo].[action2015_reports] @report ,@DateBegin, @DateEnd ", myConnection);
        myCommand.CommandType = CommandType.Text;
        myCommand.Parameters.Add("@DateBegin", Calendar1.SelectedDate);
        myCommand.Parameters.Add("@DateEnd", Calendar2.SelectedDate);
        myCommand.Parameters.Add("@report", Request.QueryString["report"]);
        myCommand.Connection.Open(); 
        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);

        Excel.Application excel = new Excel.Application();

        Excel.Workbook oBook = excel.Workbooks.Open("F:\\www\\megareport\\action2015\\template\\action_outbound.xlsx"); 
          
        Excel.Worksheet Sheet = (Excel.Worksheet)oBook.Worksheets[5];



        int Col = 1;
        int Row =   1;
        int i = 0;

        while (myReader.Read())
        {
         //   Excel.Range cellRange = (Excel.Range)Sheet.Cells[Row+1, Col];
          //  Excel.Range rowRange = cellRange.EntireRow;
         //   rowRange.Select();
         //   rowRange.Copy();

         //   rowRange.Insert(Excel.XlInsertShiftDirection.xlShiftDown); 
            if (Row == 1) {

                Col = 1;
                for (i = 0; i < myReader.FieldCount; i++)
                {
                    if (Convert.ToString(myReader.GetName(i)) != "")
                    {
                        // if (i == 10 || i == 11 || i == 12)
                        //Sheet.Cells[Row, Col] = Convert.ToString(myReader.GetValue(i)).Substring(0,(Convert.ToString(myReader.GetValue(i)).Length>5?5:Convert.ToString(myReader.GetValue(i)).Length) );
                        //      Sheet.Cells[Row, Col] = Convert.ToDouble(myReader.GetValue(i));
                        //  else
                        Sheet.Cells[Row, Col] = Convert.ToString(myReader.GetName(i));
                        //  Response.Write(Convert.ToString(myReader.GetValue(i)));
                    }

                    Col++;

                }
                Row++;
            
            }


            Col = 1;
            for (i = 0; i < myReader.FieldCount; i++)
            {
                if (Convert.ToString(myReader.GetValue(i)) != "")
                {
                   // if (i == 10 || i == 11 || i == 12)
                        //Sheet.Cells[Row, Col] = Convert.ToString(myReader.GetValue(i)).Substring(0,(Convert.ToString(myReader.GetValue(i)).Length>5?5:Convert.ToString(myReader.GetValue(i)).Length) );
                  //      Sheet.Cells[Row, Col] = Convert.ToDouble(myReader.GetValue(i));
                  //  else
                        Sheet.Cells[Row, Col] = Convert.ToString(myReader.GetValue(i));
                      //  Response.Write(Convert.ToString(myReader.GetValue(i)));
                }
                
                Col++;
                 
            }

            Row++;
        }
        myReader.Close();
        myConnection.Close();


       //  Excel.Range cellRange2 = (Excel.Range)Sheet.Cells[Row, Col];
      //  Excel.Range rowRange2 = cellRange2.EntireRow;
       // rowRange2.Select();
     //   rowRange2.Delete();  
      //  cellRange2 = (Excel.Range)Sheet.Cells[Row, Col];
     //   rowRange2 = cellRange2.EntireRow;
        //rowRange2.Select();
    //    rowRange2.Delete(); 
     //   cellRange2 = (Excel.Range)Sheet.Cells[Row, Col];
     //   rowRange2 = cellRange2.EntireRow;
        //rowRange2.Select();
     //   rowRange2.Delete();

        //oBook.RefreshAll();
         
        //ActiveWorkbook.RefreshAll

       // 
        
        
        Random R = new Random();
        string NameBlank = "report_" + R.Next(5000000);
        System.IO.File.Delete("F:\\www\\megareport\\action2015\\template\\" + NameBlank + ".xlsx");
        oBook.SaveAs("F:\\www\\megareport\\action2015\\template\\" + NameBlank + ".xlsx");
        
        oBook.Close();
        excel.Quit();

        Response.Clear();
        Response.AddHeader("Content-Disposition", "attachment; filename=" + NameBlank + ".xlsx");
        Response.WriteFile("F:\\www\\megareport\\action2015\\template\\" + NameBlank + ".xlsx");
       
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