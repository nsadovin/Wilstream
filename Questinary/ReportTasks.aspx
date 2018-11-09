<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="ReportTasks.aspx.cs" Inherits="ReportTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1><asp:Label ID="Label1" runat="server" Text="Задачи"></asp:Label></h1>
    <asp:MultiView ID="mvTasks" runat="server" ActiveViewIndex="0">
        <asp:View ID="vTasks" runat="server">
            <asp:Button ID="btnNewTask" runat="server" Text="Новая задача" OnClick="btnNewTask_Click" />
            <br /><br />
            <asp:GridView ID="gwTasks" CssClass="table-crm" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSourceReportTasks" ForeColor="#333333" GridLines="None" AllowPaging="True" PageSize="100" AllowSorting="True" Width="100%">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
            
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id"   />
                    <asp:BoundField DataField="Title" HeaderText="Отчет" SortExpression="Title" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:CheckBoxField DataField="Active" HeaderText="Статус" SortExpression="Active" />
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button ID="btnUpdate" runat="server"  CausesValidation="True"  Text="Обновить" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="btnToProjects" runat="server" OnClick="btnToProjects_Click"  CausesValidation="False"   CommandArgument='<%# Eval("Id") %>' CommandName='<%# Eval("Title") %>'  Text="Проекты" />
                            <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" CausesValidation="False"   CommandArgument='<%# Eval("Id") %>' ToolTip='<%# Eval("Title") %>' CommandName="Select" Text="Правка" />
                            &nbsp;<asp:Button ID="Button2" runat="server" OnClientClick="if(!confirm('Удалить?')) return false;" CausesValidation="False" CommandName="Delete" Text="Удалить" />
                        </ItemTemplate>
                    </asp:TemplateField>
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
            <asp:SqlDataSource ID="SqlDataSourceReportTasks" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" DeleteCommand="DELETE FROM [report_task] WHERE [Id] = @Id" InsertCommand="INSERT INTO [report_task] ([Title], [Email], [Active]) VALUES (@Title, @Email, @Active)" SelectCommand="SELECT * FROM [report_task]" UpdateCommand="UPDATE [report_task] SET [Title] = @Title, [Email] = @Email, [Active] = @Active WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="vTask" runat="server">
            <h2><asp:Label ID="lblTask" runat="server" Text="Новая задача"></asp:Label></h2>
            <asp:Button ID="btnBackToTasks" runat="server" Text="Назад" OnClick="btnBackToTasks_Click" />
            <br /><br />
            <asp:DetailsView ID="dvTask" CssClass="crm-form" runat="server"   Width="100%" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSourceReportTask" DefaultMode="Insert" OnItemInserted="dvTask_ItemInserted" OnItemCommand="dvTask_ItemCommand" OnItemUpdated="dvTask_ItemUpdated">
                <Fields>
                    <asp:BoundField DataField="Id" Visible="false" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="Title" HeaderText="Задача" SortExpression="Title" />
                    <asp:BoundField DataField="Email" HeaderText="Email (через запятую)" SortExpression="Email" />
                    <asp:TemplateField HeaderText="SQL код отчета" SortExpression="Sql">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Sql") %>' TextMode="MultiLine"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Sql") %>' TextMode="MultiLine"></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Sql") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Height="400px" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="Active" HeaderText="Статус" SortExpression="Active" />
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceReportTask" runat="server" 
                ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
                DeleteCommand="DELETE FROM [report_task] WHERE [Id] = @Id" 
                InsertCommand="INSERT INTO [report_task] ([Title], [Email], [Active],[Sql]) VALUES (@Title, @Email, @Active,@Sql)" 
                SelectCommand="SELECT * FROM [report_task] WHERE ([Id] = @Id)" 
                UpdateCommand="UPDATE [report_task] SET [Sql] =  @Sql, [Title] = @Title, [Email] = @Email, [Active] = @Active WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Sql" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gwTasks" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Sql" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
               
        <asp:View ID="vProjects" runat="server">
            <h2><asp:Label ID="Label3" runat="server" Text="Проекты в отчет"></asp:Label> <asp:Label ID="LabelProjects" runat="server" Text="Проекты в отчет"></asp:Label></h2>
            <asp:Button ID="btn2BackToTasks" runat="server" Text="Назад" OnClick="btnBackToTasks_Click" />
            <br /><br />
            <asp:HiddenField ID="hfIdTask" runat="server" />
            <h3>Задачи из Октелла</h3>
            
            <asp:GridView ID="gvOktellTasks" CssClass="table-crm" Width="100%" runat="server" CellPadding="4" DataSourceID="SqlDataSourceOktellTasks" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" ShowHeaderWhenEmpty="True">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:BoundField DataField="IdTask" HeaderText="IdTask" InsertVisible="False" ReadOnly="True" SortExpression="IdTask" Visible="False" />
                    <asp:BoundField DataField="IdTaskOktell" HeaderText="IdTaskOktell" SortExpression="IdTaskOktell" Visible="False" />
                    <asp:BoundField DataField="Task" HeaderText="Задача" SortExpression="Task" />
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True" >
                    <HeaderStyle Width="100px" />
                    </asp:CommandField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <EmptyDataTemplate>
                    Нет данных
                </EmptyDataTemplate>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceOktellTasks" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" DeleteCommand="DELETE FROM [report_task_oktell] WHERE [Id] = @Id" InsertCommand="INSERT INTO [report_task_oktell] ([Id], [IdTaskOktell], [Task]) VALUES (@Id, @IdTaskOktell, @Task)" SelectCommand="SELECT * FROM [report_task_oktell] WHERE ([IdTask] = @IdTask) ORDER BY [Task]" UpdateCommand="UPDATE [report_task_oktell] SET [IdTask] = @IdTask, [IdTaskOktell] = @IdTaskOktell, [Task] = @Task WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                    <asp:Parameter Name="IdTaskOktell" Type="Object" />
                    <asp:Parameter Name="Task" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfIdTask" Name="IdTask" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="IdTaskOktell" Type="Object" />
                    <asp:Parameter Name="Task" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>


            <asp:DetailsView ID="dvTaskOktell" CssClass="crm-form" runat="server"   Width="730px" DefaultMode="Insert" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSourcetaskOktell" OnItemInserted="dvTaskOktell_ItemInserted" OnItemInserting="dvTaskOktell_ItemInserting">
                <Fields>
                    <asp:TemplateField HeaderText=""  SortExpression="Task" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Task") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            Задача из Октелл
                            <asp:DropDownList ID="ddlTasksOktell" runat="server" DataSourceID="SqlDataSourceTasksFromOktell" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("IdTaskOktell") %>'></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceTasksFromOktell" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT   [Id]  ,[Name]  FROM [oktell_cc_temp].[dbo].[A_Cube_CC_Cat_Task]    ORDER BY [Name]"></asp:SqlDataSource>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Добавить" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Task") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField> 
                </Fields>
            </asp:DetailsView>

            <asp:SqlDataSource ID="SqlDataSourcetaskOktell" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
                DeleteCommand="DELETE FROM [report_task_oktell] WHERE [Id] = @Id" 
                InsertCommand="INSERT INTO report_task_oktell( IdTaskOktell, Task, IdTask) VALUES ( @IdTaskOktell, @Task, @IdTask)" SelectCommand="SELECT * FROM [report_task_oktell]" UpdateCommand="UPDATE [report_task_oktell] SET [IdTask] = @IdTask, [IdTaskOktell] = @IdTaskOktell, [Task] = @Task WHERE [Id] = @Id" OnInserting="SqlDataSourcetaskOktell_Inserting" CancelSelectOnNullParameter="False">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters> 
                    <asp:Parameter Name="IdTaskOktell" Type="String" />
                    <asp:Parameter Name="Task" DefaultValue="" Type="String" />
                    <asp:ControlParameter ControlID="hfIdTask" Name="IdTask" PropertyName="Value" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="IdTaskOktell" Type="Object" />
                    <asp:Parameter Name="Task" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <h3>Skillset</h3>
            <asp:GridView ID="gvSkillsets" CssClass="table-crm" Width="100%" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSourceSkillsets" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="True">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:BoundField DataField="Skillset" HeaderText="Skillset" SortExpression="Skillset" />
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True" >
                    <HeaderStyle Width="100px" />
                    </asp:CommandField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <EmptyDataTemplate>
                    Нет данных
                </EmptyDataTemplate>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            
            <asp:SqlDataSource ID="SqlDataSourceSkillsets" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" DeleteCommand="DELETE FROM [report_task_skillset] WHERE [Id] = @Id" InsertCommand="INSERT INTO [report_task_skillset] ([IdTask], [Skillset]) VALUES (@IdTask, @Skillset)" SelectCommand="SELECT * FROM [report_task_skillset] WHERE ([IdTask] = @IdTask) ORDER BY [Skillset]" UpdateCommand="UPDATE [report_task_skillset] SET [IdTask] = @IdTask, [Skillset] = @Skillset WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="Skillset" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfIdTask" Name="IdTask" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="Skillset" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <asp:DetailsView ID="dvSkillset" runat="server"  CssClass="crm-form" Width="750px" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSourceSkillset" DefaultMode="Insert" OnItemInserted="dvSkillset_ItemInserted">
                <Fields>
                    <asp:TemplateField HeaderText="Skillset" ShowHeader="False" SortExpression="Skillset">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Skillset") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            Skillset
                            <asp:DropDownList ID="ddlSkillsets" runat="server" DataSourceID="SqlDataSourceListSkillsets" DataTextField="Skillset" DataValueField="Skillset" SelectedValue='<%# Bind("Skillset") %>'></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceListSkillsets" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" SelectCommand="SELECT * FROM SCCS_STAT.dbo.[Skillset] ORDER BY [Skillset]"></asp:SqlDataSource>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Добавить" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Skillset") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                 
                </Fields>
            </asp:DetailsView>


            
            <asp:SqlDataSource ID="SqlDataSourceSkillset" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" DeleteCommand="DELETE FROM [report_task_skillset] WHERE [Id] = @Id" InsertCommand="INSERT INTO [report_task_skillset] ([IdTask], [Skillset]) VALUES (@IdTask, @Skillset)" SelectCommand="SELECT * FROM [report_task_skillset]" UpdateCommand="UPDATE [report_task_skillset] SET [IdTask] = @IdTask, [Skillset] = @Skillset WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="hfIdTask" Name="IdTask" PropertyName="Value" Type="Int32" />
                    <asp:Parameter Name="Skillset" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="Skillset" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
            <h3>Application</h3>
            <asp:GridView ID="gwApplications" CssClass="table-crm" Width="100%" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSourceApplications" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="True">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                    <asp:BoundField DataField="Application" HeaderText="Application" SortExpression="Application" />
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True">
                    <HeaderStyle Width="100px" />
                    </asp:CommandField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <EmptyDataTemplate>
                    Нет данных
                </EmptyDataTemplate>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            
            
            <asp:SqlDataSource ID="SqlDataSourceApplications" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" DeleteCommand="DELETE FROM [report_task_application] WHERE [Id] = @Id" InsertCommand="INSERT INTO [report_task_application] ([IdTask], [Application]) VALUES (@IdTask, @Application)" SelectCommand="SELECT * FROM [report_task_application] WHERE ([IdTask] = @IdTask) ORDER BY [Application]" UpdateCommand="UPDATE [report_task_application] SET [IdTask] = @IdTask, [Application] = @Application WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="Application" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfIdTask" Name="IdTask" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="Application" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
            <asp:DetailsView ID="dvApplication"  CssClass="crm-form" Width="750px" runat="server" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSourceApplication" DefaultMode="Insert" OnItemInserted="dvApplication_ItemInserted" >
                <Fields>
                    <asp:TemplateField HeaderText="Application" ShowHeader="False" SortExpression="Application">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Application") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            Application
                            <asp:DropDownList ID="ddlListApplication" runat="server" DataSourceID="SqlDataSource" DataTextField="Application" DataValueField="Application" SelectedValue='<%# Bind("Application") %>'></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" SelectCommand="SELECT [Application] FROM [SCCS_STAT].[dbo].[Application] ORDER BY [Application]"></asp:SqlDataSource>
                              <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Добавить" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Application") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField> 
                </Fields>
            </asp:DetailsView>
            
            <asp:SqlDataSource ID="SqlDataSourceApplication" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" DeleteCommand="DELETE FROM [report_task_application] WHERE [Id] = @Id" InsertCommand="INSERT INTO [report_task_application] ([IdTask], [Application]) VALUES (@IdTask, @Application)" SelectCommand="SELECT * FROM [report_task_application]" UpdateCommand="UPDATE [report_task_application] SET [IdTask] = @IdTask, [Application] = @Application WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="hfIdTask" Name="IdTask" PropertyName="Value" Type="Int32" />
                    <asp:Parameter Name="Application" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" />
                    <asp:Parameter Name="Application" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
        </asp:View>
    </asp:MultiView>
    
</asp:Content>

