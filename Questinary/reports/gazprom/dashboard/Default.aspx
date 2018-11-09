<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="reports_RAT_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    <h1> Газпромнефть - дашборды</h1>
    <asp:HyperLink ID="HyperLinkGP_1" runat="server" NavigateUrl="dashboard_details.aspx">Детальный по АЗС</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkGP_2" runat="server" NavigateUrl="dashboard_time_getting_data.aspx">Время получения данных</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkGP_3" runat="server" NavigateUrl="gazprom_dashboard_is_getted_data.aspx">Предоставлены ли данные</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkGP_4" runat="server" NavigateUrl="gazprom_dashboard_count_and_len.aspx">Количество и длительность</asp:HyperLink><br/> 
    <asp:HyperLink ID="HyperLinkGP_5" runat="server" NavigateUrl="dashboard_end_to_nd_analytics.aspx">Сквозная аналитика по остаткам на АЗС показывает динамику остатков по каждому виду топливо по каждой АЗС</asp:HyperLink><br/> 
            
</asp:Content>

