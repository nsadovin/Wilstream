<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OperatorByPeriod.aspx.cs" Inherits="OperatorByPeriod" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Операторы за период</title>
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script> 
</head>
<body>
    <form id="form1" runat="server">
     <div class="container-fluid">
                      <div class="row">
                          <div class="col-md-auto"> 
             <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default.aspx">К списку отчетов</asp:HyperLink> 
                                <h1>Операторы за период</h1>
                          </div>
                      </div>
                    <div class="row">
                        <div class="col-md-auto">    
<br/>
<table border="0">
        <tr>
            
            <td>


                


               <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                    BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                    ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px" 
                    >
                   <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                   <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                       VerticalAlign="Bottom" />
                   <OtherMonthDayStyle ForeColor="#999999" />
                   <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                   <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                       Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                   <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            <td>
                
               <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                    BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                    ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px" 
                    >
                   <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                   <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                       VerticalAlign="Bottom" />
                   <OtherMonthDayStyle ForeColor="#999999" />
                   <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                   <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                       Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                   <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>
            </td>
            
        </tr>
        
        <tr>
            <td colspan="2">
            
               Линия:                <asp:DropDownList ID="DropDownListLine"   AutoPostBack="true"  runat="server">
                    <asp:ListItem Value="0">Все линии</asp:ListItem>
                    <asp:ListItem Value="1">Первая</asp:ListItem>
                    <asp:ListItem Value="2">Вторая</asp:ListItem> 
                </asp:DropDownList> 
                
                Интервал:
                <asp:DropDownList ID="DropDownListInterval"  AutoPostBack="true"  runat="server">
                    <asp:ListItem Value="15">15 минут</asp:ListItem>
                    <asp:ListItem Value="30">30 минут</asp:ListItem>
                    <asp:ListItem Value="60">60 минут</asp:ListItem>
                    <asp:ListItem Value="1">День</asp:ListItem> 
                    <asp:ListItem Value="12">Месяц</asp:ListItem>
                </asp:DropDownList> 

            </td>
        </tr>
    </table>


    <br />

    <asp:Button ID="Button1" onclick="Button2_Click" runat="server" Font-Names="Arial" 
         Text="Экспорт в Excel" CssClass="blue unibutton" />      
    <br/>  <br />
  </div>
                      </div>

                               

                         <div class="row">
                          <div class="col-md"> 

    <asp:GridView ID="GridView1"  runat="server" CssClass="table table-sm  table-striped table-bordered"  
    AllowSorting="True" 
            DataSourceID="SqlDataSource1" PageSize="20" AllowPaging="True">
        <HeaderStyle CssClass="thead-light"
                />
    </asp:GridView>



<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:oktell_ccwsConnectionString %>" 
    
            
            SelectCommand="ivi_operators_by_period" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="report" Type="String" DefaultValue="report1" />
         
        <asp:ControlParameter ControlID="DropDownListInterval" Name="interval" 
                PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="DropDownListLine" Name="line" 
                PropertyName="SelectedValue" Type="Int32" />
        <asp:ControlParameter ControlID="Calendar1" Name="BeginDate" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="EndDate" 
                PropertyName="SelectedDate" Type="DateTime" /> 
    </SelectParameters>
</asp:SqlDataSource>
        
     </div>
                
    <br />
  
     </div>
              
    </div>
    </form>
 </body>
</html>

