<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Ekomebel.aspx.cs" Inherits="Ekomebel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" href="Content/jquery.datetimepicker.css" /> 
    <script src="Scripts/jquery.datetimepicker.js"></script>

    <script type = "text/javascript">
        $(document).ready(function () {
            jQuery('.datetimepicker').datetimepicker({
                i18n: {
                    en: {
                        months: [
                            'Январь', 'Февраль', 'Март', 'Апрель',
                            'Май', 'Июнь', 'Июль', 'Август',
                            'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь',
                        ],
                        dayOfWeek: [
                           "Вс", "Пн", "Вт", "Ср", "Чт",
                            "Пт", "Сб", 
                        ]
                    }
                },
                dayOfWeekStart: 1
               // timepicker: false,
               // format: 'd.m.Y'
            }); 
            jQuery.datetimepicker.setLocale('ru');
        });
function DisableButton() {
    document.getElementById("<%=ButtonSaveOrUpdateTask.ClientID %>").disabled = true;
    document.getElementById("<%=ButtonSaveOrUpdateTask.ClientID %>").value = 'Сохранение...'
}
        window.onbeforeunload = DisableButton;
        function checkTextAreaMaxLength(textBox,e, length)
{
            
        var mLen = textBox["MaxLength"];
        if(null==mLen)
            mLen=length; 
        var maxLength = parseInt(mLen);
        if(!checkSpecialKeys(e))
        {
         if(textBox.value.length > maxLength-1)
         {
            if(window.event)//IE
              e.returnValue = false;
            else//Firefox
                e.preventDefault();
         }
    }   
}
function checkSpecialKeys(e)
{
    if(e.keyCode !=8 && e.keyCode!=46 && e.keyCode!=37 && e.keyCode!=38 && e.keyCode!=39 && e.keyCode!=40)
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
            <asp:Panel ID="PanelLead" CssClass="col-sm"  runat="server">
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
                            <asp:DropDownList ID="DropDownListLeadSTATUS_ID"    CssClass="form-control" runat="server"></asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow> 
                    <asp:TableRow>
                        <asp:TableCell>Телефон</asp:TableCell>
                        <asp:TableCell>
                            <asp:Table ID="TablePhones" runat="server">

                            </asp:Table> 
                            <asp:Button runat="server" OnClick="ButtonAddPhone_Click" ID="ButtonAddPhone" Text="Добавить" />
                        </asp:TableCell>
                    </asp:TableRow> 
                    <asp:TableRow>
                        <asp:TableCell>Email</asp:TableCell>
                        <asp:TableCell>
                            <asp:Table ID="TableEmails" runat="server">

                            </asp:Table> 
                            <asp:Button runat="server" OnClick="ButtonAddEmail_Click" ID="ButtonAddEmail" Text="Добавить" />
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
                            <asp:CheckBox ID="CheckBoxLeadOPENED" Enabled="false" CssClass="form-control" runat="server" />
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
            
         
          <asp:Panel ID="PanelContact" CssClass="col-sm" Visible="False" runat="server"> 
            <asp:HiddenField ID="HiddenFieldIdContact" runat="server" />
            
            <h3>Контакт: <asp:Label ID="LabelNameContact" runat="server" Text="Новый"></asp:Label></h3> 
            <asp:Table ID="TableContact" runat="server">
            <asp:TableHeaderRow>
              <asp:TableCell>
                Параметр
              </asp:TableCell>
              <asp:TableCell>
                Значение
              </asp:TableCell>
            </asp:TableHeaderRow>
            <asp:TableRow CssClass="form-group">
              <asp:TableCell>Имя</asp:TableCell>
              <asp:TableCell>
                <asp:TextBox ID="TextBoxCONTACT_NAME"  CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="Contact" ControlToValidate="TextBoxCONTACT_NAME" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
              </asp:TableCell> 
            </asp:TableRow>
              <asp:TableRow CssClass="form-group">
                <asp:TableCell>Отчество</asp:TableCell>
                <asp:TableCell>
                  <asp:TextBox ID="TextBoxCONTACT_SECOND_NAME"  CssClass="form-control" runat="server"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="Contact" ControlToValidate="TextBoxCONTACT_SECOND_NAME" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                </asp:TableCell> 
              </asp:TableRow>
              <asp:TableRow CssClass="form-group">
                <asp:TableCell>Фамилия</asp:TableCell>
                <asp:TableCell>
                  <asp:TextBox ID="TextBoxCONTACT_LAST_NAME"  CssClass="form-control" runat="server"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="Contact" ControlToValidate="TextBoxCONTACT_LAST_NAME" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                </asp:TableCell> 
              </asp:TableRow>
              
              
              <asp:TableRow>
                <asp:TableCell>Телефон</asp:TableCell>
                <asp:TableCell>
                  <asp:Table ID="TableContactPhones" runat="server">
                  </asp:Table> 
                  <asp:Button runat="server" OnClick="ButtonContactAddPhone_Click" ID="Button2" Text="Добавить" />
                </asp:TableCell>
              </asp:TableRow>  
              <asp:TableRow>
                <asp:TableCell>Email</asp:TableCell>
                <asp:TableCell>
                  <asp:Table ID="TableContactEmails" runat="server">
                  </asp:Table> 
                  <asp:Button runat="server" OnClick="ButtonContactAddEmail_Click" ID="Button3" Text="Добавить" />
                </asp:TableCell>
              </asp:TableRow>
              
              <asp:TableRow>
                <asp:TableCell>Тип контакта</asp:TableCell>
                <asp:TableCell> 
                  <asp:DropDownList ID="DropDownListCONTACT_TYPE_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                            
                </asp:TableCell>
              </asp:TableRow>

              <asp:TableRow>
                <asp:TableCell>Ответственный</asp:TableCell>
                <asp:TableCell> 
                  <asp:DropDownList ID="DropDownListCONTACT_ASSIGNED_BY_ID" CssClass="form-control" runat="server"></asp:DropDownList>
                            
                </asp:TableCell>
              </asp:TableRow>
              <asp:TableRow>
                <asp:TableCell>Комментарий</asp:TableCell>
                <asp:TableCell> 
                  <asp:TextBox ID="TextBoxCONTACT_COMMENTS" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                </asp:TableCell>
              </asp:TableRow>
              
            </asp:Table>
              <asp:Button ID="ButtonSaveContact" CssClass="btn btn-primary" ValidationGroup="Lead" runat="server" OnClick="ButtonSaveContact_OnClick" Text="Создать контакт" />

          </asp:Panel>
 
            
        <div class="col-sm"  style="display: none;">
            <asp:Panel ID="PanelDeal" Visible="False" runat="server">
                
                <asp:HiddenField ID="HiddenFieldIdDeal" runat="server" />
            <h3><asp:Label ID="LabelNameDeal" runat="server" Text="Новая сделка"></asp:Label></h3> 
                <asp:Table ID="TableDeal" runat="server">
                    <asp:TableHeaderRow>
                        <asp:TableCell>
                            Параметр
                        </asp:TableCell>
                        <asp:TableCell>
                            Значение
                        </asp:TableCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow CssClass="form-group">
                        <asp:TableCell>Название сделки</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxDEAL_TITLE"  CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="Deal" ControlToValidate="TextBoxDEAL_TITLE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                        </asp:TableCell> 
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Ответственный</asp:TableCell>
                        <asp:TableCell> 
                            <asp:DropDownList ID="DropDownListDEAL_ASSIGNED_BY_ID" CssClass="form-control" runat="server"></asp:DropDownList> 
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Сумма</asp:TableCell>
                        <asp:TableCell> 
                            <asp:TextBox ID="TextBoxDEAL_OPPORTUNITY"  CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="Deal" ControlToValidate="TextBoxDEAL_OPPORTUNITY" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Валюта</asp:TableCell>
                        <asp:TableCell> 
                            <asp:DropDownList ID="DropDownListDEAL_CURRENCY_ID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="RUB">Рубль</asp:ListItem>
                                <asp:ListItem Value="USD">Доллар США</asp:ListItem>
                            </asp:DropDownList> 
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Контакт</asp:TableCell>
                        <asp:TableCell>
                            
                            <asp:HiddenField ID="HiddenFieldDEAL_CONTACT_ID" runat="server" />
                            <asp:TextBox ID="TextBoxDEAL_ContactInfoName"  CssClass="form-control" runat="server"></asp:TextBox> 
                            <asp:Label ID="LabelDEAL_ContactInfoPhone" runat="server" Text="Label"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Дата начала</asp:TableCell>
                        <asp:TableCell> 
                            <asp:TextBox ID="TextBoxDEAL_BEGINDATE"  CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="Deal" ControlToValidate="TextBoxDEAL_BEGINDATE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Комментарий</asp:TableCell>
                        <asp:TableCell> 
                            <asp:TextBox ID="TextBoxDEAL_COMMENTS" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow> 
                    <asp:TableRow>
                        <asp:TableCell>Стадия</asp:TableCell>
                        <asp:TableCell> 
                            <asp:DropDownList ID="DropDownListDEAL_STAGE_ID" CssClass="form-control" runat="server"></asp:DropDownList> 
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                
                <asp:Button ID="ButtonSaveOrUpdateDeal" CssClass="btn btn-primary" ValidationGroup="TASK"  runat="server" OnClick="ButtonSaveOrUpdateDeal_OnClick" Text="Отправить" />
            </asp:Panel>
        </div>
        
         
            
            
                <asp:Panel ID="PanelTask" CssClass="col-sm" Visible="False" runat="server">
                    <h3><asp:Label ID="LabelNameTask" runat="server" Text="Новая задача"></asp:Label></h3> 
                    <asp:Table ID="TableTask" runat="server">
                        <asp:TableHeaderRow>
                            <asp:TableCell>
                                Параметр
                            </asp:TableCell>
                            <asp:TableCell>
                                Значение
                            </asp:TableCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow CssClass="form-group">
                            <asp:TableCell>Название задачи</asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="TextBoxTASK_TITLE"  CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Task" ControlToValidate="TextBoxTASK_TITLE" runat="server" ForeColor="Red" ErrorMessage="Заполните поле" Display="Dynamic"></asp:RequiredFieldValidator>
                            </asp:TableCell> 
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Описание</asp:TableCell>
                            <asp:TableCell> 
                                  <asp:TextBox ID="TextBoxTASK_DESCRIPTION" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Ответственный</asp:TableCell>
                            <asp:TableCell> 
                                 <asp:DropDownList ID="DropDownListTASK_ASSIGNED_BY_ID" CssClass="form-control" runat="server"></asp:DropDownList> 
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Visible="False">
                            <asp:TableCell VerticalAlign="Top">Наблюдатели</asp:TableCell>
                            <asp:TableCell> 
                                <asp:Table ID="Table2" runat="server">
                                    <asp:TableRow>
                                        <asp:TableCell>1. </asp:TableCell>
                                        <asp:TableCell><asp:DropDownList ID="DropDownListTASK_AUDITOR_1" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. </asp:TableCell>
                                        <asp:TableCell><asp:DropDownList ID="DropDownListTASK_AUDITOR_2" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. </asp:TableCell>
                                        <asp:TableCell><asp:DropDownList ID="DropDownListTASK_AUDITOR_3" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. </asp:TableCell>
                                        <asp:TableCell><asp:DropDownList ID="DropDownListTASK_AUDITOR_4" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. </asp:TableCell>
                                        <asp:TableCell><asp:DropDownList ID="DropDownListTASK_AUDITOR_5" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>Крайний срок</asp:TableCell>
                            <asp:TableCell> 
                                 <asp:TextBox ID="TextBoxTASK_DEADLINE" TextMode="DateTime"  CssClass="form-control datetimepicker" runat="server"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow Visible="False">
                            <asp:TableCell  VerticalAlign="Top">CRM</asp:TableCell>
                            <asp:TableCell> 
                                <asp:Label ID="LabelTASK_UF_CRM_TASK" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="HiddenFieldTASK_UF_CRM_TASK" runat="server" />
                <asp:GridView ID="GridViewCompanySearch"  CssClass="table" runat="server" AllowPaging="False" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="LinqDataSourceCompanies" OnRowCommand="GridViewCompanySearch_RowCommand"
                    OnSelectedIndexChanged="GridViewCompanySearch_SelectedIndexChanged" DataKeyNames="ID">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="ButtonAddToTask" runat="server" class="btn btn-primary btn-sm" CausesValidation="False" CommandName="Select" Text="Прикрепить" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TITLE" HeaderText="Кампания" ReadOnly="True" SortExpression="TITLE" />
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" Visible="False" />
                    </Columns>
                </asp:GridView>
                <asp:LinqDataSource ID="LinqDataSourceCompanies" runat="server" ContextTypeName="Bitrix24" EntityTypeName="" OnSelecting="LinqDataSourceCompamies_Selecting" OrderBy="TITLE" Select="new (TITLE, ID)" TableName="CompanySeacrh">
                </asp:LinqDataSource>

                                <div class="input-group mb-3">
                                     <asp:TextBox ID="TextBoxNameCompany" CssClass="form-control" placeholder="Наименование компании" aria-label="Наименование компании" aria-describedby="basic-addon2" runat="server"></asp:TextBox>
                 
                                  <div class="input-group-append">
                    
                                        <asp:Button ID="ButtonSearchCompany"  CssClass="input-group-text"   runat="server" Text="ПОИСК" OnClick="ButtonSearchCompany_Click" />
                    
                                  </div>
                                </div>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table> 
                    <asp:Button ID="ButtonSaveOrUpdateTask" CssClass="btn btn-primary" ValidationGroup="TASK"  runat="server" OnClick="ButtonSaveOrUpdateTask_Click" Text="Отправить" />
                </asp:Panel>
            

            <div class="col-sm" style="display: none;"> 
                <asp:Panel ID="PanelSMS" runat="server">
                    <h3>Отправить СМС</h3> 
                    <asp:Table ID="Table1" runat="server">
                        <asp:TableRow>
                            <asp:TableCell><asp:TextBox ID="TextBoxSMS" TextMode="MultiLine" MaxLength="60" onkeyDown="checkTextAreaMaxLength(this,event,'60');"  Width="300" runat="server"></asp:TextBox></asp:TableCell>
                        </asp:TableRow> 
                    </asp:Table> 
                    <asp:Button ID="ButtonSendSMS" CssClass="btn btn-primary" ValidationGroup="SMS"  runat="server" OnClick="ButtonSendSMS_Click" Text="Отправить" />
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
