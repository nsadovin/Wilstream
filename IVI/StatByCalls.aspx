<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StatByCalls.aspx.cs" Inherits="StatByCalls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Статистика по звонкам</title>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
    <form id="form1" runat="server">
     <div class="container-fluid">
                      <div class="row">
                          <div class="col-md-auto"> 
             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default.aspx">К списку отчетов</asp:HyperLink> 
                                <h1>Статистика по звонкам</h1>
                          </div>
                      </div>
                    <div class="row">
                        <div class="col-md-auto">    
<br/>
<table border="0">
        <tr>
            
            <td>


                


               <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                    BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                    ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px" 
                    >
                   <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                   <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                       VerticalAlign="Bottom" />
                   <OtherMonthDayStyle ForeColor="#999999" />
                   <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                   <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                       Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                   <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td>
                
               <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                    BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                    ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px" 
                    >
                   <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                   <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                       VerticalAlign="Bottom" />
                   <OtherMonthDayStyle ForeColor="#999999" />
                   <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                   <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                       Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                   <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            
        </tr>
        
        <tr>
            <td colspan="2">
            
                Линия:
                <asp:DropDownList ID="DropDownListLine"  AutoPostBack="true"  runat="server">
                    <asp:ListItem Value="0">Все линии</asp:ListItem>
                    <asp:ListItem Value="1">Первая</asp:ListItem>
                    <asp:ListItem Value="2">Вторая</asp:ListItem> 
                </asp:DropDownList> 
                
                Интервал:
                <asp:DropDownList ID="DropDownListInterval"  AutoPostBack="true"  runat="server">
                    <asp:ListItem Value="15">15 минут</asp:ListItem>
                    <asp:ListItem Value="30">30 минут</asp:ListItem>
                    <asp:ListItem Value="60">60 минут</asp:ListItem>
                    <asp:ListItem Value="1">День</asp:ListItem>
                    <asp:ListItem Value="7">Неделя</asp:ListItem>
                    <asp:ListItem Value="12">Месяц</asp:ListItem>
                </asp:DropDownList> 

            </td>
        </tr>
    </table>

    <br />

    <asp:Button ID="Button1" onclick="Button2_Click" runat="server" Font-Names="Arial" 
         Text="Экспорт в Excel" CssClass="blue unibutton" />
    <br />

    <br/>

    <asp:GridView ID="GridView1" runat="server" CssClass="table table-sm  table-striped table-bordered"  
    AllowSorting="True" 
            DataSourceID="SqlDataSource1" PageSize="20">
        <HeaderStyle CssClass="thead-light"
                />
    </asp:GridView>



<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
    
            
            SelectCommand="ivi_stat_by_calls" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="report" Type="String" DefaultValue="report1" />
         
        <asp:ControlParameter ControlID="DropDownListInterval" Name="interval" 
                PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="DropDownListLine" Name="line" 
                PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="Calendar1" Name="BeginDate" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="EndDate" 
                PropertyName="SelectedDate" Type="DateTime" /> 
    </SelectParameters>
