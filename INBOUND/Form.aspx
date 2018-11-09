<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Form.aspx.cs" Inherits="Form" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/Style.css" rel="stylesheet" />
    <link href="css/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.min.js"></script>
    <script src="js/jquery.maskedinput.min.js"></script>
    <script src="js/jquery.masknumber.js"></script>
    <script src="js/jquery.datetimepicker.js"></script>
    <script src="js/timer.jquery.js"></script>
    <script src="js/main.js?v=1"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
       
            <asp:Panel ID="PanelForm" runat="server"></asp:Panel>
        </div>
    </form>
</body>
</html>
