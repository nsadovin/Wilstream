<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="reports_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <img src="../images/logo.png" />

        <h1>Отчеты</h1>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/reports/Calls.aspx">Детальный отчет по звонкам</asp:HyperLink><br/>
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/reports/CallsMonthDiagramm.aspx">Calls Statistics</asp:HyperLink><br/>
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/reports/PriborsStatistics.aspx">Стастистика обращений по приборам</asp:HyperLink><br/>
        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/reports/ThemaStatistics.aspx">Стастистика по вопросам обращения</asp:HyperLink><br/>
        <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/reports/RegionStatistics.aspx">Распределение звонков по регионам</asp:HyperLink>




    </div>
    </form>
</body>
</html>