</asp:SqlDataSource>
        
     </div>
                        
     </div>
                <div class="row">
                          <div class="col-md"> 
                            <div id="chart_div_answer_transfer" style="border: solid 1px #dfdfdf;"></div>
                            <br/>
                            <div id="chart_div_avg_queue" style="border: solid 1px #dfdfdf;"></div>
                            <br/>
                            <div id="chart_div_talk" style="border: solid 1px #dfdfdf;"></div>
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
        function drawChartAll() {

            // Create the data table.

        var arr = [
         ['Element', 'Доля отвеченных % ', { role: 'style' }, { role: 'annotation' }] 
            ]

            $("table.table-striped tr").each(function (index) {
                if ($(this).find("th").length == 0) {
                    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(3)").text()*1, '#76A7FA',$(this).find("td:eq(3)").text()+'%'])
                    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(5)").text()*1, '#b87333',$(this).find("td:eq(5)").text()+'%'])
                }
            });

      //      alert(arr);

        var data = google.visualization.arrayToDataTable(arr);

        // Set chart options
        var options = {'title':'Доля отвеченных и переадресованных','legend': 'none',
                       'width':'100%',
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_answer_transfer'));
            chart.draw(data, options);


 


        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Dt');
        data.addColumn('timeofday', 'Время ожидания'); 
        data.addColumn({ type: 'string', role: 'style' });
        data.addColumn({ 'type': 'string', 'role': 'tooltip', 'p': { 'html': true} });
        data.addColumn({ type: 'string', role: 'annotation' });

        var arr = [];
        $("table.table-striped tr").each(function(index) {
            if ($(this).find("th").length == 0) {
                //  arr.push([$(this).find("td:eq(0)").text(), new Date('1970-01-01T0' + $(this).find("td:eq(10)").text() + '')]);
                var tt = $(this).find("td:eq(10)").text().split(":");
                arr.push([$(this).find("td:eq(0)").text(), [tt[0] * 1, tt[1] * 1, tt[2] * 1], '#76A7FA', $(this).find("td:eq(10)").text() + '', 'Avg '+$(this).find("td:eq(10)").text()]);
                var tt = $(this).find("td:eq(11)").text().split(":");
                arr.push([$(this).find("td:eq(0)").text(), [tt[0] * 1, tt[1] * 1, tt[2] * 1], '#b87333', $(this).find("td:eq(11)").text() + '', 'Max '+$(this).find("td:eq(11)").text() + '']);
                //alert('1970-01-01T' + $(this).find("td:eq(10)").text() + 'Z');
                //    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(10)").text(), '#76A7FA', $(this).find("td:eq(10)").text() + ''])
                //    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(11)").text(), '#b87333', $(this).find("td:eq(11)").text() + ''])
            }
        });
   //     alert(arr);
        data.addRows(arr);
        
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_avg_queue'));
        chart.draw(data, {title:'Время ожидания',legend: 'none',
            height: 400,
            width: '100%',
            vAxis: {
                format: 'HH:mm:ss',
                minValue: new Date('1970-01-01T00:00:00'),
                0: { baseline: 0 }, viewWindowMode: 'explicit'
            }
        });




        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Dt');
        data.addColumn('timeofday', 'Время разговора');
        data.addColumn({ type: 'string', role: 'style' });
        data.addColumn({ 'type': 'string', 'role': 'tooltip', 'p': { 'html': true} });
        data.addColumn({ type: 'string', role: 'annotation' });

        var arr = [];
        $("table.table-striped tr").each(function(index) {
            if ($(this).find("th").length == 0) {
                //  arr.push([$(this).find("td:eq(0)").text(), new Date('1970-01-01T0' + $(this).find("td:eq(10)").text() + '')]);
                var tt = $(this).find("td:eq(14)").text().split(":");
                arr.push([$(this).find("td:eq(0)").text(), [tt[0] * 1, tt[1] * 1, tt[2] * 1], '#76A7FA', $(this).find("td:eq(14)").text() + '', 'Avg ' + $(this).find("td:eq(14)").text()]);
                var tt = $(this).find("td:eq(15)").text().split(":");
                arr.push([$(this).find("td:eq(0)").text(), [tt[0] * 1, tt[1] * 1, tt[2] * 1], '#b87333', $(this).find("td:eq(15)").text() + '', 'Max ' + $(this).find("td:eq(15)").text()]);
                //alert('1970-01-01T' + $(this).find("td:eq(10)").text() + 'Z');
                //    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(10)").text(), '#76A7FA', $(this).find("td:eq(10)").text() + ''])
                //    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(11)").text(), '#b87333', $(this).find("td:eq(11)").text() + ''])
            }
        });
        //     alert(arr);
        data.addRows(arr);

        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_talk'));
       chart.draw(data, { title: 'Время разговора', legend: 'none',
            height: 400,
            width: '100%',
            vAxis: {
                format: 'HH:mm:ss',
                minValue: new Date('1970-01-01T00:00:00'),
                0: { baseline: 0 }, viewWindowMode: 'explicit'
            }
        }); 
 
      } 
    </script>
</body>
</html>
