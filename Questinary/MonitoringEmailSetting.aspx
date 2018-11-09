<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="MonitoringEmailSetting.aspx.cs" Inherits="MonitoringEmailSetting" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:toolkitscriptmanager ID="Toolkitscriptmanager1" runat="server"></asp:toolkitscriptmanager>
        <h1>Почтовые аккаунты для задач по обработке почты</h1>
    <asp:Button ID="Button1" runat="server" Text="Добавить почтовый аккаунт" OnClick="Button1_Click" />

    <br />
    <br />

    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="-1">
        <asp:View ID="View1" runat="server">

            <asp:DetailsView ID="DetailsView1" CssClass="crm-form"  runat="server" Height="50px" Width="700px" DataSourceID="SqlDataSourceEdit" DefaultMode="Insert" AutoGenerateRows="False" DataKeyNames="Id" OnItemCommand="DetailsView1_ItemCommand" OnItemInserted="DetailsView1_ItemInserted">
                <Fields>
                    <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:TemplateField HeaderText="Название аккаунта" SortExpression="Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox4" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Описание" SortExpression="Description">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server"  TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server"  TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Height="50px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Проект (Октелл)" SortExpression="OktellIdProject">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList3" AutoPostBack="true" runat="server" DataSourceID="SqlDataSourceProjects2" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("OktellIdProject") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceProjects2" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT  [Id] ,[Name]   FROM [oktell_settings].[dbo].[A_TaskManager_Projects] ORDER BY [Name]"></asp:SqlDataSource>                   
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server" DataSourceID="SqlDataSourceProjects" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("OktellIdProject") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceProjects" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT  [Id] ,[Name]   FROM [oktell_settings].[dbo].[A_TaskManager_Projects] ORDER BY [Name]"></asp:SqlDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("OktellIdProject") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Задача (Октелл)" SortExpression="OktellIdTask">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox100" runat="server" Text='<%# Bind("OktellIdTask") %>' Style="display:none;" ></asp:TextBox> 
                            
                            <asp:DropDownList ID="DropDownList4" AutoPostBack="true"  OnDataBound="DropDownList4_DataBound"  OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" runat="server" DataSourceID="SqlDataSourceTasks2" DataTextField="Name" DataValueField="Id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceTasks2" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT NULL [Id] ,'' [Name] UNION ALL SELECT  [Id] ,[Name]   FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IdProject] = @IdProject ORDER BY [Id]">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList3" Name="IdProject" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource><asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TextBox100" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DropDownList2" AutoPostBack="true"  OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" runat="server" DataSourceID="SqlDataSourceTasks" DataTextField="Name" DataValueField="Id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceTasks" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT NULL [Id] ,'' [Name] UNION ALL SELECT  [Id] ,[Name]   FROM [oktell_settings].[dbo].[A_TaskManager_Tasks] WHERE [IdProject] = @IdProject ORDER BY [Id]">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList1" Name="IdProject" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("OktellIdTask") %>' Style="display:none;" ></asp:TextBox> 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox12" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("OktellIdTask") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Хост" SortExpression="Host">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox101" runat="server" Text='<%# Bind("Host") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="TextBox101" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Host") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("Host") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Порт" SortExpression="Port">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox102" runat="server" Text='<%# Bind("Port") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TextBox102" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Port") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Port") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Логин" SortExpression="Login">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox103" runat="server" Text='<%# Bind("Login") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="TextBox103" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Login") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("Login") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Пароль" SortExpression="Password">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="TextBox8" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>                        
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox6" ErrorMessage="Заполните поле" ForeColor="Red"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("Password") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SSL" SortExpression="IsSSL">
                        <EditItemTemplate>
                           <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("IsSSL") %>'></asp:CheckBox>
                        </EditItemTemplate>
                        <InsertItemTemplate> 
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsSSL") %>'></asp:CheckBox>
                            <br />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("IsSSL") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Активный" SortExpression="IsActive">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%# Bind("IsActive") %>'></asp:CheckBox>
                        </EditItemTemplate>
                        <InsertItemTemplate> 
                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("IsActive") %>'></asp:CheckBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Button" InsertText="Сохранить"  ShowEditButton="true" UpdateText="Обновить" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
        </asp:View>
    </asp:MultiView>

    <asp:GridView CssClass="table-crm" ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSourceSections" ForeColor="#333333" GridLines="None" Width="100%" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="Name" HeaderText="Название" SortExpression="Name" /> 
             
            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowSelectButton="true" SelectText="Редактировать" ShowEditButton="False">
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
<asp:SqlDataSource ID="SqlDataSourceSections" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
DeleteCommand="UPDATE [MonitoringEmail_Setting] SET IsDelete   = 1 WHERE [ID] = @ID" 
InsertCommand="INSERT INTO [MonitoringEmail_Setting] ([Name],[Description],[OktellIdProject],[OktellIdTask],[Host],[Port],[Login],[Password],[IsSSL],[IsDeleted],[IsActive],[CreatedOn]) VALUES (@Name,@Description,@OktellIdProject,@OktellIdTask,@Host,@Port,@Login,@Password,@IsSSL,0,@IsActive, GetDate())" 
SelectCommand="SELECT * FROM [MonitoringEmail_Setting] WHERE ([IsDeleted] = @IsDeleted) ORDER BY [ID] DESC" 
UpdateCommand="UPDATE [MonitoringEmail_Setting] SET [Name] = @Name, [UpdatedOn] = getDate() WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="Id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="OktellIdProject" Type="String"  />
        <asp:Parameter Name="OktellIdTask" Type="String"   />
        <asp:Parameter Name="Host" Type="String" />
        <asp:Parameter Name="Port" Type="Int32" />
        <asp:Parameter Name="Login" Type="String" />
        <asp:Parameter Name="Password" Type="String" />
        <asp:Parameter Name="IsActive" Type="Byte" /> 
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Int32" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="IsDeleted" Type="Int32" />
        <asp:Parameter Name="Id" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

    
