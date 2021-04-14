<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CallsMonthDiagramm.aspx.cs" Inherits="reports_CallsMonthDiagramm" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <img src="../images/logo.png" /><br/>
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/reports/Default.aspx">К отчетам</asp:LinkButton>

        <h1>Calls Statistics</h1>

        
        <br/>
        <asp:Button ID="Button1" runat="server" Text="В Excel" OnClick="Button1_Click" />
        <br/>
        <br/>
        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSourceCalls" AlternateText="Нет данных для отображения диаграммы" Palette="Excel" Width="800px">
            <series>
                <asp:Series Name="Series1" XValueMember="MonthCalls" YValueMembers="CntCalls" IsXValueIndexed="True" Label="#VAL{N0}">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisY>
                        <MajorGrid Enabled="False" />
                    </AxisY>
                    <AxisX>
                        <MajorGrid LineWidth="0" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title Alignment="TopLeft" BackImageAlignment="TopRight" Font="Microsoft Sans Serif, 12pt, style=Bold" Name="Calls Statistics" Text="Calls Statistics" DockedToChartArea="ChartArea1" IsDockedInsideChartArea="False">
                </asp:Title>
            </Titles>
        </asp:Chart>
        <asp:SqlDataSource ID="SqlDataSourceCalls" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT count(*) CntCalls,  Cast(datename(MM, DTCall) as varchar(8)) +' '+ right(Cast(DATEPART(YY, DTCall) as varchar(4)),2) as MonthCalls, Convert(varchar(7),DTCall,120)
FROM andrus_calls  
GROUP BY  Cast(datename(MM, DTCall) as varchar(8)) +' '+ right(Cast(DATEPART(YY, DTCall) as varchar(4)),2) , Convert(varchar(7),DTCall,120)
            ORDER BY Convert(varchar(7),DTCall,120)
"></asp:SqlDataSource>
        <br/>
    </div>
    </form>
</body>
</html>
