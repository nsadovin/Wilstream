<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderForm.aspx.cs" Inherits="Guru.OrderForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
    <link href="Content/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
     
    <script src="Scripts/jquery.datetimepicker.full.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.datetimepicker.setLocale('ru');
            $('.datetimepicker').datetimepicker({minDate:0,format:'Y-m-d H:i',});
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HiddenFieldId" runat="server" />
        <asp:HiddenField ID="HiddenFieldToken" runat="server" />
        <div class="container-fluid">
            
                <div class="row">
                    <div class="col-sm">Машина: 
                    <asp:Label ID="LabelBrand" runat="server" Text=""></asp:Label>
                    <asp:Label ID="LabelModel" runat="server" Text=""></asp:Label> 
                    </div>
                </div> 
                <div class="row">
                    <div class="col-sm">
                    Водитель: 
                    <asp:Label ID="LabelFirstName" runat="server" Text=""></asp:Label>
                    <asp:Label ID="LabelLastName" runat="server" Text=""></asp:Label> 
                    <asp:Label ID="LabelPhone" runat="server" Text=""></asp:Label> 
                    </div> 
                </div>
                <div class="row">
                    <div class="col-sm">
                    Лицензия водителя: 
                    <asp:Label ID="LabelCountry" runat="server" Text=""></asp:Label>
                    <asp:Label ID="LabelNumber" runat="server" Text=""></asp:Label> 
                    <asp:Label ID="LabelExperience" runat="server" Text=""></asp:Label> 
                    </div> 
                </div>
                <div class="row">
                    <div class="col-sm">
                    Кампания: 
                    <asp:Label ID="LabelCBrand" runat="server" Text=""></asp:Label>
                    </div> 
                </div>
                <div class="row">
                    <div class="col-sm">
                    Временные слоты для собеседования: 
                    <asp:Label ID="LabelInterviewSchedule" runat="server" Text=""></asp:Label> 
                    </div> 
                </div>
             <div class="row">
                    <div class="col-sm">
            <asp:Table ID="TableOrderForm" runat="server">
                <asp:TableRow>
                    <asp:TableCell>Дата и время собеседования</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBoxDateTime" CssClass="datetimepicker" runat="server"></asp:TextBox> 
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>Комментарий</asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="TextBoxComment" TextMode="MultiLine" Width="500" Height="100" runat="server"></asp:TextBox>  
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table></div></div>
                 <div class="row">
                    <div class="col-sm">
                        <asp:Button ID="ButtonSaveOrUpdateOrder" OnClick="ButtonSaveOrUpdateOrder_Click" runat="server" Text="Сохранить" />
                        <asp:Button ID="ButtonCancelOrder" OnClick="ButtonCancelOrder_Click" runat="server" Text="Отклонить заявку" />
                    </div> 
                </div>
                 
        </div>
    </form>
</body>
</html>
