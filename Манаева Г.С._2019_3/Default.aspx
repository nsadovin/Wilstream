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
                                Добрый день! Меня зовут <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>, я представляю Информационно-консультационный центр «Бизнес-Тезаурус».<br/>
                                Мы проводим социологическое исследование по заказу Минпромторга России по поводу внедрения системы цифровой маркировки товаров. Мы хотели бы задать Вам ряд вопросов об отношении к внедряемой цифровой маркировке и об опыте проверки легальности нахождения товаров в обороте. Интервью займет 5-8 минут Вашего времени.
                                <br/>  
                                <asp:Button ID="Button2" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel1_3"   onclick="standartNext" />
                     
                                
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

                         
                             
                            <asp:Panel ID="Panel1_3" runat="server" Visible="false">
                                Вопрос 1. Знаете ли вы о том, что в России с 2019 года для некоторых товаров вводится обязательная цифровая маркировка – это нанесение производителем цифрового кода на товар, с фиксацией перемещения этого товара до конечного пользователя?
                                <br/> 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать только один вариант ответа.
                                <br/> <br/> 
                                Интервьюер поясните при необходимости, что такое обязательная цифровая маркировка:<br/> 
                                Каждая единица определенных товаров помечается уникальным цифровым кодом на упаковке, по которому можно получить всю информацию о продукте и его движении, от производителя товара до прилавка розничного магазина. Информацию можно получить с помощью мобильного приложения «Честный знак», которое при сканировании цифрового кода выдает всю необходимую информацию. Обязательная маркировка товаров позволяет государству контролировать их оборот и не допускать, чтобы в него попадали подделки, фальсификат. 
                                </div>
                                <asp:Button CommandName="Panel28" CommandArgument="1" ToolTip="1" onclick="QAC_Button" Text="Нет, не слышал о таком" CssClass="green unibutton  big2" Width="1200"  ID="Button16"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="2" ToolTip="1" onclick="QAC_Button" Text="Что-то слышал, но не знаю группы товаров, для которых вводится маркировка" CssClass="green unibutton  big2" Width="1200"  ID="Button60"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="3" ToolTip="1" onclick="QAC_Button" Text="Знаю о системе маркировки, знаю группы товаров, для которых вводится маркировка, но не использую маркировку для проверки подлинности этих товаров" CssClass="green unibutton  big2" Width="1200"  ID="Button65"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="4" ToolTip="1" onclick="QAC_Button"  Text="У меня есть мобильное приложение «Честный знак» для проверки подлинности маркированных товаров.Т.е. я знаю о системе маркировки, знаю группы товаров,
                                    для которых вводится маркировка, и знаю, как проверять подлинность" style="white-space: pre-line;text-align: left;" CssClass="green unibutton  big2" Width="1200"  ID="Button70"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel40" CommandArgument="5" ToolTip="1" onclick="QAC_Button" Text="Другое" CssClass="green unibutton  big2" Width="1200"  ID="Button71"  runat="server" /><br/> 
                                <asp:HiddenField ID="HiddenFieldA1" runat="server" />
                                <br/>
                                <asp:Button ID="Button72" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                           

                             
                            <asp:Panel ID="Panel40" runat="server"  Visible="false">
                                 <div class="comment">(что именно, запишите?) </div>
                                 <br/> 
                                 <asp:TextBox ID="TextBoxA1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="A1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                                <br/> 
                                 <asp:Button ID="Button74" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button75" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A1"  CommandName="Panel28" CommandArgument="101"  onclick="QAC_TextBox" />
                      
                               
                            </asp:Panel>

                           
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false">  
                                 Вопрос 2. Ваш возраст?
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать только один вариант ответа.</div>
                                <asp:Button CommandName="Panel29" CommandArgument="1" ToolTip="2" onclick="QAC_Button" Text="18-34 лет" CssClass="green unibutton  big2" Width="600"  ID="Button3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="2" ToolTip="2" onclick="QAC_Button" Text="35-54 лет" CssClass="green unibutton  big2" Width="600"  ID="Button4"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="3" ToolTip="2" onclick="QAC_Button" Text="55 лет и более" CssClass="green unibutton  big2" Width="600"  ID="Button73"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel3" CommandArgument="4" ToolTip="2" onclick="QAC_Button" Text="Менее 18 лет" CssClass="green unibutton  big2" Width="600"  ID="Button76"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel3" CommandArgument="99" ToolTip="2" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button77"  runat="server" /><br/> 
                              
                                <br/>
                                <asp:Button ID="Button78" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />

                            </asp:Panel> 
                            
                             
                            <asp:HiddenField ID="HiddenFieldShowAll" runat="server" />
                            
                            <asp:Panel ID="Panel29" runat="server" Visible="false">
                                Вопрос 3. ИНТЕРВЬЮЕР, ОТМЕТЬТЕ ПОЛ РЕСПОНДНТА (пол?)
                                <div class="comment">Респондент может выбрать только один вариант ответа.</div>
                                <asp:Button CommandName="Panel2_4" CommandArgument="1" ToolTip="3" onclick="QAC_Button" Text="Мужской" CssClass="green unibutton  big2" Width="600"  ID="Button11"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_4" CommandArgument="2" ToolTip="3" onclick="QAC_Button" Text="Женский" CssClass="green unibutton  big2" Width="600"  ID="Button12"  runat="server" /><br/> 
                              
                                <br/>
                                <asp:Button ID="Button132" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
        
                            </asp:Panel> 


                              <asp:Panel ID="Panel2_4" runat="server"  Visible="false" CssClass="1">
                                 Вопрос 4. Ваше образование?
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel42" CommandArgument="1" ToolTip="4" onclick="QAC_Button" Text="Среднее" CssClass="green unibutton  big2" Width="600"  ID="Button15"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel42" CommandArgument="2" ToolTip="4" onclick="QAC_Button" Text="Неоконченное высшее" CssClass="green unibutton  big2" Width="600"  ID="Button123"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel42" CommandArgument="3" ToolTip="4" onclick="QAC_Button" Text="Высшее" CssClass="green unibutton  big2" Width="600"  ID="Button124"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel2" CommandArgument="4" ToolTip="4" onclick="QAC_Button" Text="Иное" CssClass="green unibutton  big2" Width="600"  ID="Button125"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel42" CommandArgument="99" ToolTip="4" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button14"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button128" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
        
                            </asp:Panel>
                              
                             
                            <asp:Panel ID="Panel2" runat="server"  Visible="false"> 
                                 <div class="comment">(что именно, запишите?)</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA4" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="A4"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button27" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button122" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4"  CommandName="Panel42" CommandArgument="401"  onclick="QAC_TextBox" />
                            </asp:Panel> 


                             
                             
                            <asp:Panel ID="Panel27" runat="server" Visible="false"> 
                                В какое время, Вам было бы удобней, что бы мы перезвонили?
                                <div class="comment">– зафиксировать –</div> Спасибо! Мы свяжемся с Вами!
                                <br />
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             

                              
                                    

                              
                              

                             
                            <asp:Panel ID="Panel42" runat="server" Visible="false">  
                                  Вопрос 5. Вы работаете?
                                 <div class="comment">Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel55" CommandArgument="1" ToolTip="5" onclick="QAC_Button" Text="Да (в том числе считается частичная занятость, самозанятость, работа без оформления и т.д.)" CssClass="green unibutton  big2" Width="900"  ID="Button5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55" CommandArgument="2" ToolTip="5" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="900"  ID="Button13"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55" CommandArgument="99" ToolTip="5" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="900"  ID="Button62"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button64" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 

                            </asp:Panel> 
 
                              
                             
                             

                            
                            
                            <asp:Panel ID="Panel33" runat="server" Visible="false"> 
                                Всего доброго, до свидания! <br />
                                <asp:Button ID="Button35" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                              

                            <asp:Panel ID="Panel32" runat="server" Visible="false"> 
                                зафиксировать новый номер - перезвонить<br />
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
                                Вопрос 6. Оцените уровень дохода Вашей семьи.
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel4" CommandArgument="1" ToolTip="6" onclick="QAC_Button" Text="Денег не хватает даже на продукты" CssClass="green unibutton  big2" Width="1100"  ID="Button6"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="2" ToolTip="6" onclick="QAC_Button" Text="На продукты денег хватает, но покупка одежды вызывает финансовые затруднения" CssClass="green unibutton  big2" Width="1100"  ID="Button66"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="3" ToolTip="6" onclick="QAC_Button" Text="Денег хватает на продукты и на одежду, но вот покупка вещей длительного пользования является проблемой" CssClass="green unibutton  big2" Width="1100"  ID="Button67"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="4" ToolTip="6" onclick="QAC_Button" Text="Я могу без труда приобретать вещи длительного пользования. Однако для меня затруднительно приобретать действительно дорогие вещи" CssClass="green unibutton  big2" Width="1100"  ID="Button68"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="5" ToolTip="6" onclick="QAC_Button" Text="Я могу позволить себе достаточно дорогостоящие вещи — квартиру, дачу и многое другое" CssClass="green unibutton  big2" Width="1100"  ID="Button10"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="99" ToolTip="6" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="1100"  ID="Button18"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button24" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 

                            </asp:Panel>

                              
                             
                            <asp:Panel ID="Panel4" runat="server"  Visible="false"> 
                                Вопрос 7. Сейчас я зачитаю Вам некоторые категории товаров. Опишите Ваше отношение к возможности покупки в каждой из данных категорий контрафактной продукции (другими словами, поддельной, фальсифицированной продукции).
                                <div class="comment">Интервьюер может пояснить при необходимости:
                                <br/>Контрафакт – подделка под известный бренд, то есть незаконное использование чужого товарного знака. Синонимы: подделка, фальсификат
                                <br/>Респондент по каждой категории должен выбрать один вариант ответа.
                                </div>
                                 <asp:Table ID="TableA7" BorderWidth="1" GridLines="Both" runat="server" >
                                     <asp:TableHeaderRow>
                                         <asp:TableHeaderCell Width="400">
                                             Вид товара
                                         </asp:TableHeaderCell>
                                         <asp:TableHeaderCell> 
                                         </asp:TableHeaderCell>
                                     </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табачные изделия (любые)</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_1" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_2" AutoPostBack="true" runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_3" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>4. мужская и женская верхняя одежда (кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_4" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_5" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_6" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_7" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_8" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_9" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_10" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_11" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Не готов ни в коем случае покупать контрафакт</asp:ListItem>
                                                <asp:ListItem Value="2">Готов покупать контрафакт, если кажется привлекательной цена и (или) качество</asp:ListItem>
                                                <asp:ListItem Value="3">Преимущественно предпочитаю контрафактную продукцию из-за ее цены</asp:ListItem>
                                                <asp:ListItem Value="98">Не покупаю данную категорию товаров</asp:ListItem>
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                        
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                 </asp:Table>
                                   <br />
                                 <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button8" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A7" CommandName="Panel6" CommandArgument="7" onclick="QAC_A7" />
                          
                            </asp:Panel>
                              



                           

                              <asp:Panel ID="Panel6" runat="server"  Visible="false" CssClass="1">
                                 Вопрос 8. Вы умеете отличать контрафактную продукцию от остальной? 
                                 <div class="comment">Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel7" CommandArgument="1" ToolTip="8" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button19"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel7" CommandArgument="2" ToolTip="8" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button47"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel7" CommandArgument="3" ToolTip="8" onclick="QAC_Button" Text="В ряде случаев смогу отличить (не всегда)" CssClass="green unibutton  big2" Width="600"  ID="Button50"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel7" CommandArgument="99" ToolTip="8" onclick="QAC_Button" Text="(не зачитывать) Нет ответа" CssClass="green unibutton  big2" Width="600"  ID="Button20"  runat="server" /><br/> 
                                  
                                <br/>
                                <asp:Button ID="Button82" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 


                            </asp:Panel>
                              

                             

                              <asp:Panel ID="Panel7" runat="server"  Visible="false" CssClass="1">
                                  Вопрос 9. Если говорить о самой идее внедрения системы обязательной цифровой маркировки. Являются ли следующие высказывания плюсами лично для Вас? 
                                  <br/>Оцените их значимость, где 1 – совершенно не значимо, 2 – нейтрально, 3 – весьма значимо.  
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент по каждой категории должен выбрать один вариант ответа.</div>
                                     <asp:Table ID="TableA9" BorderWidth="1" GridLines="Both" runat="server">
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell Width="400">Ответ</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Возможность оперативной проверки гражданами информации о производителе, составе и сроке годности</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA9_1" runat="server">
                                                <asp:ListItem Value="1">совершенно не значимо</asp:ListItem>
                                                <asp:ListItem Value="2">нейтрально</asp:ListItem>
                                                <asp:ListItem Value="3">весьма значимо</asp:ListItem>
                                                <asp:ListItem Value="99">затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>    
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>2. Возможность оперативного сообщения гражданами о выявленном нарушении качества с помощью использования системы маркировки продукции</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA9_2" runat="server">
                                                <asp:ListItem Value="1">совершенно не значимо</asp:ListItem>
                                                <asp:ListItem Value="2">нейтрально</asp:ListItem>
                                                <asp:ListItem Value="3">весьма значимо</asp:ListItem>
                                                <asp:ListItem Value="99">затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>    
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>3. Общее снижение доли незаконного оборота продукции на рынке</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA9_3" runat="server">
                                                <asp:ListItem Value="1">совершенно не значимо</asp:ListItem>
                                                <asp:ListItem Value="2">нейтрально</asp:ListItem>
                                                <asp:ListItem Value="3">весьма значимо</asp:ListItem>
                                                <asp:ListItem Value="99">затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>    
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button9" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button17" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A9" CommandName="Panel26" CommandArgument="9" onclick="QAC_A9" />
                       
                            </asp:Panel>

                             
                             
                              <asp:Panel ID="Panel26" runat="server"  Visible="false">  
                                 Вопрос 9а. Какие, на Ваш взгляд, еще плюсы от внедрения системы обязательной цифровой маркировки помимо вышеназванных?
                                <div class="comment"></div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA9a" Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Enabled="false" ValidationGroup="A9a"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA9a" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                 <asp:Button CommandName="Panel8" CommandArgument="98" ToolTip="999" onclick="QAC_Button" Text="Других плюсов, помимо вышеназванных я не вижу" CssClass="green unibutton  big2" Width="600"  ID="Button81"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel8" CommandArgument="99" ToolTip="999" onclick="QAC_Button" Text="Затрудняюсь ответить" CssClass="green unibutton  big2" Width="600"  ID="Button69"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button79" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button80" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A9a"  CommandName="Panel8" CommandArgument="999"  onclick="QAC_TextBox" />
   
                            </asp:Panel>
                              
                        
                             
                             
                            <asp:Panel ID="Panel8" runat="server"  Visible="false"> 
                                Вопрос 10. Внедрение обязательной цифровой маркировки может <b><u>повлечь за собой повышение цен на продукцию</u></b> из-за дополнительных затрат компаний на внедрение системы цифровой маркировки. 
                                <br/>Скажите, увеличение цены <b>на сколько процентов</b> приемлемо лично для Вас?
                                <br/>(с учетом положительных эффектов от введения системы обязательной цифровой маркировки) <br/>
                                 Ответ (в %)  <asp:TextBox ID="TextBoxA10" Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="A10" Enabled="false"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA10" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button21" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button22" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A10"  CommandName="Panel10" CommandArgument="10"  onclick="QAC_TextBox" />
     
                            </asp:Panel>

                              
                             
                             
                            <asp:Panel ID="Panel10" runat="server"     Visible="false"> 
                              Вопрос 11. С учетом положительных и отрицательных эффектов, охарактеризуйте, как Вы в целом относитесь к внедрению системы обязательной цифровой маркировки товаров для следующих групп товаров?
                               <div class="comment">Респондент по каждой категории должен выбрать один вариант ответа.</div>
                               <asp:Table ID="TableA11" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell Width="400">Вид товара</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табачные изделия</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA11_1" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA11_2" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_3" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. мужская и женская верхняя одежда (кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_4" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_5" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_6" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_7" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_8" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_9" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_10" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA11_11" runat="server">
                                                <asp:ListItem Value="1">1. Определенно положительно</asp:ListItem>
                                                <asp:ListItem Value="2">2. Скорее положительно</asp:ListItem>
                                                <asp:ListItem Value="3">3. Скорее отрицательно</asp:ListItem>
                                                <asp:ListItem Value="4">4. Определенно отрицательно</asp:ListItem>
                                                <asp:ListItem Value="99">99. Нет ответа / затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button48" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button49" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A11" CommandName="Panel14" CommandArgument="11" onclick="QAC_A11" />
                       
                            </asp:Panel>


                             
                               
                             
                             
                            <asp:Panel ID="Panel14" runat="server"   Visible="false"> 
                                Вопрос 12. На текущий момент обязательная цифровая маркировка введена для следующих категорий: <b>табачная продукция, шубы, обувь и лекарственные средства</b>. 
                                <br/> Скажите, что из перечисленного Вы приобретали в 2019 году?

                                <div class="comment">Респондент по каждой категории должен выбрать один вариант ответа.</div>
                              <asp:Table ID="TableA12" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Вид товара</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табачные изделия</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA12_1" runat="server">
                                                <asp:ListItem Value="1">1. Да, приобретал в 2019 году</asp:ListItem>
                                                <asp:ListItem Value="2">2. Нет, не приобретал в 2019 году</asp:ListItem> 
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA12_2" runat="server">
                                                <asp:ListItem Value="1">1. Да, приобретал в 2019 году</asp:ListItem>
                                                <asp:ListItem Value="2">2. Нет, не приобретал в 2019 году</asp:ListItem> 
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA12_3" runat="server">
                                                <asp:ListItem Value="1">1. Да, приобретал в 2019 году</asp:ListItem>
                                                <asp:ListItem Value="2">2. Нет, не приобретал в 2019 году</asp:ListItem> 
                                             </asp:RadioButtonList>        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA12_4" runat="server">
                                                <asp:ListItem Value="1">1. Да, приобретал в 2019 году</asp:ListItem>
                                                <asp:ListItem Value="2">2. Нет, не приобретал в 2019 году</asp:ListItem> 
                                             </asp:RadioButtonList>       
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                <asp:Button ID="Button61" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button63" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A12" CommandName="Panel17" CommandArgument="12" onclick="QAC_A12" />
                       
                            </asp:Panel>

                      

                             
                              <asp:Panel ID="Panel17" runat="server"  Visible="false">  
                                 Вопрос 13. Оцените, как повлияло внедрение системы маркировки <b><u>на стоимость</u></b> продукции с начала 2019 года? Цена снизилась, повысилась или осталась без изменений на …
                                <div class="comment">Интервьюер поясните при необходимости смысл вопроса:</div>
                                Нужно сравнить цену на товар вначале 2019 года и сейчас, в конце 2019 года и дать оценку (изменилась ли цена: выросла, или нет?)
                                <div class="comment">Респондент отвечает только по тем товарам, на которые в Вопросе 12 ответил «да».
                                ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ Респондент по каждой категории должен выбрать один вариант ответа.</div>
                                 <asp:Table ID="TableA13" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA13_PreRender" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Вид товара</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табачные изделия</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA13_1" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA13_2" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA13_3" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA13_4" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>       
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                <asp:Button ID="Button23" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button28" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A13" CommandName="Panel19" CommandArgument="13" onclick="QAC_A13" />
                       
                            </asp:Panel>
                              
                        
                             
                            <asp:Panel ID="Panel19" runat="server"  Visible="false"> 
                                Вопрос 14. Оцените, как повлияло внедрение системы маркировки <b><u>на качество</u></b> продукции с начала 2019 года? Качество снизилось, повысилось или осталось без изменений на …
                                 <div class="comment">Интервьюер поясните при необходимости смысл вопроса:</div>
                                Нужно сравнить качество товара вначале 2019 года и сейчас, в конце 2019 года и дать оценку (изменилось ли качество: выросло (улучшилось качество), или нет?)
                                 <div class="comment">Респондент отвечает только по тем товарам, на которые в Вопросе 12 ответил «да».<br/>
                                     ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ Респондент по каждой категории должен выбрать один вариант ответа.</div>
                                   <asp:Table ID="TableA14" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA14_PreRender" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Вид товара</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табачные изделия</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA14_1" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA14_2" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_3" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_4" runat="server">
                                                <asp:ListItem Value="1">1. Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">2. Не изменилась</asp:ListItem> 
                                                <asp:ListItem Value="3">3. Снизилась</asp:ListItem> 
                                                <asp:ListItem Value="99">99. Затрудняюсь ответить / Не могу сравнить</asp:ListItem> 
                                             </asp:RadioButtonList>       
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                <asp:Button ID="Button25" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button26" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A14" CommandName="Panel21" CommandArgument="14" onclick="QAC_A14" />
                       
                            </asp:Panel>

                                   
                               
                              <asp:Panel ID="Panel21" runat="server"  Visible="false">  
                                Вопрос 15. Для каких групп товаров, помимо <b>табачной продукции, шуб, обуви и лекарственных средств</b>, на Ваш взгляд, также целесообразно внедрение системы обязательной цифровой маркировки товаров? Пожалуйста, перечислите эти товары?
                                <div class="comment"> 
                                    ЕСЛИ РЕСПОНДЕНТ НАЗЫВАЕТ ГРУППЫ ТОВАРОМ, ЗАПИШИТЕ С ЕГО СЛОВ И ЗАДАЙТЕ УТОЧНЯЮЩИЙ ВОПРОС:  
                                </div>Поясните, почему именно на них надо ввести цифровую маркировку?<br/>
                                     <asp:TextBox ID="TextBoxA15"  Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Enabled="false" ValidationGroup="A15"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA15" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                 
                             
                                <br/> 
                                 <asp:Button ID="Button31" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button32" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A15"  CommandName="Panel22" CommandArgument="15"  onclick="QAC_TextBox_A15" />
             
                            </asp:Panel>

                            <asp:Panel ID="Panel22" runat="server"  Visible="false"> 
                                Вопрос 16. Ранее Вы сказали, что знаете про мобильное приложение "Честный знак". Скажите, пожалуйста, какие действия вы совершали с помощью этого приложения «Честный знак»?
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать несколько вариантов ответа.</div>
                                  <asp:CheckBoxList ID="CheckBoxListA16"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">Скачали приложение для ознакомления</asp:ListItem> 
                                        <asp:ListItem Value="2">Проверяли информацию о производителе, составе и сроке годности</asp:ListItem> 
                                        <asp:ListItem Value="3">Сообщали о выявленном нарушении</asp:ListItem> 
                                        <asp:ListItem Value="4">Иное (запишите что?) </asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                <asp:TextBox ID="TextBoxA16" Visible="false" runat="server"></asp:TextBox>

                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator18" Enabled="false" runat="server" ValidationGroup="A16" ControlToValidate="TextBoxA16" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                           
                                 
                                    <br/> 
                                <asp:Button ID="Button33" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button34" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A16" CommandName="Panel23" CommandArgument="16" onclick="QAC_CheckBoxList" />
                      
                            </asp:Panel>
                             

                            <asp:Panel ID="Panel23" runat="server"  Visible="false"> 
                                Вопрос 17. Для проверки каких товаров Вы использовали (или собирались использовать) приложение «Честный знак»?
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать несколько вариантов ответа.</div>
                                    <asp:CheckBoxList ID="CheckBoxListA17"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">табачные изделия</asp:ListItem> 
                                        <asp:ListItem Value="2">шубы</asp:ListItem> 
                                        <asp:ListItem Value="3">обувь</asp:ListItem> 
                                        <asp:ListItem Value="4">лекарства</asp:ListItem> 
                                        <asp:ListItem Value="5">Для других товаров (запишите, для каких?)</asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                <asp:TextBox ID="TextBoxA17" Visible="false" runat="server"></asp:TextBox>

                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Enabled="false" runat="server" ValidationGroup="A17" ControlToValidate="TextBoxA17" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                           
                                 
                                    <br/> 
                                <asp:Button ID="Button30" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button36" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A17" CommandName="Panel24" CommandArgument="17" onclick="QAC_CheckBoxList" />
                      
                            </asp:Panel>
                              
                             

                            <asp:Panel ID="Panel24" runat="server"  Visible="false"> 
                                Вопрос 18. Как часто вы используете приложение «Честный знак» в последнее время?
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel25" CommandArgument="1" ToolTip="18" onclick="QAC_Button" Text="Каждый день" CssClass="green unibutton  big2" Width="600"  ID="Button37"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel25" CommandArgument="2" ToolTip="18" onclick="QAC_Button" Text="Несколько раз в неделю" CssClass="green unibutton  big2" Width="600"  ID="Button38"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel25" CommandArgument="3" ToolTip="18" onclick="QAC_Button" Text="Несколько раз в месяц" CssClass="green unibutton  big2" Width="600"  ID="Button83"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel25" CommandArgument="4" ToolTip="18" onclick="QAC_Button" Text="Единичные случаи" CssClass="green unibutton  big2" Width="600"  ID="Button87"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel25" CommandArgument="5" ToolTip="18" onclick="QAC_Button" Text="Не использую" CssClass="green unibutton  big2" Width="600"  ID="Button84"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel25" CommandArgument="99" ToolTip="18" onclick="QAC_Button" Text="Затрудняюсь ответить" CssClass="green unibutton  big2" Width="600"  ID="Button85"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button86" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>

                             
                              <asp:Panel ID="Panel25" runat="server"  Visible="false">  
                                 Вопрос 19. Как вы узнали о системе (мобильном приложении) «Честный знак»?
                                <div class="comment"> 
                                   ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать несколько вариантов ответа.
                                </div>
                                 <asp:CheckBoxList ID="CheckBoxListA19"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">Через Интернет</asp:ListItem> 
                                        <asp:ListItem Value="2">В магазине приложений</asp:ListItem> 
                                        <asp:ListItem Value="3">Из СМИ (телевидение, радио, газеты и т.п.)</asp:ListItem> 
                                        <asp:ListItem Value="4">От знакомых, друзей, родных</asp:ListItem> 
                                        <asp:ListItem Value="5">Иное (запишите, что?) </asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                <asp:TextBox ID="TextBoxA19" Visible="false" runat="server"></asp:TextBox>

                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Enabled="false" runat="server" ValidationGroup="A19" ControlToValidate="TextBoxA19" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                               <br/><asp:Button CommandName="Panel5" CommandArgument="99" ToolTip="19" onclick="QAC_Button" Text="Затрудняюсь ответить" CssClass="red unibutton  big2" Width="500"  ID="Button88"  runat="server" /><br/> 
                  
                                 
                                    <br/> 
                                <asp:Button ID="Button39" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button40" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A19" CommandName="Panel5" CommandArgument="19" onclick="QAC_CheckBoxList" />
                      
                            </asp:Panel>
                             

                            <asp:Panel ID="Panel5" runat="server"  Visible="false"> 
                                Вопрос 20. Какие недостатки системы (мобильного приложения) «Честный знак» Вы можете назвать?
                                <div class="comment"></div>
                                 <asp:TextBox ID="TextBoxA20" Width="800" TextMode="MultiLine" Height="50"  runat="server"></asp:TextBox>   %
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Enabled="false" ValidationGroup="A20"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA20" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                             
                                <br/> 
                                 <asp:Button ID="Button42" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button43" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A20"  CommandName="Panel13" CommandArgument="20"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel9" runat="server"  Visible="false"> 
                                Вопрос 21. Как уже ранее говорилось, обязательная маркировка товаров вводится, чтобы не допускать в продаже подделок и фальсификата. Товар помечается уникальным цифровым кодом на упаковке, а далее, <b>с помощью мобильного приложения «Честный знак»</b>, можно получить всю информацию о продукте и его движении, от производителя товара до прилавка розничного магазина. Кроме этого с помощью данного приложения можно сообщать о выявленном нарушении.
                                <br/> <br/> 
                                1.	Заинтересовала ли вас возможность в будущем использовать «Честный знак» для проверки сведений о производителе, составе и сроке годности?
                                <div class="comment">Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel30" CommandArgument="1" ToolTip="2101" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button41"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel30" CommandArgument="2" ToolTip="2101" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button44"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel30" CommandArgument="99" ToolTip="2101" onclick="QAC_Button" Text="Затрудняюсь ответить" CssClass="green unibutton  big2" Width="600"  ID="Button92"  runat="server" /><br/> 
                                <asp:HiddenField ID="HiddenFieldA21_1" runat="server" />
                                <br/>
                                <asp:Button ID="Button93" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel30" runat="server"  Visible="false"> 
                                2.	Заинтересовала ли вас возможность в будущем с помощью приложения «Честный знак» <b><u>сообщать о нарушениях</u></b>?
                                <div class="comment">Респондент может выбрать только один вариант ответа.</div>
                                 <asp:Button CommandName="Panel11" CommandArgument="1" ToolTip="2102" onclick="QAC_ButtonA21_2" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button89"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel11" CommandArgument="2" ToolTip="2102" onclick="QAC_ButtonA21_2" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button90"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel11" CommandArgument="99" ToolTip="2102" onclick="QAC_ButtonA21_2" Text="Затрудняюсь ответить" CssClass="green unibutton  big2" Width="600"  ID="Button91"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button94" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>


                             

                            <asp:Panel ID="Panel11" runat="server"  Visible="false"> 
                                Вопрос 22. Для проверки каких товаров Вы в будущем С НАИБОЛЬШЕЙ ВЕРОЯТНОСТЬЮ использовали бы приложение «Честный знак»?
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент может выбрать несколько вариантов ответа.</div>
                                <asp:CheckBoxList ID="CheckBoxListA22"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">табачные изделия</asp:ListItem>
                                        <asp:ListItem>шубы</asp:ListItem>
                                        <asp:ListItem>обувь</asp:ListItem>
                                        <asp:ListItem>мужская и женская верхняя одежда (кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:ListItem>
                                        <asp:ListItem>лекарства</asp:ListItem>
                                        <asp:ListItem>молочная продукция</asp:ListItem>
                                        <asp:ListItem>кресла-коляски</asp:ListItem>
                                        <asp:ListItem>велосипеды</asp:ListItem>
                                        <asp:ListItem>фотоаппараты и лампы-вспышки</asp:ListItem>
                                        <asp:ListItem>шины и автопокрышки</asp:ListItem>
                                        <asp:ListItem>духи и туалетная вода</asp:ListItem>
                                        <asp:ListItem>Для других товаров (запишите, для каких?)</asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                <asp:TextBox ID="TextBoxA22" Visible="false" runat="server"></asp:TextBox>

                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Enabled="false" runat="server" ValidationGroup="A22" ControlToValidate="TextBoxA22" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                                        <br/>
                                <asp:Button CommandName="Panel13" CommandArgument="98" ToolTip="22" onclick="QAC_Button" Text="Ни для каких не стал бы использовать" CssClass="red unibutton  big2" Width="500"  ID="Button97"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel13" CommandArgument="99" ToolTip="22" onclick="QAC_Button" Text="Отказ от ответа" CssClass="red unibutton  big2" Width="500"  ID="Button45"  runat="server" /><br/> 
                  
                                 
                                    <br/> 
                                <asp:Button ID="Button46" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button96" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A22" CommandName="Panel13" CommandArgument="22" onclick="QAC_CheckBoxList" />
                      
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
