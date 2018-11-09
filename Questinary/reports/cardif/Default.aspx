<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="reports_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 20px;">
        
    <h1> CCWS Отчеты</h1>
	<table border="0" cellpadding="20">
		<tr>
		
		 
            <td valign="top"> 
		
            <h2>Кардиф</h2>
    <asp:HyperLink ID="HyperLinkCardif_1" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_calls">Отчет по анкетам</asp:HyperLink><br/>
    
    <asp:HyperLink ID="HyperLinkCardif_2" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_agent">Отчет по операторам</asp:HyperLink><br/>
    
    
            <h2>Кардиф 2</h2>
            <h3>Claim</h3>
    <asp:HyperLink ID="HyperLinkCardif_3" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_calls_claim">Отчет по звонкам</asp:HyperLink><br/> 
    
            <h3>Cancellation</h3>
    <asp:HyperLink ID="HyperLinkCardif_4" runat="server" NavigateUrl="Report.aspx?Procedure=CCWS.[dbo].[cardif_reports]&report=report_calls_cancellation">Отчет по звонкам</asp:HyperLink><br/> 
    
            </td>
		</tr>
	</table>
    </div>
    </form>
</body>
</html>
