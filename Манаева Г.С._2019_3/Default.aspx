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
                                <asp:Button CommandName="Panel28" CommandArgument="1" ToolTip="1" onclick="QAC_Button" Text="Нет, не слышал о таком" CssClass="green unibutton  big2" Width="600"  ID="Button16"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="2" ToolTip="1" onclick="QAC_Button" Text="Что-то слышал, но не знаю группы товаров, для которых вводится маркировка" CssClass="green unibutton  big2" Width="600"  ID="Button60"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="3" ToolTip="1" onclick="QAC_Button" Text="Знаю о системе маркировки, знаю группы товаров, для которых вводится маркировка, но не использую маркировку для проверки подлинности этих товаров" CssClass="green unibutton  big2" Width="600"  ID="Button65"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="4" ToolTip="1" onclick="QAC_Button" Text="У меня есть мобильное приложение «Честный знак» для проверки подлинности маркированных товаров. Т.е. я знаю о системе маркировки, знаю группы товаров, для которых вводится маркировка, и знаю, как проверять подлинность" CssClass="green unibutton  big2" Width="600"  ID="Button70"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel40" CommandArgument="5" ToolTip="1" onclick="QAC_Button" Text="Другое" CssClass="green unibutton  big2" Width="600"  ID="Button71"  runat="server" /><br/> 
                              
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
                                 <asp:Button CommandName="Panel55" CommandArgument="1" ToolTip="5" onclick="QAC_Button" Text="Да (в том числе считается частичная занятость, самозанятость, работа без оформления и т.д.)" CssClass="green unibutton  big2" Width="600"  ID="Button5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55" CommandArgument="2" ToolTip="5" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button13"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55" CommandArgument="99" ToolTip="5" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button62"  runat="server" /><br/> 
                                 
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
                                 <asp:Button CommandName="Panel4" CommandArgument="1" ToolTip="6" onclick="QAC_Button" Text="Денег не хватает даже на продукты" CssClass="green unibutton  big2" Width="600"  ID="Button6"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="2" ToolTip="6" onclick="QAC_Button" Text="На продукты денег хватает, но покупка одежды вызывает финансовые затруднения" CssClass="green unibutton  big2" Width="600"  ID="Button66"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="3" ToolTip="6" onclick="QAC_Button" Text="Денег хватает на продукты и на одежду, но вот покупка вещей длительного пользования является проблемой" CssClass="green unibutton  big2" Width="600"  ID="Button67"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="4" ToolTip="6" onclick="QAC_Button" Text="Я могу без труда приобретать вещи длительного пользования. Однако для меня затруднительно приобретать действительно дорогие вещи" CssClass="green unibutton  big2" Width="600"  ID="Button68"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="5" ToolTip="6" onclick="QAC_Button" Text="Я могу позволить себе достаточно дорогостоящие вещи — квартиру, дачу и многое другое" CssClass="green unibutton  big2" Width="600"  ID="Button10"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel4" CommandArgument="99" ToolTip="6" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button18"  runat="server" /><br/> 
                                 
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
                                         <asp:TableHeaderCell>
                                             Вид товара
                                         </asp:TableHeaderCell>
                                         <asp:TableHeaderCell> 
                                         </asp:TableHeaderCell>
                                     </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табачные изделия (любые)</asp:TableCell> 
                                        <asp:TableCell>  
                                            <asp:RadioButtonList ID="RadioButtonListA7_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_6" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_7" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_8" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_9" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_10" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                            <asp:RadioButtonList ID="RadioButtonListA7_11" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
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
                                 <asp:Button CommandName="Panel7" CommandArgument="2" ToolTip="8" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button20"  runat="server" /><br/> 
                                  
                                <br/>
                                <asp:Button ID="Button82" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 


                            </asp:Panel>
                              

                             

                              <asp:Panel ID="Panel7" runat="server"  Visible="false" CssClass="1">
                                  Вопрос 9. Если говорить о самой идее внедрения системы обязательной цифровой маркировки. Являются ли следующие высказывания плюсами лично для Вас? 
                                  <br/>Оцените их значимость, где 1 – совершенно не значимо, 2 – нейтрально, 3 – весьма значимо.  
                                 <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАЙТЕ ВАРИАНТЫ. Респондент по каждой категории должен выбрать один вариант ответа.</div>
                                     <asp:Table ID="TableA9" BorderWidth="1" GridLines="Both" runat="server">
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Ответ</asp:TableHeaderCell>
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
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11" Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="A11" Enabled="false"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button48" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button49" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11"  CommandName="Panel14" CommandArgument="11"  onclick="QAC_TextBox" />
                            </asp:Panel>


                             
                               
                             
                             
                            <asp:Panel ID="Panel14" runat="server"   Visible="false"> 
                                Вопрос 12. Оцените <b><u>в процентах</u></b> от годового оборота Вашей компании долю затрат <b><u>на обеспечение работы</u></b> системы обязательной цифровой маркировки товаров (без учета затрат на этапе внедрения системы обязательной цифровой маркировки товаров).  
                                <div class="comment">можно вписать диапазон или текст со слов клиента</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA12" Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="A12" Enabled="false"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA12" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button61" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button63" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A12"  CommandName="Panel17" CommandArgument="12"  onclick="QAC_TextBox" />
                            </asp:Panel>

                      

                             
                              <asp:Panel ID="Panel17" runat="server"  Visible="false">  
                                 Вопрос 13. С какими затруднениями, помимо финансовых затрат, Ваша компания столкнулась при внедрении системы обязательной цифровой маркировки товаров? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ ПОДРОБНО СО СЛОВ РЕСПОНДЕНТА</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA13" Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Enabled="false" ValidationGroup="A13"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA13" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
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
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
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
                                            <asp:Panel ID="Panel31" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel34" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>
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
                                            <asp:Panel ID="Panel35" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel36" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>        
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
                                            <asp:Panel ID="Panel37" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel38" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>  
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
                                            <asp:Panel ID="Panel39" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel43" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>
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
                                            <asp:Panel ID="Panel44" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel45" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>
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
                                            <asp:Panel ID="Panel46" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel47" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>
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
                                            <asp:Panel ID="Panel48" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel49" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>    
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
                                            <asp:Panel ID="Panel50" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel51" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>  
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
                                            <asp:Panel ID="Panel52" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel53" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel> 
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
                                            <asp:Panel ID="Panel56" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel57" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>   
                                             <asp:TextBox ID="TextBoxA14_10" Width="400" Visible="false" runat="server"></asp:TextBox>
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA14_11" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA14_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Повысилась</asp:ListItem>
                                                <asp:ListItem Value="2">Понизилась</asp:ListItem>
                                                <asp:ListItem Value="3">Не изменилась</asp:ListItem>
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>   
                                            <asp:Panel ID="Panel78" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>повысилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>      
                                            <asp:Panel ID="Panel79" runat="server"  Visible="false"> 
                                                Укажите, пожалуйста, насколько примерно процентов <b>понизилось</b>? (можно вписать диапазон или текст со слов клиента)
                                            </asp:Panel>   
                                             <asp:TextBox ID="TextBoxA14_11" Width="400" Visible="false" runat="server"></asp:TextBox>
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
                                            <asp:TableHeaderCell Width="400">Положительный эффект</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Повышение спроса на продукцию из-за повышения доверия к качеству продукции, снижения доли нелегальной продукции на рынке</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel58" runat="server"  Visible="false"> 
                                                Укажите, какой положительный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>    
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
                                            <asp:Panel ID="Panel59" runat="server"  Visible="false"> 
                                                Укажите, какой положительный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>      
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
                                            <asp:Panel ID="Panel60" runat="server"  Visible="false"> 
                                                Укажите, какой положительный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>       
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
                                            <asp:Panel ID="Panel61" runat="server"  Visible="false"> 
                                                Укажите, какой положительный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>         
                                             <asp:TextBox ID="TextBoxA15_4" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. Иные положительные эффекты (указать, какие. <asp:TextBox ID="TextBoxA15_5_dr" Width="400"   runat="server"></asp:TextBox> </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA15_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA15_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>   
                                            <asp:Panel ID="Panel62" runat="server"  Visible="false"> 
                                                Укажите, какой положительный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>         
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
                                            <asp:TableHeaderCell Width="400">Отрицательный эффект</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Необходимость отказаться с 2020 года от патентной системы налогообложения или ЕНВД</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA16_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA16_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>
                                            <asp:Panel ID="Panel63" runat="server"  Visible="false"> 
                                                Укажите, какой отрицательный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>               
                                             <asp:TextBox ID="TextBoxA16_1" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Контрагенты (поставщики, покупатели) в настоящее время не готовы к использованию системы маркировки</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA16_2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA16_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>  
                                            <asp:Panel ID="Panel64" runat="server"  Visible="false"> 
                                                Укажите, какой отрицательный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>                  
                                             <asp:TextBox ID="TextBoxA16_2" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Связанная с маркировкой прослеживаемость товаров нарушает коммерческую тайну</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA16_3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA16_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>    
                                            <asp:Panel ID="Panel65" runat="server"  Visible="false"> 
                                                Укажите, какой отрицательный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>                
                                             <asp:TextBox ID="TextBoxA16_3" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. Маркировка ведет к монополизации рынка, так как выгодна только определенному кругу крупных компаний</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA16_4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA16_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel66" runat="server"  Visible="false"> 
                                                Укажите, какой отрицательный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>              
                                             <asp:TextBox ID="TextBoxA16_4" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. Иные отрицательные эффекты  (указать, какие. <asp:TextBox ID="TextBoxA16_5_dr" Width="400"   runat="server"></asp:TextBox> </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA16_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA16_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel67" runat="server"  Visible="false"> 
                                                Укажите, какой отрицательный эффект в виде доли в процентах от годового оборота компании? (указать примерный % или диапазон процентов)
                                            </asp:Panel>              
                                             <asp:TextBox ID="TextBoxA16_5" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button33" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button34" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A15" CommandName="Panel23" CommandArgument="16" onclick="QAC_A16" />
                       
                            </asp:Panel>
                             

                            <asp:Panel ID="Panel23" runat="server"  Visible="false"> 
                                Вопрос 17. На Ваш взгляд, какова была доля незаконного оборота по группе ваших товаров ДО внедрения системы цифровой маркировки (либо вначале экспериментов по внедрению), и ПОСЛЕ этого? 
                                <div class="comment">Респондент отвечает на вопрос по тем видам товарам, по которым на вопрос 1 ответил «да».
                                    <br/>Респондент может выбрать только один вариант ответа по каждому виду товара.  (можно вписать диапазон или текст со слов клиента)</div>
                                <asp:Table ID="TableA17" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA17_PreRender">
                                    <asp:TableHeaderRow>
                                        <asp:TableHeaderCell>Вид товара</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Оценка доли незаконного оборота продукции ДО, %</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Оценка доли незаконного оборота продукции ПОСЛЕ, %</asp:TableHeaderCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. табак</asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_1" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_1" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. шубы</asp:TableCell> 
                                        <asp:TableCell> 
                                             <asp:TextBox ID="TextBoxA17_2" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_2" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. обувь</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_3" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_3" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. верхняя одежда (мужская и женская, кроме шуб), женские блузки, постельное, столовое, туалетное и кухонное белье</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_4" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_4" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. лекарства</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_5" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_5" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. молочная продукция</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_6" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_6" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. кресла-коляски</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_7" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_7" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. велосипеды</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_8" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_8" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. фотоаппараты и лампы-вспышки</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_9" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_9" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>10. шины и автопокрышки</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_10" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_10" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>11. духи и туалетная вода</asp:TableCell> 
                                        <asp:TableCell>
                                             <asp:TextBox ID="TextBoxA17_11" Width="400"   runat="server"></asp:TextBox>    
                                        </asp:TableCell> 
                                        <asp:TableCell>     
                                             <asp:TextBox ID="TextBoxA17_2_11" Width="400"   runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button36" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button37" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A17" CommandName="Panel24" CommandArgument="17" onclick="QAC_A17" />
                     
                            </asp:Panel>
                              
                             

                            <asp:Panel ID="Panel24" runat="server"  Visible="false"> 
                                Вопрос 18. В каких отраслях или для каких групп товаров, на Ваш взгляд, также целесообразно внедрение системы обязательной цифровой маркировки товаров?
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ ПОДРОБНО СО СЛОВ РЕСПОНДЕНТА</div>
                                 <asp:TextBox ID="TextBoxA18"  Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator12" Enabled="false" ValidationGroup="A18"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA18" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                  <br/> 
                                 <asp:Button CommandName="Panel25" CommandArgument="99" ToolTip="18" onclick="QAC_Button_A18" Text="Не нужно внедрять маркировку для других групп товаров" CssClass="green unibutton  big2" Width="600"  ID="Button38"  runat="server" /><br/> 
                                  
                             
                                <br/> 
                                 <asp:Button ID="Button115" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button116" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A18"  CommandName="Panel25" CommandArgument="18"  onclick="QAC_TextBox_A18" />
                            </asp:Panel>

                             
                              <asp:Panel ID="Panel25" runat="server"  Visible="false">  
                                 Вопрос 19. В рамках введенной системы маркировки Ваша компания передает сведения в Государственную информационную систему «Маркировка». Кроме того, Ваша компания сдает налоговую и иную обязательную отчетность. Возможно, какие-то сведения при этом дублируются. Оцените в процентах эту часть сведений. 
                                <div class="comment"> 
                                    (другими словами, в каком проценте случаев сведения дублируются)
                                    <br/>
                                ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ
                                </div>
                                <asp:Table ID="TableA19" BorderWidth="1" GridLines="Both" runat="server" >
                                    <asp:TableHeaderRow>
                                        <asp:TableHeaderCell>
                                            Орган исполнительной власти, в который передается отчетность
                                        </asp:TableHeaderCell>
                                        <asp:TableHeaderCell>
                                            Доля дублирующих сведений, %  (можно вписать диапазон или текст со слов клиента)
                                        </asp:TableHeaderCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Росстат</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA19_1" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>2. ФНС России</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA19_2" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>3. Отраслевые федеральные органы исполнительной власти</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA19_3" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow>  
                                    <asp:TableRow>
                                        <asp:TableCell>4. Региональные и муниципальные органы исполнительной власти</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA19_4" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>5. Иное (что именно)  <asp:TextBox ID="TextBoxA19_5_dr" Width="100" runat="server"></asp:TextBox></asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:TextBox ID="TextBoxA19_5" Width="100" runat="server"></asp:TextBox>                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button39" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button40" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A19" CommandName="Panel5" CommandArgument="19" onclick="QAC_A19" />
                          
                           
                            </asp:Panel>
                             

                            <asp:Panel ID="Panel5" runat="server"  Visible="false"> 
                                Вопрос 20. Оцените в процентах долю затрат, на которую Ваша компания может снизить издержки при отказе от передачи в ГИС «Маркировка» сведений, дублирующих сведения из налоговой и иной обязательной отчетности, предоставляемой Вашей компанией в органы исполнительной власти? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ ПОДРОБНО СО СЛОВ РЕСПОНДЕНТА  (можно вписать диапазон или текст со слов клиента)</div>
                                 <asp:TextBox ID="TextBoxA20" Width="800" TextMode="MultiLine" Height="50"  runat="server"></asp:TextBox>   %
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Enabled="false" ValidationGroup="A20"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA20" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                             
                                <br/> 
                                 <asp:Button ID="Button42" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button43" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A20"  CommandName="Panel9" CommandArgument="20"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel9" runat="server"  Visible="false"> 
                                Вопрос 21. С какими органами исполнительной власти из перечисленных вы взаимодействуете в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? 
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ</div>
                                <asp:Table ID="TableA21" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Орган исполнительной власти, осуществляющий контрольно-надзорные мероприятия</asp:TableHeaderCell>
                                            <asp:TableHeaderCell>
                                            </asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Роспотребнадзор</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_1" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>  
                                            <asp:Panel ID="Panel68" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>              
                                             <asp:TextBox ID="TextBoxA21_1" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Росздравнадзор</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_2" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel69" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_2" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Россельхознадзор</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_3" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>    
                                            <asp:Panel ID="Panel70" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>             
                                             <asp:TextBox ID="TextBoxA21_3" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. ФТС России</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_4" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel71" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_4" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. ФНС России</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_5" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel72" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_5" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. МВД России</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_6" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel73" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_6" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. Росстандарт</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_7" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel74" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_7" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>8. Ростехнадзор</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_8" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel75" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_8" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. Минпромторг России</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_9" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>    
                                            <asp:Panel ID="Panel76" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>             
                                             <asp:TextBox ID="TextBoxA21_9" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>10. Иное (что именно_) <asp:TextBox ID="TextBoxA21_10_dr" Width="400"  runat="server"></asp:TextBox> </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA21_10" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonListA21_SelectedIndexChanged" runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>      
                                            <asp:Panel ID="Panel77" runat="server"  Visible="false"> 
                                                Оцените в процентах долю сведений, которые Ваша компания передает в Государственную информационную систему «Маркировка» (ГИС «Маркировка»), которые дублируют сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий, в том числе в рамках лицензионного контроля? (указать примерный % или диапазон процентов)?
                                            </asp:Panel>           
                                             <asp:TextBox ID="TextBoxA21_10" Width="400" Visible="false" runat="server"></asp:TextBox>                                
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button41" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button44" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A15" CommandName="Panel11" CommandArgument="21" onclick="QAC_A21" />
                       
                            </asp:Panel>


                             

                            <asp:Panel ID="Panel11" runat="server"  Visible="false"> 
                                Вопрос 22. Оцените в процентах долю трат на подготовку к проведению контрольно-надзорных мероприятий и нам само проведение этих контрольно-надзорных мероприятий?
                                <div class="comment"> (можно вписать диапазон или текст со слов клиента)</div>
                                 <asp:TextBox ID="TextBoxA22" Width="400" runat="server"></asp:TextBox>   %
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Enabled="false" ValidationGroup="A22"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA22" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                             
                                <br/> 
                                 <asp:Button ID="Button45" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button46" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A22"  CommandName="Panel12" CommandArgument="22"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             

                            <asp:Panel ID="Panel12" runat="server"  Visible="false"> 
                                Вопрос 23. Оцените в процентах долю затрат, на которую Ваша компания может снизить издержки при отказе от передачи в ГИС «Маркировка» сведений, дублирующих сведения, которые Ваша компания предоставляет в рамках контрольно-надзорных мероприятий?
                                <div class="comment"> (можно вписать диапазон или текст со слов клиента)</div>
                                 <asp:TextBox ID="TextBoxA23" Width="400" runat="server"></asp:TextBox>   %
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="A23" Enabled="false"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA23" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                             
                                <br/> 
                                 <asp:Button ID="Button47" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button50" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A23"  CommandName="Panel15" CommandArgument="23"  onclick="QAC_TextBox" />
                            </asp:Panel>


                             
                            <asp:Panel ID="Panel15" runat="server"  Visible="false"> 
                                Вопрос 24. Относительно системы цифровой маркировки товаров, сейчас я зачитаю шесть ПРЕДЛАГАЕМЫХ мер по дерегулированию деятельности предприятий. Меры направленны на снятие различных барьеров и на снижение издержек бизнеса.
                                <br/>Оцените эти предлагаемые меры по шкале от 1 до 5, где 1 – совсем неэффективно для снижения издержек, 5 – очень эффективно.  

                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ</div>
                                <asp:Table ID="TableA24" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Меры по дерегулированию хозяйственной деятельности предприятий</asp:TableHeaderCell>
                                            <asp:TableHeaderCell>Оценка (где 1 – совсем неэффективно, 5 – очень эффективно; 99 – нет ответа)</asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Снижение частоты проверок контрольно-надзорных органов за счет увеличения эффективности общественного контроля через мобильное приложение «Честный знак»</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA24_1" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                               
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Отказ от предоставления сведений предприятиями в контрольно-надзорные органы, если эти сведения предоставляются в ГИС «Маркировка»</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA24_2" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                            
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Отказ от предоставления сведений предприятиями в рамках подачи налоговой и иной обязательной отчетности, если эти сведения предоставляются в ГИС «Маркировка»</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA24_3" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                                       
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. Профилактика нарушений за счет автоматических уведомлений на основании данных, содержащихся в ГИС «Маркировка»</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA24_4" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                                                  
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. Проведение выездных проверок контрольно-надзорных органов в местах продажи товара без отвлечения персонала предприятия (магазина, склада) (с помощью программного обеспечения, интегрированного с системой «Честный знак»)</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA24_5" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                                 
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. Отказ от требования к наличию сопроводительной документации на груз в отношении сведений, содержащихся в Национальном каталоге товаров</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA24_6" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                                   
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button51" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button52" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A24" CommandName="Panel16" CommandArgument="24" onclick="QAC_A24" />
                       
                            </asp:Panel>


                              <asp:Panel ID="Panel16" runat="server"  Visible="false">  
                                Вопрос 25. Получает ли Ваша компания какие-либо <b>меры предпринимательской поддержки</b>, которые используются для компенсации затрат на внедрение системы цифровой маркировки продукции? 
                                <div class="comment"> 
                                   ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ
                                </div>
                                <br/>
                                  <asp:Table ID="TableA25" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell Width="500">Меры поддержки</asp:TableHeaderCell>
                                            <asp:TableHeaderCell></asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Возмещение затрат в рамках региональных / муниципальных программ поддержки предпринимательской деятельности малого бизнеса</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA25_1" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>                              
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Возмещение процентной ставки по кредиту (лизингу) на оборудование от Фонда развития промышленности (в т.ч. займы по льготной ставке)</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA25_2" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>                                  
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Субсидии на приобретение оборудования для маркировки</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA25_3" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>                                  
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4. Льготные условия предоставления кредита на приобретение оборудования в рамках программ льготного кредитования субъектов малого предпринимательства (например, в рамках программы льготного кредитования по ставке 8,5%)  </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA25_4" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>                                      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5. Иное (что именно) <asp:TextBox ID="TextBoxA25_5" Width="400"  runat="server"></asp:TextBox> </asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA25_5" AutoPostBack="true"   runat="server">
                                                <asp:ListItem Value="1">Да</asp:ListItem>
                                                <asp:ListItem Value="2">Нет</asp:ListItem> 
                                                <asp:ListItem Value="99">не знаю</asp:ListItem>
                                             </asp:RadioButtonList>                                      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                 </asp:Table>
                                <br />
                                <asp:Button ID="Button53" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button54" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A25" CommandName="Panel18" CommandArgument="25" onclick="QAC_A25" />
                       
                            </asp:Panel>

                             
                             
                            <asp:Panel ID="Panel18" runat="server"  Visible="false"> 
                                Вопрос 26. Предпоследний вопрос. Я вам зачитаю две меры поддержки предпринимательства. Оцените степень их влияния на снижение издержек бизнеса по шкале от 1 до 5, где 1 – совсем неэффективно, 5 – очень эффективно.  
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАЧИТАТЕ ВАРИАНТЫ</div>
                                <asp:Table ID="TableA26" BorderWidth="1" GridLines="Both" runat="server" >
                                        <asp:TableHeaderRow>
                                            <asp:TableHeaderCell>Меры по дерегулированию хозяйственной деятельности предприятий</asp:TableHeaderCell>
                                            <asp:TableHeaderCell>Оценка степени влияния (где 1 – совсем неэффективно, 5 – очень эффективно; 99 – нет ответа)</asp:TableHeaderCell>
                                        </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1. Возмещение для малого бизнеса части затрат на закупку оборудования, программного обеспечения, меток, внедрения электронного документооборота и обучение персонала в рамках внедрения системы маркировки – в виде субсидий</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA26_1" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                               
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Возмещение для малого бизнеса части затрат на закупку оборудования, программного обеспечения, меток, внедрения электронного документооборота и обучение персонала в рамках внедрения системы маркировки – в виде налогового вычета</asp:TableCell> 
                                        <asp:TableCell> 
                                            <asp:RadioButtonList ID="RadioButtonListA26_2" AutoPostBack="true"  runat="server">
                                                <asp:ListItem Value="1">1</asp:ListItem>
                                                <asp:ListItem Value="2">2</asp:ListItem> 
                                                <asp:ListItem Value="3">3</asp:ListItem> 
                                                <asp:ListItem Value="4">4</asp:ListItem> 
                                                <asp:ListItem Value="5">5</asp:ListItem> 
                                                <asp:ListItem Value="99">нет ответа</asp:ListItem>
                                             </asp:RadioButtonList>                            
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                 </asp:Table>
                                <br />
                                 <asp:Button ID="Button55" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button57" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A26" CommandName="Panel20" CommandArgument="26" onclick="QAC_A26" />
                       
                            </asp:Panel>

                             

                            <asp:Panel ID="Panel20" runat="server"  Visible="false"> 
                                Вопрос 27. Какие еще меры по дерегулированию (снятию различных барьеров) хозяйственной деятельности предприятий, связанные с внедрением системы цифровой маркировки товаров, вы могли бы предложить?  
                                <div class="comment">ИНТЕРВЬЮЕР, ЗАПИШИТЕ ПОДРОБНО СО СЛОВ РЕСПОНДЕНТА</div>
                                 <asp:TextBox ID="TextBoxA27" Width="800" TextMode="MultiLine" Height="50" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="A27" Enabled="false"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA27" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                
                             
                                <br/> 
                                 <asp:Button ID="Button58" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button59" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A27"  CommandName="Panel13" CommandArgument="27"  onclick="QAC_TextBox" />
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
