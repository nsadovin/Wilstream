<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="reports_ResultsAnketa" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 20px;">
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="../../Default.aspx">К списку отчетов</asp:HyperLink>   
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
        
    </table>

    <br />

    <asp:Button ID="Button1" onclick="Button2_Click" runat="server" Font-Names="Arial" 
         Text="Экспорт в Excel" CssClass="blue unibutton" />
    <br />

    <br/>
  
        

    </div>
    </form>
</body>
</html>
