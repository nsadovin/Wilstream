<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="ScenarioTypeClients.aspx.cs" Inherits="ScenarioTypeClients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Типы клиентов</h1>
    <asp:GridView ID="GridView1" runat="server" CssClass="table-crm" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTypeClients" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="ID">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Наименование" SortExpression="Title" />
            <asp:TemplateField HeaderText="Активный" SortExpression="Active">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Active") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>

                    <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToBoolean(Eval("Active"))?"ДА":"НЕТ" %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" OnClick="Button1_Click"  CommandArgument='<%# Eval("ID") %>' runat="server" CausesValidation="False" CommandName="Edit" Text="Правка" />
                    &nbsp;<asp:Button ID="Button2" runat="server" Visible='<%# !Convert.ToBoolean(Eval("IsSystem")) %>' OnClientClick="if(!confirm('Удалить?')) return false;" CausesValidation="False" CommandName="Delete" Text="Удалить" />
                </ItemTemplate>
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
    <asp:SqlDataSource ID="SqlDataSourceTypeClients" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [Active], [ID], [IsSystem] FROM [crm_scenario_ClientTypes] WHERE ([IsDelete] = @IsDelete) ORDER BY [Title]" DeleteCommand="UPDATE crm_scenario_ClientTypes SET IsDelete = 1 WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Byte" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

