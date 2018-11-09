<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="gazprom_dashboard_count_and_len.aspx.cs" Inherits="gazprom_dashboard_count_and_len" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
     <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default.aspx">К списку дашбордов</asp:HyperLink>  
     
    <h1 style="font-family: Arial;font-size: 18px;font-weight: bold;">Газпромнефть - дашборды / Количество и длительность</h1>
   <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
   
   <div style="height: 25px;  position:relative; vertical-align:bottom; display:inline-block;"> 
                
    Номер АЗС <asp:DropDownList ID="DropDownListAzs" AutoPostBack=true runat="server" DataSourceID="SqlDataSourceAzs" DataTextField="Title" DataValueField="ID"></asp:DropDownList>
   
    <asp:SqlDataSource ID="SqlDataSourceAzs" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT * FROM (SELECT null as ID, 'Все' as Title, 0 OrderBy UNION ALL SELECT distinct [Номер АЗС] as ID, [Номер АЗС] as Title, cast([Номер АЗС] as int) OrderBy FROM oktell.dbo.WS_GAGPROMNEFT with(nolock) ) t Order By t.OrderBy    "></asp:SqlDataSource>
        
        Даты. Начало - Окончание 
                           <asp:TextBox ID="tbCallOnStart" style="height: 20px!important; width:110px; font-size: 11px;" CssClass="dpicker" runat="server"></asp:TextBox>
                   
                        - <asp:TextBox ID="tbCallOnEnd" style="height: 20px!important;width:110px; font-size: 11px;" CssClass="dpicker" runat="server"></asp:TextBox>
                        <asp:Button ID="Button1" runat="server"   Text="Выбрать"   />
                        </div>
<br/>
<br/>
   
    <asp:UpdatePanel ID="UpdatePanel2"   runat="server">
     <ContentTemplate> 
            <asp:Button ID="UpdateButton" runat="server"   Text="Выключить обновление" OnClick="UpdateButton_OnClick" />
            <br/>
            <br/>
         </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1"   runat="server">
     <ContentTemplate>
         <asp:Timer ID="Timer1" runat="server" Interval="10000" OnTick="Timer1_Tick"></asp:Timer>
         
         
    <table>
        <tr>
            <td>
                            
         
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="tables" OnRowDataBound="GridView1_RowDataBound"
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
     
            
            SelectCommand="gazprom_dashboard_count_and_len" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
     <SelectParameters> 
     
        <asp:ControlParameter ControlID="DropDownListAzs" Name="NumAzs" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="tbCallOnStart" Name="StartDate" PropertyName="Text"  Type="DateTime"/>
        <asp:ControlParameter ControlID="tbCallOnEnd" Name="EndDate" PropertyName="Text"  Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>

   </td>
            <td valign=top style="padding-left: 20px;">
    <asp:GridView ID="GridView2" runat="server" CssClass="tables" AllowPaging="True"  
    AllowSorting="True" CellPadding="4"  
            DataSourceID="SqlDataSource2" ForeColor="#333333" 
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



<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
     
            
            SelectCommand="gazprom_dashboard_count_and_len" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter DefaultValue="call_by_azs" Name="Report" Type="String" />
        <asp:ControlParameter ControlID="DropDownListAzs" Name="NumAzs" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="tbCallOnStart" Name="StartDate" PropertyName="Text"  Type="DateTime"/>
        <asp:ControlParameter ControlID="tbCallOnEnd" Name="EndDate" PropertyName="Text"  Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>

            </td>
        </tr>
    </table>
    
         </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

