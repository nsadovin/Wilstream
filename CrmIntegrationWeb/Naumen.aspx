<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Naumen.aspx.cs" Inherits="Naumen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title> 
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" /> 
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>

</head>
<body>
    <div class="container-fluid">
        
    <form id="form1" runat="server" class="bd-example">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="row">
            <div class="col-sm">
                 <h1>Тануки ITSM</h1> 
                 <h2><asp:Label ID="LabelLead" runat="server" Text="Новая заявка"></asp:Label></h2> 
            </div>
        </div> 
        <div class="row">
            <div class="col-sm">
                <asp:HiddenField ID="HiddenFieldLeadUUID" runat="server" />
                <asp:RequiredFieldValidator ValidationGroup="SaveAndUpdateLead" ID="RequiredFieldValidatorTextBoxShortDescr" runat="server" ControlToValidate="TextBoxShortDescr"  ErrorMessage="Необходимо заполнить поле Тема" EnableClientScript="true" Display="Dynamic" SetFocusOnError="True"><div class="alert alert-danger"  role="alert" >Необходимо заполнить поле Тема</div></asp:RequiredFieldValidator>
                      
                <asp:RequiredFieldValidator ValidationGroup="SaveAndUpdateLead" ID="RequiredFieldValidator1" runat="server" ControlToValidate="DropDownListUrgency"  ErrorMessage="Необходимо заполнить поле Тема" EnableClientScript="true" Display="Dynamic"><div class="alert alert-danger"  role="alert" >Необходимо заполнить поле Срочность</div></asp:RequiredFieldValidator>
                     <asp:Panel ID="PanelError" Visible="false" runat="server">
                        <div class="alert alert-danger"  role="alert" >
                            <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                        </div> 
                    </asp:Panel> 
                      
                <asp:Table ID="TableLead"  style="width: 100%;" runat="server">
                    <asp:TableRow CssClass="form-group">
                        <asp:TableCell>Тема</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TextBoxShortDescr" CssClass="form-control" runat="server"></asp:TextBox>
                              </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="form-group">
                        <asp:TableCell>Описание</asp:TableCell>
                        <asp:TableCell><asp:TextBox ID="TextBoxDescriptionRTF" Height="200" CssClass="form-control" TextMode="MultiLine" runat="server"></asp:TextBox></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="form-group">
                        <asp:TableCell>Срочность</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="DropDownListUrgency"  CssClass="form-control" runat="server">
                                <asp:ListItem Value="">Не указано</asp:ListItem>
                                <asp:ListItem Value="urgency$37501">Высокая</asp:ListItem>
                                <asp:ListItem Value="urgency$37502">Средняя</asp:ListItem>
                                <asp:ListItem Value="urgency$37503">Низкая</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                    <asp:Button ID="ButtonSaveLead" CausesValidation="true"  CssClass="btn btn-primary saver" ValidationGroup="SaveAndUpdateLead" runat="server" OnClick="ButtonSaveLead_Click"  Text="Сохранить" />
        </div>
        </div>
        <script>
            $(document).ready(function () {

                $('.saver').click(function () {
                    if ($('.saver').data("stop") == "1") return false;
                    else {
                        $('.saver').data("stop", "1");
                        return true;
                    }
                    setTimeout('$(".saver").data("stop", "");',2000);
                });
            });
        </script>
    </form>
    </div>
</body>
</html>
