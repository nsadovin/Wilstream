<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ThemaStatistics.aspx.cs" Inherits="reports_ThemaStatistics" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <img src="../images/logo.png" /><br/>
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/reports/Default.aspx">К отчетам</asp:LinkButton>

        <h1>Стастистика по вопросам обращения</h1>

        <table>
            <tr>
                   <td>
                       <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                           <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                           <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                           <OtherMonthDayStyle ForeColor="#999999" />
                           <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                           <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                           <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                           <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                           <WeekendDayStyle BackColor="#CCCCFF" />
                       </asp:Calendar>
                   </td>
                    <td>
                        &nbsp;
                    </td>
                   <td>
                       <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                           <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                           <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                           <OtherMonthDayStyle ForeColor="#999999" />
                           <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                           <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                           <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                           <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                           <WeekendDayStyle BackColor="#CCCCFF" />
                       </asp:Calendar>
                   </td>
            </tr>
        </table>

        
        <br/>
        <asp:Button ID="Button1" runat="server" Text="В Excel" OnClick="Button1_Click" />
        <br/>
        <br/>
        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSourceCalls" AlternateText="Нет данных для отображения диаграммы" Palette="Excel" Width="1498px" BackImageAlignment="TopRight" BackImageWrapMode="Unscaled" Height="1022px">
            <series>
                <asp:Series Name="Series1" XValueMember="Thema" YValueMembers="CntCalls"    ChartType="Pie" CustomProperties="PieLineColor=Black, PieLabelStyle=Outside, PieStartAngle=20, CollectedThreshold=10" Label="#VALX (#PERCENT)" MarkerSize="10" MarkerStep="10">
                    <SmartLabelStyle IsMarkerOverlappingAllowed="True" />
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1" BorderDashStyle="Solid">
                    <AxisY>
                        <MajorGrid Enabled="False" />
                    </AxisY>
                    <AxisX>
                        <MajorGrid LineWidth="0" />
                    </AxisX>
                    <Area3DStyle Enable3D="True" Inclination="0" Rotation="0" />
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title Alignment="TopLeft" BackImageAlignment="TopRight" Font="Microsoft Sans Serif, 12pt, style=Bold" Name="Стастистика по вопросам обращения" Text="Стастистика по вопросам обращения" DockedToChartArea="ChartArea1" IsDockedInsideChartArea="False">
                </asp:Title>
            </Titles>
        </asp:Chart>
        <asp:SqlDataSource ID="SqlDataSourceCalls" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="
            SELECT count(*) CntCalls,  Thema
FROM andrus_calls  
            WHERE (([DTCall] &gt;= @DTCall1) AND ([DTCall] &lt;= @DTCall2+1))
GROUP BY  Thema
">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="DTCall1" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="DTCall2" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br/>
    </div>
    </form>
</body>
</html>
