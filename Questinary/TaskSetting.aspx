<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="TaskSetting.aspx.cs" Inherits="TaskSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Настройки</h2>

    <asp:GridView ID="GridView1" runat="server" CssClass="table-crm" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSourceListSetting" ForeColor="#333333" GridLines="None" ShowHeader="False" Width="925px" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="IdProject" HeaderText="IdProject" SortExpression="IdProject" Visible="False" />
            <asp:BoundField DataField="IdTask" HeaderText="IdTask" SortExpression="IdTask" Visible="False" />
            <asp:BoundField DataField="IdSetting" HeaderText="IdSetting" SortExpression="IdSetting" Visible="False" />
            <asp:BoundField DataField="Title" />
            <asp:BoundField DataField="Value" HeaderText="Value" SortExpression="Value">
            <ControlStyle Width="500px" />
            </asp:BoundField>
            <asp:CommandField ButtonType="Button" ShowEditButton="True" />
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
    <asp:SqlDataSource ID="SqlDataSourceListSetting" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" DeleteCommand="DELETE FROM [cc_TaskSetting] WHERE [Id] = @Id" InsertCommand="INSERT INTO [cc_TaskSetting] ([IdProject], [IdTask], [IdSetting], [Value]) VALUES (@IdProject, @IdTask, @IdSetting, @Value)" SelectCommand="SELECT t1.Id, t1.IdProject, t1.IdTask, t1.IdSetting, t1.Value, cc_TypeSetting.Title, cc_TypeSetting.Description FROM cc_TaskSetting AS t1 INNER JOIN cc_TypeSetting ON t1.IdSetting = cc_TypeSetting.Id WHERE (t1.IdTask = @IdTask) OR (t1.IdTask IS NULL)" UpdateCommand="UPDATE [cc_TaskSetting] SET [Value] = @Value WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="IdProject" Type="Int32" />
            <asp:Parameter Name="IdTask" Type="Int32" />
            <asp:Parameter Name="IdSetting" Type="Int32" />
            <asp:Parameter Name="Value" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="IdTask" QueryStringField="IdTask" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

