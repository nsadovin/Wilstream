<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calls.aspx.cs" Inherits="reports_Calls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <img src="../images/logo.png" /><br/>
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/reports/Default.aspx">К отчетам</asp:LinkButton>

        <h1>Детальный отчет по звонкам</h1>

        <table>
            <tr>
                   <td>
                       <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                           <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                           <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                           <OtherMonthDayStyle ForeColor="#999999" />
                           <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                           <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                           <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                           <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                           <WeekendDayStyle BackColor="#CCCCFF" />
                       </asp:Calendar>
                   </td>
                    <td>
                        &nbsp;
                    </td>
                   <td>
                       <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                           <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                           <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                           <OtherMonthDayStyle ForeColor="#999999" />
                           <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                           <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                           <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                           <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                           <WeekendDayStyle BackColor="#CCCCFF" />
                       </asp:Calendar>
                   </td>
            </tr>
        </table>
        <br/>
        <br/>
        <asp:Button ID="Button1" runat="server" Text="В Excel" OnClick="Button1_Click" />
        <br/>
        <br/>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="IdCall" DataSourceID="SqlDataSourceCalls">
            <Columns>
                <asp:BoundField DataField="IdCall" HeaderText="Id звонка" InsertVisible="False" ReadOnly="True" SortExpression="IdCall" />
                <asp:BoundField DataField="agid" HeaderText="Пин оператора" SortExpression="agid" />
                <asp:BoundField DataField="cgpn" HeaderText="АОН" SortExpression="cgpn" />
                <asp:BoundField DataField="cdpn" HeaderText="Номер доступа" SortExpression="cdpn" />
                <asp:BoundField DataField="DTCall" HeaderText="Дата звонка" SortExpression="DTCall" />
                <asp:BoundField DataField="Action" HeaderText="Действие оператора" SortExpression="Action" />
                <asp:BoundField DataField="Thema" HeaderText="Тема звонка" SortExpression="Thema" />
                <asp:BoundField DataField="Product" HeaderText="Товар" SortExpression="Product" />
                <asp:BoundField DataField="Marketing" HeaderText="Источник рекламы" SortExpression="Marketing" />
                <asp:BoundField DataField="Oblast" HeaderText="Область" SortExpression="Oblast" />
                <asp:BoundField DataField="Comment" HeaderText="Комментарий" SortExpression="Comment" />
                <asp:BoundField DataField="DTCreated" HeaderText="DTCreated" SortExpression="DTCreated" Visible="False" />
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SortedAscendingCellStyle BackColor="#EDF6F6" />
            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
            <SortedDescendingCellStyle BackColor="#D6DFDF" />
            <SortedDescendingHeaderStyle BackColor="#002876" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceCalls" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT * FROM [andrus_calls] WHERE (([DTCall] &gt;= @DTCall1) AND ([DTCall] &lt;= @DTCall2+1)) ORDER BY [DTCall] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="DTCall1" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="DTCall2" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
