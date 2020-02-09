<%@ Page Language="C#"  EnableSessionState="True"  AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <meta charset="utf-8" />
    <!--[if IE]><script src="js/html5.js"></script><![endif]-->
    <link href="css/style.css" rel="stylesheet" type="text/css" />
	<!--[if lte IE 6]><link rel="stylesheet" href="css/style_ie.css" type="text/css" media="screen, projection" /><![endif]-->
      <script>
          function getClass(node, cls) {
              var list = node.getElementsByTagName('*');
              var classArray = cls.split(/\s+/);
              var result = [];

              for (var i = 0; i < list.length; i++) {
                  for (var j = 0; j < classArray.length; j++) {
                      var reg = new RegExp("\\b" + classArray[j] + "\\b");
                      if (reg.test(list[i].className)) {
                          result.push(list[i]);
                          break;
                      }
                  }
              }

              return result
          }
          var aSave = new Array();

          function randomTable() {
              table = document.getElementById("sorttable");



              var a = new Array();

              if (table) {

                  for (i = 1; i < table.rows.length; i++) {
                      a[i - 1] = new Array();
                      a[i - 1][0] = Math.random();
                      a[i - 1][1] = table.rows[i];
                  }

                  a.sort();
                  a.reverse();

                  for (i = 0; i < a.length; i++)
                      table.appendChild(a[i][1]);
              }

              table = getClass(document.getElementById('form1'), 'sorttable2')[0];




              a = new Array();


              if (table) {
                  id = table.getAttribute("id");
                  if (table.hasAttribute("title")) {

                      var a2 = new Array();
                      var a3 = new Array();
                      var a4 = table.getAttribute("title").split("_");
                      for (i = 0; i < a4[0] * 1; i++) {
                          a2[i] = new Array();
                          a2[i][0] = Math.random();
                          a2[i][1] = table.rows[i];
                      }
                      var b = new Array();
                      for (i = a4[0] * 1; i < a4[1] * 1; i++) {
                          a[i - a4[0] * 1] = new Array();
                          a[i - a4[0] * 1][0] = Math.random();
                          a[i - a4[0] * 1][1] = table.rows[i];
                          b[i - a4[0] * 1] = a[i - a4[0] * 1][0] * 1;
                      }

                      if (aSave[id]) {
                          for (i = 0; i < aSave[id].length; i++) {
                              a[i][0] = aSave[id][i];
                          }
                      } else
                          aSave[id] = b;

                      a.sort();
                      a.reverse();

                      for (i = a4[1] * 1; i < table.rows.length; i++) {
                          a3[i - a4[1] * 1] = new Array();
                          a3[i - a4[1] * 1][0] = Math.random();
                          a3[i - a4[1] * 1][1] = table.rows[i];
                      }


                      for (i = 0; i < a2.length; i++)
                          table.appendChild(a2[i][1]);

                      for (i = 0; i < a.length; i++)
                          table.appendChild(a[i][1]);

                      for (i = 0; i < a3.length; i++)
                          table.appendChild(a3[i][1]);

                  }

                  else {


                      for (i = 0; i < table.rows.length; i++) {
                          a[i] = new Array();
                          a[i][0] = Math.random();
                          a[i][1] = table.rows[i];
                      }

                      a.sort();
                      a.reverse();

                      for (i = 0; i < a.length; i++)
                          table.appendChild(a[i][1]);

                  }
              }


          }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        
    <div>
        <asp:HiddenField ID="HiddenField1" runat="server" />

        <asp:HiddenField ID="HF_Fio" runat="server" />
        <asp:HiddenField ID="HF_Out_ID" runat="server" />
        <asp:HiddenField ID="HF_cid" runat="server" />
        <asp:HiddenField ID="HiddenFieldOut_ID" runat="server" />
         
        <asp:HiddenField ID="HF_Abonent_ID" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_13" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_14" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_17" runat="server" /> 

        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
        <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
            <asp:TabPanel runat="server" HeaderText="Сценарий" ID="TabPanel1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>
                           <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" 
                                InsertCommand="ext_insertOneResult" InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure" DeleteCommand="[ext_deleteOldResult]" DeleteCommandType="StoredProcedure">
                                <DeleteParameters>
                                    <asp:Parameter Name="IdChain" Type="String" />
                                    <asp:Parameter Name="result_id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="IdChain" Type="String" />
                                    <asp:Parameter Name="Abonent_ID" Type="Int32" />
                                    <asp:Parameter Name="Campaign_ID" Type="Int32" />
                                    <asp:Parameter Name="result_id" Type="Int32" />
                                    <asp:Parameter Name="result" Type="String" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                          <div style="display:none;">  Квота: <asp:Label ID="LabelQuote" runat="server" Text=""></asp:Label></div>
                             <asp:Label ID="LBMSG" runat="server" Visible="False" Text="Label" CssClass="warning"></asp:Label>
                            
                             
                             
                          <asp:Panel ID="Panel1" runat="server"  >
                              Добрый день! Вы занимаетесь внутренней отделкой?
                            
                              <div class="comment">  </div>   

                              <asp:Button CommandName="Panel7" CommandArgument="1" ToolTip="-3" onclick="QAC_Button" Text="Да"   CssClass="green unibutton  big2" Width="500"  ID="Button9"  runat="server" /><br/>  
                                 <asp:Button CommandName="Panel3" CommandArgument="2" ToolTip="-3" onclick="QAC_Button" Text="Нет"    CssClass="green unibutton  big2" Width="500"  ID="Button10"  runat="server" /><br/> 
                              
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel9" runat="server" Visible="false"> 
                               К сожалению, анкетирование предусмотрено только в телефонном режиме. Разговор не займет более 5 минут. С кем лучше поговорить по данному вопросу?
                                <br />
                                <asp:Button ID="Button17" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel33" runat="server" Visible="false"> 
                               Спасибо за уделенное время, всего вам доброго<br />
                                <asp:Button ID="Button35" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel8" runat="server" Visible="false"> 
                                <div class="comment">перезвонить через 1-2 раза и попробовать снова выйти на КЛ </div>
                               Спасибо за уделенное время, всего вам доброго<br />
                                <asp:Button ID="Button16" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel7" runat="server"  Visible="false" CssClass="1">
                               Меня зовут «<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>», исследовательское агентство "Русопрос". Мы проводим исследование рынка строительных материалов, и хотели бы задать несколько вопросов Вашему бригадиру или прорабу. Соедините, пожалуйста.
                                <br/> 
                                <asp:Button CommandName="Panel24_2" CommandArgument="1" ToolTip="-2" onclick="QAC_Button" Text="соединение"   CssClass="green unibutton  big2" Width="500"  ID="Button11"  runat="server" /><br/>  
                                 <asp:Button CommandName="Panel3" CommandArgument="2" ToolTip="-2" onclick="QAC_Button" Text="отказ"    CssClass="green unibutton  big2" Width="500"  ID="Button13"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button20" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                             

                            <asp:Panel ID="Panel3" runat="server" Visible="false">
                                <asp:Label ID="LBQuoteMsg" runat="server" Text="" Visible="False" CssClass="warning"></asp:Label>
                                ЗАКОНЧИТЬ ИНТЕРВЬЮ<br />
                                <asp:Button ID="Button7" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                            
                            
                            
                            <asp:Panel ID="Panel24_2" runat="server" Visible="false"> 
                                Добрый день! Меня зовут «<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>», исследовательское агентство "Русопрос". Мы проводим исследование рынка строительных материалов, и просим Вас ответить на несколько наших вопросов. Это займет не более 5 минут.
                                <div class="comment">   </div>
                                <br/>
                                    <asp:Button CommandName="Panel2" CommandArgument="1" ToolTip="-1" onclick="QAC_Button_S0" Text="согласие" CssClass="green unibutton  big2" Width="600"  ID="Button168_2"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel3" CommandArgument="2" ToolTip="-1" onclick="QAC_Button_S0" Text="отказ" CssClass="green unibutton  big2" Width="600"  ID="Button168_3"  runat="server" /><br/> 
                               <br/> 
                                <br/> 
                                 <asp:Button ID="Button175_2" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                             
                            </asp:Panel>

                             
                              <asp:HiddenField ID="HiddenFieldS0_1" runat="server"  />
                              
                              

                            <asp:Panel ID="Panel2" runat="server" CssClass="1" Visible="false">
                                S1. Укажите, пожалуйста, Ваш возраст (число полных лет) 
                                <div class="comment">/открытый ввод/<br/>  
                                </div>
                                   
                                 <asp:TextBox ID="TextBoxS1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="S1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxS1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button61" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="S1"  CommandName="Panel23" CommandArgument="1"  onclick="QAC_TextBox" />
                       
                            </asp:Panel>

                             
                             
                            <asp:Panel ID="Panel23" runat="server" Visible="false"> 
                                <div class="comment">/отметить код/ </div>
                                <br/>
                                    <asp:Button CommandName="Panel3" CommandArgument="1" ToolTip="101" onclick="QAC_Button" Text="21 и младше" CssClass="red unibutton  big2" Width="400"  ID="Button62"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel24" CommandArgument="2" ToolTip="101" onclick="QAC_Button" Text="22 - 65 лет" CssClass="green unibutton  big2" Width="400"  ID="Button99"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel3" CommandArgument="3" ToolTip="101" onclick="QAC_Button" Text="66 и старше" CssClass="red unibutton  big2" Width="400"  ID="Button102"  runat="server" /><br/>                                     
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button103" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                 
                            </asp:Panel>
                            
                            
                                
                            <asp:Panel ID="Panel69_s1" runat="server" Visible="false">  
                                <div class="comment"> Квота "возраст-пол" выполнена.
                                            </div> 
                                Спасибо большое! Всего Вам доброго! 
                                <br />
                                <asp:Button ID="Button169_s1" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                              
                             
                            <asp:Panel ID="Panel24" runat="server" Visible="false"> 
                                S2. Вы являетесь бригадиром или прорабом строительной бригады, которая на протяжении  последних 6 месяцев осуществляла внутреннюю отделку домов, квартир или иных помещений?
                                <div class="comment"></div>
                                <br/>
                                    <asp:Button CommandName="Panel31"  CommandArgument="1" ToolTip="2" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button168"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel3" CommandArgument="2" ToolTip="2" onclick="QAC_Button" Text="Нет" CssClass="red unibutton  big2" Width="600"  ID="Button170"  runat="server" /><br/> 
                                       <br/> 
                                <br/> 
                                 <asp:Button ID="Button175" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                             
                            </asp:Panel>
                            
                            
                            <asp:Panel ID="Panel69_s2" runat="server" Visible="false">  
                                <div class="comment"> Квота по данному ФО выполнена.
                                            </div> 
                                Спасибо большое! Всего Вам доброго! 
                                <br />
                                <asp:Button ID="Button169_s2" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                            
                            
                            
                                <asp:Panel ID="Panel31" runat="server"  Visible="false"> 
                                    S3. Покупали ли Вы сами или принимали решение о покупке следующих строительных/отделочных материалов во время вашего последнего ремонта? 
                                    <div class="comment">/множественный ответ/</div> 
                                    <asp:CheckBoxList ID="CheckBoxListS3"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">Гипсокартон </asp:ListItem> 
                                        <asp:ListItem Value="2">Штукатурка</asp:ListItem> 
                                        <asp:ListItem Value="3">Шпаклевка</asp:ListItem> 
                                        <asp:ListItem Value="4">Плиточный клей</asp:ListItem> 
                                        <asp:ListItem Value="5">Стяжки для пола / ровнители для пола</asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                    
                                   <br/>  
                                 <asp:Button CommandName="Panel3" CommandArgument="6" ToolTip="3" onclick="QAC_Button" Text="Ничего из перечисленного выше" CssClass="red unibutton  big2" Width="500"  ID="Button5"  runat="server" /><br/> 
                  
                                    <br/> 
                                <asp:Button ID="Button98" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button104" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="S3" CommandName="Panel34" CommandArgument="3" onclick="QAC_CheckBoxList_S3" />
                      
                                </asp:Panel> 
                                
                                
                                
                            <asp:Panel ID="Panel69_q1" runat="server" Visible="false">  
                                <div class="comment"> Квота по данному параметру выполнена.
                                            </div> 
                                Спасибо большое! Всего Вам доброго! 
                                <br />
                                <asp:Button ID="Button169_q1" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                              
                                 
                             
                                <asp:Panel ID="Panel34" runat="server"  Visible="false"> 
                                    S4. В каком регионе Вы живете? 
                                    <div class="comment"> /один ответ/    </div> 
                                    <br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="1" ToolTip="4" onclick="QAC_Button_S4" Text="Москва" CssClass="green unibutton  big2" Width="400"  ID="Button105"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="2" ToolTip="4" onclick="QAC_Button_S4" Text="Санкт-Петербург" CssClass="green unibutton  big2" Width="400"  ID="Button106"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="3" ToolTip="4" onclick="QAC_Button_S4" Text="Нижний Новгород" CssClass="green unibutton  big2" Width="400"  ID="Button107"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="4" ToolTip="4" onclick="QAC_Button_S4" Text="Краснодар" CssClass="green unibutton  big2" Width="400"  ID="Button108"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="5" ToolTip="4" onclick="QAC_Button_S4" Text="Иркутск" CssClass="green unibutton  big2" Width="400"  ID="Button109"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="6" ToolTip="4" onclick="QAC_Button_S4" Text="Воронеж" CssClass="green unibutton  big2" Width="400"  ID="Button111"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="7" ToolTip="4" onclick="QAC_Button_S4" Text="Пермь" CssClass="green unibutton  big2" Width="400"  ID="Button113"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="8" ToolTip="4" onclick="QAC_Button_S4" Text="Новосибирск" CssClass="green unibutton  big2" Width="400"  ID="Button121"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="9" ToolTip="4" onclick="QAC_Button_S4" Text="Екатеринбург" CssClass="green unibutton  big2" Width="400"  ID="Button138"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="10" ToolTip="4" onclick="QAC_Button_S4" Text="Казань" CssClass="green unibutton  big2" Width="400"  ID="Button142"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel59" CommandArgument="11" ToolTip="4" onclick="QAC_Button_S4" Text="Крым" CssClass="green unibutton  big2" Width="400"  ID="Button143"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel3" CommandArgument="12" ToolTip="4" onclick="QAC_Button" Text="Другой регион" CssClass="red unibutton  big2" Width="400"  ID="Button154"  runat="server" /><br/> 
                                    
                                    <br/> 
                                     <asp:Button ID="Button158" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                </asp:Panel> 

                                <asp:HiddenField ID="HiddenFieldS4" runat="server" />
                                 
                                <asp:Panel ID="Panel36" runat="server"  Visible="false">  
                                     <div class="comment">20. Другое (зафиксировать)</div> 
                                     <br/> 
                                        <asp:TextBox ID="TextBoxD2" Width="400" runat="server"></asp:TextBox> 
                                    <br/>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="D2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxD2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                   
                                  
                                    <br/> 
                                    <asp:Button ID="Button231" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                    <asp:Button ID="Button232" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="D2"  CommandName="Panel59" CommandArgument="32"  onclick="QAC_TextBox" />
                          
                                 </asp:Panel> 

                             

                             
                            <asp:Panel ID="Panel13" runat="server" Visible="false">
                                 А с кем из Ваших коллег лучше переговорить по данному вопросу?  <br/>
                                <asp:Button CommandName="PanelRecall"   onclick="standartNext" Text="зафиксировать - перезвонить"    CssClass="green unibutton  big2" Width="500"  ID="Button22"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel3"    onclick="standartNext" Text="завершить"    CssClass="green unibutton  big2" Width="500"  ID="Button21"  runat="server" /><br/> 
                                 <br/> <br/> 
                                 <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                            <asp:Panel ID="Panel6" runat="server" Visible="false">
                                 Когда лучше перезвонить? –   Кого спросить? - Спасибо! До свидания!  <br/>
                                 <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                             
                              <asp:Panel ID="PanelRecall" runat="server"  Visible="false" > 
                                  <div class="comment"> 
                                      ОПЕРАТОР: Записать номер. Далее звонить по этому номеру и начинать интервью заново.
                                  </div>  
                                  <div class="comment">ОПЕРАТОР: ЗАПИШИТЕ</div> 
                                  <asp:TextBox ID="TextBoxNewPhone"  runat="server"></asp:TextBox>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ValidationGroup="S1_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxNewPhone" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                  <asp:MaskedEditExtender ID="TextBoxNewPhone_MaskedEditExtender" runat="server" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" Mask="99999999999" MaskType="Number" TargetControlID="TextBoxNewPhone">
                                  </asp:MaskedEditExtender>
                                  <asp:FilteredTextBoxExtender ID="TextBoxNewPhone_FilteredTextBoxExtender" runat="server" Enabled="True" FilterType="Numbers" TargetControlID="TextBoxNewPhone">
                                  </asp:FilteredTextBoxExtender>

                                  <br/>
                                  <asp:Button ID="Button140" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                  <asp:Button ID="Button139" runat="server" CssClass="unibutton" Text="Далее (Сохранить!)" ValidationGroup="S1_3" CommandName="Panel58" OnClick="ButtonS1_3_Click" />


                                  <asp:SqlDataSource ID="SqlDataSourcePhones" runat="server" ConnectionString="<%$ ConnectionStrings:CCAConnectionString %>" SelectCommand="[OUTBOUND].[dbo].[oktell_getAllContacts]" SelectCommandType="StoredProcedure">
                                      <SelectParameters>
                                          <asp:ControlParameter ControlID="HF_cid" Name="Campaign_ID" PropertyName="Value" Type="Int32" />
                                          <asp:ControlParameter ControlID="HF_Abonent_ID" Name="Abonent_ID" PropertyName="Value" Type="Int32" />
                                      </SelectParameters>
                                  </asp:SqlDataSource>
                                  <br/><br/>
                                   
                             </asp:Panel>

                             
                            <asp:Panel ID="Panel58" runat="server" Visible="false">
                                <asp:Label ID="Label44" runat="server" Text="" Visible="False" CssClass="warning"></asp:Label>
                                Для опроса нам необходимы люди, заинтересованные в покупке квартиры именно в этот период. Извините за беспокойство, до свидания.<br />
                                <asp:Button ID="Button141" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                              

                             
                            <asp:Panel ID="Panel69" runat="server" Visible="false">  
                                Спасибо большое! Всего Вам доброго! 
                                <br />
                                <asp:Button ID="Button169" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>


                              
                         
                            <!--БЛОК 1
                            ВОПРОСЫ Q5-12 ЗАДАВАТЬ ЕСЛИ В S3 ОТМЕЧЕНО «2», ИЛИ «3», ИЛИ «4» ИЛИ «5» «ПОКУПАЛ ШТУКАТУРКИ, ИЛИ ШПАКЛЕВКИ, ИЛИ ПЛИТОЧНЫЙ КЛЕЙ, ИЛИ СТЯЖКИ ДЛЯ ПОЛА/РОВНИТЕЛИ ДЛЯ ПОЛА».
                             -->  
                             
                            <asp:Panel ID="Panel59" runat="server"  Visible="false"> 
                                Q5. Какие марки сухих строительных смесей Вы знаете, слышали о них, не важно, использовали Вы их когда-либо или нет? 
                                Пожалуйста, постарайтесь как можно точнее перечислить все названия, которые сможете вспомнить
                                <div class="comment">/открытый ввод/</div> 
                                <asp:TextBox ID="TextBoxQ5" Width="400" TextMode="MultiLine" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ValidationGroup="Q5"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ5" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button57" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button59" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q5"  CommandName="Panel32" CommandArgument="5"  onclick="QAC_TextBox" />
                       
                            </asp:Panel>

                              

                             
                            <asp:Panel ID="Panel32" runat="server"  Visible="false"> 
                                Q6. Какие из указанных ниже марок сухих строительных смесей Вам известны? Какие из них Вы когда-либо покупали? Готовы ли повторить покупку в будущем? 
                                <br/>
                                
                                <asp:Table runat="server" ID="TableQ6" CssClass="sorttable2" GridLines="Both" ToolTip="2_11"   > 
                                    <asp:TableHeaderRow>
                                        <asp:TableCell></asp:TableCell>
                                        <asp:TableCell></asp:TableCell>
                                        <asp:TableCell>Знаю</asp:TableCell>
                                        <asp:TableCell>Покупал (-а)</asp:TableCell>
                                        <asp:TableCell>Готов (-а) повторить покупку в будущем</asp:TableCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Knauf (КНАУФ)                  </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_1" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_1" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_1" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Волма                          </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_2" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_2" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_2" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Старатели                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_3" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_3" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_3" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Основит                        </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_4" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_4" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_4" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>UNIS (Юнис)                    </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_5" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_5" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_5" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>Гипсополимер                   </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_6" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_6" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_6" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>7</asp:TableCell><asp:TableCell>Bergauf (Бергауф)              </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_7" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_7" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_7" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Церезит (Ceresit)              </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_8" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_8" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_8" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>9</asp:TableCell><asp:TableCell>Вебер-Ветонит (WEBER Vetonit)  </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_9" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_9" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_9" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>10</asp:TableCell><asp:TableCell>Rotband (Ротбанд)             </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_10" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_10" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_10" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>11</asp:TableCell><asp:TableCell>Крепс                         </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_11" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_11" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_11" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>12</asp:TableCell><asp:TableCell>Плитонит                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_12" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_12" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_12" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>13</asp:TableCell><asp:TableCell>Брозекс                       </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_13" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_13" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_13" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>14</asp:TableCell><asp:TableCell>ЕК                            </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_14" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_14" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_14" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>15</asp:TableCell><asp:TableCell>Форман                        </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_15" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_15" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_15" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>16</asp:TableCell><asp:TableCell>Геркулес                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_16" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_16" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_16" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>17</asp:TableCell><asp:TableCell>Боларс                        </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_1_17" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_2_17" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ6_3_17" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                </asp:Table> 
                                 
                                <br/> 
                                <asp:Button ID="Button52" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button64" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q6"  CommandName="Panel64" CommandArgument="6"  onclick="QAC_Q6" />
                      
                            </asp:Panel>



                             
                            <asp:Panel ID="Panel64" runat="server"  Visible="false">
                               Q7. Готовы ли вы порекомендовать сухие строительные смеси перечисленных марок своим родственникам/друзьям/знакомым/коллегам? ДАЙТЕ ОТВЕТ ТОЛЬКО ПО ТЕМ МАРКАМ, КОТОРЫЕ ВЫ ПОКУПАЛИ. 
                                <div class="comment">(Укажите ответ по каждой марке, которую покупали. Если не покупали - отметьте вариант "Не покупал(-а)")  /один ответ в каждой строке, ротация/</div> 
                               
                                <asp:Table runat="server" ID="TableQ7" CssClass="sorttable2" GridLines="Both" > 
                                    <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Knauf (КНАУФ)                          </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_1" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Волма                                  </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_2" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Старатели                              </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_3" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Основит                                </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_4" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>UNIS (Юнис)                            </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_5" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>Гипсополимер                           </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_6" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>7</asp:TableCell><asp:TableCell>Bergauf (Бергауф)                      </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_7" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Церезит (Ceresit)                      </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_8" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>9</asp:TableCell><asp:TableCell>Вебер-Ветонит (WEBER Vetonit)          </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_9" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>10</asp:TableCell><asp:TableCell>Rotband (Ротбанд)                     </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_10" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>11</asp:TableCell><asp:TableCell>Крепс                                 </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_11" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>12</asp:TableCell><asp:TableCell>Плитонит                              </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_12" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>13</asp:TableCell><asp:TableCell>Брозекс                               </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_13" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>14</asp:TableCell><asp:TableCell>ЕК                                    </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_14" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>15</asp:TableCell><asp:TableCell>Форман                                </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_15" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>16</asp:TableCell><asp:TableCell>Геркулес                              </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_16" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>17</asp:TableCell><asp:TableCell>Боларс                                </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ7_17" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                </asp:Table>
                                <br/> 
                                <asp:Button ID="Button58" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button66" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q7"  CommandName="Panel29" CommandArgument="7"  onclick="QAC_Q7" />
            
                            </asp:Panel>

                            <asp:Panel ID="Panel29" runat="server"  Visible="false">
                                Q8. Как Вы считаете, какое место занимают сухие строительные смеси КНАУФ среди прочих марок?
                                  <div class="comment"> /один ответ/                  </div>
                                    <asp:Button CommandName="Panel65" CommandArgument="1" ToolTip="8" onclick="QAC_Button" Text="1. КНАУФ предлагает уникальные сухие строительные смеси, у марки нет конкурентов." CssClass="green unibutton  big2" Width="900"  ID="Button3"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel65" CommandArgument="2" ToolTip="8" onclick="QAC_Button" Text="2. Сухие строительные смеси КНАУФ – одни из лучших на рынке." CssClass="green unibutton  big2" Width="900"  ID="Button24"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel65" CommandArgument="3" ToolTip="8" onclick="QAC_Button" Text="3. Сухие строительные смеси КНАУФ среднего уровня, их легко можно заменить смесями любых других марок." CssClass="green unibutton  big2" Width="900"  ID="Button27"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel65" CommandArgument="4" ToolTip="8" onclick="QAC_Button" Text="4. Сухие строительные смеси КНАУФ – одни из худших на рынке." CssClass="green unibutton  big2" Width="900"  ID="Button42"  runat="server" /><br/> 
                                     
                                    <br/> 
                                     <asp:Button ID="Button48" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                            </asp:Panel>

                                        
                             
                            <asp:Panel ID="Panel65" runat="server"  Visible="false">
                                Q9. Какие основные преимущества и/или недостатки сухих строительных смесей КНАУФ и Ротбанд в сравнении со смесями других марок  Вы можете назвать? 
                                <div class="comment"> В случае отсутствия преимуществ или недостатков просьба в поле для ответа указать "Нет"   </div>
                                <div class="comment"> Преимущества /открытый ввод/                                </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxQ9_1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Q9"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ9_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                <div class="comment"> Недостатки /открытый ввод/  </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxQ9_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="Q9"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ9_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                
                                <br/> 
                                <asp:Button ID="Button54" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button60" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q9"  CommandName="Panel30" CommandArgument="901"  onclick="QAC_Q9" />
            
                            </asp:Panel> 
                              
                              
                            
                            <asp:Panel ID="Panel30_" runat="server"  Visible="false">
                                 Q10. Напишите марку сухих строительных смесей, которую Вы покупаете чаще всего, и укажите основные преимущества смесей этой марки в сравнении со смесями других марок? 
                                <div class="comment">открытый ввод/название</div>
                                   <asp:TextBox ID="TextBoxQ10" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="Q10"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ10" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                <div class="comment">преимущества</div>
                                   <asp:TextBox ID="TextBoxQ10_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ValidationGroup="Q10"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ10_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                
                                <br/> 
                                <asp:Button ID="Button26" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button28" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q10"  CommandName="" CommandArgument="10"  onclick="QAC_Q10" />
            
                            </asp:Panel>
                               <!-- Конец БЛОК 1 -->
                            
                             <!-- БЛОК 2
                                ВОПРОСЫ Q11-16 ЗАДАВАТЬ ЕСЛИ В S3 ОТМЕЧЕНО «1» «ПОКУПАЛ ГИПСОКАРТОН».
                                -->
                           <!-- Old Q11 --> 
                            <asp:Panel ID="Panel30" runat="server"  Visible="false">
                                Q10. Какие марки гипсокартона Вы знаете, слышали о них, не важно, использовали Вы их когда-либо или нет? Пожалуйста, постарайтесь как можно точнее перечислить все названия, которые сможете вспомнить: 
                               <div class="comment">открытый ввод</div>
                                   <asp:TextBox ID="TextBoxQ11" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="Q11"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ11" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                
                                <br/> 
                                <asp:Button ID="Button34" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button70" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q11"  CommandName="Panel68" CommandArgument="11"  onclick="QAC_TextBox" />
            
                            </asp:Panel>

                              
                             <!-- Old Q12 --> 
                             <asp:Panel ID="Panel68" runat="server" Visible="false"> 
                                Q11. Какие из указанных ниже марок гипсокартона Вам известны? Какие из них Вы когда-либо покупали? Готовы ли повторить покупку в будущем? 
                                <div class="comment">/множественный выбор по каждому столбцу, ротация/</div>
                            
                                  <asp:Table runat="server" ID="TableQ12" CssClass="sorttable2" ToolTip="2_10" GridLines="Both" >
                                    <asp:TableHeaderRow>
                                        <asp:TableCell></asp:TableCell>
                                        <asp:TableCell></asp:TableCell>
                                        <asp:TableCell>Знаю</asp:TableCell>
                                        <asp:TableCell>Покупал (-а)</asp:TableCell>
                                        <asp:TableCell>Готов (-а) повторить покупку в будущем</asp:TableCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Knauf (КНАУФ)                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_1" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_1" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_1" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Danogips (Даногипс)                </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_2" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_2" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_2" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Волма                              </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_3" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_3" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_3" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Gypsotonne (Гипсотон)              </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_4" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_4" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_4" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>Gyproc (Гипрок)                    </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_5" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_5" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_5" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>Magma (Магма)                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_6" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_6" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_6" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>7</asp:TableCell><asp:TableCell>Гипсополимер                       </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_7" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_7" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_7" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Aksolit (Аксолит)                  </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_8" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_8" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_8" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>9</asp:TableCell><asp:TableCell>Gifas (Гифас)                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_9" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_9" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_9" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>10</asp:TableCell><asp:TableCell>Иркутский Гипсовый Завод          </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_10" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_10" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_10" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>11</asp:TableCell><asp:TableCell>Голден Груп (Декоратор)           </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_11" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_11" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_11" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>12</asp:TableCell><asp:TableCell>Ангарский Гипсовый завод          </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_1_12" OnCheckedChanged="CheckBoxQ6_1_1_CheckedChanged" AutoPostBack="true"  runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_2_12" Enabled="false" runat="server" /></asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ12_3_12" Enabled="false" runat="server" /></asp:TableCell></asp:TableRow>
                                </asp:Table> 
                                 
                                <br/> 
                                <asp:Button ID="Button71" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button72" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q12"  CommandName="Panel70" CommandArgument="12"  onclick="QAC_Q12" />
                      
                            </asp:Panel> 
                             
                            <asp:HiddenField ID="HiddenFieldA2" runat="server"  />

                             
                            <asp:Panel ID="Panel71" runat="server" Visible="false">  
                                Большое спасибо. До свидания.
                                <br />
                                <asp:Button ID="Button173" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                               
                             <!-- Old Q13 --> 
                                
                                <asp:Panel ID="Panel70" runat="server"  Visible="false"> 
                                    Q12. Готовы ли Вы порекомендовать гипсокартон перечисленных марок своим родственникам/друзьям/знакомым/коллегам? ДАЙТЕ ОТВЕТ ТОЛЬКО ПО ТЕМ МАРКАМ, КОТОРЫЕ ВЫ ПОКУПАЛИ САМИ 
                                     <span class="comment"> (Укажите ответ по каждой марке, которую покупали. Если не покупали - отметьте вариант "Не покупал(-а)")  /один ответ в каждой строке, ротация/</div> 
                                    <asp:Table runat="server" ID="TableQ13" CssClass="sorttable2"  GridLines="Both"> 
                                    <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Knauf (КНАУФ)                      </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_1" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Danogips (Даногипс)                </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_2" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Волма                              </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_3" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Gypsotonne (Гипсотон)              </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_4" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>Gyproc (Гипрок)                    </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_5" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>Magma (Магма)                      </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_6" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>7</asp:TableCell><asp:TableCell>Гипсополимер                       </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_7" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Aksolit (Аксолит)                  </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_8" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>9</asp:TableCell><asp:TableCell>Gifas (Гифас)                      </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_9" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>10</asp:TableCell><asp:TableCell>Иркутский Гипсовый Завод          </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_10" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>11</asp:TableCell><asp:TableCell>Голден Груп (Декоратор)           </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_11" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                    <asp:TableRow><asp:TableCell>12</asp:TableCell><asp:TableCell>Ангарский Гипсовый завод          </asp:TableCell><asp:TableCell><asp:RadioButtonList ID="DropDownListQ13_12" runat="server"><asp:ListItem Value=""></asp:ListItem><asp:ListItem Value="1">Точно да</asp:ListItem><asp:ListItem Value="2">Скорее да</asp:ListItem><asp:ListItem Value="3">Скорее нет</asp:ListItem><asp:ListItem Value="4">Точно нет</asp:ListItem><asp:ListItem Value="5">Не покупал (-а)</asp:ListItem></asp:RadioButtonList></asp:TableCell></asp:TableRow>
                                </asp:Table>
                                <br/> 
                                <asp:Button ID="Button23" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button25" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q13"  CommandName="Panel14" CommandArgument="13"  onclick="QAC_Q13" />
            
                                </asp:Panel> 

                             <asp:HiddenField ID="HiddenFieldQ11" runat="server" />
                             <!-- Old Q14 --> 
                            <asp:Panel ID="Panel14" runat="server"  Visible="false">
                                Q13. Как вы считаете, какое место занимает гипсокартон КНАУФ среди прочих марок? 
                                 <div class="comment"> /один ответ/ </div>
                                     
                                   <asp:Button CommandName="Panel76" CommandArgument="1" ToolTip="14" onclick="QAC_Button_Q14" Text="1. КНАУФ предлагает уникальный гипсокартон, у марки нет конкурентов." CssClass="green unibutton  big2" Width="900"  ID="Button83"  runat="server" /><br/> 
                                   <asp:Button CommandName="Panel76" CommandArgument="2" ToolTip="14" onclick="QAC_Button_Q14" Text="2. Гипсокартон КНАУФ – один из лучших на рынке. " CssClass="green unibutton  big2" Width="900"  ID="Button84"  runat="server" /><br/> 
                                   <asp:Button CommandName="Panel76" CommandArgument="3" ToolTip="14" onclick="QAC_Button_Q14" Text="3. Гипсокартон  КНАУФ среднего уровня, его легко можно заменить гипсокартоном любых других марок." CssClass="green unibutton  big2" Width="900"  ID="Button122"  runat="server" /><br/> 
                                   <asp:Button CommandName="Panel76" CommandArgument="4" ToolTip="14" onclick="QAC_Button_Q14" Text="4. Гипсокартон КНАУФ – один из худших на рынке." CssClass="green unibutton  big2" Width="900"  ID="Button123"  runat="server" /><br/> 
                                   
                                    <br/> 
                                       <asp:Button ID="Button195" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                            </asp:Panel> 

                             <!-- Old Q15 --> 
                                <!-- ВОПРОС Q15 ЗАДАВАТЬ ЕСЛИ В Q12 ОТМЕЧЕН «1» «ПОКУПАЛ ГИПСОКАРТОН КНАУФ». -->
                                <asp:Panel ID="Panel76" runat="server"  Visible="false"> 
                                    Q14. Какие основные преимущества и/или недостатки гипсокартона КНАУФ в сравнении с гипсокартоном других марок Вы можете назвать?
                                    <div class="comment"></div>
                                    <div class="comment">/открытый ввод/</div>
                                      
                                          <asp:TextBox ID="TextBoxQ15_1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="Q15"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ15_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                                
                                <br/> 
                                <asp:Button ID="Button32" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button46" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q15"  CommandName="Panel4" CommandArgument="1501"  onclick="QAC_TextBox" />
            
                                 </asp:Panel>  
                           
                             <!-- ВОПРОС Q16 ЗАДАВАТЬ ЕСЛИ В Q12 ОТМЕЧЕНЫ ВСЕ ОТВЕТЫ ЗА ИСКЛЮЧЕНИЕМ «1» «ПОКУПАЛ ГИПСОКАРТОН МАРКИ КНАУФ». -->
                                <asp:Panel ID="Panel4_" runat="server"  Visible="false"> 
                                    Q16. Напишите марку гипсокартона, который Вы покупаете чаще всего, и укажите основные преимущества гипсокартона этой марки в сравнении гипсокартоном других марок?
                                     <div class="comment">  /открытый ввод/название </div>
                                          <asp:TextBox ID="TextBoxQ16" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Q16"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ16" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                  <div class="comment">  /открытый ввод/преимущества </div>
                                          <asp:TextBox ID="TextBoxQ16_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ValidationGroup="Q16"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ16_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                <asp:Button ID="Button4" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button6" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q16"  CommandName="Panel5" CommandArgument="16"  onclick="QAC_Q16" />
            
                                 </asp:Panel> 
                             
                             <!-- Конец БЛОК 1.  -->

                             <!-- БЛОК 3. ВОПРОСЫ Q17-22 ЗАДАВАТЬ ВСЕМ РЕСПОНДЕНТАМ  -->
                             
                             <!-- Old Q17 --> 
                                <asp:Panel ID="Panel4" runat="server"  Visible="false"> 
                                    Q15. Где Вы покупали сухие строительные смеси и/или гипсокартон для Вашего последнего ремонта?
                                   <div class="comment"> /множественный выбор, любое количество ответов/  </div>
                                       <asp:Table runat="server" ID="TableQ17" GridLines="Both">
                                        <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Гипермаркет строительных материалов, такие как ОБИ, Леруа Мерлен, Петрович, Касторама, К-Раута, Максидом и т.п.</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ17_1" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Супермаркет строительных материалов (небольшая площадь, самообслуживание)                                      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ17_2" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Магазин строительных материалов у дома (маленькая площадь, традиционный магазин, торговля через прилавок)      </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ17_3" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Строительный рынок                                                                                             </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ17_4" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>Оптовая база                                                                                                   </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ17_5" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>Интернет-магазин                                                                                               </asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ17_6" runat="server" /></asp:TableCell></asp:TableRow> 
                                        <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Другое (укажите, что)                                                                                          </asp:TableCell>
                                            <asp:TableCell><asp:CheckBox ID="CheckBoxQ17_8" AutoPostBack="true" OnCheckedChanged="CheckBoxQ17_8_CheckedChanged" runat="server" /><asp:TextBox Visible="false" ID="TextBoxQ17_8" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Q17"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ17_8" Enabled="false" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></asp:TableCell>
                                            
                                        </asp:TableRow>
                                       </asp:Table>
                                    

                                        <asp:Button ID="Button2" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                        <asp:Button ID="Button8" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q17"  CommandName="Panel16" CommandArgument="17"  onclick="QAC_Q17"  />
            
                                 </asp:Panel> 
                             <!-- Old Q18 --> 
                                <asp:Panel ID="Panel16" runat="server"  Visible="false"> 
                                   Q16. Какими источниками информации Вы пользуетесь для выбора конкретной марки сухих строительных смесей и/или гипсокартона? 
                                   <div class="comment">  /множественный выбор, ротация/ </div>
                                     <asp:Table runat="server" ID="TableQ18" GridLines="Both"  >  
                                        <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Телепередачи о ремонте</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_2" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Реклама на телевидении</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_3" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Пресса: журналы, газеты и т.п.</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_4" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Радио</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_5" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>Дополнительная информация в местах продаж: листовки, брошюры, прайс-листы и тп</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_6" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>Реклама на транспорте (в метро, в электричках, на/в автобусах, троллейбусах)</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_7" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>7</asp:TableCell><asp:TableCell>Рекламные щиты на улицах</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_8" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Рекомендации родных / близких / знакомых</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_9" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>9</asp:TableCell><asp:TableCell>Рекомендации строителей/прорабов/бригадиров</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_10" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>10</asp:TableCell><asp:TableCell>Рекомендации продавца</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_11" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>11</asp:TableCell><asp:TableCell>Личный, предыдущий опыт использования</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_12" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>12</asp:TableCell><asp:TableCell>Семинары, мастер-классы производителя</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_13" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>13</asp:TableCell><asp:TableCell>Интернет – сайты производителей стройматериалов</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_14" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>14</asp:TableCell><asp:TableCell>Интернет – форумы, сайты, посвященные строительной тематике</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_15" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>15</asp:TableCell><asp:TableCell>Интернет – социальные сети, группы в социальных сетях</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_16" runat="server" /></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>16</asp:TableCell><asp:TableCell>Другое (укажите, что)</asp:TableCell><asp:TableCell><asp:CheckBox ID="CheckBoxQ18_17" OnCheckedChanged="CheckBoxQ18_17_CheckedChanged" AutoPostBack="true" runat="server" /><asp:TextBox Visible="false" ID="TextBoxQ18_17" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="Q18"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ18_17" Enabled="false" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator></asp:TableCell></asp:TableRow>
                                       </asp:Table>
                                    

                                        <asp:Button ID="Button18" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                        <asp:Button ID="Button29" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q18"  CommandName="Panel17" CommandArgument="17"  onclick="QAC_Q18"  />
            
                                 </asp:Panel> 


                             <!-- Old Q19 -->                              
                                <asp:Panel ID="Panel17" runat="server"  Visible="false"> 
                                    Q17. Рекламу каких марок строительных и отделочных материалов Вы видели или слышали за последние полгода? Напишите, пожалуйста, где Вы ее видели.
                                  <div class="comment">/открытый ввод, ответ в каждой строке/</div>
                                    <br/> 
                                    <asp:Table runat="server" ID="TableQ19" GridLines="Both"  > 
                                        <asp:TableHeaderRow>
                                            <asp:TableCell></asp:TableCell>
                                            <asp:TableCell></asp:TableCell>
                                            <asp:TableCell></asp:TableCell>
                                        </asp:TableHeaderRow>
                                        <asp:TableRow><asp:TableCell>1</asp:TableCell><asp:TableCell>Knauf (КНАУФ)                  </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_1" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>2</asp:TableCell><asp:TableCell>Ceresit (Церезит)              </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_2" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>3</asp:TableCell><asp:TableCell>Юнис (UNIS)                    </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_3" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>4</asp:TableCell><asp:TableCell>Волма                          </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_4" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>5</asp:TableCell><asp:TableCell>Gyproc (Гипрок)                </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_5" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>6</asp:TableCell><asp:TableCell>WEBER Vetonit (Вебер-Ветонит)  </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_6" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>7</asp:TableCell><asp:TableCell>Ротбанд (Rotband)              </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_7" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                        <asp:TableRow><asp:TableCell>8</asp:TableCell><asp:TableCell>Старатели                      </asp:TableCell><asp:TableCell><asp:TextBox ID="TextBoxQ19_8" runat="server"></asp:TextBox></asp:TableCell></asp:TableRow>
                                     </asp:Table>
                                    <br/> 
                                     
                                        <asp:Button ID="Button36" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                        <asp:Button ID="Button38" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q19"  CommandName="Panel18" CommandArgument="19"  onclick="QAC_Q19"  />
            
                                 </asp:Panel> 
                             
                             <!-- Old Q20 -->            
                                <asp:Panel ID="Panel18" runat="server"  Visible="false"> 
                                    Q18. Что в первую очередь может побудить Вас приобрести продукцию марки КНАУФ? Укажите три наиболее важных для Вас фактора. 
                                    <div class="comment">/множественный выбор, три варианта ответа/</div>
                                     <asp:CheckBoxList ID="CheckBoxListQ20"  runat="server" CssClass="3"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">Известная марка</asp:ListItem> 
                                        <asp:ListItem Value="2">Приемлемый уровень цен продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="3">Личный опыт использования продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="4">Высокое качество продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="5">Рекомендации по КНАУФ родных / близких / знакомых</asp:ListItem> 
                                        <asp:ListItem Value="6">Рекомендации по КНАУФ строителей/прорабов/бригадиров</asp:ListItem> 
                                        <asp:ListItem Value="7">Продукцию КНАУФ легко купить</asp:ListItem> 
                                        <asp:ListItem Value="8">Грамотная консультация продавцов по КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="9">Детальная и полезная информация о продукции КНАУФ в открытом доступе (статьи, видеоролики и проч.)</asp:ListItem> 
                                        <asp:ListItem Value="10">Удобная упаковка продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="11">Технические характеристики  продукции КНАУФ </asp:ListItem> 
                                        <asp:ListItem Value="12">Другое (укажите, что)</asp:ListItem> 
                                     </asp:CheckBoxList> 
                                      <br/> 
                                    <asp:TextBox ID="TextBoxQ20" Visible="false" runat="server"></asp:TextBox>

                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator15" Enabled="false" runat="server" ValidationGroup="Q20" ControlToValidate="TextBoxQ20" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                           
                                     
                                        <br/> 
                                    <asp:Button ID="Button80" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                    <asp:Button ID="Button82" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="Q20" CommandName="Panel19" CommandArgument="20" onclick="QAC_CheckBoxList_Q20" />
                          
                                 </asp:Panel> 

                             
                             <!-- Old Q21 -->            
                                <asp:Panel ID="Panel19" runat="server"  Visible="false"> 
                                    Q19. Что для вас в первую очередь может стать препятствием для приобретения продукции марки КНАУФ? Укажите три наиболее важных для Вас фактора.
                                    <div class="comment">/множественный выбор, три варианта ответа /</div>
                                    <asp:CheckBoxList ID="CheckBoxListQ21"  runat="server" CssClass="3"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">Марка КНАУФ мне не знакома </asp:ListItem> 
                                        <asp:ListItem Value="2">Высокие цены продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="3">Негативный личный опыт использования продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="4">Низкое качество продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="5">Отрицательные отзывы родных / близких / знакомых</asp:ListItem> 
                                        <asp:ListItem Value="6">Отрицательные отзывы строителей/прорабов/бригадиров</asp:ListItem> 
                                        <asp:ListItem Value="7">Продукцию КНАУФ сложно купить</asp:ListItem> 
                                        <asp:ListItem Value="8">Отрицательные отзывы в Интернете</asp:ListItem> 
                                        <asp:ListItem Value="9">Мало детальной и полезной информации о продукции КНАУФ в открытом доступе (статьи, видеоролики и проч.)</asp:ListItem> 
                                        <asp:ListItem Value="10">НЕудобная упаковка продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="11">Неудовлетворительные технические характеристики  продукции КНАУФ</asp:ListItem> 
                                        <asp:ListItem Value="12">Другое (укажите, что)</asp:ListItem> 
                                     </asp:CheckBoxList> 
                                      <br/> 
                                    <asp:TextBox ID="TextBoxQ21" Visible="false" runat="server"></asp:TextBox>

                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator16" Enabled="false" runat="server" ValidationGroup="Q21" ControlToValidate="TextBoxQ21" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                           
                                     
                                        <br/> 
                                    <asp:Button ID="Button39" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                    <asp:Button ID="Button41" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="Q21" CommandName="Panel20" CommandArgument="21" onclick="QAC_CheckBoxList_Q21" />
                          
                        
                                 </asp:Panel> 
                                
                             <!-- Old Q22 -->            
                                <asp:Panel ID="Panel20" runat="server"  Visible="false"> 
                                    Q20. Согласны ли вы со следующими утверждениями о марке КНАУФ? Дайте оценку по 7-балльной шкале, где «1» - полностью не согласен, а «7» - полностью согласен.
                                    <div class="comment"> /один ответ в каждой строке /  </div>
                                      <br/> 
                                    1.		КНАУФ предлагает оптимальное соотношение цены-качества материалов
                                           <br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="1" ToolTip="2201" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button76"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="2" ToolTip="2201" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button129"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="3" ToolTip="2201" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button12"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="4" ToolTip="2201" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button14"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="5" ToolTip="2201" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button15"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="6" ToolTip="2201" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button130"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel37" CommandArgument="7" ToolTip="2201" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button131"  runat="server" /><br/> 
                                   
                                    <br/> 
                                     <asp:Button ID="Button133" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel37" runat="server"  Visible="false"> 
                                    2.		КНАУФ - известная марка
                                           <br/> 

                                    <asp:Button CommandName="Panel38" CommandArgument="1" ToolTip="2202" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button31"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel38" CommandArgument="2" ToolTip="2202" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button33"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel38" CommandArgument="3" ToolTip="2202" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button37"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel38" CommandArgument="4" ToolTip="2202" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button40"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel38" CommandArgument="5" ToolTip="2202" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button44"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel38" CommandArgument="6" ToolTip="2202" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button45"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel38" CommandArgument="7" ToolTip="2202" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button47"  runat="server" /><br/> 
                                   
                                     <br/> 
                                     <asp:Button ID="Button74" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel38" runat="server"  Visible="false"> 
                                    3.		КНАУФ ценит меня как своего клиента
                                           <br/> 

                                    <asp:Button CommandName="Panel39" CommandArgument="1" ToolTip="2203" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button49"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel39" CommandArgument="2" ToolTip="2203" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button50"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel39" CommandArgument="3" ToolTip="2203" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button51"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel39" CommandArgument="4" ToolTip="2203" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button53"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel39" CommandArgument="5" ToolTip="2203" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button55"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel39" CommandArgument="6" ToolTip="2203" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button63"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel39" CommandArgument="7" ToolTip="2203" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button65"  runat="server" /><br/> 
                                   
                                     
                                    <br/> 
                                     <asp:Button ID="Button114" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel39" runat="server"  Visible="false"> 
                                    4.		Продукцию КНАУФ легко купить
                                           <br/> 

                                    <asp:Button CommandName="Panel40" CommandArgument="1" ToolTip="2204" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button67"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel40" CommandArgument="2" ToolTip="2204" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button68"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel40" CommandArgument="3" ToolTip="2204" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button69"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel40" CommandArgument="4" ToolTip="2204" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button73"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel40" CommandArgument="5" ToolTip="2204" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button77"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel40" CommandArgument="6" ToolTip="2204" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button78"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel40" CommandArgument="7" ToolTip="2204" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button79"  runat="server" /><br/> 
                                   
                                    <br/> 
                                     <asp:Button ID="Button119" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel40" runat="server"  Visible="false"> 
                                    5.		Марке КНАУФ можно доверять 
                                           <br/> 

                                    <asp:Button CommandName="Panel41" CommandArgument="1" ToolTip="2205" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button81"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel41" CommandArgument="2" ToolTip="2205" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button85"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel41" CommandArgument="3" ToolTip="2205" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button86"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel41" CommandArgument="4" ToolTip="2205" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button87"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel41" CommandArgument="5" ToolTip="2205" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button88"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel41" CommandArgument="6" ToolTip="2205" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button89"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel41" CommandArgument="7" ToolTip="2205" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button90"  runat="server" /><br/> 
                                   
                                     
                                    <br/> 
                                     <asp:Button ID="Button127" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel41" runat="server"  Visible="false"> 
                                    6.		КНАУФ – один из важнейших поставщиков строительных материалов для меня
                                           <br/> 
                                     
                                    
                                    <asp:Button CommandName="Panel42" CommandArgument="1" ToolTip="2206" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button91"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel42" CommandArgument="2" ToolTip="2206" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button92"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel42" CommandArgument="3" ToolTip="2206" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button93"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel42" CommandArgument="4" ToolTip="2206" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button94"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel42" CommandArgument="5" ToolTip="2206" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button96"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel42" CommandArgument="6" ToolTip="2206" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button97"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel42" CommandArgument="7" ToolTip="2206" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button100"  runat="server" /><br/> 
                                   
                                     
                                    <br/> 
                                     <asp:Button ID="Button147" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel42" runat="server"  Visible="false"> 
                                    7.		В будущем я буду пользоваться продукцией КНАУФ
                                           <br/> 
                                    
                                    <asp:Button CommandName="Panel43" CommandArgument="1" ToolTip="2207" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button101"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel43" CommandArgument="2" ToolTip="2207" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button110"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel43" CommandArgument="3" ToolTip="2207" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button112"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel43" CommandArgument="4" ToolTip="2207" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button115"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel43" CommandArgument="5" ToolTip="2207" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button116"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel43" CommandArgument="6" ToolTip="2207" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button117"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel43" CommandArgument="7" ToolTip="2207" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button118"  runat="server" /><br/> 
                                    
                                     
                                    <br/> 
                                     <asp:Button ID="Button152" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 

                                <asp:Panel ID="Panel43" runat="server"  Visible="false"> 
                                   8.		Если ко мне обратятся за советом, я обязательно порекомендую КНАУФ
                                           <br/> 
                                    
                                    <asp:Button CommandName="Panel44" CommandArgument="1" ToolTip="2208" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button120"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel44" CommandArgument="2" ToolTip="2208" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button124"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel44" CommandArgument="3" ToolTip="2208" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button125"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel44" CommandArgument="4" ToolTip="2208" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button126"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel44" CommandArgument="5" ToolTip="2208" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button128"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel44" CommandArgument="6" ToolTip="2208" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button132"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel44" CommandArgument="7" ToolTip="2208" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button135"  runat="server" /><br/> 
                                    
                                     
                                    <br/> 
                                     <asp:Button ID="Button162" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 
                                

                                <asp:Panel ID="Panel44" runat="server"  Visible="false"> 
                                   9.		У КНАУФ широкий ассортимент
                                           <br/> 
                                    
                                    <asp:Button CommandName="Panel45" CommandArgument="1" ToolTip="2209" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button136"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel45" CommandArgument="2" ToolTip="2209" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button137"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel45" CommandArgument="3" ToolTip="2209" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button144"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel45" CommandArgument="4" ToolTip="2209" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button145"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel45" CommandArgument="5" ToolTip="2209" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button146"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel45" CommandArgument="6" ToolTip="2209" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button148"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel45" CommandArgument="7" ToolTip="2209" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button149"  runat="server" /><br/> 
                                    
                                    <br/> 
                                     <asp:Button ID="Button167" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 
                                

                                <asp:Panel ID="Panel45" runat="server"  Visible="false"> 
                                   10.		Мне нравится продукция КНАУФ
                                           <br/> 
                                    
                                    <asp:Button CommandName="Panel46" CommandArgument="1" ToolTip="2210" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button150"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel46" CommandArgument="2" ToolTip="2210" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button151"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel46" CommandArgument="3" ToolTip="2210" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button153"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel46" CommandArgument="4" ToolTip="2210" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button155"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel46" CommandArgument="5" ToolTip="2210" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button156"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel46" CommandArgument="6" ToolTip="2210" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button159"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel46" CommandArgument="7" ToolTip="2210" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button160"  runat="server" /><br/> 
                                   
                                     
                                    <br/> 
                                     <asp:Button ID="Button177" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 
                                

                                <asp:Panel ID="Panel46" runat="server"  Visible="false"> 
                                   11.		КНАУФ- новатор в области строительных материалов
                                           <br/> 

                                    
                                    <asp:Button CommandName="Panel47" CommandArgument="1" ToolTip="2211" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button161"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel47" CommandArgument="2" ToolTip="2211" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button163"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel47" CommandArgument="3" ToolTip="2211" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button164"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel47" CommandArgument="4" ToolTip="2211" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button165"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel47" CommandArgument="5" ToolTip="2211" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button166"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel47" CommandArgument="6" ToolTip="2211" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button171"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel47" CommandArgument="7" ToolTip="2211" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button172"  runat="server" /><br/> 
                                   
                                      
                                    <br/> 
                                     <asp:Button ID="Button183" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 
                             
                                

                                <asp:Panel ID="Panel47" runat="server"  Visible="false"> 
                                   12.		С продукцией КНАУФ легко работать
                                           <br/> 

                                    
                                    
                                    <asp:Button CommandName="Panel28" CommandArgument="1" ToolTip="2212" onclick="QAC_Button" Text="1. Совершенно не согласен" CssClass="green unibutton  big2" Width="400"  ID="Button174"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel28" CommandArgument="2" ToolTip="2212" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="400"  ID="Button176"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel28" CommandArgument="3" ToolTip="2212" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="400"  ID="Button178"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel28" CommandArgument="4" ToolTip="2212" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="400"  ID="Button179"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel28" CommandArgument="5" ToolTip="2212" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="400"  ID="Button180"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel28" CommandArgument="6" ToolTip="2212" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="400"  ID="Button181"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel28" CommandArgument="7" ToolTip="2212" onclick="QAC_Button" Text="7. Полностью согласен" CssClass="green unibutton  big2" Width="400"  ID="Button182"  runat="server" /><br/> 
                                   
                                       
                                    <br/> 
                                     <asp:Button ID="Button188" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                                 </asp:Panel> 


                                <asp:Panel ID="Panel28" runat="server"  Visible="false">  
                                    Q21.Пол респондента 
                                    <div class="comment"> /один ответ/</div> 
                                    <br/> 
                                            <br/> 
                                    <asp:Button CommandName="Panel10" CommandArgument="1" ToolTip="23" onclick="QAC_Button" Text="1. Мужской " CssClass="green unibutton  big2" Width="400"  ID="Button75"  runat="server" /><br/> 
                                    <asp:Button CommandName="Panel10" CommandArgument="2" ToolTip="23" onclick="QAC_Button" Text="2. Женский " CssClass="green unibutton  big2" Width="400"  ID="Button134"  runat="server" /><br/> 
                                      
                                    <br/> 
                                     <asp:Button ID="Button157" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                        
                        
                                </asp:Panel> 

                                 
                              
                                <asp:Panel ID="Panel10" runat="server"  Visible="false">  
                                    ФИО

                                    <br/> 
                                     <asp:TextBox ID="TextBoxAFIO" Width="400" runat="server"></asp:TextBox> 
                                    <br/>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="AFIO"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxAFIO" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                   
                                    <br/> 
                                    <br/> 
                                     <asp:Button ID="Button30" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                    <asp:Button ID="Button43" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="AFIO"  CommandName="Panel54" CommandArgument="53"  onclick="QAC_TextBox" />
                                </asp:Panel>
                                 
                                 
                              
                             
                            <asp:Panel ID="Panel54" runat="server"  Visible="false">
                               Наше интервью закончено, благодарю за участие!
                               <div class="comment">ЗАВЕРШИТЬ АНКЕТИРОВАНИЕ</div>
                                <br/>
                                <asp:Button ID="Button95" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             

                             
                             

                         </ContentTemplate>
                             </asp:UpdatePanel>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                        AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <span style="font-weight:bold; color:Red;">Обработка информации ...</span>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </ContentTemplate>
            </asp:TabPanel>

             

        </asp:TabContainer>
    
    </div>
    </form>
</body>
</html>
