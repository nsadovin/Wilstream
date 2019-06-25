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
                                <h1>Realtime</h1>
                          </div>
                      </div>
            <div class="row">
                        <div class="col-md-auto">    
                <br/>
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>

            <table border="1">
                <tr>
                    <td style="width: 60px; text-align:center;"><%=Operators.Count(r=>r.OperatorStatus!="usDisconnected") %></td>
                    <td>Общее количество операторов на линии</td>
                    <td> </td>
                    <td style="width: 60px; text-align:center; background-color: green;"><%=Operators.Count(r=>r.OperatorStatus=="usReady") %></td>
                    <td>Количество свободных операторов</td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
                <tr>
                    <td style="width: 60px; text-align:center; background-color: #00BFFF;"><%=Operators.Count(r=>r.OperatorStatus=="usFullbusy") %></td>
                    <td>Количество операторов в разговоре</td>
                    <td> </td>
                    <td style="width: 60px; text-align:center; background-color: yellow;"><%=Operators.Count(r=>r.OperatorStatus=="usLunch") %></td>
                    <td>Количество операторов в перерыве</td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
                <tr>
                    <td style="width: 60px; text-align:center; background-color: red;"><%=Queue.Count()+Operators.Count(r=>r.OperatorStatus=="usFullbusy") %></td>
                    <td>Общее количество звонков</td>
                    <td> </td>
                    <td style="width: 60px; text-align:center; background-color: green;"><%=Operators.Count(r=>r.OperatorStatus=="usFullbusy") %></td>
                    <td>Количество звонков в разговоре с оператором</td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
                <tr>
                    <td style="width: 60px; text-align:center; background-color: yellow;"><%=Queue.Count() %></td>
                    <td>Количество звонков в очереди</td>
                    <td> </td>
                    <td style="width: 60px; text-align:center; background-color: #00BFFF;"><%=CallInfoByOperator.Count(r=>r.taskid == Guid.Parse(TaskId)&&r.auserid == r.OperatorId) %></td>
                    <td>Количество активных исходящих звонков (перевод на ресторан)</td>
                </tr>
            </table>
            <br />
            <table border="1">
                <tr>
                    <th>Телефон</th>
                    <th>Статус</th>
                    <th>Время ожидания</th>
                    <th>Время в разговоре</th>
                    <th>Номер перевода</th>
                </tr> 
                            <%foreach (QueueCall oc in Queue)
                            {
                            %>
                                <tr>
                                    <td style="background-color:yellow;"><%=oc.callerid %></td> 
                                    <td style="background-color:yellow;">В очереди</td> 
                                    <td style="background-color:yellow;"><%=  TimeSpan.FromSeconds(Convert.ToInt32(oc.lenqueue)).ToString() %></td> 
                                    <td style="background-color:yellow;"></td> 
                                    <td style="background-color:yellow;"></td>  
                                </tr>
                            <%
                            }
                            %>
                      <%foreach (CallInfoOperator oc in CallInfoByOperator)
                          {
                              if (oc.taskid == Guid.Parse(TaskId))
                              {
                                  if (oc.auserid != oc.OperatorId)
                                  {
                                                %>
                                                    <tr>
                                                        <td style="background-color:green;"><%=oc.AON %></td> 
                                                        <td style="background-color:green;"><%=oc.auserid == oc.OperatorId ? "перевод" : "в разговоре" %></td> 
                                                        <td style="background-color:green;"></td> 
                                                        <td style="background-color:green;"><%= oc.auserid == oc.OperatorId ? TimeSpan.FromSeconds(Convert.ToInt32((DateTime.Now - oc.timestart).TotalSeconds)).ToString() : TimeSpan.FromSeconds(Convert.ToInt32(oc.TimeStatus)).ToString() %></td> 
                                                        <td style="background-color:green;"><%=oc.auserid == oc.OperatorId ? oc.boutnumber : "" %></td> 
                                                    </tr>
                                                <%
                                            }
                                            else
                                            {
                                                              %>
                                                    <tr>
                                                        <td style="background-color:#00BFFF;"><%=oc.AON %></td> 
                                                        <td style="background-color:#00BFFF;"><%=oc.auserid == oc.OperatorId ? "перевод" : "в разговоре" %></td> 
                                                        <td style="background-color:#00BFFF;"></td> 
                                                        <td style="background-color:#00BFFF;"><%= oc.auserid == oc.OperatorId ? TimeSpan.FromSeconds(Convert.ToInt32((DateTime.Now - oc.timestart).TotalSeconds)).ToString() : TimeSpan.FromSeconds(Convert.ToInt32(oc.TimeStatus)).ToString() %></td> 
                                                        <td style="background-color:#00BFFF;"><%=oc.auserid == oc.OperatorId ? oc.boutnumber : "" %></td> 
                                                    </tr>
                                                <%
                                                            }

                                                        }
                                                    }
                            %>
                
                      <%foreach (MissedCall oc in MissedCalls)
                        {
                             
                                                %>
                                                    <tr>
                                                        <td style="background-color:red;"><%=oc.AbonentNumber %></td> 
                                                        <td style="background-color:red;">пропущенный</td> 
                                                        <td style="background-color:red;"><%=TimeSpan.FromSeconds(Convert.ToInt32( oc.LenQueue)).ToString() %></td> 
                                                        <td style="background-color:red;"></td> 
                                                        <td style="background-color:red;"></td> 
                                                    </tr>
                                                <%
                           
                        }
                            %>
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
