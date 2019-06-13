<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Realtime.aspx.cs" Inherits="Realtime" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>В разрезе операторов он лайн</title>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script> 
</head>
<body>
    <form id="form1" runat="server">
        
           <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <div class="container-fluid">
                      <div class="row">
                          <div class="col-md-auto"> 
             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default.aspx">К списку отчетов</asp:HyperLink> 
                                <h1>В разрезе операторов онлайн</h1>
                          </div>
                      </div>
            <div class="row">
                        <div class="col-md-auto">    
                <br/>
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>

            <table>
                <tr>
                    <td><%=Operators.Count(r=>r.OperatorStatus!="usDisconnected") %></td>
                    <td>Общее количество операторов на линии</td>
                    <td> </td>
                    <td><%=Operators.Count(r=>r.OperatorStatus=="usReady") %></td>
                    <td>Количество свободных операторов</td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
                <tr>
                    <td><%=Operators.Count(r=>r.OperatorStatus=="usFullbusy") %></td>
                    <td>Количество операторов в разговоре</td>
                    <td> </td>
                    <td><%=Operators.Count(r=>r.OperatorStatus=="usLunch") %></td>
                    <td>Количество операторов в перерыве</td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
                <tr>
                    <td><%=Queue.Count() %></td>
                    <td>Количество звонков в очереди</td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                </tr>
            </table>
            <table border="1">
                <tr>
                    <th>В работе</th>
                    <th>Готов</th>
                    <th>Не готов</th>
                </tr>
                <tr>
                    <td valign="top">
                        <table> 
                            <%foreach (Operator op in Operators.Where(r=>r.OperatorStatus=="usFullbusy" ||  r.OperatorStatus=="usReserved"))
                            {
                            %>
                                <tr><td><%=op.Name %></td></tr>
                            <%
                            }
                            %>
                        </table>
                    </td> 
                    <td valign="top">
                        <table> 
                            <%foreach (Operator op in Operators.Where(r=>r.OperatorStatus=="usReady"))
                            {
                            %>
                                <tr><td><%=op.Name %></td></tr>
                            <%
                            }
                            %>
                        </table>
                    </td> 
                    <td valign="top">
                        <table> 
                            <%foreach (Operator op in Operators.Where(r=>r.OperatorStatus=="usLunch"))
                            {
                            %>
                                <tr><td><%=op.Name %></td></tr>
                            <%
                            }
                            %>
                        </table>
                    </td>
                </tr>
            </table>
                                     <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick"></asp:Timer>
                                </ContentTemplate> 
                        </asp:UpdatePanel>

                        </div>
            </div>
    </div>
    </form>
</body>
</html>
