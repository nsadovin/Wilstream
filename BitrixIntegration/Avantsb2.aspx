<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Avantsb2.aspx.cs" Inherits="Avantsb2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title></title>
  <link href="Content/bootstrap.min.css" rel="stylesheet" />
  <script src="Scripts/jquery-3.0.0.min.js"></script>
  <script src="Scripts/popper.min.js"></script>
  <script src="Scripts/bootstrap.min.js"></script>
  <script type="text/javascript">
    function DisableButton() {
      document.getElementById("<%=ButtonSaveLead.ClientID %>").disabled = true;
      document.getElementById("<%=ButtonSaveLead.ClientID %>").value = 'Сохранение...'
    }
    window.onbeforeunload = DisableButton;
    function checkTextAreaMaxLength(textBox, e, length) {

      var mLen = textBox["MaxLength"];
      if (null == mLen)
        mLen = length;
      var maxLength = parseInt(mLen);
      if (!checkSpecialKeys(e)) {
        if (textBox.value.length > maxLength - 1) {
          if (window.event)//IE
            e.returnValue = false;
          else//Firefox
            e.preventDefault();
        }
      }
    }
    function checkSpecialKeys(e) {
      if (e.keyCode != 8 && e.keyCode != 46 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
        return false;
      else
        return true;
    }
  </script>
</head>
<body>
  <div class="container-fluid">
    <form id="form1" runat="server">
      <div class="row">
        <asp:Panel ID="PanelLead" CssClass="col-auto" Visible="false" runat="server">
          <h2>Лид:
              <asp:Label ID="LabelNameLead" runat="server" Text="Новый"></asp:Label></h2>
          <asp:HiddenField ID="HiddenFieldIdLead" runat="server" />
          <asp:Table ID="TableLead" runat="server">
            <asp:TableHeaderRow Visible="false">
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
              <asp:TableCell>Фамилия</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxLeadLAST_NAME" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Lead" ControlToValidate="TextBoxLeadLAST_NAME" Enabled="false" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

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
              <asp:TableCell>Отчество</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxLeadSECOND_NAME" CssClass="form-control" runat="server"></asp:TextBox>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Город</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxLeadADDRESS_CITY" CssClass="form-control" runat="server"></asp:TextBox>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Статус</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListLeadSTATUS_ID" CssClass="form-control" runat="server"></asp:DropDownList>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Дополнительно о статусе</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxLeadSTATUS_DESCRIPTION" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Телефон</asp:TableCell>
              <asp:TableCell>
                <div class="row ml-0 mr-0">
                <asp:Table ID="TablePhones" CssClass="col-9" runat="server">
                </asp:Table>
                  <div class="col-3 text-right pr-0 pl-0">
                <asp:Button runat="server" CssClass="btn" OnClick="ButtonAddPhone_Click" ID="ButtonAddPhone" Text="Добавить" />
                </div>
                </div>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Email</asp:TableCell>
              <asp:TableCell>
                 <div class="row ml-0 mr-0">
                <asp:Table ID="TableEmails" CssClass="col-9" runat="server">
                </asp:Table>
                   <div class="col-3 text-right pr-0 pl-0">
                <asp:Button runat="server" CssClass="btn"  OnClick="ButtonAddEmail_Click" ID="ButtonAddEmail" Text="Добавить" />
                   </div>
                   </div>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Источник</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListLeadSOURCE_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Lead" ControlToValidate="DropDownListLeadSOURCE_ID" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Доступен для всех</asp:TableCell>
              <asp:TableCell>
                <asp:CheckBox ID="CheckBoxLeadOPENED" Enabled="false" CssClass="form-control" runat="server" />
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Ответственный</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListLeadASSIGNED_BY_ID" Enabled="false"  CssClass="form-control" runat="server"></asp:DropDownList>

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



        <asp:Panel ID="PanelContact" CssClass="col-auto" Visible="False" runat="server">
          
        <asp:Panel ID="PanelCompany" Visible="false" runat="server">
            <h2>Компания</h2>
            <asp:HiddenField ID="HiddenFieldIdCompany" runat="server" />
            <asp:Table ID="TableCompany" runat="server">
              <asp:TableHeaderRow Visible="false">
                <asp:TableCell>
                  Параметр
                </asp:TableCell>
                <asp:TableCell>
                  Значение
                </asp:TableCell>
              </asp:TableHeaderRow>
              <asp:TableRow CssClass="form-group">
                <asp:TableCell>Название компании</asp:TableCell>
                <asp:TableCell>
                  <asp:TextBox ID="TextBoxCompanyTITLE" CssClass="form-control" runat="server"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ValidationGroup="Company" ControlToValidate="TextBoxCompanyTITLE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                </asp:TableCell>
              </asp:TableRow>
              <asp:TableRow>
                <asp:TableCell>Телефон</asp:TableCell>
                <asp:TableCell>                
                  <div class="row ml-0 mr-0">
                    <asp:Table ID="TableCompanyPhones" CssClass="col-9" runat="server">
                    </asp:Table>                  
                    <div class="col-3 text-right pr-0 pl-0">
                      <asp:Button runat="server" CssClass="btn" OnClick="ButtonCompanyAddPhone_OnClick" ID="ButtonCompanyAddPhone" Text="Добавить" />
                    </div>
                  </div>
                </asp:TableCell>
              </asp:TableRow>
              <asp:TableRow>
                <asp:TableCell>Email</asp:TableCell>
                <asp:TableCell>  
                  <div class="row ml-0 mr-0">
                    <asp:Table ID="TableCompanyEmails" CssClass="col-9" runat="server">
                    </asp:Table>
                    <div class="col-3 text-right pr-0 pl-0">
                      <asp:Button runat="server" CssClass="btn" OnClick="ButtonCompanyAddEmail_OnClick" ID="ButtonCompanyAddEmail" Text="Добавить" />
                    </div>
                  </div>
                </asp:TableCell>
              </asp:TableRow>
            </asp:Table>

          <br/>
          <asp:Button ID="ButtonSaveCompany" CssClass="btn btn-primary" ValidationGroup="Company" runat="server" OnClick="ButtonSaveCompany_OnClick" Text="Создать компанию" />
          <br/>
          <br/>

          </asp:Panel>

          <asp:HiddenField ID="HiddenFieldIdContact" runat="server" />

          <h3>Контакт:
              <asp:Label ID="LabelNameContact" runat="server" Text="Новый"></asp:Label></h3>
          <asp:Table ID="TableContact" runat="server">
            <asp:TableHeaderRow Visible="false">
              <asp:TableCell>
                Параметр
              </asp:TableCell>
              <asp:TableCell>
                Значение
              </asp:TableCell>
            </asp:TableHeaderRow>
            <asp:TableRow CssClass="form-group">
              <asp:TableCell Width="150">Имя</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxCONTACT_NAME" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="Contact" ControlToValidate="TextBoxCONTACT_NAME" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="form-group">
              <asp:TableCell>Фамилия</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxCONTACT_LAST_NAME" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="Contact" ControlToValidate="TextBoxCONTACT_LAST_NAME" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="form-group">
              <asp:TableCell>Отчество</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxCONTACT_SECOND_NAME" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="Contact" ControlToValidate="TextBoxCONTACT_SECOND_NAME" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Телефон</asp:TableCell>
              <asp:TableCell>                
                <div class="row ml-0 mr-0">
                <asp:Table ID="TableContactPhones" CssClass="col-9" runat="server">
                </asp:Table>                  
                   <div class="col-3 text-right pr-0 pl-0">
                <asp:Button runat="server" CssClass="btn" OnClick="ButtonContactAddPhone_Click" ID="Button2" Text="Добавить" />
                  </div>
                  </div>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Email</asp:TableCell>
              <asp:TableCell>  
                <div class="row ml-0 mr-0">
                <asp:Table ID="TableContactEmails" CssClass="col-9" runat="server">
                </asp:Table>
                  <div class="col-3 text-right pr-0 pl-0">
                <asp:Button runat="server" CssClass="btn" OnClick="ButtonContactAddEmail_Click" ID="Button3" Text="Добавить" />
                  </div>
                  </div>
              </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow Visible="false">
              <asp:TableCell>Тип контакта</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListCONTACT_TYPE_ID" CssClass="form-control" runat="server"></asp:DropDownList>

              </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow Visible="false">
              <asp:TableCell>Ответственный</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListCONTACT_ASSIGNED_BY_ID" CssClass="form-control" runat="server"></asp:DropDownList>

              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Комментарий</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxCONTACT_COMMENTS" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
              </asp:TableCell>
            </asp:TableRow>

          </asp:Table>
          <br/>
          <asp:Button ID="ButtonSaveContact" CssClass="btn btn-primary" ValidationGroup="Lead" runat="server" OnClick="ButtonSaveContact_OnClick" Text="Создать контакт" />
          <br/>
          <br/>

        </asp:Panel>

        <asp:Panel ID="PanelSearchContact" CssClass="col-auto" runat="server">
          <h3>Клиент звонит с другого номера </h3>
          <div class="input-group mb-3">
            <asp:TextBox ID="TextBoxContactSearch" CssClass="form-control" placeholder="Номер телефона" aria-label="Номер телефона" aria-describedby="basic-addon2" runat="server"></asp:TextBox>

            <div class="input-group-append">
              <asp:Button ID="ButtonContactSearch" CssClass="input-group-text" runat="server" Text="ПОИСК" OnClick="ButtonContactSearch_Click" />
            </div>

          </div>

            <asp:Panel ID="PanelContactSearch" Visible="false" CssClass="col-auto" runat="server">

            <asp:GridView ID="GridViewContactSearch"    CssClass="table" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceContactSearch" 
                    OnSelectedIndexChanged="GridViewContactSearch_SelectedIndexChanged" DataKeyNames="Id" EmptyDataText="Контактов не найдено" ToolTip="Контакты">
                    <Columns>
                        <asp:TemplateField HeaderText="Контакт" SortExpression="Title">
                          <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                            <asp:Label ID="LabelPhones" runat="server" Text='<%# Eval("Phones","Тел.: {0}") %>'></asp:Label>
                          </EditItemTemplate>
                          <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Title") %>'></asp:Label><br/>
                            <asp:Label ID="LabelPhones" runat="server" Text='<%# Eval("Phones","Тел.: {0}") %>'></asp:Label>
                            <asp:Label ID="LabelEmails" runat="server" Visible='<%# Eval("Emails").ToString() !="" %>' Text='<%# Eval("Emails","Email: {0}") %>'></asp:Label>
                          </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="False" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="ButtonOpenClosedDeal" runat="server" class="btn btn-primary btn-sm" CausesValidation="False" CommandName="Select" Text="Перейти" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:LinqDataSource ID="LinqDataSourceContactSearch" runat="server" ContextTypeName="Sourcers" EntityTypeName="" OnSelecting="LinqDataSourceContactSearch_Selecting" OrderBy="Title" Select="new (Title, Id, Phones, Emails)" TableName="Contacts">
                </asp:LinqDataSource>

              </asp:Panel>


        </asp:Panel>

        <asp:Panel ID="PanelSMS" CssClass="col-auto" Visible="false" runat="server">
          <h3>Отправить СМС</h3>
          <asp:Table ID="Table1" runat="server">
            <asp:TableRow>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxSMS" TextMode="MultiLine" MaxLength="60" onkeyDown="checkTextAreaMaxLength(this,event,'60');" Width="300" runat="server"></asp:TextBox>
              </asp:TableCell>
            </asp:TableRow>
          </asp:Table>
          <asp:Button ID="ButtonSendSMS" CssClass="btn btn-primary" ValidationGroup="SMS" runat="server" OnClick="ButtonSendSMS_Click" Text="Отправить" />
        </asp:Panel>

        <asp:Panel ID="PanelLeadProducts" CssClass="col-auto" Visible="False" runat="server">
          <h3>Товары</h3>

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
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PRODUCT_PRICE") %>'></asp:TextBox>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Кол-во" SortExpression="PRODUCT_QUANTITY">

                <EditItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("PRODUCT_QUANTITY") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PRODUCT_QUANTITY") %>'></asp:TextBox>
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

              <asp:Button ID="ButtonProductSearch" CssClass="input-group-text" runat="server" Text="ПОИСК" OnClick="ButtonProductSearch_Click" />

            </div>
          </div>

          <asp:GridView ID="GridViewProductSearch" CssClass="table" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceProducts" OnRowCommand="GridViewProductSearch_RowCommand" OnSelectedIndexChanged="GridViewProductSearch_SelectedIndexChanged">
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
      

      <div class="row">

        <asp:Panel ID="PanelDeal" CssClass="col-auto" Visible="False" runat="server">

          <asp:HiddenField ID="HiddenFieldIdDeal" runat="server" />
          <h3>
            <asp:Label ID="LabelNameDealTitle" runat="server" Text="Сделка:"></asp:Label>            
            <asp:Label ID="LabelNameDeal" runat="server" Text="Новая"></asp:Label>            
          <asp:Button ID="ButtonCloseClosedDeal" CssClass="btn btn-primary" runat="server" OnClick="ButtonCloseClosedDeal_Click" Text="Закрыть" />
          <asp:Button ID="ButtonShowClosedDeal" CssClass="btn btn-primary" runat="server" OnClick="ButtonShowClosedDeal_Click" Text="Закрытые сделки" />
          </h3>
          <asp:Table ID="TableDeal" CssClass="" runat="server">
            <asp:TableHeaderRow Visible="false">
              <asp:TableCell>
                            Параметр
              </asp:TableCell>
              <asp:TableCell>
                            Значение
              </asp:TableCell>
            </asp:TableHeaderRow>
            <asp:TableRow>
              <asp:TableCell ToolTip="Стадия">Статус сделки</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList Enabled="false" ID="DropDownListDEAL_STAGE_ID" CssClass="form-control" runat="server"></asp:DropDownList>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="form-group">
              <asp:TableCell Width="150">Название сделки</asp:TableCell>
              <asp:TableCell Width="451">
                <asp:TextBox ID="TextBoxDEAL_TITLE" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="Deal" ControlToValidate="TextBoxDEAL_TITLE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Источник</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListDEAL_SOURCE_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Deal" ControlToValidate="DropDownListDEAL_SOURCE_ID" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Тип сделки</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListDEAL_TYPE_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ValidationGroup="Deal" ControlToValidate="DropDownListDEAL_SOURCE_ID" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>

              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Ответственный</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList Enabled="false" ID="DropDownListDEAL_ASSIGNED_BY_ID" CssClass="form-control" runat="server"></asp:DropDownList>
              </asp:TableCell>
            </asp:TableRow>
            
            <asp:TableRow Visible="false">
              <asp:TableCell>Сумма</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxDEAL_OPPORTUNITY" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="Deal" ControlToValidate="TextBoxDEAL_OPPORTUNITY" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Валюта</asp:TableCell>
              <asp:TableCell>
                <asp:DropDownList ID="DropDownListDEAL_CURRENCY_ID" CssClass="form-control" runat="server">
                  <asp:ListItem Value="RUB">Рубль</asp:ListItem>
                  <asp:ListItem Value="USD">Доллар США</asp:ListItem>
                </asp:DropDownList>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Контакт</asp:TableCell>
              <asp:TableCell>
                <asp:HiddenField ID="HiddenFieldDEAL_CONTACT_ID" runat="server" />
                <asp:TextBox ID="TextBoxDEAL_ContactInfoName" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:Label ID="LabelDEAL_ContactInfoPhone" runat="server" Text="Label"></asp:Label>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow Visible="false">
              <asp:TableCell>Дата начала</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxDEAL_BEGINDATE" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="Deal" ControlToValidate="TextBoxDEAL_BEGINDATE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
              <asp:TableCell>Комментарий</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxDEAL_COMMENTS" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
              </asp:TableCell>
            </asp:TableRow>
          </asp:Table>

          <asp:Button ID="ButtonSaveOrUpdateDeal" CssClass="btn btn-primary" ValidationGroup="Deal" runat="server" OnClick="ButtonSaveOrUpdateDeal_OnClick" Text="Создать сделку" />
          <br/>
          <br/>
        </asp:Panel>

        <asp:Panel ID="PanelClosedDeals" CssClass="col-auto" Visible="False" runat="server">
          <h3>Закрытые сделки</h3>
          <asp:GridView ID="GridViewClosedDeals"   CssClass="table" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceClosedDeals" 
                    OnSelectedIndexChanged="GridViewCompanySearch_SelectedIndexChanged" DataKeyNames="Id" Caption="" CaptionAlign="Top" EmptyDataText="Нет закрытых сделок" ToolTip="Закрытые сделки">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="ButtonOpenClosedDeal" runat="server" class="btn btn-primary btn-sm" CausesValidation="False" CommandName="Select" Text="Показать" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Title" HeaderText="Сделка" ReadOnly="True" SortExpression="Title" />
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="False" />
                    </Columns>
                </asp:GridView>
                <asp:LinqDataSource ID="LinqDataSourceClosedDeals" runat="server" ContextTypeName="Sourcers" EntityTypeName="" OnSelecting="LinqDataSourceCompamies_Selecting" OrderBy="Title" Select="new (Title, Id)" TableName="ClosedDeals">
                </asp:LinqDataSource>
        </asp:Panel>
      </div>
      
    </form>
  </div>
</body>
</html>
