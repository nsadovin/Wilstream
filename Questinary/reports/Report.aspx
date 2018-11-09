<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="reports_ResultsAnketa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="../Megareport.aspx">К списку отчетов</asp:HyperLink>   
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
        <tr>
            <td colspan="2"><asp:Panel ID="PanelFilterTaskOktell" runat="server">
                Задача (Oktell):
                <asp:DropDownList ID="ddlTasksOktell" runat="server" DataSourceID="SqlDataSourceTasksFromOktell" OnSelectedIndexChanged="Index_Changed" AutoPostBack=true DataTextField="Name" DataValueField="Id"  ></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceTasksFromOktell" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
                            SelectCommand="select * from (SELECT  cast(null as uniqueidentifier) as [Id]  , '---------------' as [Name], 0 orderby  UNION ALL SELECT   [Id]  ,[Name], 1 orderby   FROM [oktell_cc_temp].[dbo].[A_Cube_CC_Cat_Task] ) t    ORDER BY orderby, [Name]"></asp:SqlDataSource>
            </asp:Panel></td> 
        </tr>
        
    </table>

    <br />

    <asp:Button ID="Button1" onclick="Button2_Click" runat="server" Font-Names="Arial" 
         Text="Экспорт в Excel" CssClass="blue unibutton" />
    <br />

    <br/>

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" OnRowDataBound="GridView1_RowDataBound"
    AllowSorting="True" CellPadding="4" 
            DataSourceID="SqlDataSource1" ForeColor="#333333" 
    GridLines="None" Width="2000px" CellSpacing="1" PageSize="20">  
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
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
    ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" 
    OnSelecting="SqlDataSource_SetTimeout"
            
            SelectCommand="MegaReports" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter Name="Procedure" QueryStringField="Procedure" 
            Type="String" />
        <asp:ControlParameter ControlID="Calendar1" Name="StartDate" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="EndDate" 
                PropertyName="SelectedDate" Type="DateTime" />
		<asp:QueryStringParameter Name="report" QueryStringField="report" 
            Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
        

    </asp:Content>

