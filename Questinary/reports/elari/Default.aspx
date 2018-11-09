<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="reports_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 20px;">
        
    <h1>Отчеты Элари (Древо жизни)</h1>
	<table border="0" cellpadding="20">
		<tr>
		
		 
            <td valign="top"> 
		
            <asp:GridView ID="GridViewForms" runat="server"  CssClass="table-crm" OnRowCommand="GridViewForms_RowCommand" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSourceFormList"  CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeader="False">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:HiddenField ID="HiddenFieldProcedureReport" Value='<%#Eval("ProcedureReport") %>' runat="server" />
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Id") %>' CommandName='<%#Eval("ProcedureReport") %>' Text="Построить" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns><EditRowStyle BackColor="#2461BF" />
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

    <asp:SqlDataSource ID="SqlDataSourceFormList" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" 
    DeleteCommand="DELETE FROM [cc_Form] WHERE [Id] = @Id" 
    InsertCommand="INSERT INTO [cc_Form] ([Title]) VALUES (@Title)" 
    SelectCommand="SELECT [Id], [Title],[ProcedureReport] FROM [cc_Form] WHERE (([Deleted] = @Deleted) AND ([idTask] = @idTask))" UpdateCommand="UPDATE [cc_Form] SET [Title] = @Title WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Title" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="Deleted" Type="Int32" />
            <asp:Parameter DefaultValue="47" Name="IdTask" Type="Int32" /> 
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
            </td>
		</tr>
	</table>
    </div>
    </form>
</body>
</html>
