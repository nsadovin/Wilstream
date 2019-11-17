<%@ Page Language="C#"  EnableSessionState="True"  AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <meta charset="utf-8" />
    <!--[if IE]><script src="js/html5.js"></script><![endif]-->
    <link href="css/style.css" rel="stylesheet" type="text/css" />
	<!--[if lte IE 6]><link rel="stylesheet" href="css/style_ie.css" type="text/css" media="screen, projection" /><![endif]-->
	 
	 
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
        <asp:HiddenField ID="HiddenFieldColumn_12" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_11" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_13" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_14" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_17" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_15" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_9" runat="server" /> 

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
                             
                             
                             
                            <asp:Panel ID="Panel1" runat="server">
                                Добрый день! Меня зовут <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>, я представляю Информационно-консультационный центр «Бизнес-Тезаурус». Мы проводим социологическое исследование по заказу Минпромторга России по поводу внедрения системы цифровой маркировки товаров. 
                                <br/>  
                                <asp:Button ID="Button2" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel40"   onclick="standartNext" />
                     
                                
                            </asp:Panel>

                               <asp:Panel ID="Panel41" runat="server"  Visible="false"> 
                                 <div class="comment">уточнить новое название  </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxF1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ValidationGroup="F1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button129" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button130" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F1"  CommandName="Panel40" CommandArgument="-51"  onclick="QAC_TextBox" />
                            </asp:Panel> 

                                
                            <asp:Panel ID="Panel40" runat="server" Visible="false">  
                                Вопрос 0. Скажите, пожалуйста, Вы сможете ответить на вопросы по системе цифровой маркировки товаров?<br/> 
                                <asp:Button CommandName="Panel1_3" CommandArgument="согласие" ToolTip="0" onclick="QAC_Button"     Text="согласие" CssClass="green unibutton  big2" Width="200"  ID="Button163"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel1"  CommandArgument="соединение с другим сотрудником" ToolTip="0" onclick="QAC_Button"     Text="соединение с другим сотрудником" CssClass="green unibutton  big2" Width="200"  ID="Button164"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel41"  CommandArgument="дают другой номер" ToolTip="0" onclick="QAC_Button"     Text="дают другой номер" CssClass="green unibutton  big2" Width="200"  ID="Button165"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel3"  CommandArgument="отказ" ToolTip="0" onclick="QAC_Button"     Text="отказ" CssClass="green unibutton  big2" Width="200"  ID="Button166"  runat="server" /><br/> 
                                <div class="comment">ИНТЕРВЬЮЕР, ЕСЛИ РЕСПОНДЕНТ ПРОСИТ ПОЯСНИТЬ, КАКИЕ ВОПРОСЫ ПО МАРКИРОВКЕ ИНТЕРЕСУЮТ, УТОЧНИТЬ: Мы хотели задать ряд вопросов, которые позволят выявить существующие барьеры при внедрении системы цифровой маркировки товаров, оценить готовность бизнеса к внедрению системы цифровой маркировки товаров, а также обсудить варианты смягчения государственного регулирования участников оборота товаров, подлежащих обязательной маркировке.</div>
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel1_3" runat="server" Visible="false">
                                Вопрос 1. Осуществляет ли Ваша компания хранение, транспортировку, производство или продажу на территории Российской Федерации, а также ввоз в Российскую Федерацию товаров, относящихся к следующим видам продукции?
                                <br/> 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ. может быть один или несколько вариантов ответа.  </div>
                                    <asp:CheckBoxList ID="CheckBoxListA1"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">табак</asp:ListItem> 
                                        <asp:ListItem Value="2">шубы</asp:ListItem> 
                                        <asp:ListItem Value="3">обувь</asp:ListItem> 
                                        <asp:ListItem Value="4">верхняя одежда (мужская и женская, кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:ListItem> 
                                        <asp:ListItem Value="5">лекарства</asp:ListItem> 
                                        <asp:ListItem Value="6">молочная продукция</asp:ListItem> 
                                        <asp:ListItem Value="7">кресла-коляски</asp:ListItem> 
                                        <asp:ListItem Value="8">велосипеды</asp:ListItem> 
                                        <asp:ListItem Value="9">фотоаппараты и лампы-вспышки</asp:ListItem> 
                                        <asp:ListItem Value="10">шины и автопокрышки</asp:ListItem> 
                                        <asp:ListItem Value="11">духи и туалетная вода</asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                 
                                    <br/> 
                                <asp:Button ID="Button65" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button121" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A1" CommandName="Panel28" CommandArgument="1" onclick="QAC_CheckBoxList" />
                      
                            </asp:Panel>
                            <asp:HiddenField ID="HiddenFieldA1" runat="server" />

                           
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false">  
                                 Вопрос 2. Какими видами деятельности, занимается Ваша компания относительно «продукт из вопроса1»?
                                   <br/>  
                                <asp:Table ID="TableA2" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA2_PreRender">
                                    <asp:TableRow>
                                        <asp:TableCell>1. табак</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_1"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_2"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_3"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. верхняя одежда (мужская и женская, кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_4"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_5"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_6"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_7"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_8"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_9"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_10"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBoxList ID="CheckBoxListA2_11"  runat="server"  >
                                                <asp:ListItem Value="1">Производство продукции</asp:ListItem>
                                                <asp:ListItem Value="2">Импорт продукции</asp:ListItem>
                                                <asp:ListItem Value="3">Хранение и транспортировка продукции</asp:ListItem>
                                                <asp:ListItem Value="4">Оптовая торговля</asp:ListItem>
                                                <asp:ListItem Value="5">Розничная торговля</asp:ListItem> 
                                            </asp:CheckBoxList> 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button3" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button4" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A2" CommandName="Panel29" CommandArgument="2" onclick="QAC_A2" />
                            

                            </asp:Panel> 
                            
                             
                            <asp:HiddenField ID="HiddenFieldShowAll" runat="server" />
                            
                            <asp:Panel ID="Panel29" runat="server" Visible="false">
                                Вопрос 3. Какова форма собственности Вашего предприятия?
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ. может быть ОДИН вариант ответа.  </div>
                                <asp:Button CommandName="Panel2_4" CommandArgument="1" ToolTip="3" onclick="QAC_Button" Text="1. Индивидуальный предприниматель (ИП)" CssClass="green unibutton  big2" Width="600"  ID="Button11"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_4" CommandArgument="2" ToolTip="3" onclick="QAC_Button" Text="2. Общество с ограниченной ответственностью (ООО)" CssClass="green unibutton  big2" Width="600"  ID="Button12"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_4" CommandArgument="3" ToolTip="3" onclick="QAC_Button" Text="3. Акционерное общество" CssClass="green unibutton  big2" Width="600"  ID="Button13"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2" CommandArgument="5" ToolTip="3" onclick="QAC_Button" Text="5. Другое" CssClass="green unibutton  big2" Width="600"  ID="Button24"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_4" CommandArgument="99" ToolTip="3" onclick="QAC_Button" Text="99. Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button5"  runat="server" /><br/> 
                              
                                <br/>
                                <asp:Button ID="Button132" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
        
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel2" runat="server"  Visible="false"> 
                                 <div class="comment">(уточнить, что именно __________)</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA3_99" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="A3_99"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA3_99" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button27" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button122" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A3_99"  CommandName="Panel2_4" CommandArgument="399"  onclick="QAC_TextBox" />
                            </asp:Panel> 



                              <asp:Panel ID="Panel2_4" runat="server"  Visible="false" CssClass="1">
                                 Вопрос 4.  Оцените, в какую категорию попадает выручка предприятия в 2019 году, включая все филиалы (подразделения)?
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ. может быть ОДИН вариант ответа.</div>
                                 <asp:Button CommandName="Panel26" CommandArgument="1" ToolTip="4" onclick="QAC_Button" Text="От 0 до 120 млн руб." CssClass="green unibutton  big2" Width="600"  ID="Button15"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel26" CommandArgument="2" ToolTip="4" onclick="QAC_Button" Text="От 120 до 800 млн руб." CssClass="green unibutton  big2" Width="600"  ID="Button123"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel26" CommandArgument="3" ToolTip="4" onclick="QAC_Button" Text="От 800 млн руб. до 2 млрд руб." CssClass="green unibutton  big2" Width="600"  ID="Button124"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel26" CommandArgument="4" ToolTip="4" onclick="QAC_Button" Text="Свыше 2 млрд руб." CssClass="green unibutton  big2" Width="600"  ID="Button125"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel26" CommandArgument="99" ToolTip="4" onclick="QAC_Button" Text="Затрудняюсь ответить / нет ответа" CssClass="green unibutton  big2" Width="600"  ID="Button14"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button128" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
        
                            </asp:Panel>
                              
                             
                             
                            <asp:Panel ID="Panel27" runat="server" Visible="false"> 
                                В какое время, Вам было бы удобней, что бы мы перезвонили?
                                <div class="comment">– зафиксировать –</div> Спасибо! Мы свяжемся с Вами!
                                <br />
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             

                              
                                   
                            <asp:Panel ID="Panel26" runat="server"  Visible="false">
                                 Вопрос 5.  Какова примерно общая численность сотрудников компании, включая все филиалы (подразделения), на текущий момент? 
                                 <div class="comment">                                 </div>
                                 <br/> 
                                 <asp:TextBox ID="TextBoxA5" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ValidationGroup="A5"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA5" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <asp:Button CommandName="Panel42" CommandArgument="99" ToolTip="5" onclick="QAC_Button" Text="Затрудняюсь ответить / нет ответа" CssClass="green unibutton  big2" Width="600"  ID="Button134"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button16" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button18" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A5"  CommandName="Panel55" CommandArgument="5"  onclick="QAC_TextBox" />
                      
                               
                            </asp:Panel>


                             
                                 <asp:Panel ID="Panel42" runat="server" Visible="false">  
                                   Вопрос 5а.  В какой примерный диапазон попадает общая численность сотрудников компании, включая все филиалы (подразделения)?
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ. может быть ОДИН вариант ответа</div>
                             
                                   <br/>  
                                <asp:Table ID="TableA5a" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA5a_PreRender">
                                    <asp:TableRow>
                                        <asp:TableCell>1. табак</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA5a_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_1" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA5a_2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_2" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_3" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. верхняя одежда (мужская и женская, кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_4" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_5" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_6" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_6" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_7" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_7" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_8" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_8" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_9" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_9" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_10" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_10" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA5a_11" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA5a_SelectedIndexChanged" runat="server">
                                                 <asp:ListItem Value="1">1.	Внедрение системы маркировки завершено</asp:ListItem>
                                                 <asp:ListItem Value="2">2.	Компания участвует в эксперименте по внедрению системы маркировки</asp:ListItem>
                                                 <asp:ListItem Value="3">3.	Внедрение системы маркировки еще не начато, но компания в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="4">4.	Внедрение системы маркировки еще не начато, и компания не в курсе требований к ее внедрению</asp:ListItem>
                                                 <asp:ListItem Value="5">5.	Иное (что?) _______</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA5a_11" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button142" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button143" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A5a" CommandName="Panel55" CommandArgument="502" onclick="QAC_A5a" />
                            

                            </asp:Panel> 
 
                              
                             
                             

                            
                            
                            <asp:Panel ID="Panel33" runat="server" Visible="false"> 
                                Всего доброго, до свидания! <br />
                                <asp:Button ID="Button35" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                              

                            <asp:Panel ID="Panel32" runat="server" Visible="false"> 
                                зафиксировать дату и время перезвона<br />
                                <asp:Button ID="Button118" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel> 

                            <asp:Panel ID="Panel3" runat="server" Visible="false">
                                <asp:Label ID="LBQuoteMsg" runat="server" Text="" Visible="False" CssClass="warning"></asp:Label>
                                ЗАКОНЧИТЬ ИНТЕРВЬЮ<br />
                                <asp:Button ID="Button7" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>   

                               
                                
                       
                             
                            <asp:Panel ID="Panel55" runat="server"  Visible="false"> 
                                Вопрос 6. Как Вы относитесь к внедрению системы обязательной цифровой маркировки товаров, в обороте которых участвует Ваша компания? 
                                <div class="comment">Респондент отвечает на вопрос по тем видам товарам, по которым на вопрос 1 ответил «да». Респондент может выбрать только один вариант ответа по каждому виду товара. </div>
                                <br/>
                                <asp:Table ID="TableA6" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA6_PreRender">
                                    <asp:TableRow>
                                        <asp:TableCell>1. табак</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA6_1" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>                                   
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA6_2" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_3" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. верхняя одежда (мужская и женская, кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_4" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_5" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_6" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_7" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_8" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_9" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_10" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA6_11" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. нет ответа </asp:ListItem>
                                             </asp:RadioButtonList>     
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button6" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button10" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A6" CommandName="Panel4" CommandArgument="6" onclick="QAC_A6" />
                          
                            </asp:Panel>

                              
                             
                            <asp:Panel ID="Panel4" runat="server"  Visible="false"> 
                                <div class="comment">ИНТЕРВЬЮЕР, В ВОПРОСАХ 7-8-9 НАС ИНТЕРЕСУЕТ ГОД, В КОТОРОМ ОРГАНИЗАЦИИ ВНЕДРЯЛИ СИСТЕМУ МАРКИРОВКИ. (КАК ПРАВИЛО, ЭТО 2019 ГОД, НО В РЯДЕ СЛУЧАЕВ МОГЛИ НАЧАТЬ ВНЕДРЕНИЕ СИСТЕМЫ И В 2018 ГОДУ).</div>
                                Вопрос 7. На этапе <b><u>внедрения системы</u></b> цифровой маркировки товаров. Какой ПРИМЕРНО процент от годового оборота Вашей компании составляет…? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ. МОЖНО УКАЗАТЬ ДИАПАЗОН ПРОЦЕНТОВ</div>
                                 <asp:Table ID="TableA7" BorderWidth="1" GridLines="Both" runat="server" >
                                    <asp:TableRow>
                                        <asp:TableCell>1. Покупка оборудования на внедрение системы цифровой маркировкой товаров (например: принтеры, принтеры-аппликаторы, сканеры) </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_1" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>2. Модернизация существующих технологических процессов под систему маркировки</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_2" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>3. Внедрение электронного документооборота</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_3" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>4. Подключение к оператору электронного документооборота</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_4" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>5. Первичное приобретение кодов маркировки</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_5" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>6. Приобретение квалифицированной электронной подписи</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_6" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>7. Обучение работников, связанное с внедрением системы цифровой маркировки товаров</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_7" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>8. Иное (укажите, что?) <asp:TextBox ID="TextBoxA7_8_dr" Width="100" runat="server"></asp:TextBox></asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA7_8" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button8" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A7" CommandName="Panel6" CommandArgument="7" onclick="QAC_A7" />
                          
                            </asp:Panel>
                              



                           

                              <asp:Panel ID="Panel6" runat="server"  Visible="false" CssClass="1">
                                 Вопрос 8. Оцените <b><u>в рублях</u></b> суммарные финансовые затраты <b><u>на внедрение системы</u></b> обязательной цифровой маркировки товаров. 
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ СЛОВО В СЛОВО КАК ОТВЕТИТ РЕСПОНДЕНТ</div>
                                 <br/> 
                                 <asp:TextBox ID="TextBoxA8" Width="400" runat="server"></asp:TextBox>  человек
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="A8"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA8" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                               
                                <br/> 
                                 <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button20" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A8"  CommandName="Panel7" CommandArgument="8"  onclick="QAC_TextBox" />

                            </asp:Panel>
                              

                             

                              <asp:Panel ID="Panel7" runat="server"  Visible="false" CssClass="1">
                                  Вопрос 9. Оцените <b><u>в процентах</u></b> от годового оборота Вашей компании долю затрат на <b><u>внедрение системы</u></b> обязательной цифровой маркировки товаров 
                                 <div class="comment"></div>
                                 <br/> 
                                   <asp:TextBox ID="TextBoxA9" Width="400" runat="server"></asp:TextBox>  человек
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ValidationGroup="A9"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA9" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                               
                                <br/> 
                                 <asp:Button ID="Button9" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button17" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A9"  CommandName="Panel8" CommandArgument="9"  onclick="QAC_TextBox_A9" />

                            </asp:Panel>


                             
                             
                            <asp:Panel ID="Panel8" runat="server"  Visible="false"> 
                                Вопрос 10. Ранее Вы сказали, что у вас процесс внедрения маркировки по некоторым товарам завершен. На этапе <b><u>обеспечения работы системы</u></b> цифровой маркировки товаров, какой ПРИМЕРНО процент от годового оборота Вашей компании составляет…? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ. МОЖНО УКАЗАТЬ ДИАПАЗОН ПРОЦЕНТОВ</div>
                                  <asp:Table ID="TableA10" BorderWidth="1" GridLines="Both" runat="server" >
                                    <asp:TableRow>
                                        <asp:TableCell>1. Приобретение кодов маркировки </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA10_1" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>2. Услуги оператора электронного документооборота</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA10_2" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>3. Услуги оператора фискальных данных</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA10_3" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>4. Иное (что?)  <asp:TextBox ID="TextBoxA10_4_dr" Width="100" runat="server"></asp:TextBox></asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA10_4" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button21" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button22" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A10" CommandName="Panel10" CommandArgument="10" onclick="QAC_A10" />
                          
                            </asp:Panel>

                              
                             
                             
                            <asp:Panel ID="Panel10" runat="server"  OnPreRender="Panel10_PreRender"   Visible="false"> 
                              Вопрос 11. Оцените <b><u>в рублях</u></b> суммарные финансовые затраты <b><u>на обеспечение работы</u></b> системы обязательной цифровой маркировки товаров (без учета затрат на этапе внедрения системы обязательной цифровой маркировки товаров).  
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ СЛОВО В СЛОВО КАК ОТВЕТИТ РЕСПОНДЕНТ</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="A11"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button48" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button49" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11"  CommandName="Panel14" CommandArgument="11"  onclick="QAC_TextBox" />
                            </asp:Panel>


                             
                               
                             
                             
                            <asp:Panel ID="Panel14" runat="server" OnPreRender="Panel14_PreRender"  Visible="false"> 
                                Вопрос 12. Оцените <b><u>в процентах</u></b> от годового оборота Вашей компании долю затрат <b><u>на обеспечение работы</u></b> системы обязательной цифровой маркировки товаров (без учета затрат на этапе внедрения системы обязательной цифровой маркировки товаров).  
                                <div class="comment"></div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA12" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="A12"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA12" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button61" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button63" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A12"  CommandName="Panel17" CommandArgument="12"  onclick="QAC_TextBox" />
                            </asp:Panel>

                      

                             
                              <asp:Panel ID="Panel17" runat="server"  Visible="false">  
                                 Вопрос 13. С какими затруднениями, помимо финансовых затрат, Ваша компания столкнулась при внедрении системы обязательной цифровой маркировки товаров? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ ПОДРОБНО СО СЛОВ РЕСПОНДЕНТА</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA13" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="A13"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA13" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                 <asp:Button CommandName="Panel19" CommandArgument="99" ToolTip="13" onclick="QAC_Button" Text="Помимо финансовых затрат, прочих затруднений не было" CssClass="green unibutton  big2" Width="600"  ID="Button23"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button28" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button30" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A13"  CommandName="Panel19" CommandArgument="13"  onclick="QAC_TextBox" />
   
                            </asp:Panel>
                              
                        
                             
                            <asp:Panel ID="Panel19" runat="server"  Visible="false"> 
                                Вопрос 14. Оцените, как изменилась стоимость продукции из-за внедрения системы маркировки?
                                 <div class="comment">Респондент отвечает на вопрос по тем видам товарам, по которым на вопрос 1 ответил «да». 
                                  <br/>    ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ. ОДИН ОТВЕТ
                                 </div>
                                    <asp:Table ID="TableA14" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA14_PreRender">
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Товары</asp:TableHeaderCell>
                                            <asp:TableHeaderCell>Если «Повысилась» или «Понизилась», то «Укажите, на сколько?»(указать примерный % или диапазон процентов)</asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табак</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA14_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_1" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA14_2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>         
                                             <asp:TextBox ID="TextBoxA14_2" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_3" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. верхняя одежда (мужская и женская, кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_4" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_5" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_6" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_6" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_7" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>        
                                             <asp:TextBox ID="TextBoxA14_7" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_8" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>       
                                             <asp:TextBox ID="TextBoxA14_8" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_9" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_9" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_10" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA14_10" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button25" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button26" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A14" CommandName="Panel21" CommandArgument="14" onclick="QAC_A14" />
                       
                            </asp:Panel>

                                   
                               
                              <asp:Panel ID="Panel21" runat="server"  Visible="false">  
                                Вопрос 15. Какие <b><u>положительные</u></b> эффекты для Вашего предприятия может принести (или уже принесло) внедрение системы маркировки товаров? 
                                <div class="comment"> 
                                   ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ
                                </div>
                                <br/>
                                  <asp:Table ID="TableA15" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Положительный эффект</asp:TableHeaderCell>
                                            <asp:TableHeaderCell>Если «Да», то «Укажите, какой положительный эффект в виде доли в процентах от годового оборота компании?» (указать примерный % или диапазон процентов)</asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Повышение спроса на продукцию из-за повышения доверия к качеству продукции, снижения доли нелегальной продукции на рынке</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA15_1" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Повышение качества планирования и учета запасов продукции за счет повышения доступности данных о продукции</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA15_2" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Снижение затрат, связанных с ошибками персонала при сборке заказов клиента или подготовке сопроводительной документации</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA15_3" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. Экономия на операционных затратах в логистике за счет более эффективной обработки грузов, предполагающей сканирование кодов маркировки</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA15_4" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. Иные положительные эффекты (указать, какие. <asp:TextBox ID="TextBoxA15_5_dr" Width="400" Visible="false" runat="server"></asp:TextBox> </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBoxA15_5" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button31" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button32" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A15" CommandName="Panel22" CommandArgument="15" onclick="QAC_A15" />
                       
                            </asp:Panel>

                            <asp:Panel ID="Panel22" runat="server"  Visible="false"> 
                                Вопрос 16. Какие <b><u>отрицательные</u></b> эффекты для Вашего предприятия может принести (или уже принесло) внедрение системы маркировки товаров? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ</div>
                                      <asp:Table ID="TableA16" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Отрицательный эффект</asp:TableHeaderCell>
                                            <asp:TableHeaderCell>Если «Да», то «Укажите, какой отрицательный эффект в виде доли в процентах от годового оборота компании?» (указать примерный % или диапазон процентов)</asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Повышение спроса на продукцию из-за повышения доверия к качеству продукции, снижения доли нелегальной продукции на рынке</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonList1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBox1" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Повышение качества планирования и учета запасов продукции за счет повышения доступности данных о продукции</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonList2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBox2" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Снижение затрат, связанных с ошибками персонала при сборке заказов клиента или подготовке сопроводительной документации</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonList3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBox3" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. Экономия на операционных затратах в логистике за счет более эффективной обработки грузов, предполагающей сканирование кодов маркировки</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonList4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBox4" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. Иные положительные эффекты (указать, какие. <asp:TextBox ID="TextBox5" Width="400" Visible="false" runat="server"></asp:TextBox> </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonList5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                             <asp:TextBox ID="TextBox6" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button33" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button34" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A15" CommandName="Panel22" CommandArgument="15" onclick="QAC_A15" />
                       
                            </asp:Panel>
                             

                            <asp:Panel ID="Panel23" runat="server"  Visible="false"> 
                                17. Тел. организации <br/> 
                                 <asp:TextBox ID="TextBoxA17" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="A17"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA17" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button110" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button114" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A17"  CommandName="Panel24" CommandArgument="17"  onclick="QAC_TextBox" />
                            </asp:Panel>
                              
                             

                            <asp:Panel ID="Panel24" runat="server"  Visible="false"> 
                                18. ФИО респондента  <br/> 
                                 <asp:TextBox ID="TextBoxA18" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ValidationGroup="A18"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA18" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button115" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button116" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A18"  CommandName="Panel25" CommandArgument="18"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                              <asp:Panel ID="Panel25" runat="server"  Visible="false">  
                                 Согласны ли Вы на обработку сообщённых Вами персональных данных путём хранения, систематизации, обезличивания и передачи заказчику исследования только для контроля качества исследования и только на срок, необходимый для такого контроля?
                                <div class="comment"> 
                                 ИНТЕРВЬЮЕР! Если респонденты будут смущаться, недопонимать - объяснить, что речь идет о том, чтобы передать телефонный номер, по которому звонили, только с целью контроля, что это интервью было действительно проведено, это стандартная процедура при любых подобных опросах. 
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel13" CommandArgument="1" ToolTip="19" onclick="QAC_Button" Text="да" CssClass="green unibutton  big2" Width="600"  ID="Button117"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel13" CommandArgument="2" ToolTip="19" onclick="QAC_Button" Text="нет" CssClass="green unibutton  big2" Width="600"  ID="Button119"  runat="server" /><br/> 
                                   
                                <br/>
                                <asp:Button ID="Button120" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                             
                            <asp:Panel ID="Panel13" runat="server"  Visible="false"> 
                                 <br/> 
                                «<asp:Label ID="Label5" CssClass="fio" runat="server" Text=""></asp:Label>», благодарим Вас за потраченное время. Все Ваши ответы очень важны для нас. До свидания! 
                                <br/> 
                                 <asp:Button ID="Button29" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                              
                            </asp:Panel> 
                              
                                               
                             
                            <asp:Panel ID="Panel54" runat="server"  Visible="false">
                               <div class="comment">ЗАВЕРШИТЬ АНКЕТИРОВАНИЕ</div>
                                <br/>
                                <asp:Button ID="Button95" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             

                             
                             

                         </ContentTemplate>
                        <Triggers>
            <asp:AsyncPostBackTrigger ControlID ="Button18"  EventName ="Click" /> 
       </Triggers>
                             </asp:UpdatePanel>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                        AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <span style="font-weight:bold; color:Red;">Обработка информации ...</span>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </ContentTemplate>
            </asp:TabPanel>


            <asp:TabPanel runat="server" Visible="false" HeaderText="Реакции на фразы собеседника " ID="TabPanel2">
                <ContentTemplate>

                    <b>[Это Вам не ко мне / Поговорите с … / Я не смогу Вам помочь]</b>
                    <br/>Утоните, пожалуйста, с кем мы можем связаться, чтобы пригласить Ваших коллег на выставку и конгресс?
                    <br/>Зафиксировать телефон, имя и отчество, изменить контактные данные в базе, связаться
                    <br/><br/>
                    <b>[Не посещаем выставки]</b>
                    <br/>«<asp:Label ID="Label40"    CssClass="fio" runat="server" Text=""></asp:Label>», мы просто вышлем Вам информацию о выставке – это Вас ни к чему не обязывает. Мы уверены, Вы сами убедитесь в том, что это мероприятие позволит Вам улучшить свою работу и развивать свой бизнес. Эту выставку можно воспринимать, как большой учебный центр – там вас ждет очень много новой информации и практик.
                    <br/><br/>
                    <b>[Это не наш профиль / Мы не занимаемся косметикой]</b>
                    <br/>«<asp:Label ID="Label41"    CssClass="fio" runat="server" Text=""></asp:Label>», мы просто вышлем Вам информацию о выставке – это Вас ни к чему не обязывает. Это мероприятие объединяет многие сферы, так или иначе связанные с индустрией красоты. Мы уверены, Вы убедитесь в том Вы и Ваша компания сможете улучшить свою работу и найти идеи по развитию своего бизнеса.
                    <br/><br/>
                    <b>[Не могу в этот день]</b>
                    <br/>«<asp:Label ID="Label42"    CssClass="fio" runat="server" Text=""></asp:Label>», обратите, пожалуйста, внимание на то, что выставка пройдет в течение трех дней – с 25 по 27 апреля. Может быть, Вы сможете посетить ее в один из дней. Поверьте, это время пройдет полезно!
                    <br/><br/>
                    <b>[Были на выставке, не понравилось / Были, ничего нового / Были, потратили время]</b>
                    <br/>«<asp:Label ID="Label43"    CssClass="fio" runat="server" Text=""></asp:Label>», 
                    обратите внимание на то, что треть компаний на Интершарм ранее не выставлялись на выставке, а на каждом втором стенде традиционно многочисленные новинки. 
                    В рамках выставки пройдет большое число образовательных мероприятий и мастер-классов, многие из них пройдут впервые.  Это юбилейная выставка Интершарм и она не похожа ни на одну другую. С каждым годом приумножает свои масштабы новых компаний, продуктов и мероприятий. Весь каталог компаний, а также программу мероприятий вы можете посмотреть на нашем сайте интерчАрм точка ру.

                    <br/><br/>                    
                    
                    
                    <b>[Сколько стоит билет и где его купить?]</b>
                    <br/>«<asp:Label ID="Label40_1"    CssClass="fio" runat="server" Text=""></asp:Label>», Билет на выставку категории <b style="background-color: yellow;">СТАНДАРТ</b> в дни выставки будет стоить 900 рублей. По нему можно посетить выставку в один любой день ее работы, а также мастер-классы на стендах по условиям которых не нужна дополнительная регистрация/оплата.
                    <br/><b style="background-color: yellow;">Но!</b> Сейчас на сайте выставки «интерЧАрм ру» билеты можно приобрести со значительной скидкой за 545 руб.
                    <br/><br/>
                    
                    
                    <b>[Вы звонили в прошлый раз, обещали скидку, но так ничего на электронный адрес не пришло]</b>
                    <br/>«<asp:Label ID="Label40_2"    CssClass="fio" runat="server" Text=""></asp:Label>», очень жаль, что так вышло! Давайте сверим электронный адрес – может быть в нем была ошибка. <… фрагмент из сценария… > Важный момент – при покупке билета на сайте выставки «интерЧАрм ру» до 24 апреля вы можете купить билет со скидкой за 545 рублей , вместо 900 рублей в дни выставки.
                    <br/><br/>
                    
                    
                    <b>[Большая очередь на вход с билетами с сайта]</b>
                    <br/>«<asp:Label ID="Label40_3"    CssClass="fio" runat="server" Text=""></asp:Label>», спасибо вам за комментарий. Мы понимаем, о чем вы говорите. Выставка очень
                    популярна среди профессионалов и поклонников бьюти-индустрии. Мы с каждым годом работаем над тем,
                    чтобы никто из наших гостей не проводил время в ожидании. В минуты максимального потока мы
                    направляем все наши ресурсы на то, чтобы ускорить процесс. Мы действительно работаем над этим, «<asp:Label ID="Label40_4"    CssClass="fio" runat="server" Text=""></asp:Label>»!
                    <br/><br/> 
                    
                    
                    
                    </ContentTemplate>
                </asp:TabPanel>


            <asp:TabPanel runat="server" Visible="false" HeaderText="Информация" ID="TabPanel3">
                <ContentTemplate>
                        <p><strong><em>Произношение бренда: &laquo;интершАрм профЭшнл&raquo; - название выставки нужно ВСЕГДА произносить целиком, поскольку &laquo;Интершарм&raquo; (без дополнений) &ndash; это название осенней выставки в Москве, &laquo;Интершарм профешнл&raquo; (без города) &ndash; это название весенней выставки в Москве. ЭТО ВАЖНО!</em></strong></p>

<p>&nbsp;</p>

<p><strong>Что надо знать всем операторам</strong>:</p>

<ol>
	<li>Всего 2 вида сценария: скрипт для баз, предоставленных Заказчиком и скрипт для баз УИЛЛСТРИМ</li>
	<li>Для каждого профиля потенциального посетителя (профессия/должность) есть определенное целевое сообщение в сценарии</li>
</ol>

<p style="margin-left:36.0pt;">&nbsp;</p>

<ol>
	<li value="3">Выставки Интершарм в 2018 году пройдут дважды: два раза в Москве, весной и осенью</li>
	<li>Все выставки разные! Это не одна и та же выставка, которая проходит несколько раз в год. Выставка в октябре в Москве объединяет все сегменты рынка парфюмерии и косметики, в апреле в Москве &ndash; только профессионалов индустрии красоты (салоны и мастера)</li>
	<li>Дополнительная информация: по выставкам в Москве: <a href="http://www.intercharm.ru/">www.intercharm.ru</a> (интерЧАрм точка ру), (интерЧАрм эс пэ бэ точка ру &ndash; это нужно четко произносить, чтобы люди не шли на сайт московских выставок)</li>
	<li><strong>НОВЫЕ КАТЕГОРИИ БИЛЕТОВ:</strong></li>
</ol>

<p style="margin-left:35.45pt;">БИЛЕТ &laquo;STANDARD 1&raquo; (билет на 1 день)</p>

<p style="margin-left:35.45pt;">Дает право посетить 1 любой день работы выставки: стенды и мастер-классы на них, а также мероприятия, по условиям которых не нужна дополнительная регистрация/оплата</p>

<p style="margin-left:35.45pt;">Цена до 24 апреля 2018 - 545 руб.</p>

<p style="margin-left:35.45pt;">В продаже есть еще категория билетов &laquo;КОНГРЕСС&raquo;, о них подробнее на сайте. Обо всех&nbsp; деталях можно узнать на сайте <a href="http://www.intercharm.ru/">www.intercharm.ru</a></p>

<p style="margin-left:35.45pt;">&nbsp;</p>

<ol>
	<li value="7">Выставка проходит в современном выставочном комплексе Крокус Экспо, г. Москва. Ближайшая станция метро &laquo;Мякинино&raquo;. Схема проезда доступна на сайте <a href="http://www.intercharm.ru/">www.intercharm.ru</a>. Даты проведения выставки: 25-27 апреля 2018 г.</li>
	<li>Информация тем, кто не получил до звонка письмо по электронной почте, будет рассылаться не ежедневно, а по итогам каждой недели (то есть в течение нескольких дней с момента звонка)</li>
	<li><strong>Буклетов на скидку в этом году нет (и этого уже нет два года и не будет!)</strong></li>
	<li>В этом проекте нам КРАЙНЕ ВАЖЕН каждый человек. Весь разговор должен быть спокойным и четким, а также ориентирован на каждый профиль посетителя</li>
	<li><strong>Профили посетителей, в соответствии с которыми определенный ответ по сценарию:</strong><br />
	-Руководитель/владелец/администратор салона красоты, клиники или мед учреждения</li>
</ol>

<p style="margin-left:36.0pt;">-Ногтевой мастер</p>

<p style="margin-left:36.0pt;">-Парикмахер/стилист</p>

<p style="margin-left:36.0pt;">-Косметолог</p>

<p style="margin-left:36.0pt;">-Врач</p>

<p style="margin-left:36.0pt;">-Визажист</p>

<p style="margin-left:36.0pt;">-Массажист</p>

<p style="margin-left:36.0pt;">-Общее (все остальные)</p>

<p style="margin-left:36.0pt;">&nbsp;</p>

<ol>
	<li value="12"><strong>100% звонков должны содержать: многократное обращение к посетителю по имени, верное и четкое название и даты выставки, интернет-сайт </strong><strong>intercharm</strong><strong>.</strong><strong>ru</strong><strong> (интерЧАрм точка ру) и УЛЫБКУ! Исключение составляют только ошибочные звонки, но даже там мы улыбаемся </strong></li>
</ol>

<div>
<p>&nbsp;</p>
</div>

<p>&nbsp;</p>

<p><em>Дополнительная справочная информация о том, что представлено на выставке:</em></p>

<p>&nbsp;</p>

<p><strong>Косметика</strong></p>

<ul>
	<li>Детская косметика</li>
	<li>Космецевтика</li>
	<li>Лечебная косметика</li>
	<li>Мужская косметика</li>
	<li>Натуральная и органическая косметика</li>
	<li>Парафармацевтика и БАДы</li>
	<li>Средства личной гигиены</li>
	<li>Средства по уходу за кожей</li>
</ul>

<p><strong>Косметология</strong></p>

<ul>
	<li>Аппаратная косметология</li>
	<li>Ароматерапия</li>
	<li>Дизайн бровей</li>
	<li>Инъекции</li>
	<li>Косметика anti-age</li>
	<li>Косметика по уходу за лицом и телом</li>
	<li>Лазерная косметология</li>
	<li>Мезонити</li>
	<li>Перманентный макияж (пигменты, инструменты)</li>
	<li>Пилинги</li>
	<li>Пирсинг (инструменты,&nbsp; аксессуары)</li>
	<li>Подология</li>
	<li>Продукция для соляриев</li>
	<li>Средства и расходники для депиляции</li>
	<li>Трихология (косметика, препараты, оборудование)</li>
</ul>

<p><strong>Продукция для салонов красоты </strong></p>

<ul>
	<li>Мебель для салонов и институтов красоты и спа</li>
	<li>Оборудование для салонов и институтов красоты и спа</li>
</ul>

<p><strong>Ногтевой сервис</strong></p>

<ul>
	<li>Продукция для маникюра, педикюра и ухода за ногтями</li>
	<li>Инструменты и оборудование для ногтевого сервиса</li>
</ul>

<p><strong>Парикмахерское искусство</strong></p>

<ul>
	<li>Средства для окрашивания волос</li>
	<li>Средства по уходу за волосами</li>
	<li>Волосы для наращивания, парики</li>
	<li>Инструменты и аксессуары для парикмахеров</li>
	<li>Оборудование для парикмахерских</li>
	<li>Ресницы для наращивания</li>
</ul>

<p><strong>Декоративная косметика</strong></p>

<ul>
	<li>Професиональная декоративная косметика</li>
	<li>Мобильные студии для визажистов</li>
	<li>Кейсы и сумки для визажистов</li>
</ul>

<p><strong>А также:</strong></p>

<ul>
	<li>Дезинфицирующие средства</li>
	<li>Бьюти-гаджеты для личного использования</li>
	<li>Профессиональная одежда</li>
	<li>Профессиональные аксессуары (спонжи, пуховки, аппликаторы, кисти, расчески)</li>
	<li>Расходные материалы</li>
</ul>

<p>&nbsp;</p>

<p><strong>Подробный каталог всех компаний есть на сайте www.intercharm.ru (интерЧАрм точка ру)</strong></p>

                    </ContentTemplate>
                </asp:TabPanel>

        </asp:TabContainer>
    
    </div>
    </form>
</body>
</html>
