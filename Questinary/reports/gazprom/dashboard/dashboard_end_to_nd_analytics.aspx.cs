using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class dashboard_end_to_nd_analytics : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.DataSourceMode = SqlDataSourceMode.DataReader;
        IDataReader rdr = (IDataReader)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        
        
            HtmlTable table = new HtmlTable();
            
            HtmlTable tableAzs = new HtmlTable();
            Chart chartAzs = new Chart();
            string CurItem = null;
            string CurDate = null;
            string CurToplivo = null;
            HtmlTableRow rowHead = new HtmlTableRow();
            HtmlTableRow rowTimeHead = new HtmlTableRow();
            HtmlTableRow rowToplivo = new HtmlTableRow();
            Series seriesToplivo = new Series();
            

            while (rdr.Read())
            {


                if (CurItem != rdr[0].ToString())
                {
                    HtmlTableRow row = new HtmlTableRow();
                    HtmlTableCell cell = new HtmlTableCell();

                    tableAzs = new HtmlTable() { ID = "tableAzs" + rdr[0].ToString() };
                    tableAzs.Border = 1;
                    tableAzs.Attributes.Add("class", "test");
                    tableAzs.CellSpacing = 0;
                    rowHead = new HtmlTableRow();
                    rowTimeHead = new HtmlTableRow();
                    HtmlTableCell cellNameAzs = new HtmlTableCell();
                    cellNameAzs.InnerHtml = "<b>АЗС " + rdr[0].ToString() + "</b>";
                    cellNameAzs.RowSpan = 2;
                    cellNameAzs.Width = "80";
                    rowHead.Cells.Add(cellNameAzs);
                    tableAzs.Rows.Add(rowHead);
                    tableAzs.Rows.Add(rowTimeHead);

                    tableAzs.Rows.Add(new HtmlTableRow());
                    cell.Controls.Add(tableAzs);

                    chartAzs = new Chart();
                    chartAzs.Height = 300;
                    chartAzs.BorderWidth = 1;
                    chartAzs. BorderlineDashStyle=ChartDashStyle.Solid;
                    chartAzs.BorderlineColor = System.Drawing.Color.Gray;
                    
                    chartAzs.ID = "chartAzs" + rdr[0].ToString();
                    //chartAzs.Series.Add(new Series() { Name = "АИ-95" });
                   // Random rnd = new Random(Guid.NewGuid().GetHashCode());
                   // Dictionary<DateTime, int> testData = new Dictionary<DateTime, int>();
                 //    for (int i = 0; i < Convert.ToInt32(20); i++)
                 //    {
                  ////       testData.Add(DateTime.Now.AddDays(i), rnd.Next(1, 50));
                  //   }
                    chartAzs.ChartAreas.Add(new ChartArea() { Name = "ChartArea1" });
                    chartAzs.Legends.Add(new Legend() { Name = "Legend1" });
                    chartAzs.ChartAreas[0].BorderWidth = 1;
                    chartAzs.Titles.Add(new Title() { Text = " АЗС " + rdr[0].ToString(), Font = new System.Drawing.Font("Arial", 16, System.Drawing.FontStyle.Bold) });
                 //   chartAzs.Series["АИ-95"].Points.DataBind(testData, "Key", "Value", string.Empty);
                   // chartAzs.Series["АИ-95"].ChartTypeName = "Line";


                    cell.Controls.Add(new Panel() {  Height = 10});
                    cell.Controls.Add(chartAzs);
                    cell.Controls.Add(new Panel() { Height = 30 });
                    row.Cells.Add(cell);
                    table.Rows.Add(row);
                    CurItem = rdr[0].ToString();
                    CurDate = null;
                    
                }

                if (CurDate != rdr[1].ToString())
                {
                    HtmlTableCell cellDate = new HtmlTableCell();
                    cellDate.InnerHtml = "<b>" + rdr[1].ToString() + "</b>";
                    cellDate.ColSpan = 3;
                    cellDate.Attributes.Add("class", "dates");
                    cellDate.Align = "Center";
                    rowHead.Cells.Add(cellDate);
                    rowTimeHead.Cells.Add(new HtmlTableCell() { InnerHtml = "6:30", Align = "Center", Width = "80" });
                    rowTimeHead.Cells.Add(new HtmlTableCell() { InnerHtml = "14:30", Align = "Center", Width = "80" });
                    rowTimeHead.Cells.Add(new HtmlTableCell() { InnerHtml = "21:30", Align = "Center", Width = "80" });
                    CurDate = rdr[1].ToString();
                //    6:30	14:30	21:30

                }

                //if (CurToplivo != rdr[2].ToString())
              //  {
                    rowToplivo = getRowToplivo(tableAzs, rdr[2].ToString());
                    rowToplivo.Cells.Add(new HtmlTableCell() { InnerHtml = rdr[3].ToString(), Align = "Center" });
                    rowToplivo.Cells.Add(new HtmlTableCell() { InnerHtml = rdr[4].ToString(), Align = "Center" });
                    rowToplivo.Cells.Add(new HtmlTableCell() { InnerHtml = rdr[5].ToString(), Align = "Center" });

                    seriesToplivo = getSeriesToplivo(chartAzs, rdr[2].ToString());
                    seriesToplivo.Points.AddXY(DateTime.Parse(CurDate + " 06:30:00"), rdr[3].ToString());
                    seriesToplivo.Points.AddXY(DateTime.Parse(CurDate + " 14:30:00"), rdr[4].ToString());
                    seriesToplivo.Points.AddXY(DateTime.Parse(CurDate + " 21:30:00"), rdr[5].ToString());

                chartAzs.Width = rowToplivo.Cells!=null? 
                    ((rowToplivo.Cells.Count +1) * 85  + 12) : 100;
                     

                    //tableAzs.Rows

                 //   HtmlTableCell cellToplivo = new HtmlTableCell();
                //    cellDate.InnerHtml = rdr[1].ToString();
                  //  rowHead.Cells.Add(cellDate);
                 //   CurDate = rdr[1].ToString();
              //  }
                

            

            }


            PanelTable.Controls.Add(table); 
    }


    private Series getSeriesToplivo(Chart chartAzs, string toplivo)
    {
        foreach (Series series in chartAzs.Series)
        {
            if (series.Name == toplivo) return series;
        }
        var seriesToplivo = new Series() { Name = toplivo, ChartTypeName = "Line", Legend = "Legend1", IsValueShownAsLabel = true }; 
        
                 
        chartAzs.Series.Add(seriesToplivo);
        return seriesToplivo;
    }

    private HtmlTableRow getRowToplivo(HtmlTable tableAzs, string toplivo)
    {
        foreach (HtmlTableRow row in tableAzs.Rows)
        {
            if (row.Cells.Count>0&&row.Cells[0].InnerHtml == toplivo) return row;
        }
        var rowToplivo = new HtmlTableRow();
        rowToplivo.Cells.Add(new HtmlTableCell() { InnerHtml = toplivo });
        tableAzs.Rows.Add(rowToplivo);
        return rowToplivo;
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
     //   GridView1.DataBind(); 
    }
}