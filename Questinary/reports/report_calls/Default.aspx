<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
   <div style="margin: 20px;">
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="../../Megareport.aspx">К списку отчетов</asp:HyperLink>   
       <br />
       Скилсет:
       <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceSkillset" DataTextField="Skillset" DataValueField="Skillset" AppendDataBoundItems="True">
           <asp:ListItem></asp:ListItem>
       </asp:DropDownList>
       <asp:SqlDataSource ID="SqlDataSourceSkillset" runat="server" ConnectionString="<%$ ConnectionStrings:SCCS_STATConnectionString %>" SelectCommand="SELECT * FROM [Skillset] ORDER BY [Skillset]"></asp:SqlDataSource>
       Application:
       <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceApplication" DataTextField="Application" DataValueField="Application" AutoPostBack="True" AppendDataBoundItems="True">
           <asp:ListItem></asp:ListItem>
       </asp:DropDownList>
       <asp:SqlDataSource ID="SqlDataSourceApplication" runat="server" ConnectionString="<%$ ConnectionStrings:SCCS_STATConnectionString %>" SelectCommand="SELECT * FROM [Application] ORDER BY [Application]"></asp:SqlDataSource>
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

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" CellPadding="4" 
            DataSourceID="SqlDataSource1" ForeColor="#333333" 
    GridLines="None" Width="2000px" CellSpacing="1" PageSize="20" AutoGenerateColumns="False" DataKeyNames="ID">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="BeginTime" HeaderText="BeginTime" SortExpression="BeginTime" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" SortExpression="Duration" />
            <asp:BoundField DataField="DNIS" HeaderText="DNIS" SortExpression="DNIS" />
            <asp:BoundField DataField="CLID" HeaderText="CLID" SortExpression="CLID" />
            <asp:BoundField DataField="CDN" HeaderText="CDN" SortExpression="CDN" />
            <asp:BoundField DataField="CallID" HeaderText="CallID" SortExpression="CallID" />
            <asp:BoundField DataField="LoginID" HeaderText="LoginID" SortExpression="LoginID" />
            <asp:BoundField DataField="Skillset" HeaderText="Skillset" SortExpression="Skillset" />
            <asp:BoundField DataField="ArrivedTime" HeaderText="ArrivedTime" SortExpression="ArrivedTime" />
            <asp:BoundField DataField="HoldTime" HeaderText="HoldTime" SortExpression="HoldTime" />
            <asp:BoundField DataField="RingTime" HeaderText="RingTime" SortExpression="RingTime" />
            <asp:BoundField DataField="Answered" HeaderText="Answered" SortExpression="Answered" />
            <asp:BoundField DataField="Application" HeaderText="Application" SortExpression="Application" />
            <asp:BoundField DataField="QueuedToSkillsetTime" HeaderText="QueuedToSkillsetTime" SortExpression="QueuedToSkillsetTime" />
            <asp:BoundField DataField="CallAbandonedTime" HeaderText="CallAbandonedTime" SortExpression="CallAbandonedTime" />
            <asp:BoundField DataField="PositionID" HeaderText="PositionID" SortExpression="PositionID" />
            <asp:BoundField DataField="RefCallID" HeaderText="RefCallID" SortExpression="RefCallID" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#99CCFF" Font-Bold="False" ForeColor="Black" 
            Font-Size="12px" Font-Underline="False" BorderColor="Black" 
            BorderStyle="Solid" BorderWidth="1px"  />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>



<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SCCS_STATConnectionString %>" 
    
            OnSelecting="SqlDataSource_SetTimeout"
            SelectCommand="SELECT * FROM [ACDCalls] WHERE 
    (([Application] = @Application or @Application is null or @Application = '') AND ([Skillset] = @Skillset or  @Skillset is null or  @Skillset = '') AND ([BeginTime] &gt;= @BeginTime) AND ([BeginTime] &lt;= @BeginTime2))" CancelSelectOnNullParameter="False">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList2" Name="Application" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Skillset" 
                PropertyName="SelectedValue" Type="String" />
		<asp:ControlParameter ControlID="Calendar1" Name="BeginTime" PropertyName="SelectedDate" Type="DateTime" />
        <asp:ControlParameter ControlID="Calendar2" Name="BeginTime2" PropertyName="SelectedDate" Type="DateTime" />
    </SelectParameters>
</asp:SqlDataSource>
        

    </div>
    </form>
</body>
</html>
