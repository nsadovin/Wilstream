<%@ Page Language="C#" AutoEventWireup="true" CodeFile="obmen.aspx.cs" Inherits="obmen" %>

<!DOCTYPE html> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="scripts/jquery-3.0.0.min.js"></script>
  <script type="text/javascript" src="scripts/moment.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script> 
  <script type="text/javascript" src="scripts/bootstrap-datetimepicker.js"></script>
    <script src="Content/bootstrap-datepicker.ru.js"></script>
    <script type = "text/javascript">
function DisableButton() {
    document.getElementById("<%=ButtonUpdateLead.ClientID %>").disabled = true;
    document.getElementById("<%=ButtonUpdateLead.ClientID %>").value = 'Сохранение...'
}
window.onbeforeunload = DisableButton;
</script>
</head>
<body>
    <form id="form1" runat="server">
        
            <asp:HiddenField ID="HiddenFieldIdChain" runat="server" />
    <div class="container-fluid">
        <div class="row" style="padding: 10px; display: none;"> 
            <asp:TextBox ID="TextBoxWordSearch" Width="400" runat="server"></asp:TextBox> <asp:Button ID="ButtonSearch" OnClick="ButtonSearch_Click" runat="server" Text="ПОИСК" />
            <asp:Button ID="ButtonClear" OnClick="ButtonClear_Click" runat="server" Text="ОЧИСТИТЬ ПОИСК" />
            
           
            
            <asp:Label ID="LabelMsg" Visible="false" style="width: 100%;" runat="server" Text=""></asp:Label>
             
        </div>
        <div class="row">
        <asp:Panel ID="PanelInfo" Visible="false" runat="server">

        </asp:Panel>
            </div>
        
        <div class="row">
        <div class="col">
            <asp:Table ID="TableSearch" style="width: 100%;" CssClass="table-borderless" runat="server"> 
            </asp:Table> 
        </div>
        </div>
        <div class="row">
        <div class="col">
        <asp:Panel ID="PanelInfoLead"  Visible="false" runat="server">

            
            <asp:HiddenField ID="HiddenFieldLeadJson" runat="server" />
            <h1>Лид (<asp:Label ID="LabelLeadId" runat="server" Text=""></asp:Label>)</h1> 
            <asp:Table ID="TableLead" CssClass="table-borderless" runat="server">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>Поле</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Значение</asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell>Тег:</asp:TableCell>
                    <asp:TableCell><asp:TextBox ID="TextBoxTags" Width="400" Text="колл-центр" ReadOnly="true" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Ответственный:</asp:TableCell>
                    <asp:TableCell><asp:DropDownList ID="DropDownListResponsibleUsers"  CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Воронка:</asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="DropDownListPipeline" AutoPostBack="true" OnSelectedIndexChanged="DropDownListPipeline_SelectedIndexChanged" CssClass="form-control" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Статус:</asp:TableCell>
                    <asp:TableCell>
                        <asp:DropDownList ID="DropDownListStatuses" CssClass="form-control" runat="server"></asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Название:</asp:TableCell>
                    <asp:TableCell><asp:TextBox ID="TextBoxLeadName" Width="400" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Дата создания:</asp:TableCell>
                    <asp:TableCell><asp:TextBox ID="TextBoxDateCreate" ReadOnly="true" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
             
            <asp:Button ID="ButtonUpdateLead" CssClass="btn btn-primary" OnClick="ButtonUpdateAddLead_Click" runat="server" Text="Сохранить изменения" />
             
        </asp:Panel>
        </div>
        <div class="col"> 
        <asp:Panel ID="PanelMainContact"  Visible="false"   runat="server">
            <h1>Контакт</h1> 
            <asp:HiddenField ID="HiddenFieldMainContactId" runat="server" />
            <asp:Panel ID="PanelContacts"   runat="server">
                <asp:Table ID="TableMainContact" CssClass="table-borderless" runat="server">
                    <asp:TableHeaderRow>
                        <asp:TableHeaderCell>Поле</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Значение</asp:TableHeaderCell>
                    </asp:TableHeaderRow> 
                    <asp:TableRow>
                        <asp:TableCell>ФИО:</asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="TextBoxMainContactName" Width="400" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Кампания:</asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="TextBoxMainCampaignName" Width="400" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                 </asp:Table>  
             </asp:Panel>
             <br/>
                <asp:Button ID="ButtonUpdateMainContact" Visible="false"  CssClass="btn btn-primary" OnClick="ButtonUpdateMainContact_Click" runat="server" Text="Сохранить изменения" />
                <asp:Button ID="ButtonAddContact" Visible="false"  CssClass="btn btn-outline-primary" OnClick="ButtonAddContact_Click" runat="server" Text="Добавить +" />
            
        </asp:Panel>

        <asp:Panel ID="PanelNotes" Visible="false" runat="server">
            <h1>Примечания</h1> 
             
            <asp:Panel ID="PanelNote"    runat="server">
                <asp:Table ID="TableNotes" CssClass="table-borderless" runat="server">

                </asp:Table>
                 <asp:Table ID="TableNote" CssClass="table-borderless" runat="server">
                    <asp:TableHeaderRow>
                        <asp:TableHeaderCell>Поле</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Значение</asp:TableHeaderCell>
                    </asp:TableHeaderRow> 
                    <asp:TableRow>
                        <asp:TableCell>Текст:</asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="TextBoxTextNote" TextMode="MultiLine" Width="400" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>    
                  </asp:Table>
                  <br />
                  <asp:Button ID="ButtonAddNote" CssClass="btn btn-outline-primary" OnClick="ButtonAddNote_Click" runat="server" Text="Добавить примечание" />
            
            </asp:Panel>
        </asp:Panel>
            
        <asp:Panel ID="PanelTasks" Visible="false"   runat="server">
            <h1>Задача</h1> 
            
            <asp:Panel ID="PanelTask"    runat="server">
                 <asp:Table ID="TableTask" CssClass="table-borderless" runat="server">
                    <asp:TableHeaderRow>
                        <asp:TableHeaderCell>Поле</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Значение</asp:TableHeaderCell>
                    </asp:TableHeaderRow> 
                    <asp:TableRow>
                        <asp:TableCell>Задача:</asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="TextBoxText" TextMode="MultiLine" Width="400" CssClass="form-control" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Тип:</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="DropDownListTaskType" runat="server">
                                <asp:ListItem Value="1">Звонок</asp:ListItem>
                                <asp:ListItem Value="2">Встреча</asp:ListItem>
                                <asp:ListItem Value="3">Написать письмо</asp:ListItem>
                            </asp:DropDownList> 
                            </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Ответственный:</asp:TableCell>
                        <asp:TableCell><asp:DropDownList ID="DropDownListResponsibleUserId" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Дата, до которой необходимо завершить задачу:</asp:TableCell>
                        <asp:TableCell>
                            <div class='input-group date' id='datetimepicker1'> 
                                <asp:TextBox ID="TextBoxCompleteTillAt"  CssClass="form-control" runat="server"></asp:TextBox>
                                <span class="input-group-append input-group-addon">
                                    <span class="input-group-text fa fa-calendar">+</span>
                                </span>
                            </div>
                            <script type="text/javascript">
                                
                                $(function () {
                                    $('#datetimepicker1').datetimepicker({
                                        //locale: 'ru',
                                        format: 'YYYY-MM-DD hh:mm'
                                    });
                                });
                            </script>
                            
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Задача завершена или нет:</asp:TableCell>
                        <asp:TableCell>
                            <asp:CheckBox ID="CheckBoxIsCompleted" Checked="false" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                  </asp:Table>
                  <br />
                  <asp:Button ID="ButtonAddTask" CssClass="btn btn-outline-primary" OnClick="ButtonAddTask_Click" runat="server" Text="Создать задачу" />
            
            </asp:Panel>
        </asp:Panel>
        </div>
           </div> 
        <div class="row"  style="padding: 10px;">
            <div class="col"> 
                <asp:Panel ID="PanelPipeLine"  Visible="false" runat="server">
                    <h1>Воронки</h1>  
                    <asp:Panel ID="PanelPipeLineButtons"     runat="server">

                    </asp:Panel> 
                </asp:Panel>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
