<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="TaskReport.aspx.cs" Inherits="TaskReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Отчеты рег формам</h2>
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
            <asp:QueryStringParameter Name="idTask" QueryStringField="IdTask" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