<asp:SqlDataSource ID="SqlDataSourceEdit" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
DeleteCommand="UPDATE [MonitoringEmail_Setting] SET IsDelete   = 1 WHERE [ID] = @ID" 
InsertCommand="INSERT INTO [MonitoringEmail_Setting] ([Name],[Description],[OktellIdProject],[OktellIdTask],[Host],[Port],[Login],[Password],[IsSSL],[IsDeleted],[IsActive],[CreatedOn]) VALUES (@Name,@Description,@OktellIdProject,@OktellIdTask,@Host,@Port,@Login,@Password,@IsSSL,0,@IsActive, GetDate())" 
SelectCommand="SELECT * FROM [MonitoringEmail_Setting] WHERE ([IsDeleted] = @IsDeleted) AND Id = @Id ORDER BY [ID] DESC" 
UpdateCommand="UPDATE [dbo].[MonitoringEmail_Setting] SET [Name] = @Name  ,[Description] = @Description   ,[OktellIdProject] = @OktellIdProject   ,[OktellIdTask] = @OktellIdTask  ,[Host] = @Host  ,[Port] = @Port  ,[Login] = @Login  ,[Password] = @Password  ,[IsSSL] = @IsSSL  ,[IsActive] = @IsActive   ,[UpdatedOn] = GetDate() WHERE [ID] = @ID">
    <DeleteParameters>
        <asp:Parameter Name="Id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="OktellIdProject" Type="String"  />
        <asp:Parameter Name="OktellIdTask" Type="String"   />
        <asp:Parameter Name="Host" Type="String" />
        <asp:Parameter Name="Port" Type="Int32" />
        <asp:Parameter Name="Login" Type="String" />
        <asp:Parameter Name="Password" Type="String" />
        <asp:Parameter Name="IsSSL" />
        <asp:Parameter Name="IsActive" Type="Byte" /> 
    </InsertParameters>
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Int32" />
        <asp:ControlParameter ControlID="GridView1" DefaultValue="" Name="Id" PropertyName="SelectedValue" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="OktellIdProject" Type="String"  />
        <asp:Parameter Name="OktellIdTask" Type="String"   />
        <asp:Parameter Name="Host" Type="String" />
        <asp:Parameter Name="Port" Type="Int32" />
        <asp:Parameter Name="Login" Type="String" />
        <asp:Parameter Name="Password" Type="String" />
        <asp:Parameter Name="IsSSL" />
        <asp:Parameter Name="IsActive" Type="Byte" /> 
        <asp:Parameter Name="Id" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>

