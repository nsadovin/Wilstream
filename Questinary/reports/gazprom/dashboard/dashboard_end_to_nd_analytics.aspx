<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="dashboard_end_to_nd_analytics.aspx.cs" Inherits="dashboard_end_to_nd_analytics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
     <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default.aspx">К списку дашбордов</asp:HyperLink>  
     
    <h1 style="font-family: Arial;font-size: 18px;font-weight: bold;">Газпромнефть - дашборды / Сквозная аналитика по остаткам на АЗС показывает динамику остатков по каждому виду топливо по каждой АЗС</h1>
   <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 <div style="height: 25px;  position:relative; vertical-align:bottom; display:inline-block;"> 
                
    Номер АЗС <asp:DropDownList ID="DropDownListAzs" AutoPostBack=true runat="server" DataSourceID="SqlDataSourceAzs" DataTextField="Title" DataValueField="ID"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceAzs" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT * FROM (SELECT null as ID, 'Все' as Title, 0 OrderBy UNION ALL SELECT distinct [Номер АЗС] as ID, [Номер АЗС] as Title, cast([Номер АЗС] as int) OrderBy FROM oktell.dbo.WS_GAGPROMNEFT with(nolock) ) t Order By t.OrderBy    "></asp:SqlDataSource>
        
        Даты. Начало - Окончание 
                           <asp:TextBox ID="tbCallOnStart" style="height: 20px!important; width:110px; font-size: 11px;" CssClass="dpicker" runat="server"></asp:TextBox>
                   
                        - <asp:TextBox ID="tbCallOnEnd" style="height: 20px!important;width:110px; font-size: 11px;" CssClass="dpicker" runat="server"></asp:TextBox>
                        <asp:Button ID="UpdateButton" runat="server"   Text="Выбрать"   />
                        </div>
<br/>
<br/>
                

    <asp:UpdatePanel ID="UpdatePanel1"   runat="server">
     <ContentTemplate>
         <asp:Timer ID="Timer1" runat="server" Interval="60000" OnTick="Timer1_Tick"></asp:Timer>
    
    <asp:Panel runat=server ID="PanelTable" ></asp:Panel>


<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
     
            
            SelectCommand="gazprom_dashboard_end_to_nd_analytics" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListAzs" Name="NumAzs" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="tbCallOnStart" Name="StartDate" PropertyName="Text"  Type="DateTime"/>
        <asp:ControlParameter ControlID="tbCallOnEnd" Name="EndDate" PropertyName="Text"  Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
         </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

