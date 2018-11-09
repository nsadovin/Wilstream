<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="FAQSections.aspx.cs" Inherits="FAQSections" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:toolkitscriptmanager ID="Toolkitscriptmanager1" runat="server"></asp:toolkitscriptmanager>
        <h1>FAQ Разделы</h1>
    <asp:Button ID="Button1" runat="server" Text="Добавить раздел" OnClick="Button1_Click" />

    <br />
    <br />

    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="-1">
        <asp:View ID="View1" runat="server">

            <asp:DetailsView ID="DetailsView1" CssClass="crm-form"  runat="server" Height="50px" Width="125px" DataSourceID="SqlDataSourceSections" DefaultMode="Insert" AutoGenerateRows="False" DataKeyNames="ID" OnItemCommand="DetailsView1_ItemCommand" OnItemInserted="DetailsView1_ItemInserted">
                <Fields>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Название раздела" SortExpression="Title" />
                    <asp:CommandField ButtonType="Button" InsertText="Сохранить" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
        </asp:View>
    </asp:MultiView>

    <asp:GridView CssClass="table-crm" ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSourceSections" ForeColor="#333333" GridLines="None" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="Title" HeaderText="Название раздела" SortExpression="Title" />
            <asp:CommandField ButtonType="Button" SelectText="Вопрос-Ответы" ShowSelectButton="True">
            <ItemStyle Width="200px" />
            </asp:CommandField>
            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True">
            <ItemStyle Width="200px" />
            </asp:CommandField>
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" DeleteCommand="UPDATE [crm_faq_Sections] SET IsDelete   = 1 WHERE [ID] = @ID" InsertCommand="INSERT INTO [crm_faq_Sections] ([Title]) VALUES (@Title)" SelectCommand="SELECT * FROM [crm_faq_Sections] WHERE ([IsDeleted] = @IsDeleted) ORDER BY [ID] DESC" UpdateCommand="UPDATE [crm_faq_Sections] SET [Title] = @Title, [DTUpdated] = getDate() WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="IsDeleted" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="IsDeleted" Type="Int32" />
        <asp:Parameter Name="ID" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>

