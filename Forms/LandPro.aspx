<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="LandPro.aspx.cs" Inherits="LandPro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="order_id" DataSourceID="SqlDataSourceOktell_ccws" ForeColor="#333333" GridLines="None" Height="50px" Width="578px">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="order_id" HeaderText="order_id" InsertVisible="False" ReadOnly="True" SortExpression="order_id" Visible="False" />
                    <asp:BoundField DataField="id" HeaderText="id заказа" SortExpression="id" />
                    <asp:BoundField DataField="userName" HeaderText="Имя пользователя" SortExpression="userName" />
                    <asp:BoundField DataField="phone" HeaderText="телефон" SortExpression="phone" />
                    <asp:TemplateField HeaderText="Поставки">
                        <ItemTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="supply_id" DataSourceID="SqlDataSourceSyplies" Width="1092px" OnRowUpdated="GridView1_RowUpdated">
                                <Columns>
                                    <asp:CommandField ShowEditButton="True" />
                                    <asp:BoundField DataField="supply_id" HeaderText="supply_id" InsertVisible="False" ReadOnly="True" SortExpression="supply_id" Visible="False" />
                                    <asp:TemplateField HeaderText="Итоговый набор товаров">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("supply_id") %>' />
                                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="product_id" DataSourceID="SqlDataSourceProductsEdits">
                                                <Columns>
                                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                                    <asp:BoundField DataField="product_id" HeaderText="product_id" InsertVisible="False" ReadOnly="True" SortExpression="product_id" Visible="False" />
                                                    <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" Visible="False" />
                                                    <asp:BoundField DataField="productName" HeaderText="Имя товара" ReadOnly="True" SortExpression="productName" />
                                                    <asp:BoundField DataField="quantity" HeaderText="Колличество в поставке" SortExpression="quantity" />
                                                    <asp:BoundField DataField="LandproSupply_supply_id" HeaderText="LandproSupply_supply_id" SortExpression="LandproSupply_supply_id" Visible="False" />
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSourceProductsEdits" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
                                                DeleteCommand="DELETE FROM [LandproProducts] WHERE [product_id] = @product_id"
                                                InsertCommand="INSERT INTO [LandproProducts] ([id], [productName], [quantity], [LandproSupply_supply_id]) VALUES (@id, @productName, @quantity, @LandproSupply_supply_id)" SelectCommand="SELECT * FROM [LandproProducts] WHERE ([LandproSupply_supply_id] = @LandproSupply_supply_id)" 
                                                UpdateCommand="UPDATE [LandproProducts] SET [quantity] = @quantity WHERE [product_id] = @product_id">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="product_id" Type="Int32" />
                                                </DeleteParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="id" Type="Int32" />
                                                    <asp:Parameter Name="productName" Type="String" />
                                                    <asp:Parameter Name="quantity" Type="Int32" />
                                                    <asp:Parameter Name="LandproSupply_supply_id" Type="Int32" />
                                                </InsertParameters>
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="HiddenField2" Name="LandproSupply_supply_id" PropertyName="Value" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="id" Type="Int32" />
                                                    <asp:Parameter Name="productName" Type="String" />
                                                    <asp:Parameter Name="quantity" Type="Int32" />
                                                    <asp:Parameter Name="LandproSupply_supply_id" Type="Int32" />
                                                    <asp:Parameter Name="product_id" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("supply_id") %>' />
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceProducts">
                                                <Columns>
                                                    <asp:BoundField DataField="productName" HeaderText="Имя товара" SortExpression="productName" />
                                                    <asp:BoundField DataField="quantity" HeaderText="Колличество в поставке" SortExpression="quantity" />
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT [productName], [quantity] FROM [LandproProducts] WHERE ([LandproSupply_supply_id] = @LandproSupply_supply_id)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="HiddenField1" Name="LandproSupply_supply_id" PropertyName="Value" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="id" HeaderText="id поставки" ReadOnly="True" SortExpression="id" />
                                    <asp:BoundField DataField="status" HeaderText="Статус поставки" SortExpression="status" />
                                    <asp:TemplateField HeaderText="Выбранный тип доставки" SortExpression="deliveryType">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HiddenFieldTypes" runat="server" Value='<%# Eval("deliveryTypes") %>' />
                                            <asp:DropDownList ID="DropDownList1" runat="server" OnDataBinding="DropDownList1_DataBinding" OnPreRender="DropDownList1_PreRender" SelectedValue='<%# Bind("deliveryType") %>'>
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("deliveryType") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="postalCode" HeaderText="Почтовый индекс" SortExpression="postalCode" />
                                    <asp:BoundField DataField="administrativeArea" HeaderText="Область" SortExpression="administrativeArea" />
                                    <asp:BoundField DataField="settlement" HeaderText="Населенный пункт" SortExpression="settlement" />
                                    <asp:BoundField DataField="street" HeaderText="Улица" SortExpression="street" />
                                    <asp:BoundField DataField="house" HeaderText="Номер дома" SortExpression="house" />
                                    <asp:BoundField DataField="deliveryTypes" HeaderText="deliveryTypes" SortExpression="deliveryTypes" Visible="False" />
                                    <asp:BoundField DataField="LandproOrder_order_id" HeaderText="LandproOrder_order_id" SortExpression="LandproOrder_order_id" Visible="False" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceSyplies" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
                                DeleteCommand="DELETE FROM [LandproSupplies] WHERE [supply_id] = @supply_id"
                                InsertCommand="INSERT INTO [LandproSupplies] ([id], [status], [postalCode], [administrativeArea], [settlement], [street], [house], [deliveryTypes], [LandproOrder_order_id]) VALUES (@id, @status, @postalCode, @administrativeArea, @settlement, @street, @house, @deliveryTypes, @LandproOrder_order_id)" 
                                SelectCommand="SELECT * FROM [LandproSupplies] WHERE ([LandproOrder_order_id] = @LandproOrder_order_id)"
                                UpdateCommand="UPDATE [LandproSupplies] SET [status] = @status, [postalCode] = @postalCode, [administrativeArea] = @administrativeArea, [settlement] = @settlement, [street] = @street, [house] = @house,[deliveryType] = @deliveryType WHERE [supply_id] = @supply_id">
                                <DeleteParameters>
                                    <asp:Parameter Name="supply_id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="id" Type="Int32" />
                                    <asp:Parameter Name="status" Type="String" />
                                    <asp:Parameter Name="postalCode" Type="String" />
                                    <asp:Parameter Name="administrativeArea" Type="String" />
                                    <asp:Parameter Name="settlement" Type="String" />
                                    <asp:Parameter Name="street" Type="String" />
                                    <asp:Parameter Name="house" Type="String" />
                                    <asp:Parameter Name="deliveryTypes" Type="String" />
                                    <asp:Parameter Name="LandproOrder_order_id" Type="Int32" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="LandproOrder_order_id" QueryStringField="order_id" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="id" Type="Int32" />
                                    <asp:Parameter Name="status" Type="String" />
                                    <asp:Parameter Name="postalCode" Type="String" />
                                    <asp:Parameter Name="administrativeArea" Type="String" />
                                    <asp:Parameter Name="settlement" Type="String" />
                                    <asp:Parameter Name="street" Type="String" />
                                    <asp:Parameter Name="house" Type="String" />
                                    <asp:Parameter Name="deliveryTypes" Type="String" />
                                    <asp:Parameter Name="LandproOrder_order_id" Type="Int32" />
                                    <asp:Parameter Name="supply_id" Type="Int32" />
                                    <asp:Parameter Name="deliveryType" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceOktell_ccws" runat="server" ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" SelectCommand="SELECT * FROM [LandproOrders] WHERE ([order_id] = @order_id)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="order_id" QueryStringField="order_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
