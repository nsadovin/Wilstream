<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DynamicByPeriod.aspx.cs" Inherits="DynamicByPeriod" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Динамика за период</title>
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
                                <h1>Динамика за период</h1>
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
            
               <!-- Линия:-->
                <asp:DropDownList ID="DropDownListLine"  Visible="false" AutoPostBack="true"  runat="server">
                    <asp:ListItem Value="0">Все линии</asp:ListItem>
                    <asp:ListItem Selected="True" Value="1">Первая</asp:ListItem>
                    <asp:ListItem Value="2">Вторая</asp:ListItem> 
                </asp:DropDownList> 
                
                Интервал:
                <asp:DropDownList ID="DropDownListInterval"  AutoPostBack="true"  runat="server">
                    <asp:ListItem Value="15">15 минут</asp:ListItem>
                    <asp:ListItem Value="30">30 минут</asp:ListItem>
                    <asp:ListItem Value="60">60 минут</asp:ListItem>
                    <asp:ListItem Value="1">День</asp:ListItem> 
                    <asp:ListItem Value="12">Месяц</asp:ListItem>
                </asp:DropDownList> 

            </td>
        </tr>
    </table>


    <br />

    <br/>
  </div>
                      </div>

                              <div class="row">
                          <div class="col-md"> 
                            <div id="chart_div_answer_transfer" style="border: solid 1px #dfdfdf;"></div>
                            <br/>
                            <div id="chart_div_avg_queue" style="border: solid 1px #dfdfdf;"></div>
                          </div>
                      </div>

                         <div class="row">
                          <div class="col-md"> 

    <asp:GridView ID="GridView1" runat="server" CssClass="table table-sm  table-striped table-bordered"  
    AllowSorting="True" 
            DataSourceID="SqlDataSource1" PageSize="20">
        <HeaderStyle CssClass="thead-light"
                />
    </asp:GridView>



<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
    
            
            SelectCommand="ivi_dynamic_by_period" CancelSelectOnNullParameter="False" 
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
                
    <br />

    <asp:Button ID="Button1" onclick="Button2_Click" runat="server" Font-Names="Arial" 
         Text="Экспорт в Excel" CssClass="blue unibutton" />        
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



            var arr = [
         ['Element', 'Среднее время ожидания и макисмальное время ожидания', { role: 'style' }, { role: 'annotation' }] 
            ]

            $("table.table-striped tr").each(function (index) {
                if ($(this).find("th").length == 0) {
                    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(10)").text(), '#76A7FA',$(this).find("td:eq(10)").text()+''])
//                    arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(10)").text(), '#76A7FA',$(this).find("td:eq(10)").text()+''])
                 //   arr.push([$(this).find("td:eq(0)").text(), $(this).find("td:eq(11)").text(), '#b87333',$(this).find("td:eq(11)").text()+''])
                }
            });

      //      alert(arr);

        var data = google.visualization.arrayToDataTable(arr);

        // Set chart options
        var options = {'title':'Время ожидания','legend': 'none',
                       'width':'100%',
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_avg_queue'));
        chart.draw(data, options);
 
      } 
    </script>
</body>
</html>
