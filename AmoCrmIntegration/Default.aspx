<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
        <div class="row" style="padding: 10px;"> 
                <asp:Label ID="LabelMsg" Visible="false" style="width: 100%;" runat="server" Text=""></asp:Label>
             
        </div>
        <div class="row">
        <asp:Panel ID="PanelInfo" Visible="false" runat="server">

        </asp:Panel>
            </div>

        <div class="row">
        <div class="col">
        <asp:Panel ID="PanelInfoLead"  Visible="false" runat="server">
            <asp:HiddenField ID="HiddenFieldLeadJson" runat="server" />
            <h1>Сделка (<asp:Label ID="LabelLeadId" runat="server" Text=""></asp:Label>)</h1> 
            <asp:Table ID="TableLead" CssClass="table-borderless" runat="server">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>Поле</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Значение</asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell>Ответственный:</asp:TableCell>
                    <asp:TableCell><asp:DropDownList ID="DropDownListResponsibleUsers" CssClass="form-control" runat="server"></asp:DropDownList></asp:TableCell>
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
             
            <asp:Button ID="ButtonUpdateLead" CssClass="btn btn-primary" OnClick="ButtonUpdateLead_Click" runat="server" Text="Сохранить изменения" />
             
        </asp:Panel>
        </div>
        <div class="col"> 
        <asp:Panel ID="PanelMainContact"  Visible="false" runat="server">
            <h1>Контакт</h1> 
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
                 </asp:Table>  
             </asp:Panel>
             <br/>
                <asp:Button ID="ButtonUpdateMainContact" CssClass="btn btn-primary" OnClick="ButtonUpdateMainContact_Click" runat="server" Text="Сохранить изменения" />
                <asp:Button ID="ButtonAddContact" CssClass="btn btn-outline-primary" OnClick="ButtonAddContact_Click" runat="server" Text="Добавить +" />
            
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
