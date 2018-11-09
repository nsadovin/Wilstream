<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Email.aspx.cs" Inherits="Email" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridViewEmail" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="SqlDataSourceEmail" ForeColor="#333333" GridLines="None" Width="100%" Font-Size="12px" OnRowCommand="GridViewEmail_RowCommand" OnSelectedIndexChanged="GridViewEmail_SelectedIndexChanged">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonCntAnser" runat="server" CausesValidation="False" CommandName="Select" Text='<%# Eval("CntAnswer","Ответы ({0})") %>' Enabled='<%# Convert.ToInt32(Eval("CntAnswer"))>0 %>' OnClick="LinkButtonCntAnser_Click" ></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Wrap="False" />
                </asp:TemplateField>
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="IdType" HeaderText="IdType" SortExpression="IdType" Visible="False" />
                <asp:BoundField DataField="ParentID" HeaderText="ParentID" SortExpression="ParentID" Visible="False" />
                <asp:BoundField DataField="To" HeaderText="Кому" SortExpression="To" />
                <asp:BoundField DataField="Copy" HeaderText="Копия" SortExpression="Copy" Visible="False" />
                <asp:BoundField DataField="From" HeaderText="От кого" SortExpression="From" />
                <asp:BoundField DataField="Subject" HeaderText="Тема" SortExpression="Subject" />
                <asp:TemplateField HeaderText="Сообщение" SortExpression="Body">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Body") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Body") %>'></asp:Label>
                        <asp:HiddenField ID="HiddenFieldId" runat="server" Value='<%# Eval("Id") %>' />
                        <asp:GridView ID="GridViewAnswer" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSourceAnswer" Font-Size="12px" ForeColor="#333333" GridLines="None" Visible="False">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="From" HeaderText="От кого" SortExpression="From" />
                                <asp:BoundField DataField="Subject" HeaderText="Тема" SortExpression="Subject" />
                                <asp:BoundField DataField="Body" HeaderText="Сообщение" SortExpression="Body" />
                                <asp:BoundField DataField="DTCreated" HeaderText="Дата" SortExpression="DTCreated" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceAnswer" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" SelectCommand="SELECT [From], [Subject], [Body], [DTCreated] FROM [cc_EmailHistory] WHERE ([ParentID] = @ParentID) ORDER BY [Id] DESC">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HiddenFieldId" Name="ParentID" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DTCreated" HeaderText="Дата" SortExpression="DTCreated" />
                <asp:BoundField DataField="MessageID" HeaderText="MessageID" SortExpression="MessageID" Visible="False" />
                <asp:BoundField DataField="MessageArrived" HeaderText="MessageArrived" SortExpression="MessageArrived" Visible="False" />
                <asp:BoundField DataField="IdTask" HeaderText="IdTask" SortExpression="IdTask" Visible="False" />
                <asp:BoundField DataField="IdProject" HeaderText="IdProject" SortExpression="IdProject" Visible="False" />
                <asp:BoundField DataField="IdPopupLoad" HeaderText="IdPopupLoad" SortExpression="IdPopupLoad" Visible="False" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceEmail" runat="server" ConnectionString="<%$ ConnectionStrings:INBOUNDConnectionString %>" SelectCommand="SELECT Id, IdType, ParentID, [To], Copy, [From], Subject, Body, DTCreated, MessageID, MessageArrived, IdTask, IdProject, IdPopupLoad, (SELECT count(*) FROM cc_EmailHistory WITH(NOLOCK) WHERE (IdTask = @IdTask) AND (ParentID = eh.Id)  ) as CntAnswer FROM cc_EmailHistory eh WITH(NOLOCK) WHERE (IdTask = @IdTask) AND (ParentID = @ParentID) ORDER BY Id DESC">
            <SelectParameters>
                <asp:QueryStringParameter Name="IdTask" QueryStringField="IdTask" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="ParentID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
