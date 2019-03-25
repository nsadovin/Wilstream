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
        
       
                    <div class="container-fluid">
                      <div class="row">
                          <div class="col-md-auto"> 
                                <h1>Статистика за текущий день</h1>
                                От <asp:DropDownList ID="DropDownListStartDate" runat="server" AutoPostBack="true"></asp:DropDownList>
                                <br/>
                                <br/>
                          </div>
                      </div>
            
                      <div class="row justify-content-md-center">
                        <div class="col-md-6">  
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                            <asp:GridView ID="GridViewStat" runat="server" AutoGenerateColumns="True" CssClass="table table-sm" DataSourceID="SqlDataSourceStatOnlineDay"></asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceStatOnlineDay" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="ivi_stat_online_day" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
                                <SelectParameters>
                                    <asp:ControlParameter  Name="start_last_time" ControlID="DropDownListStartDate" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                         <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick"></asp:Timer>
                                </ContentTemplate> 
                        </asp:UpdatePanel>

                        </div>
                        <div class="col-md-6">
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

         function drawChartAll() {
             var arr = [
                 ['Время', 'Вызовов ', { role: 'style' }, { role: 'annotation' }]
             ];
             arr.push(["первая линия", $(".table-sm tr:eq(1)").find("td:eq(1)").text() * 1, '#76A7FA', $(".table-sm tr:eq(1)").find("td:eq(1)").text()  + ''])
             arr.push(["вторая линия", $(".table-sm tr:eq(2)").find("td:eq(1)").text() * 1, '#76A7FA', $(".table-sm tr:eq(1)").find("td:eq(1)").text()  + ''])

          
             ajaxDrawChart('Очередь', 'chart_div_queue', arr);

             var arr = [
                 ['Время', 'Вызовов ', { role: 'style' }, { role: 'annotation' }]
             ];
            $("table.table-sm tr:eq(3) td").each(function (index) {
                if (index >0) {
                    arr.push([$(".table-sm tr:eq(0) th:eq(" + index + ")").text(), $(this).text() * 1, '#76A7FA', $(this).text() + '']);
                    arr.push([$(".table-sm tr:eq(0) th:eq(" + index + ")").text(), $("table.table-sm tr:eq(4) td:eq(" + index + ")").text() * 1, '#b87333', $("table.table-sm tr:eq(4) th:eq(" + index + ")").text() + '']);
                    
                }
             });
 
             ajaxDrawChart('Пропущенные', 'chart_div_abondoned', arr);
         }

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
