<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Data.aspx.cs" Inherits="Data" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <img src="images/logo.png" />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="IdData" DataSourceID="SqlDataSource2" DefaultMode="Insert" Height="50px" Width="125px">
            <EditRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <Fields>
                <asp:BoundField DataField="IdData" HeaderText="IdData" InsertVisible="False" ReadOnly="True" SortExpression="IdData" />
                <asp:TemplateField HeaderText="Справочник" SortExpression="IdDirectory">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("IdDirectory") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceDirectoties" DataTextField="Directory" DataValueField="IdDirectory" SelectedValue='<%# Bind("IdDirectory") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceDirectoties" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT [IdDirectory], [Directory] FROM [andrus_directories] ORDER BY [Directory]"></asp:SqlDataSource>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("IdDirectory") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Value" HeaderText="Значение" SortExpression="Value" />
                <asp:CommandField ButtonType="Button" ShowCancelButton="False" ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
        </asp:DetailsView>

          <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" DeleteCommand="DELETE FROM andrus_data WHERE (IdData = @IdData)" InsertCommand="INSERT INTO andrus_data(IdDirectory, Value) VALUES (@IdDirectory, @Value)" SelectCommand="SELECT t1.*,(select top 1 Directory from andrus_directories t2 where t1.IdDirectory = t2.IdDirectory ) as Directory FROM [andrus_data] t1" UpdateCommand="UPDATE andrus_data SET IdDirectory = @IdDirectory, Value = @Value WHERE (IdData = @IdData)" CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="IdData" PropertyName="SelectedValue" />
            </DeleteParameters>
           
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView1" Name="IdData" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceData" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" DeleteCommand="DELETE FROM andrus_data WHERE (IdData = @IdData)" InsertCommand="INSERT INTO andrus_data(IdDirectory, Value) VALUES (@IdDirectory, @Value)" SelectCommand="SELECT t1.*,(select top 1 Directory from andrus_directories t2 where t1.IdDirectory = t2.IdDirectory ) as Directory FROM [andrus_data] t1 where t1.IdDirectory = @IdDirectory" UpdateCommand="UPDATE andrus_data SET IdDirectory = @IdDirectory, Value = @Value WHERE (IdData = @IdData)" CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="IdData" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList3" Name="IdDirectory" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView1" Name="IdData" PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>

      
        Справочник:
        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource1" DataTextField="Directory" DataValueField="IdDirectory" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT [Directory], [IdDirectory] FROM [andrus_directories] ORDER BY [Directory]"></asp:SqlDataSource>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="IdData" DataSourceID="SqlDataSourceData" Width="861px">
            <Columns>
                <asp:BoundField DataField="IdData" HeaderText="ID значения" InsertVisible="False" ReadOnly="True" SortExpression="IdData" />
                <asp:TemplateField HeaderText="Справочник" SortExpression="IdDirectory">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceDirectories" DataTextField="Directory" DataValueField="IdDirectory" SelectedValue='<%# Bind("IdDirectory") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceDirectories" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT [IdDirectory], [Directory] FROM [andrus_directories] ORDER BY [Directory]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Directory") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Value" HeaderText="Значение" SortExpression="Value" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Правка" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="if(!confirm('Удалить?')) return false;" Text="Удалить" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <SortedAscendingCellStyle BackColor="#EDF6F6" />
            <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
            <SortedDescendingCellStyle BackColor="#D6DFDF" />
            <SortedDescendingHeaderStyle BackColor="#002876" />
        </asp:GridView>
        <br />
    
    </div>
    </form>
</body>
</html>
