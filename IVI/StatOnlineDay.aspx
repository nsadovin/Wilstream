<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StatOnlineDay.aspx.cs" Inherits="StatOnlineDay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
           <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
       
                    <div class="container">
                      <div class="row">
                          <div class="col-md-auto"> 
                                <h1>Статистика за текущий день</h1>
                          </div>
                      </div>
            
                      <div class="row">
                        <div class="col-md-auto">  
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                            <asp:GridView ID="GridViewStat" runat="server" AutoGenerateColumns="False" CssClass="table table-sm" DataSourceID="SqlDataSourceStatOnlineDay">
                                <Columns>
                                    <asp:BoundField DataField="Показатель" HeaderText="Показатель" ReadOnly="True" SortExpression="Показатель" />
                                    <asp:BoundField DataField="19:15" HeaderText="19:15" ReadOnly="True" SortExpression="19:15" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceStatOnlineDay" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="ivi_stat_online_day" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False"></asp:SqlDataSource>
                         <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick"></asp:Timer>
                                </ContentTemplate> 
                        </asp:UpdatePanel>

                        </div>
                        <div class="col">
                          <div id="chart_div_queue" style="border: solid 1px #dfdfdf;"></div>
                          <br/>
                          <div id="chart_div_abondoned" style="border: solid 1px #dfdfdf;"></div>
                        </div> 
                      </div>
                        
                    </div>
                   
    </form>
     <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChartAll);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function ajaxDrawChart(name, id_area , chart_data) {
         var data = google.visualization.arrayToDataTable(chart_data);

            // Set chart options
            var options = {'title':name,'legend': 'none',
                           'width':'100%',
                           'height':300}; 
            // Instantiate and draw our chart, passing in some options.
            var chart = new google.visualization.ColumnChart(document.getElementById(id_area));
            chart.draw(data, options);     
      } 
    </script>
</body>
</html>
