<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="ScenarioTypeClient.aspx.cs" Inherits="ScenarioTypeClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1><asp:Label ID="Label1" runat="server" Text="Новый тип клиента"></asp:Label>
        
    </h1>
        <asp:DetailsView ID="DetailsView1" OnItemUpdated="DetailsView1_ItemUpdated" OnItemCommand="DetailsView1_ItemCommand" OnItemInserted="DetailsView1_ItemInserted" CssClass="crm-form" runat="server" DataSourceID="SqlDataSourceTypeClient" AutoGenerateRows="False" DefaultMode="Insert">
            <Fields>
                <asp:TemplateField HeaderText="Наименование">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Активный">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
    
    <asp:SqlDataSource ID="SqlDataSourceTypeClient" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT * FROM [crm_scenario_ClientTypes] WHERE (([ID] = @ID) AND ([IsDelete] = @IsDelete))" InsertCommand="INSERT INTO crm_scenario_ClientTypes(Title, Active, IsDelete, IsSystem) VALUES (@Title, @Active, 0, 0)" UpdateCommand="UPDATE crm_scenario_ClientTypes SET Title =@Title, Active =@Active WHERE ID = @ID">
        <InsertParameters>
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Active" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Byte" />
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
</asp:Content>

