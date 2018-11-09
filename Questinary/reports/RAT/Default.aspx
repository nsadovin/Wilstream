<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="reports_RAT_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="/Megareport.aspx">К списку отчетов</asp:HyperLink>   
    <h1> РАТ Отчеты</h1>
    <asp:HyperLink ID="HyperLinkRAT_1" runat="server" NavigateUrl="OnlineOperator.aspx?Procedure=[oktell_ccws].[dbo].[RAT_1_online_status]">Онлайн по операторам</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkRAT_2" runat="server" NavigateUrl="OnlineSkill.aspx?Procedure=[oktell_ccws].[dbo].[RAT_2_online_service]">Онлайн по уровню сервиса</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkRAT_3" runat="server" NavigateUrl="Operator.aspx?Procedure=[oktell_ccws].[dbo].[RAT_3_skill_dayli]">Отчет по операторам в разрезе скилл</asp:HyperLink><br/>
    <asp:HyperLink ID="HyperLinkRAT_4" runat="server" NavigateUrl="Skill.aspx?Procedure=[oktell_ccws].[dbo].[RAT_4_skill_full]">Отчет по скилл, за каждые 15 мин</asp:HyperLink><br/>
            
</asp:Content>

