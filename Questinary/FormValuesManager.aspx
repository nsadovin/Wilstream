<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="FormValuesManager.aspx.cs" Inherits="FormValuesManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Регистрационные формы: проект <asp:DropDownList ID="DropDownListProjects" runat="server" OnSelectedIndexChanged="DropDownListProjects_SelectedIndexChanged" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceProjects" DataTextField="Title" DataValueField="Id">
        <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceProjects" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT * FROM [Projects] ORDER BY [Title]"></asp:SqlDataSource>
</h1>
    <asp:Panel ID="PanelColumns" Visible="false" runat="server">

        Родительская категория
        <asp:DropDownList ID="DropDownListValues" runat="server"  
                            AppendDataBoundItems="True" AutoPostBack="true"  DataSourceID="SqlDataSourceValues" 
                            DataTextField="Title" DataValueField="Id">
                        <asp:ListItem Value="0">Без родительской категории</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceValues" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" 
                            SelectCommand="SELECT * FROM [ReferenceBook] WHERE IdProject = @IdProject AND IdSection in (select IdSection from  [ReferenceBookSection] where  IdProject = @IdProject) ORDER BY [Title]">
                            <SelectParameters>
                                <asp:ControlParameter DbType="String" Name="IdProject" ControlID="DropDownListProjects" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource> 
        <br/>
        Поле формы: 
        <asp:DropDownList ID="DropDownListSection" runat="server"  
                               AutoPostBack="true"    DataSourceID="SqlDataSourceSections" 
                            DataTextField="Title" DataValueField="IdSection"> 
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceSections" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" 
                            SelectCommand="SELECT * FROM [ReferenceBookSection] WHERE IdProject = @IdProject ORDER BY [Title]">
                            <SelectParameters>
                                <asp:ControlParameter DbType="String" Name="IdProject" ControlID="DropDownListProjects" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>  

        <asp:ListView ID="ListViewValues" runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceListReferenceBook" InsertItemPosition="LastItem">
            <AlternatingItemTemplate>
                <tr style="background-color:#FFF8DC;">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" OnClientClick="if(!confirm('Удалить? После удаления данные будет невозможно восстановить!')) return false;" CommandName="Delete" Text="Удалить" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Изменить" />
                    </td> 
                    <td>
                        <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdParentLabel" runat="server" Text='<%# Eval("Category") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdSectionLabel" runat="server" Text='<%# Eval("Section") %>' />
                    </td> 
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="background-color:#008A8C;color: #FFFFFF;">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Обновить" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Отмена" />
                    </td> 
                    <td>
                        <asp:TextBox ID="TitleTextBox" Width="400" runat="server" Text='<%# Bind("Title") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdParentLabel" runat="server" Text='<%# Eval("Category") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdSectionLabel" runat="server" Text='<%# Eval("Section") %>' />
                    </td> 
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                    <tr>
                        <td>Нет данных.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Вставить" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Очистить" />
                    </td> 
                    <td>
                        <asp:TextBox ID="TitleTextBox" Width="400" runat="server" Text='<%# Bind("Title") %>' />
                    </td>
                    <td>
                        
                        
                    </td>
                    <td>
                        
                        
                    </td> 
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="background-color:#DCDCDC;color: #000000;">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server"  OnClientClick="if(!confirm('Удалить? После удаления данные будет невозможно восстановить!')) return false;" CommandName="Delete" Text="Удалить" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Изменить" />
                    </td> 
                    <td>
                        <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdParentLabel" runat="server" Text='<%# Eval("Category") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdSectionLabel" runat="server" Text='<%# Eval("Section") %>' />
                    </td> 
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                                <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                    <th runat="server"></th> 
                                    <th runat="server">Название</th>
                                    <th runat="server">Родительская категория</th>
                                    <th runat="server">Поле</th> 
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                            <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Удалить" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Изменить" />
                    </td> 
                    <td>
                        <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdParentLabel" runat="server" Text='<%# Eval("Category") %>' />
                    </td>
                    <td>
                        <asp:Label ID="IdSectionLabel" runat="server" Text='<%# Eval("IdSection") %>' />
                    </td> 
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceListReferenceBook" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" DeleteCommand="DELETE FROM [ReferenceBook] WHERE [Id] = @Id" InsertCommand="INSERT INTO [ReferenceBook] ([Title], [IdParent], [IdSection], [IdProject]) VALUES (@Title, @IdParent, @IdSection, @IdProject)" SelectCommand="SELECT t1.*,t2.Title Category, t3.Title as Section FROM [ReferenceBook] t1
 LEFT JOIN [ReferenceBook] t2 on t1.IdParent = t2.Id 
, ReferenceBookSection t3
WHERE (t1.[IdProject] = @IdProject) AND t1.IdSection =  t3.IdSection
AND t1.IdParent = @IdParent AND t1.IdSection = @IdSection
ORDER BY t1.Title" UpdateCommand="UPDATE [ReferenceBook] SET [Title] = @Title  WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:ControlParameter ControlID="DropDownListValues" Name="IdParent" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownListSection" Name="IdSection" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownListProjects" Name="IdProject" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListProjects" Name="IdProject" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownListValues" Name="IdParent" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="DropDownListSection" Name="IdSection" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </asp:Panel>
</asp:Content>

