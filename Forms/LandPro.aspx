<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="LandPro.aspx.cs" Inherits="LandPro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="Scripts/jquery-ui.js"></script>
    
    <title></title>
    <script>
        var url = "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address";
        var token = "6e970c6ac0f96e9a33da308da7196c4619bfaf6a";

        $(document).ready(function () {
            SearchText();
        });

        function SearchText() {
            $(".address").autocomplete({
                    source: function(request, handresponse) {
                        var query = request.term;  
                        var options = {
                            method: "POST",
                            mode: "cors",
                            headers: {
                                "Content-Type": "application/json",
                                "Accept": "application/json",
                                "Authorization": "Token " + token
                            },
                            body: JSON.stringify({ query: query })
                        }

                        fetch(url, options)
                            .then(response => { return response.text(); })
                            .then(result => { 
                                var obj = JSON.parse(result);
                                handresponse(obj.suggestions.map(function(v) {
                                    return { label: v.unrestricted_value, value: v.unrestricted_value,  data: v.data };
                                }
                                ));
                               //console.log(result);
                            })
                            .catch(error => console.log("error", error));
                }
                , select: function (event, ui) {
                    var block = $(this).parents(".address_place");
                    block.find(".postal_code").val(ui.item.data.postal_code);
                    block.find(".region").val(ui.item.data.region_with_type);
                    var settlement = "";
                    if (ui.item.data.city_with_type != null)
                        settlement = ui.item.data.city_with_type;

                    if (ui.item.data.area_with_type != null) {
                        if (settlement != "")
                            settlement += ", " + ui.item.data.area_with_type;
                        else
                            settlement = ui.item.data.area_with_type;
                    };

                    
                    if (ui.item.data.settlement_with_type != null) {
                        if (settlement != "")
                            settlement += ", " + ui.item.data.settlement_with_type;
                        else
                            settlement = ui.item.data.settlement_with_type;
                    };
                    block.find(".settlement").val(settlement);
                    block.find(".street").val(ui.item.data.street_with_type);
                    block.find(".house").val(ui.item.data.house); 
                    return true;
                }
                }
            );
        }  
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="order_id" DataSourceID="SqlDataSourceOktell_ccws" ForeColor="#333333" GridLines="None" Height="50px" Width="100%" >
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                <EditRowStyle BackColor="#999999" />
                <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                <Fields>
                    <asp:BoundField DataField="order_id" HeaderText="order_id" InsertVisible="False" ReadOnly="True" SortExpression="order_id" Visible="False" />
                    <asp:BoundField DataField="id" HeaderText="id заказа" SortExpression="id" />
                    <asp:BoundField DataField="userName" HeaderText="Имя пользователя" SortExpression="userName" />
                    <asp:BoundField DataField="phone" HeaderText="Телефон" SortExpression="phone" />
                    <asp:BoundField DataField="totalSum" HeaderText="Сумма заказа" SortExpression="totalSum" />
                    <asp:TemplateField HeaderText="Поставки">
                        <ItemTemplate>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="supply_id" DataSourceID="SqlDataSourceSyplies" Width="100%" OnRowUpdated="GridView1_RowUpdated" OnRowUpdating="GridView1_RowUpdating">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="supply_id" HeaderText="supply_id" InsertVisible="False" ReadOnly="True" SortExpression="supply_id" Visible="False" />
                                    <asp:TemplateField HeaderText="Итоговый набор товаров">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("supply_id") %>' />
                                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" W
                                                DataKeyNames="product_id" DataSourceID="SqlDataSourceProductsEdits">
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
                                                ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" 
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
                                            <asp:GridView ID="GridView2" runat="server" DataKeyNames="product_id"  AutoGenerateColumns="False" DataSourceID="SqlDataSourceProducts">
                                                <Columns>
                                                    <asp:BoundField DataField="product_id" HeaderText="product_id" InsertVisible="False" ReadOnly="True" SortExpression="product_id" Visible="False" />
                                                    <asp:BoundField DataField="productName" HeaderText="Имя товара" SortExpression="productName" />
                                                    <asp:TemplateField HeaderText="Колличество в поставке" SortExpression="quantity">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("quantity") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("quantity") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" 
                                                               SelectCommand="SELECT [productName], [quantity],[product_id] FROM [LandproProducts] WHERE ([LandproSupply_supply_id] = @LandproSupply_supply_id)"
                                                               UpdateCommand="UPDATE [LandproProducts] SET [quantity] = @quantity WHERE [product_id] = @product_id">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="HiddenField1" Name="LandproSupply_supply_id" PropertyName="Value" Type="Int32" />
                                                </SelectParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="id" Type="Int32" />
                                                    <asp:Parameter Name="productName" Type="String" />
                                                    <asp:Parameter Name="quantity" Type="Int32" />
                                                    <asp:Parameter Name="LandproSupply_supply_id" Type="Int32" />
                                                    <asp:Parameter Name="product_id" Type="Int32" />
                                                </UpdateParameters>
                                            </asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="id" HeaderText="id поставки" ReadOnly="True" SortExpression="id" />  
                                    <asp:TemplateField HeaderText="Статус поставки" SortExpression="status">
                                        <EditItemTemplate> 
                                            <asp:DropDownList ID="DropDownListStatus" runat="server"   SelectedValue='<%# Bind("status") %>'>
                                                <asp:ListItem></asp:ListItem>
                                                <asp:ListItem Value="wait">wait</asp:ListItem>
                                                <asp:ListItem Value="success">success</asp:ListItem>
                                                <asp:ListItem Value="decline">decline</asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownListStatus" runat="server"   SelectedValue='<%# Bind("status") %>'>
                                                <asp:ListItem></asp:ListItem>
                                                <asp:ListItem Value="wait">wait</asp:ListItem>
                                                <asp:ListItem Value="success">success</asp:ListItem>
                                                <asp:ListItem Value="decline">decline</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Выбранный тип доставки" SortExpression="deliveryType">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HiddenFieldTypes" runat="server" Value='<%# Eval("deliveryTypes") %>' />
                                            <asp:DropDownList ID="DropDownList1" runat="server" OnDataBinding="DropDownList1_DataBinding" OnPreRender="DropDownList1_PreRender" SelectedValue='<%# Bind("deliveryType") %>'>
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:HiddenField ID="HiddenFieldTypes" runat="server" Value='<%# Eval("deliveryTypes") %>' />
                                            <asp:DropDownList ID="DropDownList1" runat="server" OnDataBinding="DropDownList1_DataBinding" OnPreRender="DropDownList1_PreRender" SelectedValue='<%# Bind("deliveryType") %>'>
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Адрес" SortExpression="postalCode" >
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("postalCode") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <div class="address_place container">
                                                <div class="row"><div class="col-sm-4">Индекс:</div> <div class="col-sm-8"><asp:TextBox ID="TextBox6" Width="100%" CssClass="postal_code" runat="server" Text='<%# Bind("postalCode") %>'></asp:TextBox></div></div>
                                                <div class="row"><div class="col-sm-4">Область: </div> <div class="col-sm-8"><asp:TextBox ID="TextBox5" CssClass="region" Width="100%" runat="server" Text='<%# Bind("administrativeArea") %>'></asp:TextBox></div></div>
                                                <div class="row"><div class="col-sm-4">Населенный пункт: </div> <div class="col-sm-8"><asp:TextBox ID="TextBox4" Width="100%" CssClass="settlement"  runat="server" Text='<%# Bind("settlement") %>'></asp:TextBox></div></div>
                                                <div class="row"><div class="col-sm-4">Улица: </div> <div class="col-sm-8"><asp:TextBox ID="TextBox3" CssClass="street"  Width="100%" runat="server" Text='<%# Bind("street") %>'></asp:TextBox></div></div>
                                                <div class="row"><div class="col-sm-4">Номер дома: </div> <div class="col-sm-8"><asp:TextBox ID="TextBox2" CssClass="house" Width="100%"  runat="server" Text='<%# Bind("house") %>'></asp:TextBox></div></div>
                                                <div class="row"><div class="col-sm-4">Поиск: </div> <div class="col-sm-8"><asp:TextBox ID="TextBoxSearchAddress" Width="100%"  CssClass="address" runat="server"></asp:TextBox></div></div>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle Width="600px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Комментарий" SortExpression="comment">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("comment") %>' TextMode="MultiLine"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("comment") %>' TextMode="MultiLine"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="deliveryTypes" HeaderText="deliveryTypes" SortExpression="deliveryTypes" Visible="False" />
                                    <asp:BoundField DataField="LandproOrder_order_id" HeaderText="LandproOrder_order_id" SortExpression="LandproOrder_order_id" Visible="False" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceSyplies" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" 
                                DeleteCommand="DELETE FROM [LandproSupplies] WHERE [supply_id] = @supply_id"
                                InsertCommand="INSERT INTO [LandproSupplies] ([id], [status], [postalCode], [administrativeArea], [settlement], [street], [house], [deliveryTypes], [LandproOrder_order_id]) VALUES (@id, @status, @postalCode, @administrativeArea, @settlement, @street, @house, @deliveryTypes, @LandproOrder_order_id)" 
                                SelectCommand="SELECT * FROM [LandproSupplies] WHERE ([LandproOrder_order_id] = @LandproOrder_order_id)"
                                UpdateCommand="UPDATE [LandproSupplies] SET [status] = @status, [postalCode] = @postalCode, [administrativeArea] = @administrativeArea, [settlement] = @settlement, [street] = @street, [house] = @house,[deliveryType] = @deliveryType, comment = @comment WHERE [supply_id] = @supply_id">
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
                                    <asp:Parameter Name="comment" Type="String" />
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
                                    <asp:Parameter Name="comment" Type="String" />
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
            <asp:SqlDataSource ID="SqlDataSourceOktell_ccws" runat="server" ConnectionString="<%$ ConnectionStrings:oktellConnectionString %>" SelectCommand="SELECT * FROM [LandproOrders] WHERE ([order_id] = @order_id)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="order_id" QueryStringField="order_id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
