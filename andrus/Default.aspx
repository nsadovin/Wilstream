<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

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

        <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="558px" AutoGenerateRows="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="IdCall" DataSourceID="SqlDataSourceCall" DefaultMode="Insert" OnItemInserted="DetailsView1_ItemInserted">
            <EditRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <Fields>
                <asp:TemplateField HeaderText="Действие оператора" SortExpression="Action">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Action") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceActions" DataTextField="Value" DataValueField="Value" SelectedValue='<%# Bind("Action") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceActions" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT 'Выбрать значение' as [Value], 1 ordering  UNION SELECT [Value], 2 ordering FROM [andrus_data] WHERE ([IdDirectory] = @IdDirectory) ORDER BY ordering , [Value]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="1" Name="IdDirectory" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Enabled="False" ControlToValidate="DropDownList1" Display="Dynamic" ErrorMessage="Поле обязательно к заполнению" InitialValue="Выбрать значение" ForeColor="Red"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Action") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Тема звонка" SortExpression="Thema">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Thema") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSourceThems" DataTextField="Value" DataValueField="Value" SelectedValue='<%# Bind("Thema") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceThems" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT 'Выбрать значение' as [Value], 1 ordering  UNION SELECT [Value], 2 ordering FROM [andrus_data] WHERE ([IdDirectory] = @IdDirectory) ORDER BY ordering , [Value]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="2" Name="IdDirectory" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Enabled="False" ControlToValidate="DropDownList2" Display="Dynamic" ErrorMessage="Поле обязательно к заполнению" InitialValue="Выбрать значение" ForeColor="Red"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Thema") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Товар, которым заинтересовался звонящий" SortExpression="Product">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Product") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSourceProducts" DataTextField="Value" DataValueField="Value" SelectedValue='<%# Bind("Product") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT 'Выбрать значение' as [Value], 1 ordering  UNION SELECT [Value], 2 ordering FROM [andrus_data] WHERE ([IdDirectory] = @IdDirectory) ORDER BY ordering , [Value]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="3" Name="IdDirectory" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Enabled="False" ControlToValidate="DropDownList3" Display="Dynamic" ErrorMessage="Поле обязательно к заполнению" InitialValue="Выбрать значение" ForeColor="Red"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Product") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Откуда Вы узнали о нас (из какого источника информации)?" SortExpression="Marketing">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Marketing") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDataSourceMarketings" DataTextField="Value" DataValueField="Value" SelectedValue='<%# Bind("Marketing") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceMarketings" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT 'Выбрать значение' as [Value], 1 ordering  UNION SELECT [Value], 2 ordering FROM [andrus_data] WHERE ([IdDirectory] = @IdDirectory) ORDER BY ordering , [Value]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="4" Name="IdDirectory" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"  Enabled="False" ControlToValidate="DropDownList4" Display="Dynamic" ErrorMessage="Поле обязательно к заполнению" InitialValue="Выбрать значение" ForeColor="Red"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Marketing") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Откуда вы звоните? (Область)" SortExpression="Oblast">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Oblast") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDataOblast" DataTextField="Value" DataValueField="Value" SelectedValue='<%# Bind("Oblast") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataOblast" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT 'Выбрать значение' as [Value], 1 ordering  UNION SELECT [Value], 2 ordering FROM [andrus_data] WHERE ([IdDirectory] = @IdDirectory) ORDER BY ordering , [Value]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="5" Name="IdDirectory" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Enabled="False" ControlToValidate="DropDownList5" Display="Dynamic" ErrorMessage="Поле обязательно к заполнению" InitialValue="Выбрать значение" ForeColor="Red"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("Oblast") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Комментарий" ShowHeader="False" SortExpression="Comment">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Comment") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        Комментарий<br />
                        <asp:TextBox ID="TextBox5" runat="server" Height="112px" Text='<%# Bind("Comment") %>' TextMode="MultiLine" Width="99%"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("Comment") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <InsertItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Сохранить" Font-Size="Larger" Height="51px" Width="176px" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="New" Text="Создать" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <RowStyle BackColor="White" ForeColor="#003399" />
        </asp:DetailsView>

        <asp:SqlDataSource ID="SqlDataSourceCall" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="SELECT * FROM [andrus_calls]" InsertCommand="INSERT INTO andrus_calls(agid, cgpn, cdpn, DTCall, Action, Thema, Product, Marketing,Oblast, Comment, DTCreated) VALUES (@agid, @cgpn, @cdpn, getDate(), @Action, @Thema, @Product , @Marketing, @Oblast, @Comment, GETDATE())">
            <InsertParameters>
                <asp:QueryStringParameter Name="agid" QueryStringField="agid" />
                <asp:QueryStringParameter Name="cgpn" QueryStringField="cgpn" />
                <asp:QueryStringParameter Name="cdpn" QueryStringField="cdpn" />
                <asp:Parameter Name="Action" />
                <asp:Parameter Name="Thema" />
                <asp:Parameter Name="Product" />
                <asp:Parameter Name="Marketing" />
                <asp:Parameter Name="Oblast" />
                <asp:Parameter Name="Comment" />
            </InsertParameters>
        </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
