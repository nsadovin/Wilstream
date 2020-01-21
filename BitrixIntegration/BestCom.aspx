<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BestCom.aspx.cs" Inherits="BestCom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
    <div class="container-fluid">
    <form id="form1" runat="server"> 
        <div class="row">
            <div class="col-sm"> 
            <asp:Panel ID="PanelLead" runat="server">
                <h2>Лид: <asp:Label ID="LabelNameLead" runat="server" Text="Новый"></asp:Label></h2>
                <asp:HiddenField ID="HiddenFieldIdLead" runat="server" />
                <asp:Table ID="TableLead" runat="server">
                    <asp:TableHeaderRow>
                        <asp:TableCell>
                            Параметр
                        </asp:TableCell>
                        <asp:TableCell>
                            Значение
                        </asp:TableCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow CssClass="form-group">
                        <asp:TableCell>Название лида</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxLeadTITLE" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Lead" ControlToValidate="TextBoxLeadTITLE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

                        </asp:TableCell> 
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Имя</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxLeadNAME" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="Lead" ControlToValidate="TextBoxLeadNAME" Enabled="false" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Фамилия</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxLeadLAST_NAME" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Lead" ControlToValidate="TextBoxLeadLAST_NAME" Enabled="false" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Отчество</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxLeadSECOND_NAME" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Город</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxLeadADDRESS_CITY" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Статус</asp:TableCell>
                        <asp:TableCell> 
                            <asp:DropDownList ID="DropDownListLeadSTATUS_ID" Enabled="false" CssClass="form-control" runat="server"></asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow> 
                    <asp:TableRow>
                        <asp:TableCell>Телефон</asp:TableCell>
                        <asp:TableCell>
                            <asp:Table ID="TablePhones" runat="server">

                            </asp:Table> 
                        </asp:TableCell>
                    </asp:TableRow> 
                    <asp:TableRow>
                        <asp:TableCell>Источник</asp:TableCell>
                        <asp:TableCell> 
                            <asp:DropDownList ID="DropDownListLeadSOURCE_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Lead" ControlToValidate="DropDownListLeadSOURCE_ID" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Доступен для всех</asp:TableCell>
                        <asp:TableCell> 
                            <asp:CheckBox ID="CheckBoxLeadOPENED" CssClass="form-control" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Ответственный</asp:TableCell>
                        <asp:TableCell> 
                             <asp:DropDownList ID="DropDownListLeadASSIGNED_BY_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                            
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Комментарий</asp:TableCell>
                        <asp:TableCell> 
                              <asp:TextBox ID="TextBoxLeadCOMMENTS" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    
                    
                </asp:Table>
                <asp:Button ID="ButtonSaveLead" CssClass="btn btn-primary" ValidationGroup="Lead" runat="server" OnClick="ButtonSaveLead_Click" Text="Создать лид" />
            </asp:Panel>
            </div>
            <div class="col-sm" style="display: none;">
                <h3>Товары</h3>
            <asp:Panel ID="PanelLeadProducts" runat="server">

                <asp:GridView CssClass="table" ID="GridViewLeadProducts" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceLeadProducts" OnSelectedIndexChanged="GridViewLeadProducts_SelectedIndexChanged" OnLoad="GridViewLeadProducts_Load" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button1" CssClass="btn btn-danger btn-sm" runat="server" CausesValidation="False" CommandName="Select" Text="Удалить" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NAME" HeaderText="Товар" ReadOnly="True" SortExpression="NAME" />
                        <asp:TemplateField HeaderText="Цена" SortExpression="PRODUCT_PRICE">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("PRODUCT_PRICE") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate> 
                                 <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ID") %>'></asp:HiddenField>
                                <asp:TextBox ID="TextBox1" runat="server"  Text='<%# Bind("PRODUCT_PRICE") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField  HeaderText="Кол-во" SortExpression="PRODUCT_QUANTITY">
                            
                            <EditItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("PRODUCT_QUANTITY") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate> 
                                <asp:TextBox ID="TextBox2" runat="server"  Text='<%# Bind("PRODUCT_QUANTITY") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" Visible="False" />
                    </Columns>
                </asp:GridView>
                <asp:LinqDataSource ID="LinqDataSourceLeadProducts" runat="server" ContextTypeName="Bitrix24" EntityTypeName="" OnSelecting="LinqDataSourceLeadProducts_Selecting" OrderBy="NAME" Select="new (NAME, ID,PRODUCT_PRICE,PRODUCT_QUANTITY)" TableName="ProductSeacrh" OnContextDisposing="LinqDataSourceLeadProducts_ContextDisposing" OnInit="LinqDataSourceLeadProducts_Init">
                </asp:LinqDataSource>
                 <div class="input-group mb-3">
                     <asp:TextBox ID="TextBoxProductSearch" CssClass="form-control" placeholder="Наименование товара" aria-label="Имя получателя" aria-describedby="basic-addon2" runat="server"></asp:TextBox>
                 
                  <div class="input-group-append">
                    
                        <asp:Button ID="ButtonProductSearch"  CssClass="input-group-text"   runat="server" Text="ПОИСК" OnClick="ButtonProductSearch_Click" />
                    
                  </div>
                </div>
                 
                <asp:GridView ID="GridViewProductSearch"  CssClass="table" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceProducts" OnRowCommand="GridViewProductSearch_RowCommand" OnSelectedIndexChanged="GridViewProductSearch_SelectedIndexChanged">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" class="btn btn-primary btn-sm" CausesValidation="False" CommandName="Select" Text="Добавить" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NAME" HeaderText="Товар" ReadOnly="True" SortExpression="NAME" />
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" Visible="False" />
                    </Columns>
                </asp:GridView>
                <asp:LinqDataSource ID="LinqDataSourceProducts" runat="server" ContextTypeName="Bitrix24" EntityTypeName="" OnSelecting="LinqDataSourceProducts_Selecting" OrderBy="NAME" Select="new (NAME, ID)" TableName="ProductSeacrh">
                </asp:LinqDataSource>
            </asp:Panel>
         
            </div>
        </div>
    </form>
   </div>
</body>
</html>
