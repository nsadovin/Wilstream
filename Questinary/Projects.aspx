<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="Projects.aspx.cs" Inherits="Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:MultiView ID="mvProjects" runat="server" ActiveViewIndex="0">
        <asp:View ID="vProjects" runat="server">

    <asp:Button ID="btnAddProject" runat="server" OnClick="btnAddProject_Click" Text="Новый проект" />

            <br /> <br />

    <asp:GridView ID="GridViewProjects" CssClass="table-crm" Width="100%" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceProjectList" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True">
     <AlternatingRowStyle BackColor="White" />
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="#" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:TemplateField HeaderText="Проект" SortExpression="Title">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenFieldIdProject" runat="server" Value='<%# Eval("Id") %>' />
                    <br />
                    <asp:GridView ID="GridViewTasks" Width="100%" CssClass="table-crm" OnRowCommand="GridViewTasks_RowCommand" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceTaskList" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" ShowHeader="False">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                            <asp:TemplateField ShowHeader="False" ItemStyle-Width="300">
                                <ItemTemplate>
                                    <nobr>
                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Id") %>' CommandName="Reports" Text="Отчеты" />
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Id") %>' CommandName="Settings" Text="Настройки" />
                                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Id") %>' CommandName="Tabs" Text="Вкладки" />
                                    </nobr>
                                </ItemTemplate>
                                <ItemStyle Width="200px" />
                            </asp:TemplateField>
                        </Columns>
                         <EditRowStyle BackColor="#2461BF" />
                        <EmptyDataTemplate>
                            Нет данных
                        </EmptyDataTemplate>
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
                    <asp:SqlDataSource ID="SqlDataSourceTaskList" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" DeleteCommand="DELETE FROM [cc_Task] WHERE [Id] = @Id" InsertCommand="INSERT INTO [cc_Task] ([Title]) VALUES (@Title)" SelectCommand="SELECT [Id], [Title] FROM [cc_Task] WHERE (([Deleted] = @Deleted) AND ([IdProject] = @IdProject))" UpdateCommand="UPDATE [cc_Task] SET [Title] = @Title WHERE [Id] = @Id">
                        <DeleteParameters>
                            <asp:Parameter Name="Id" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Title" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="Deleted" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenFieldIdProject" Name="IdProject" PropertyName="Value" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Title" Type="String" />
                            <asp:Parameter Name="Id" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <asp:Button ID="btnAddNewTask" runat="server" OnClick="btnAddNewTask_Click" Text="Добавить задачу" />
                </ItemTemplate>
            </asp:TemplateField>
        <asp:BoundField DataField="Active" HeaderText="Статус" SortExpression="Active" Visible="False" >
            <ItemStyle Width="300px" />
            </asp:BoundField>
    </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <EmptyDataTemplate>
            Нет данных
        </EmptyDataTemplate>
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
<asp:SqlDataSource ID="SqlDataSourceProjectList" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" DeleteCommand="DELETE FROM [cc_Project] WHERE [Id] = @Id" InsertCommand="INSERT INTO [cc_Project] ([Title], [Active]) VALUES (@Title, @Active)" SelectCommand="SELECT [Id], [Title], [Active] FROM [cc_Project] WHERE ([Deleted] = @Deleted) ORDER BY [Id] DESC" UpdateCommand="UPDATE [cc_Project] SET [Title] = @Title, [Active] = @Active WHERE [Id] = @Id">
    <DeleteParameters>
        <asp:Parameter Name="Id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Active" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="Deleted" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Active" Type="Int32" />
        <asp:Parameter Name="Id" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

            </asp:View>
        <asp:View ID="vProject" runat="server">
            <asp:Button ID="btnBackToProjects" runat="server" OnClick="btnBackToProjects_Click" Text="Назад" />
            <br />
            <asp:DetailsView ID="dvProject" runat="server" AutoGenerateRows="False" CssClass="crm-form"    Width="100%"  DataKeyNames="Id" DataSourceID="SqlDataSourceProject" DefaultMode="Insert" OnItemInserted="dvProject_ItemInserted"  >
                <Fields>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="Title" HeaderText="Название" SortExpression="Title" />
                    <asp:BoundField DataField="Description" HeaderText="Описание" SortExpression="Description" />
                    <asp:BoundField DataField="Active" HeaderText="Статус" SortExpression="Active" />
                    <asp:CommandField ButtonType="Button" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" DeleteCommand="DELETE FROM [cc_Project] WHERE [Id] = @Id" InsertCommand="INSERT INTO [cc_Project] ([Title], [Description], [Active],  [Created], [Updated]) VALUES (@Title, @Description, @Active,  getDate(),getDate())" SelectCommand="SELECT * FROM [cc_Project]" UpdateCommand="UPDATE [cc_Project] SET [Title] = @Title, [Description] = @Description, [Active] = @Active, [Deleted] = @Deleted, [Created] = @Created, [Updated] = @Updated WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="Active" Type="Int32" />
                    <asp:Parameter Name="Created" Type="DateTime" />
                    <asp:Parameter Name="Updated" Type="DateTime" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="Active" Type="Int32" />
                    <asp:Parameter Name="Deleted" Type="Int32" />
                    <asp:Parameter Name="Created" Type="DateTime" />
                    <asp:Parameter Name="Updated" Type="DateTime" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="vTask" runat="server">
            
            <asp:Button ID="btnBackToProjects2" runat="server" OnClick="btnBackToProjects_Click" Text="Назад" />
               <asp:HiddenField ID="hfIdProject" runat="server" />
               <br />
            <asp:DetailsView ID="dvTask" runat="server" AutoGenerateRows="False" CssClass="crm-form"    Width="100%" DataKeyNames="Id" DataSourceID="SqlDataSourceTask" DefaultMode="Insert" OnItemInserted="dvTask_ItemInserted" >
                <Fields>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="Title" HeaderText="Название" SortExpression="Title" />
                    <asp:BoundField DataField="Description" HeaderText="Описание" SortExpression="Description" />
                    <asp:BoundField DataField="Oktell_IdTask" HeaderText="Oktell_IdTask" SortExpression="Oktell_IdTask" />
                    <asp:BoundField DataField="Active" HeaderText="Статус" SortExpression="Active" />
                    <asp:CommandField ButtonType="Button" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceTask" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" DeleteCommand="DELETE FROM [cc_Task] WHERE [Id] = @Id" InsertCommand="INSERT INTO [cc_Task] ([Title], [Description], [IdProject], [Oktell_IdTask], [Active],   [Created], [Updated]) VALUES (@Title, @Description, @IdProject, @Oktell_IdTask, @Active, getDate(), getDate())" SelectCommand="SELECT * FROM [cc_Task]" UpdateCommand="UPDATE [cc_Task] SET [Title] = @Title, [Description] = @Description, [IdProject] = @IdProject, [Oktell_IdTask] = @Oktell_IdTask, [Active] = @Active, [Deleted] = @Deleted, [Created] = @Created, [Updated] = @Updated WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:ControlParameter ControlID="hfIdProject" Name="IdProject" PropertyName="Value" Type="Int32" />
                    <asp:Parameter Name="Oktell_IdTask" Type="String" />
                    <asp:Parameter Name="Active" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="IdProject" Type="Int32" />
                    <asp:Parameter Name="Oktell_IdTask" Type="Object" />
                    <asp:Parameter Name="Active" Type="Int32" />
                    <asp:Parameter Name="Deleted" Type="Int32" />
                    <asp:Parameter Name="Created" Type="DateTime" />
                    <asp:Parameter Name="Updated" Type="DateTime" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
</asp:Content>

