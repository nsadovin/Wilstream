<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="OketllManualTask.aspx.cs" Inherits="OketllManualTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
            <asp:GridView ID="gvOktellTasks" CssClass="table-crm" Width="100%" runat="server" CellPadding="4" DataSourceID="SqlDataSourceOktellTasks" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" ShowHeaderWhenEmpty="True">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="False" /> 
                    <asp:BoundField DataField="IdTask" HeaderText="IdTask" InsertVisible="False" ReadOnly="True" SortExpression="IdTask" Visible="False" />
                     
                      <asp:TemplateField HeaderText="Задача"  SortExpression="TaskName" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:HiddenField ID="HiddenFieldIdTask" runat="server" Value='<%# Eval("IdTask") %>' />
                            <asp:DropDownList ID="ddlTasksOktell" runat="server" DataSourceID="SqlDataSourceTasksFromOktell" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("IdTask") %>'></asp:DropDownList>
                             <asp:SqlDataSource ID="SqlDataSourceTasksFromOktell" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" SelectCommand="SELECT null  [Id]  ,'' [Name] 
                                UNION ALL Select * from ( Select @IdTask  as Id, '' as [Name] ) t Where not exists( SELECT   *  FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE Id = @IdTask)
                                UNION ALL SELECT   [Id]  ,[Name]  FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IsOutputTask] =  1 
 
ORDER BY [Name] ">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenFieldIdTask" Name="IdTask" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                           
                        </EditItemTemplate>
                        <InsertItemTemplate> 
                            
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TaskName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>  

                    <asp:BoundField DataField="AON" HeaderText="АОН при исходе" SortExpression="AON" />
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="true" >
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
            <asp:SqlDataSource ID="SqlDataSourceOktellTasks" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" 
                DeleteCommand="DELETE FROM [WS_OtherTask] WHERE [Id] = @Id" 
                InsertCommand="INSERT INTO [WS_OtherTask] ([IdTask], [TaskName], [AON]) VALUES ( @IdTask, (SELECT   top 1 [Name]     FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IsOutputTask] =  1 and Id = @IdTask),@AON)" 
                SelectCommand="SELECT * FROM [WS_OtherTask] ORDER BY [TaskName]"
                 UpdateCommand="UPDATE [WS_OtherTask] SET [IdTask] = @IdTask, [AON] = @AON,  [TaskName] = (SELECT   top 1 [Name]     FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IsOutputTask] =  1 and Id = @IdTask) WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Id" Type="Int32" /> 
                    <asp:Parameter Name="Task" Type="String" />
                    <asp:Parameter Name="AON" Type="String" />
                </InsertParameters>
                <SelectParameters> 
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                    <asp:Parameter Name="AON" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>


            <asp:DetailsView ID="dvTaskOktell" CssClass="crm-form" runat="server"   Width="730px" DefaultMode="Insert" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSourcetaskOktell" OnItemInserted="dvTaskOktell_ItemInserted" OnItemInserting="dvTaskOktell_ItemInserting">
                <Fields>
                    <asp:TemplateField HeaderText=""  SortExpression="TaskName" ShowHeader="False">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TaskName") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            АОН: <asp:TextBox ID="TextBoxAON" runat="server" Text='<%# Bind("AON") %>'></asp:TextBox><br/>
                            Задача из Октелл:
                            <asp:DropDownList ID="ddlTasksOktell" runat="server" DataSourceID="SqlDataSourceTasksFromOktell" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("IdTask") %>'></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceTasksFromOktell" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" SelectCommand="SELECT   [Id]  ,[Name]  FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IsOutputTask] =  1 and Id not in (select IdTask  from WS_OtherTask where IdTask is not null) ORDER BY [Name]"></asp:SqlDataSource>
                            <br/>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Добавить" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TaskName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>  
                </Fields>
            </asp:DetailsView>

            <asp:SqlDataSource ID="SqlDataSourcetaskOktell" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" 
                DeleteCommand="DELETE FROM [WS_OtherTask] WHERE [Id] = @Id" 
                InsertCommand="INSERT INTO WS_OtherTask ( IdTask,AON, TaskName) VALUES ( @IdTask,@AON, (SELECT   top 1 [Name]     FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IsOutputTask] =  1 and Id = @IdTask))" 
                SelectCommand="SELECT * FROM [WS_OtherTask]" 
                UpdateCommand="UPDATE [WS_OtherTask] SET [IdTask] = @IdTask ,[AON] = @AON,
                [TaskName] = (SELECT   top 1 [Name]     FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IsOutputTask] =  1 and Id = @IdTask) WHERE [Id] = @Id" 
                  CancelSelectOnNullParameter="False">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters> 
                    <asp:Parameter Name="IdTask" Type="String" />  
                    <asp:Parameter Name="AON" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdTask" Type="Int32" /> 
                    <asp:Parameter Name="Id" Type="Int32" />
                    <asp:Parameter Name="AON" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
</asp:Content>

