<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="reports_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 20px;">
        
    <h1> IVI Отчеты</h1>
	<table border="0" cellpadding="20">
		<tr>
		
		 
            <td valign="top"> 
		 
            <asp:HyperLink ID="HyperLinkE_1" runat="server" NavigateUrl="Report.aspx?Procedure=[oktell_ccws].[dbo].[reportIVI]&report=report1">Отчет SL</asp:HyperLink><br/>
     
            <asp:HyperLink ID="HyperLinkE_2" runat="server" NavigateUrl="Report.aspx?Procedure=[oktell_ccws].[dbo].[reportIVI]&report=report2">Отчет по оператором (среднее время разговоров)</asp:HyperLink><br/>
     
            </td>
		</tr>
	</table>
    </div>
    </form>
</body>
</html>
