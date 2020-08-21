<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <asp:Chart runat="server">
    <series><asp:Series Name="Series1"></asp:Series></series>
    <chartareas><asp:ChartArea Name="ChartArea1"></asp:ChartArea></chartareas>
</asp:Chart>
        </div>
    </form>
</body>
</html>
