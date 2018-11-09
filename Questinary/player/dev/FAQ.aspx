<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FAQ.aspx.cs" Inherits="player_FAQ" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="js/jquery.js"></script>
    <script src="js/main.js"></script>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
           <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                             
         <asp:DataList ID="DataList1" runat="server" CellPadding="4" 
                                                            DataSourceID="SqlDataSource1" ForeColor="#333333" Width="100%" 
                                                            DataKeyField="ID" onselectedindexchanged="DataList1_SelectedIndexChanged"   OnPreRender="DataList1_PreRender">
                                                        <AlternatingItemStyle BackColor="White" />
                                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <ItemStyle BackColor="White" />
                                                        <ItemTemplate>
                                
                                                            <asp:Label ID="IDLabel" Visible="False" runat="server" Text='<%# Eval("ID","{0}.") %>' />
                                                            <asp:LinkButton ID="QuestLinkButton" runat="server" Text='<%# Eval("Question") %>' 
                                                                ForeColor="Black" Font-Underline="False" CommandName="Select" ></asp:LinkButton>
                                                            <br/><br/>
                                                            <asp:Label ID="AnswerLabel" runat="server" Visible="false" Text='<%# Eval("Answer") %>' />
                                                        </ItemTemplate>
                                                        <SelectedItemStyle BackColor="#D1DDF1" ForeColor="#333333" BorderWidth="5" BorderColor="White" />
                                                        <SelectedItemTemplate>
                                                            <div style="margin: 5px;">
                                                            <asp:Label ID="IDLabel" Visible="False" runat="server" Text='<%# Eval("ID","{0}.") %>' />
                                                            <asp:Label ID="QuestLabel" runat="server" Text='<%# Eval("Question") %>' />
                                                            <br/>
                                                            <div style="margin: 15px;">
                                                            <asp:Label ID="AnswerLabel" runat="server" Text='<%# Eval("Answer") %>' Font-Size="14px" /></div>
                                                            </div>
                                                        </SelectedItemTemplate>
                                                    </asp:DataList>

                                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:QuestionaryConnectionString %>" 
                                
                                                                SelectCommand="SELECT ID, [Question], [Answer] FROM [crm_faq_QA] WHERE ([IdSection] = @IdSection) and IsDeleted = 0 ORDER BY ID ">
                                                            <SelectParameters>
                                                                <asp:QueryStringParameter Name="IdSection" QueryStringField="IdSection" Type="Int32" />
                                                            </SelectParameters>
                                                            </asp:SqlDataSource>
                                                         
                              </ContentTemplate>
                    </asp:UpdatePanel>
                 
    </div>
    </form>
</body>
</html>
