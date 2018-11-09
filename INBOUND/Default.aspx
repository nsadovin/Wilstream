<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
        <asp:HiddenField runat="server" ID="HiddenFieldIdProject"></asp:HiddenField>
        <asp:HiddenField runat="server" ID="HiddenFieldIdTask"></asp:HiddenField>
        <asp:HiddenField runat="server" ID="HiddenFieldIdPopupLoad"></asp:HiddenField>
        <asp:HiddenField runat="server" ID="HiddenFieldOperator"></asp:HiddenField>
        <asp:HiddenField runat="server" ID="HiddenFieldIdOperator"></asp:HiddenField>
        <table class="header">
            <tr>
                <td id="logo"><asp:Image ID="ImageLogo" runat="server" /></td>
                <td id="welcome"><asp:Label ID="LabelWelcome" runat="server" CssClass="welcome" Text="Welcome"></asp:Label></td>
                <td id="buttons"><asp:Button ID="ButtonClosePopup" ValidationGroup="closedPupup" runat="server" OnClick="ButtonClosePopup_Click" Text="ЗАКРЫТЬ" /></td>
            </tr>
           
            
        </table>  
         <asp:TabContainer ID="TabContainerMain" runat="server"> 
        
         </asp:TabContainer>
        
        
    </div>
    </form>
</body>
</html>
