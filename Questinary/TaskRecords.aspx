<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="TaskRecords.aspx.cs" Inherits="TaskRecords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridViewTasks" CellPadding="4" runat="server"  CssClass="table-crm" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceTasks">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:TemplateField HeaderText="IdTask" SortExpression="IdTask">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceOktellTasks" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("IdTask") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceOktellTasks" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" SelectCommand="SELECT   [Id] ,[Name]   FROM [oktell_settings].[dbo].[A_TaskManager_Tasks]  ORDER BY [Name]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IdTask") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ftp_host" HeaderText="ftp_host" SortExpression="ftp_host" />
            <asp:BoundField DataField="ftp_login" HeaderText="ftp_login" SortExpression="ftp_login" />
            <asp:BoundField DataField="ftp_pass" HeaderText="ftp_pass" SortExpression="ftp_pass" />
            <asp:BoundField DataField="ftp_path" HeaderText="ftp_path" SortExpression="ftp_path" />
            <asp:BoundField DataField="UserResults" HeaderText="UserResults" SortExpression="UserResults" />
            <asp:BoundField DataField="FormatFileName" HeaderText="FormatFileName" SortExpression="FormatFileName" />
            <asp:BoundField DataField="IsRecorded" HeaderText="IsRecorded" SortExpression="IsRecorded" />
            <asp:BoundField DataField="IsActive" HeaderText="IsActive" SortExpression="IsActive" />
            <asp:BoundField DataField="IsDeleted" HeaderText="IsDeleted" SortExpression="IsDeleted" />
            <asp:BoundField DataField="IsTransfer" HeaderText="IsTransfer" SortExpression="IsTransfer" />
            <asp:BoundField DataField="FilterTimeZonaStart" HeaderText="FilterTimeZonaStart" SortExpression="FilterTimeZonaStart" />
            <asp:BoundField DataField="FilterTimeZonaEnd" HeaderText="FilterTimeZonaEnd" SortExpression="FilterTimeZonaEnd" />
            <asp:BoundField DataField="FuncFormatFile" HeaderText="FuncFormatFile" SortExpression="FuncFormatFile" />
            <asp:BoundField DataField="FuncFormatDir" HeaderText="FuncFormatDir" SortExpression="FuncFormatDir" />
            <asp:BoundField DataField="FuncFormatDirAfter" HeaderText="FuncFormatDirAfter" SortExpression="FuncFormatDirAfter" />
            <asp:BoundField DataField="CountLoad" HeaderText="CountLoad" SortExpression="CountLoad" />
            <asp:BoundField DataField="ExludeDateInFolder" HeaderText="ExludeDateInFolder" SortExpression="ExludeDateInFolder" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceTasks" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" 
        DeleteCommand="DELETE FROM [WS_TaskOktellRecords] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [WS_TaskOktellRecords] ([Name], [IdTask], [ftp_host], [ftp_login], [ftp_pass], [ftp_path], [UserResults], [FormatFileName], [IsRecorded], [IsActive], [IsDeleted], [IsTransfer], [FilterTimeZonaStart], [FilterTimeZonaEnd], [FuncFormatFile], [FuncFormatDir], [FuncFormatDirAfter], [CountLoad], [ExludeDateInFolder]) VALUES (@Name, @IdTask, @ftp_host, @ftp_login, @ftp_pass, @ftp_path, @UserResults, @FormatFileName, @IsRecorded, isnull(@IsActive,0), @IsDeleted, @IsTransfer, @FilterTimeZonaStart, @FilterTimeZonaEnd, @FuncFormatFile, @FuncFormatDir, @FuncFormatDirAfter, @CountLoad, isnull(@ExludeDateInFolder,''))" 
        SelectCommand="SELECT * FROM [WS_TaskOktellRecords]" 
        UpdateCommand="UPDATE [WS_TaskOktellRecords] SET [Name] = @Name, [IdTask] = @IdTask, [ftp_host] = @ftp_host, [ftp_login] = @ftp_login, [ftp_pass] = @ftp_pass, [ftp_path] = @ftp_path, [UserResults] = @UserResults, [FormatFileName] = @FormatFileName, [IsRecorded] = @IsRecorded, [IsActive] = @IsActive, [IsDeleted] = @IsDeleted, [IsTransfer] = @IsTransfer, [FilterTimeZonaStart] = @FilterTimeZonaStart, [FilterTimeZonaEnd] = @FilterTimeZonaEnd, [FuncFormatFile] = @FuncFormatFile, [FuncFormatDir] = @FuncFormatDir, [FuncFormatDirAfter] = @FuncFormatDirAfter, [CountLoad] = @CountLoad, [ExludeDateInFolder] = @ExludeDateInFolder WHERE [Id] = @Id"
        >
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="IdTask" Type="String" />
            <asp:Parameter Name="ftp_host" Type="String" />
            <asp:Parameter Name="ftp_login" Type="String" />
            <asp:Parameter Name="ftp_pass" Type="String" />
            <asp:Parameter Name="ftp_path" Type="String" />
            <asp:Parameter Name="UserResults" Type="String" />
            <asp:Parameter Name="FormatFileName" Type="String" />
            <asp:Parameter Name="IsRecorded" Type="Int32" />
            <asp:Parameter Name="IsActive" Type="Int32" />
            <asp:Parameter Name="IsDeleted" Type="Int32" />
            <asp:Parameter Name="IsTransfer" Type="Int32" />
            <asp:Parameter Name="FilterTimeZonaStart" Type="Int32" />
            <asp:Parameter Name="FilterTimeZonaEnd" Type="Int32" />
            <asp:Parameter Name="FuncFormatFile" Type="String" />
            <asp:Parameter Name="FuncFormatDir" Type="String" />
            <asp:Parameter Name="FuncFormatDirAfter" Type="String" />
            <asp:Parameter Name="CountLoad" Type="Int32" />
            <asp:Parameter Name="ExludeDateInFolder" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="IdTask" Type="String" />
            <asp:Parameter Name="ftp_host" Type="String" />
            <asp:Parameter Name="ftp_login" Type="String" />
            <asp:Parameter Name="ftp_pass" Type="String" />
            <asp:Parameter Name="ftp_path" Type="String" />
            <asp:Parameter Name="UserResults" Type="String" />
            <asp:Parameter Name="FormatFileName" Type="String" />
            <asp:Parameter Name="IsRecorded" Type="Int32" />
            <asp:Parameter Name="IsActive" Type="Int32" />
            <asp:Parameter Name="IsDeleted" Type="Int32" />
            <asp:Parameter Name="IsTransfer" Type="Int32" />
            <asp:Parameter Name="FilterTimeZonaStart" Type="Int32" />
            <asp:Parameter Name="FilterTimeZonaEnd" Type="Int32" />
            <asp:Parameter Name="FuncFormatFile" Type="String" />
            <asp:Parameter Name="FuncFormatDir" Type="String" />
            <asp:Parameter Name="FuncFormatDirAfter" Type="String" />
            <asp:Parameter Name="CountLoad" Type="Int32" />
            <asp:Parameter Name="ExludeDateInFolder" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="DetailsView1" CssClass="crm-form"  runat="server" AutoGenerateRows="False" DataKeyNames="Id" DataSourceID="SqlDataSourceTasks" DefaultMode="Insert" Height="50px" Width="125px">
        <Fields>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:TemplateField HeaderText="IdTask" SortExpression="IdTask">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("IdTask") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceOktellTasks" DataTextField="Name" DataValueField="Id" SelectedValue='<%# Bind("IdTask") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceOktellTasks" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" SelectCommand="SELECT   [Id] ,[Name]   FROM [oktell_settings].[dbo].[A_TaskManager_Tasks]  ORDER BY [Name]"></asp:SqlDataSource>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IdTask") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ftp_host" HeaderText="ftp_host" SortExpression="ftp_host" />
            <asp:BoundField DataField="ftp_login" HeaderText="ftp_login" SortExpression="ftp_login" />
            <asp:BoundField DataField="ftp_pass" HeaderText="ftp_pass" SortExpression="ftp_pass" />
            <asp:BoundField DataField="ftp_path" HeaderText="ftp_path" SortExpression="ftp_path" />
            <asp:BoundField DataField="UserResults" HeaderText="UserResults" SortExpression="UserResults" />
            <asp:BoundField DataField="FormatFileName" HeaderText="FormatFileName" SortExpression="FormatFileName" />
            <asp:BoundField DataField="IsRecorded" HeaderText="IsRecorded" SortExpression="IsRecorded" />
            <asp:BoundField DataField="IsActive" HeaderText="IsActive" SortExpression="IsActive" />
            <asp:BoundField DataField="IsDeleted" HeaderText="IsDeleted" SortExpression="IsDeleted" />
            <asp:BoundField DataField="IsTransfer" HeaderText="IsTransfer" SortExpression="IsTransfer" />
            <asp:BoundField DataField="FilterTimeZonaStart" HeaderText="FilterTimeZonaStart" SortExpression="FilterTimeZonaStart" />
            <asp:BoundField DataField="FilterTimeZonaEnd" HeaderText="FilterTimeZonaEnd" SortExpression="FilterTimeZonaEnd" />
            <asp:BoundField DataField="FuncFormatFile" HeaderText="FuncFormatFile" SortExpression="FuncFormatFile" />
            <asp:BoundField DataField="FuncFormatDir" HeaderText="FuncFormatDir" SortExpression="FuncFormatDir" />
            <asp:BoundField DataField="FuncFormatDirAfter" HeaderText="FuncFormatDirAfter" SortExpression="FuncFormatDirAfter" />
            <asp:BoundField DataField="CountLoad" HeaderText="CountLoad" SortExpression="CountLoad" />
            <asp:BoundField DataField="ExludeDateInFolder" HeaderText="ExludeDateInFolder" SortExpression="ExludeDateInFolder" />
            <asp:CommandField ShowInsertButton="True" />
        </Fields>
    </asp:DetailsView>
    <br />
</asp:Content>

