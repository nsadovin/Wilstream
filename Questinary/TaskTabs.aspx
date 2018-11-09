<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="TaskTabs.aspx.cs" Inherits="TaskTabs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Вкладки</h2>
    <h2>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Назад" />
    </h2>
      <asp:MultiView ID="mvTabs" runat="server" ActiveViewIndex="0">
        <asp:View ID="vTabs" runat="server">
    <asp:GridView ID="GridViewTabs" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="table-crm" DataKeyNames="Id" DataSourceID="SqlDataSourceTabs" ForeColor="#333333" GridLines="None" Width="100%">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="Title" HeaderText="Название вкладки" SortExpression="Title" />
            <asp:BoundField DataField="Description" HeaderText="Описание" SortExpression="Description" />
            <asp:BoundField DataField="Sort" HeaderText="Сортировка" SortExpression="Sort" />
            <asp:BoundField DataField="Active" HeaderText="Статус" SortExpression="Active" />
            <asp:BoundField DataField="Created" HeaderText="Создан" SortExpression="Created" />
            <asp:BoundField DataField="Updated" HeaderText="Обновлен" SortExpression="Updated" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceTabs" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" DeleteCommand="UPDATE cc_TaskTab SET Deleted = 1 WHERE (Id = @Id)" InsertCommand="INSERT INTO [cc_TaskTab] ([IdProject], [IdTask], [Title], [Description], [Sort], [Active], [Deleted], [Created], [Updated]) VALUES ((Select top 1 IdProject From [dbo].[cc_Task] where Id =@IdTask), @IdTask, @Title, @Description, @Sort, 1, 0, GetDate(), GetDate())" SelectCommand="SELECT * FROM [cc_TaskTab] WHERE (([Deleted] = @Deleted) AND ([IdTask] = @IdTask))" UpdateCommand="UPDATE [cc_TaskTab] SET   [Title] = @Title, [Description] = @Description, [Sort] = @Sort, [Active] = @Active,   [Updated] = GetDate() WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="IdProject" Type="Int32" />
            <asp:QueryStringParameter Name="IdTask" QueryStringField="IdTask" Type="Int32" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Sort" Type="Int32" />
            <asp:Parameter Name="Active" Type="Int32" />
            <asp:Parameter Name="Deleted" Type="Int32" />
            <asp:Parameter Name="Created" Type="DateTime" />
            <asp:Parameter Name="Updated" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="Deleted" Type="Int32" />
            <asp:QueryStringParameter Name="IdTask" QueryStringField="IdTask" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="IdProject" Type="Int32" />
            <asp:Parameter Name="IdTask" Type="Int32" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Sort" Type="Int32" />
            <asp:Parameter Name="Active" Type="Int32" />
            <asp:Parameter Name="Deleted" Type="Int32" />
            <asp:Parameter Name="Created" Type="DateTime" />
            <asp:Parameter Name="Updated" Type="DateTime" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Добавить вкладку" />
             
          </asp:View>
        <asp:View ID="vTab" runat="server">
            <asp:DetailsView ID="dvTab" CssClass="crm-form"   runat="server" Height="50px" Width="374px" AutoGenerateRows="False" DataSourceID="SqlDataSourceTabs" DefaultMode="Insert" OnItemCommand="dvTab_ItemCommand" OnItemInserted="dvTab_ItemInserted">
                <Fields>
                    <asp:BoundField DataField="Title" HeaderText="Название вкладки" SortExpression="Title" />
                    <asp:BoundField DataField="Description" HeaderText="Описание" SortExpression="Description" />
                    <asp:BoundField DataField="Sort" HeaderText="Сортировка" SortExpression="Sort" />
                    <asp:BoundField DataField="Active" HeaderText="Статус" SortExpression="Active" />
                    <asp:CommandField ButtonType="Button" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
        </asp:View>
       </asp:MultiView>

</asp:Content>

