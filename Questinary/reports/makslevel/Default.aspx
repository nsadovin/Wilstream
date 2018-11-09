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
		
            <h2>Макслевел</h2>
    <asp:HyperLink ID="HyperLinkE_1" runat="server" NavigateUrl="Report.aspx?Procedure=[INBOUND].[dbo].[reportForm]&report=form_IdForm_15">Отчет по каждой форме</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkE_2" runat="server" NavigateUrl="Report.aspx?Procedure=[INBOUND].[dbo].[reportFormGroupByFields]&report=form_IdForm_15">Отчет по количеству общий</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkE_3" runat="server" NavigateUrl="Report.aspx?Procedure=[INBOUND].[dbo].[reportFormGroupByFields]&report=form2_IdForm_15">Отчет с разбивкой по типу претензий</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkE_4" runat="server" NavigateUrl="Report.aspx?Procedure=[INBOUND].[dbo].[reportFormGroupByFields]&report=form3_IdForm_15">Отчет с разбивкой по торговому направлению</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkE_5" runat="server" NavigateUrl="Report.aspx?Procedure=[INBOUND].[dbo].[reportFormGroupByFields]&report=form4_IdForm_15">Отчет с разбивкой по салонам</asp:HyperLink><br/>
     
            </td>
		</tr>
	</table>
    </div>
    </form>
</body>
</html>
