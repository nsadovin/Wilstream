<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="dashboard_time_getting_data.aspx.cs" Inherits="dashboard_time_getting_data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
     <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default.aspx">К списку дашбордов</asp:HyperLink>  
     
    <h1>Газпромнефть - дашборды / Время получения данных</h1>
   <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel ID="UpdatePanel1"   runat="server">
     <ContentTemplate>
         <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick"></asp:Timer>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="False" CssClass="tables" 
    AllowSorting="True" CellPadding="4" 
            DataSourceID="SqlDataSource1" ForeColor="#333333" 
    GridLines="Both"   CellSpacing="1" PageSize="20">
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
    ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
     
            
            SelectCommand="gazprom_dashboard_time_getting_data" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    
</asp:SqlDataSource>
         </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

