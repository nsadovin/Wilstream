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
                                Здравствуйте!<br/> 
                                Меня зовут  <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>. (Название Исполнителя) проводит опрос организаций об использовании программ и сервисов с правовой информацией.
                                <br/>Пожалуйста, соедините меня с бухгалтерией, желательно главным бухгалтером.
                                <div class="comment">!!! Если в компании нет бухгалтера (аутсорсинг, удаленное обслуживание, централизованная бухгалтерия и т.п.), попросить переключить на юриста. 
                                (ЕСЛИ БУХГАЛТЕР В КОМПАНИИ ЕСТЬ, НО НЕ МОЖЕТ ОТВЕТИТЬ, ДОГОВОРИТЬСЯ О ПОВТОРНОМ ЗВОНКЕ. ЮРИСТА ИЛИ ДР. СПЕЦИАЛИСТА В ДАННОМ СЛУЧАЕ НЕ ОПРАШИВАТЬ)
                                !!! Если в компании нет ни бухгалтера, ни юриста, то:
                                - если опрашивается индивидуальный предприниматель, адвокатское или нотариальное образование, попросить переключить на сотрудника, занимающего другую должность, использующего в своей работе правовую информацию.

                                ПРИ ПЕРЕКЛЮЧЕНИИ ЗАЧИТАЙТЕ ВСТУПЛЕНИЕ:
                                </div>
                                Здравствуйте!
                                <br/>Меня зовут <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>. (Название Исполнителя) проводит опрос об использовании в организациях программ и сервисов с правовой информацией.
                                <div class="comment">
                                ЕСЛИ РЕСПОНДЕНТ УТВЕРЖДАЕТ, ЧТО ОН БУХГАЛТЕР ИЛИ ЮРИСТ ИЛИ ДРУГОЙ СПЕЦИАЛИСТ, ИСПОЛЬЗУЮЩИЙ В РАБОТЕ ПРАВОВУЮ ИНФОРМАЦИЮ, ВСТУПЛЕНИЕ ПОВТОРНО НЕ ЗАЧИТЫВАТЬ, СРАЗУ ЗАДАТЬ ВОПРОС 1:
                                </div> 
                                <br/> 
                                <asp:Button CommandName="Panel1_3"    onclick="standartNext" Text="Далее" CssClass="green unibutton big2" Width="300"  ID="Button2"  runat="server" /><br/> 
                                 
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel1_3" runat="server" Visible="false">

                                1.	Уточните, пожалуйста, Вашу должность? 
                                <div>
                                    ИНТЕРВЬЮЕР! Точная должность бухгалтера/юриста здесь не нужна, отметьте - относится ли опрашиваемый к бухгалтерии или юристам, либо укажите должность, если переключили на другого сотрудника - (только для ИП, адвокатских или нотариальных контор!)
                                </div>
                                <br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="1" ToolTip="1" onclick="QAC_Button"     Text="1.	Бухгалтер (главный бухгалтер, зам. главного бухгалтера, руководитель какого-либо участка бухгалтерии, старший бухгалтер, бухгалтер)" CssClass="green unibutton  big2" Width="1100"  ID="Button42_2_5"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel28"  CommandArgument="2" ToolTip="1" onclick="QAC_Button"     Text="2.	Юрист (руководитель юридического подразделения, юрист, юрисконсульт, адвокат)" CssClass="red unibutton  big2" Width="1100"  ID="Button3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2"  CommandArgument="998" ToolTip="1" onclick="QAC_Button"   Text="998. Другой " CssClass="red unibutton  big2" Width="1100"  ID="Button3_2_5"  runat="server" /><br/> 
                               <br/> 
                                 <asp:Button ID="Button121" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                             
                            </asp:Panel>
                            

                            <asp:Panel ID="Panel2" runat="server"  Visible="false"> 
                                 <div class="comment">(записать, на кого именно переключили) </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="A1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button4" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button5" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A1"  CommandName="Panel28" CommandArgument="101"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false">
                                <div class="comment">ПРИ ВЫХОДЕ НА НУЖНОГО РЕСПОНДЕНТА ЗАЧИТАЙТЕ:</div>
                                Мы хотели бы задать Вам несколько вопросов, наш разговор займет не более 10 минут.

                                <div class="comment">ЕСЛИ РЕСПОНДЕНТ СОГЛАШАЕТСЯ ПРИНЯТЬ УЧАСТИЕ В ИССЛЕДОВАНИИ, ПЕРЕХОДИТЕ К ВОПРОСАМ:</div>

                                2.	Ваша организация является … (ЗАЧИТАТЬ СПИСОК)?
                                <asp:CheckBoxList ID="CheckBoxListA2"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">1. самостоятельным юридическим лицом, ведущим коммерческую деятельность (ООО, АО, ПАО, Унитарное предприятие (МУП, ГУП), Производственный кооператив, Полное товарищество и т.д.) </asp:ListItem> 
                                        <asp:ListItem Value="2">2. филиалом, обособленным подразделением, представительством юридического лица, ведущего коммерческую деятельность </asp:ListItem> 
                                        <asp:ListItem Value="3">3. индивидуальным предпринимателем без образования Юр. Лица (ИП)</asp:ListItem> 
                                        <asp:ListItem Value="4">4. адвокатским и/или нотариальным образованием</asp:ListItem>  
                                 </asp:CheckBoxList> 
                                  <br/> 
                                 
                                   <br/>  
                                 <asp:Button CommandName="Panel3" CommandArgument="5" ToolTip="2" onclick="QAC_Button" Text="5. ничем из перечисленного " CssClass="red unibutton  big2" Width="500"  ID="Button24"  runat="server" /><br/> 
                  
                                    <br/> 
                                <asp:Button ID="Button27" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button68" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A2" CommandName="Panel29" CommandArgument="2" onclick="QAC_CheckBoxList" />
                                <div class="comment">Справочно: интервью завершается в случае, если называются:
                                <br/>•	органы власти и управления,
                                <br/>•	органы МВД, ФСБ, налоговой инспекции,
                                <br/>•	прокуратуры, суды,
                                <br/>•	любые виды государственных учреждений (образования, здравоохранения, культуры и др.)
                                <br/>•	общественные организации,
                                <br/>•	все другие виды некоммерческих организаций
                                    </div>
                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel29" runat="server" Visible="false">
                                3. Скажите, пожалуйста, какие из следующих программ и сервисов с правовой информацией доступны для использования в Вашей компании (в целом, не только Вам или Вашему подразделению)?
                                <div class="comment">(ЗАЧИТАТЬ. ОТМЕТИТЬ ВСЕ НАЗВАННЫЕ)</div>
                                <asp:CheckBoxList ID="CheckBoxListA3"  runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">1. Справочные правовые системы КонсультантПлюс</asp:ListItem> 
                                        <asp:ListItem Value="2">2. Системы Гарант (информационно-правовое обслуживание (ИПО) Гарант)</asp:ListItem> 
                                        <asp:ListItem Value="3">3. Профессиональные справочные системы Кодекс</asp:ListItem> 
                                        <asp:ListItem Value="4">51. Бухгалтерская справочная Система Главбух (от компании Актион)!!! ОБЯЗАТЕЛЬНО УТОЧНИТЬ, ЧТО РЕЧЬ ИДЕТ ИМЕННО О БУХГАЛТЕРСКОЙ СПРАВОЧНОЙ СИСТЕМЕ ГЛАВБУХ, А НЕ О ЖУРНАЛЕ ГЛАВБУХ И НЕ О САЙТЕ ГЛАВБУХ.РУ</asp:ListItem> 
                                        <asp:ListItem Value="5">54. Юридическая справочная Система Юрист (от компании Актион)</asp:ListItem> 
                                        <asp:ListItem Value="6">55. Любая другая система производства компании Актион (Кадры, Финансовый директор, Госзаказ и др.) кроме Главбух и Юрист</asp:ListItem> 
                                        <asp:ListItem Value="7">6. 1С:ИТС (информационно-технологическое сопровождение пользователей "1С:Предприятие", договор на которое заключается отдельно)!!!ОБЯЗАТЕЛЬНО УТОЧНИТЬ, ЧТО РЕЧЬ ИДЕТ ИМЕННО ОБ ИНФОРМАЦИОННОЙ СИСТЕМЕ 1С:ИТС, КОТОРАЯ ЯВЛЯЕТСЯ ДОПОЛНЕНИЕМ К 1С:ПРЕДПРИЯТИЕ, И ПОСТАВЛЯЕТСЯ ОТДЕЛЬНО</asp:ListItem> 
                                        <asp:ListItem Value="8">7. Справочно-правовой веб-сервис Норматив (от компании СКБ Контур) ОБЯЗАТЕЛЬНО УТОЧНИТЬ, ЧТО ЭТО ИМЕННО СПРАВОЧНО-ПРАВОВОЙ ВЕБ-СЕРВИС «НОРМАТИВ», А НЕ ПРОГРАММА ДЛЯ ПЕРЕДАЧИ ЭЛЕКТРОННОЙ ОТЧЕТНОСТИ «КОНТУР - ЭКСТЕРН».</asp:ListItem> 
                                        <asp:ListItem Value="9">9. Справочно-правовая система Бюро (от компании «Мое дело») ОБЯЗАТЕЛЬНО УТОЧНИТЬ, ЧТО ЭТО НЕ ПРОГРАММА ДЛЯ ВЕДЕНИЯ БУХГАЛТЕРИИ ОНЛАЙН, А ОНЛАЙН-СЕРВИС С ПРАВОВОЙ ИНФОРМАЦИЕЙ И КОНСУЛЬТАЦИЯМИ, ПОДКЛЮЧАЕМЫЙ ОТДЕЛЬНО.</asp:ListItem> 
                                        <asp:ListItem Value="10">11. Право.ру</asp:ListItem> 
                                        <asp:ListItem Value="11">998. Другое (не из списка) ЗАПИСАТЬ, НАЗВАННОЕ ответом</asp:ListItem> 
                                 </asp:CheckBoxList> 
                                  <br/> 
                                <asp:TextBox ID="TextBoxA3" Visible="false" runat="server"></asp:TextBox>

                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator18" Enabled="false" runat="server" ValidationGroup="A3" ControlToValidate="TextBoxA3" ErrorMessage="Заполните поле другое"></asp:RequiredFieldValidator>
                           
                                   <br/>  
                                 <asp:Button CommandName="Panel3" CommandArgument="999" ToolTip="3" onclick="QAC_Button" Text="999. Затрудняюсь ответить/отказ" CssClass="red unibutton  big2" Width="500"  ID="Button11"  runat="server" /><br/> 
                  
                                    <br/> 
                                <asp:Button ID="Button12" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button13" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A3" CommandName="Panel2_4" CommandArgument="3" onclick="QAC_CheckBoxList_A3" />
                      
                            </asp:Panel> 





                              <asp:Panel ID="Panel2_4" runat="server"  Visible="false" CssClass="1">
                                 4. Какие из названных Вами программ и сервисов используются на платной основе – т.е., компания оплачивает их сопровождение или доступ к ним?
                                 <div class="comment"></div>
                                  <br/> 
                                <asp:Table ID="TableA4" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA4_PreRender">
                                    <asp:TableRow>
                                        <asp:TableCell>1. КонсультантПлюс</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_1" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Гарант</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_2" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Кодекс</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_3" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>51. Система Главбух</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_4" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>54. Система Юрист</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_5" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>55. Любая другая система производства компании Актион (Кадры, Финдир, Госзаказ и др.) кроме Главбух и Юрист</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_6" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. 1С:ИТС </asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_7" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. Справочно-правовой веб-сервис Норматив (от СКБ Контур)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_8" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. Справочно-правовая система Бюро (от компании «Мое дело»)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA4_9" runat="server">
                                                 <asp:ListItem Value="1">платно</asp:ListItem>
                                                 <asp:ListItem Value="2">бесплатно</asp:ListItem>
                                                 <asp:ListItem Value="999">затрудняюсь ответить о платности</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                        </asp:Table>
                                      <br/> 
                                <asp:Button ID="Button14" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button15" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A4" CommandName="Panel26" CommandArgument="4" onclick="QAC_A4" />
                            
                            </asp:Panel>
                              
                             
                             
                            <asp:Panel ID="Panel27" runat="server" Visible="false"> 
                                В какое время, Вам было бы удобней, что бы мы перезвонили?
                                <div class="comment">– зафиксировать –</div> Спасибо! Мы свяжемся с Вами!
                                <br />
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             

                              
                                   
                            <asp:Panel ID="Panel26" runat="server"  Visible="false">
                                  5. Какие системы и сервисы с правовой информацией используете в своей работе лично Вы? 
                                 <div class="comment">(множественный выбор)<br/>
                                     НЕ ЗАЧИТЫВАТЬ. ОТМЕТЬТЕ ВСЕ ОТВЕТЫ
                                 </div>
                                    <asp:Table ID="TableA5" BorderWidth="1" GridLines="Both" runat="server" OnPreRender="TableA5_PreRender">
                                    <asp:TableRow>
                                        <asp:TableCell>1. КонсультантПлюс</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_1"  Text="" runat="server" />                                      
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2. Гарант</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_2"  Text="" runat="server" />                                          
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3. Кодекс</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_3"  Text="" runat="server" />                                          
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>51. Система Главбух</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_4"  Text="" runat="server" />                                          
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>54. Система Юрист</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_5"  Text="" runat="server" />                                           
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>55. Любая другая система производства компании Актион (Кадры, Финдир, Госзаказ и др.) кроме Главбух и Юрист</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_6"  Text="" runat="server" />                                          
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6. 1С:ИТС </asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_7"  Text="" runat="server" />                                         
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>7. Справочно-правовой веб-сервис Норматив (от СКБ Контур)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_8"  Text="" runat="server" />                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9. Справочно-правовая система Бюро (от компании «Мое дело»)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:CheckBox ID="CheckBoxA5_9"  Text="" runat="server" />                                         
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                        </asp:Table>
                                      <br/> 
                                <asp:Button ID="Button16" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button18" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A5" CommandName="Panel55" CommandArgument="5" onclick="QAC_A5" />
                            
                               
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
                                6. Какая из используемых Вами систем или сервисов с правовой информацией является для Вас основной? Под основной мы понимаем ту, которая используется Вами чаще всего. 
                                <div class="comment">НЕ ЗАЧИТЫВАТЬ. ОТМЕТИТЬ ОДИН ОТВЕТ</div>
                                <br/>
                                <asp:Button CommandName="Panel4" CommandArgument="1" ToolTip="6" onclick="QAC_Button" Text="1.КонсультантПлюс" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_1"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="2" ToolTip="6" onclick="QAC_Button" Text="2. Гарант" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="3" ToolTip="6" onclick="QAC_Button" Text="3. Кодекс" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="51" ToolTip="6" onclick="QAC_Button" Text="51. Система Главбух" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_4"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="54" ToolTip="6" onclick="QAC_Button" Text="54. Система Юрист" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_5"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="55" ToolTip="6" onclick="QAC_Button" Text="55. Любая другая система производства компании Актион (Кадры, Финдир, Госзаказ и др.) кроме Главбух и Юрист" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_6"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="6" ToolTip="6" onclick="QAC_Button" Text="6. 1С: ИТС" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_7"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="7" ToolTip="6" onclick="QAC_Button" Text="7. Справочно-правовой веб-сервис Норматив (от СКБ Контур)" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_8"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="9" ToolTip="6" onclick="QAC_Button" Text="9. Справочно-правовая система Бюро (от компании «Мое дело»)" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_9"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel5" CommandArgument="998" ToolTip="6" onclick="QAC_Button" Text="998. Другое (не из списка) " CssClass="green unibutton  big2" Width="600"  ID="Button6"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="999" ToolTip="6" onclick="QAC_Button" Text="999. Затрудняюсь ответить" CssClass="green unibutton  big2" Width="600"  ID="Button10"  runat="server" /><br/> 
                
                                <br/>
                                <asp:Button ID="Button17" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>



                             
                            <asp:Panel ID="Panel5" runat="server"  Visible="false"> 
                                 <div class="comment">ЗАПИСАТЬ, НАЗВАННОЕ </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA6_998" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="A6_998"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA6_998" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button21" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A6_998"  CommandName="Panel4" CommandArgument="6998"  onclick="QAC_TextBox" />
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel4" runat="server"  Visible="false"> 
                                7. Как часто Вы лично обращаетесь к справочным правовым системам? 
                                <div class="comment">ЗАЧИТАТЬ. ОТМЕТИТЬ ОДИН ОТВЕТ
                                    <br/>
                                    ВНИМАНИЕ! ИНТЕРЕСУЕТ ЧАСТОТА ОБРАЩЕНИЯ К СПС В ЦЕЛОМ, НЕЗАВИСИМО ОТ КОЛИЧЕСТВА ИСПОЛЬЗУЕМЫХ СПС
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel6" CommandArgument="1" ToolTip="7" onclick="QAC_Button" Text="1-несколько раз в день" CssClass="green unibutton  big2" Width="600"  ID="Button8"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="2" ToolTip="7" onclick="QAC_Button" Text="Несколько раз в неделю" CssClass="green unibutton  big2" Width="600"  ID="Button22"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="3" ToolTip="7" onclick="QAC_Button" Text="1 раз в неделю" CssClass="green unibutton  big2" Width="600"  ID="Button23"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="4" ToolTip="7" onclick="QAC_Button" Text="Несколько раз в месяц" CssClass="green unibutton  big2" Width="600"  ID="Button25"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="5" ToolTip="7" onclick="QAC_Button" Text="1 раз в месяц" CssClass="green unibutton  big2" Width="600"  ID="Button26"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="6" ToolTip="7" onclick="QAC_Button" Text="1-несколько раз в год" CssClass="green unibutton  big2" Width="600"  ID="Button28"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="7" ToolTip="7" onclick="QAC_Button" Text="Реже одного раза в год" CssClass="green unibutton  big2" Width="600"  ID="Button9"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button54" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              



                           

                              <asp:Panel ID="Panel6" runat="server"  Visible="false" CssClass="1">
                                  8. Пользовалась ли Ваша компания за последний год платными услугами юристов следующих организаций…? 
                                 <div class="comment">ЗАЧИТАТЬ, ОТМЕТИТЬ НАЗВАННОЕ, ОТМЕТИТЬ ОДИН ОТВЕТ ПО КАЖДОЙ СТРОКЕ</div>
                                 <br/> 
                                <asp:Table ID="TableA8" BorderWidth="1" GridLines="Both" runat="server">
                                    <asp:TableRow>
                                        <asp:TableCell>Европейская юридическая служба (ЕЮС)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA8_1" runat="server">
                                                 <asp:ListItem Value="1">Да, пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="2">Нет, не пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Национальная юридическая служба (Амулекс)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA8_2" runat="server">
                                                 <asp:ListItem Value="1">Да, пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="2">Нет, не пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Правовед</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA8_3" runat="server">
                                                 <asp:ListItem Value="1">Да, пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="2">Нет, не пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Компании, обслуживающие справочные правовые системы</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA8_4" runat="server">
                                                 <asp:ListItem Value="1">Да, пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="2">Нет, не пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Иные компании, онлайн-сервисы или юристы</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA8_5" runat="server">
                                                 <asp:ListItem Value="1">Да, пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="2">Нет, не пользовалась</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                        </asp:Table>
                                      <br/> 
                                <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button20" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A8" CommandName="Panel7" CommandArgument="8" onclick="QAC_A8" />
                            
                            </asp:Panel>
                              

                             

                              <asp:Panel ID="Panel7" runat="server"  Visible="false" CssClass="1">
                                  9. На каких условиях оказывались платные услуги юристами…? 
                                 <div class="comment">ЗАЧИТАТЬ НАЗВАНИЯ ОРГАНИЗАЦИЙ, ВАРИАНТЫ ОТВЕТОВ, ОТМЕТИТЬ ОДИН ОТВЕТ ПО КАЖДОЙ СТРОКЕ</div>
                                 <br/> 
                                <asp:Table ID="TableA9" runat="server" BorderWidth="1" GridLines="Both"  OnPreRender="TableA9_PreRender">
                                    <asp:TableRow>
                                        <asp:TableCell>Европейская юридическая служба (ЕЮС)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA9_1" runat="server">
                                                 <asp:ListItem Value="1">Карта (абонемент) на обслуживание</asp:ListItem>
                                                 <asp:ListItem Value="2">Разовое</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить / отказ</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Национальная юридическая служба (Амулекс)</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA9_2" runat="server">
                                                 <asp:ListItem Value="1">Карта (абонемент) на обслуживание</asp:ListItem>
                                                 <asp:ListItem Value="2">Разовое</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить / отказ</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Правовед</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA9_3" runat="server">
                                                 <asp:ListItem Value="1">Карта (абонемент) на обслуживание</asp:ListItem>
                                                 <asp:ListItem Value="2">Разовое</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить / отказ</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Компании, обслуживающие справочные правовые системы</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA9_4" runat="server">
                                                 <asp:ListItem Value="1">Карта (абонемент) на обслуживание</asp:ListItem>
                                                 <asp:ListItem Value="2">Разовое</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить / отказ</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>Иные компании, онлайн-сервисы или юристы</asp:TableCell> 
                                        <asp:TableCell>
                                            <asp:RadioButtonList ID="RadioButtonListA9_5" runat="server">
                                                 <asp:ListItem Value="1">Карта (абонемент) на обслуживание</asp:ListItem>
                                                 <asp:ListItem Value="2">Разовое</asp:ListItem>
                                                 <asp:ListItem Value="3">Затрудняюсь ответить / отказ</asp:ListItem>
                                             </asp:RadioButtonList>                                        
                                        </asp:TableCell> 
                                    </asp:TableRow> 
                                        </asp:Table>
                                      <br/> 
                                <asp:Button ID="Button30" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button31" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A9" CommandName="Panel8" CommandArgument="9" onclick="QAC_A9" />
                            
                            </asp:Panel>


                             
                             
                            <asp:Panel ID="Panel8" runat="server"  Visible="false"> 
                                И В ЗАВЕРШЕНИЕ СКАЖИТЕ, ПОЖАЛУЙСТА:
                                <br/> 
                                10.  Сколько человек работает в штате Вашей организации (списочный состав)? (Если организация имеет сложную структуру, то ответьте только про структурную единицу (головной офис, филиал и т.п.), непосредственно в которой Вы работаете). 
                                 <div class="comment">НЕ ЗАЧИТЫВАТЬ. СНАЧАЛА ЗАПИСАТЬ ТОЧНОЕ КОЛИЧЕСТВО СОТРУДНИКОВ, А ЗАТЕМ ОТМЕТИТЬ СООТВЕТСТВУЮЩИЙ ИНТЕРВАЛ. ОДИН ОТВЕТ</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA10" Width="400" runat="server"></asp:TextBox>  человек
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="A10"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA10" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                 <asp:Button CommandName="Panel10" CommandArgument="999" ToolTip="102" onclick="QAC_Button" Text="Затрудняюсь ответить/ Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button46"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button32" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button33" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A10"  CommandName="Panel9" CommandArgument="10"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                             
                            <asp:Panel ID="Panel9" runat="server"  Visible="false">  
                                <div class="comment"> 
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel10" CommandArgument="1" ToolTip="101" onclick="QAC_Button" Text="От 1 до 5" CssClass="green unibutton  big2" Width="600"  ID="Button36"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="2" ToolTip="101" onclick="QAC_Button" Text="От 6 до 10" CssClass="green unibutton  big2" Width="600"  ID="Button37"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="3" ToolTip="101" onclick="QAC_Button" Text="От 11 до 15" CssClass="green unibutton  big2" Width="600"  ID="Button38"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="4" ToolTip="101" onclick="QAC_Button" Text="От 15 до 20" CssClass="green unibutton  big2" Width="600"  ID="Button39"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="5" ToolTip="101" onclick="QAC_Button" Text="От 21 до 50" CssClass="green unibutton  big2" Width="600"  ID="Button40"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="6" ToolTip="101" onclick="QAC_Button" Text="От 51 до 100" CssClass="green unibutton  big2" Width="600"  ID="Button41"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="7" ToolTip="101" onclick="QAC_Button" Text="От 101 до 250" CssClass="green unibutton  big2" Width="600"  ID="Button43"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="8" ToolTip="101" onclick="QAC_Button" Text="От 251 до 500" CssClass="green unibutton  big2" Width="600"  ID="Button44"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="9" ToolTip="101" onclick="QAC_Button" Text="От 501 до 1000" CssClass="green unibutton  big2" Width="600"  ID="Button45"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="10" ToolTip="101" onclick="QAC_Button" Text="1001 и более" CssClass="green unibutton  big2" Width="600"  ID="Button34"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button42" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                             
                             
                            <asp:Panel ID="Panel10" runat="server"  Visible="false"> 
                                11. <span class="comment">ЕСЛИ ОПРАШИВАЕТСЯ БУХГАЛТЕР:</span> Сколько штатных бухгалтеров работают в Вашей компании (включая Вас)? (Если организация имеет сложную структуру, то ответьте только про структурную единицу (головной офис, филиал и т.п.), непосредственно в которой Вы работаете).
                                <span class="comment">ЕСЛИ ОПРАШИВАЕТСЯ ЮРИСТ или другой специалист:</span> Есть ли в Вашей компании штатный бухгалтер или бухгалтерия? Если есть, то сколько бухгалтеров работают в Вашей компании? (Если организация имеет сложную структуру, то ответьте только про структурную единицу (головной офис, филиал и т.п.), непосредственно в которой Вы работаете). 

                                 <div class="comment">НЕ ЗАЧИТЫВАТЬ. СНАЧАЛА ЗАПИСАТЬ ТОЧНОЕ КОЛИЧЕСТВО БУХГАЛТЕРОВ, А ЗАТЕМ ОТМЕТИТЬ СООТВЕТСТВУЮЩИЙ ИНТЕРВАЛ. ОДИН ОТВЕТ</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="A11"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA10" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                 <asp:Button CommandName="Panel14" CommandArgument="999" ToolTip="112" onclick="QAC_Button" Text="Затрудняюсь ответить/ Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button47"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button48" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button49" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11"  CommandName="Panel11" CommandArgument="11"  onclick="QAC_TextBox" />
                            </asp:Panel>


                             
                             
                            <asp:Panel ID="Panel11" runat="server"  Visible="false">  
                                <div class="comment"> 
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel14" CommandArgument="1" ToolTip="111" onclick="QAC_Button" Text="Один штатный бухгалтер на половину ставки" CssClass="green unibutton  big2" Width="600"  ID="Button50"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel14" CommandArgument="2" ToolTip="111" onclick="QAC_Button" Text="Один штатный бухгалтер на полную ставку" CssClass="green unibutton  big2" Width="600"  ID="Button51"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel14" CommandArgument="3" ToolTip="111" onclick="QAC_Button" Text="2-3 штатных бухгалтера" CssClass="green unibutton  big2" Width="600"  ID="Button52"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel14" CommandArgument="4" ToolTip="111" onclick="QAC_Button" Text="Более 3-х штатных бухгалтеров" CssClass="green unibutton  big2" Width="600"  ID="Button53"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel14" CommandArgument="5" ToolTip="111" onclick="QAC_Button" Text="Нет штатных бухгалтеров" CssClass="green unibutton  big2" Width="600"  ID="Button55"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel12" CommandArgument="6" ToolTip="111" onclick="QAC_Button" Text="Другое" CssClass="green unibutton  big2" Width="600"  ID="Button57"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button62" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                             
                             
                             
                            <asp:Panel ID="Panel12" runat="server"  Visible="false">  
                                 <div class="comment">Другое</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11_6" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="A11_6"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11_6" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button59" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button60" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11_6"  CommandName="Panel14" CommandArgument="113"  onclick="QAC_TextBox" />
                            </asp:Panel>


                             
                             
                            <asp:Panel ID="Panel14" runat="server"  Visible="false"> 
                                12. <span class="comment">ЕСЛИ ОПРАШИВАЕТСЯ БУХГАЛТЕР или другой специалист, кроме юриста: </span> Есть ли в Вашей компании штатный юрист или юридический отдел? Если есть, то сколько юристов работают в Вашей компании? (Имеется в виду только Ваш офис). 
                                <span class="comment">ЕСЛИ ОПРАШИВАЕТСЯ ЮРИСТ: </span> Сколько штатных юристов работают в Вашей компании (включая Вас)? (Если организация имеет сложную структуру, то ответьте только про структурную единицу (головной офис, филиал и т.п.), непосредственно в которой Вы работаете).  

                                 <div class="comment">НЕ ЗАЧИТЫВАТЬ. СНАЧАЛА ЗАПИСАТЬ ТОЧНОЕ КОЛИЧЕСТВО ЮРИСТОВ, А ЗАТЕМ ОТМЕТИТЬ СООТВЕТСТВУЮЩИЙ ИНТЕРВАЛ. ОДИН ОТВЕТ</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA12" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="A12"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA12" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                 <asp:Button CommandName="Panel17" CommandArgument="999" ToolTip="122" onclick="QAC_Button" Text="Затрудняюсь ответить/ Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button58"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button61" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button63" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A12"  CommandName="Panel15" CommandArgument="12"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                              <asp:Panel ID="Panel15" runat="server"  Visible="false">  
                                <div class="comment"> 
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel17" CommandArgument="1" ToolTip="121" onclick="QAC_Button" Text="Один штатный юрист на половину ставки" CssClass="green unibutton  big2" Width="600"  ID="Button64"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel17" CommandArgument="2" ToolTip="121" onclick="QAC_Button" Text="Один штатный юрист на полную ставку" CssClass="green unibutton  big2" Width="600"  ID="Button65"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel17" CommandArgument="3" ToolTip="121" onclick="QAC_Button" Text="2-3 штатных юриста" CssClass="green unibutton  big2" Width="600"  ID="Button66"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel17" CommandArgument="4" ToolTip="121" onclick="QAC_Button" Text="Более 3-х штатных юристов" CssClass="green unibutton  big2" Width="600"  ID="Button67"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel17" CommandArgument="5" ToolTip="121" onclick="QAC_Button" Text="Нет штатных юристов" CssClass="green unibutton  big2" Width="600"  ID="Button69"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel16" CommandArgument="6" ToolTip="121" onclick="QAC_Button" Text="Другое" CssClass="green unibutton  big2" Width="600"  ID="Button70"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button71" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                             
                             
                             
                            <asp:Panel ID="Panel16" runat="server"  Visible="false">  
                                 <div class="comment">Другое</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA12_6" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="A12_6"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA12_6" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button72" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button73" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A12_6"  CommandName="Panel17" CommandArgument="123"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                              <asp:Panel ID="Panel17" runat="server"  Visible="false">  
                                  13. Какова основная сфера деятельности Вашей организации? (Если организация имеет сложную структуру, то ответьте только про структурную единицу (головной офис, филиал и т.п.), непосредственно в которой Вы работаете ).  
                                <div class="comment"> ЗАЧИТАТЬ. ОТМЕТИТЬ ОДИН ОТВЕТ         </div>
                                <div class="comment"> ИНТЕРВЬЮЕР! Если респондент сразу назвал ответ, который можно закодировать – не зачитывать весь список. ЗАЧИТЫВАТЬ, ЕСЛИ РЕСПОНДЕНТ НЕ МОЖЕТ ОПРЕДЕЛИТЬСЯ С НАЗВАНИЕМ СФЕРЫ     </div>
                                <br/>
                                <asp:Button CommandName="Panel19" CommandArgument="1" ToolTip="13" onclick="QAC_Button" Text="Промышленность" CssClass="green unibutton  big2" Width="600"  ID="Button74"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="2" ToolTip="13" onclick="QAC_Button" Text="Сельское и лесное хозяйство" CssClass="green unibutton  big2" Width="600"  ID="Button75"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="3" ToolTip="13" onclick="QAC_Button" Text="Строительство" CssClass="green unibutton  big2" Width="600"  ID="Button76"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="4" ToolTip="13" onclick="QAC_Button" Text="Транспорт" CssClass="green unibutton  big2" Width="600"  ID="Button77"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="5" ToolTip="13" onclick="QAC_Button" Text="Связь" CssClass="green unibutton  big2" Width="600"  ID="Button78"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="6" ToolTip="13" onclick="QAC_Button" Text="Розничная торговля и общественное питание (столовые, кафе, рестораны и т.п.)" CssClass="green unibutton  big2" Width="600"  ID="Button81"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="7" ToolTip="13" onclick="QAC_Button" Text="Оптовая торговля" CssClass="green unibutton  big2" Width="600"  ID="Button82"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="8" ToolTip="13" onclick="QAC_Button" Text="Информационно-вычислительное обслуживание" CssClass="green unibutton  big2" Width="600"  ID="Button83"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="9" ToolTip="13" onclick="QAC_Button" Text="Операции с недвижимым имуществом" CssClass="green unibutton  big2" Width="600"  ID="Button84"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="10" ToolTip="13" onclick="QAC_Button" Text="Геология, разведка недр, геодезическая и гидрометеорологическая служба" CssClass="green unibutton  big2" Width="600"  ID="Button85"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="11" ToolTip="13" onclick="QAC_Button" Text="Здравоохранение и физическая культура" CssClass="green unibutton  big2" Width="600"  ID="Button86"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="12" ToolTip="13" onclick="QAC_Button" Text="Культура и искусство" CssClass="green unibutton  big2" Width="600"  ID="Button87"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="13" ToolTip="13" onclick="QAC_Button" Text="Наука и научное обслуживание" CssClass="green unibutton  big2" Width="600"  ID="Button88"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="14" ToolTip="13" onclick="QAC_Button" Text="Финансы – банковское дело, страхование" CssClass="green unibutton  big2" Width="600"  ID="Button89"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="15" ToolTip="13" onclick="QAC_Button" Text="ВЭД (внешнеэкономическая деятельность)" CssClass="green unibutton  big2" Width="600"  ID="Button90"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="16" ToolTip="13" onclick="QAC_Button" Text="Бизнес-услуги, консалтинг (включая бухгалтерское дело, аудиторские услуги и налогообложение)" CssClass="green unibutton  big2" Width="600"  ID="Button91"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="17" ToolTip="13" onclick="QAC_Button" Text="СМИ/маркетинг/реклама" CssClass="green unibutton  big2" Width="600"  ID="Button92"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="18" ToolTip="13" onclick="QAC_Button" Text="Бытовые услуги, включая гостиничное дело" CssClass="green unibutton  big2" Width="600"  ID="Button93"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="19" ToolTip="13" onclick="QAC_Button" Text="Издательско-полиграфическая деятельность" CssClass="green unibutton  big2" Width="600"  ID="Button94"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel18" CommandArgument="998" ToolTip="13" onclick="QAC_Button" Text="Другое" CssClass="green unibutton  big2" Width="600"  ID="Button96"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel19" CommandArgument="999" ToolTip="13" onclick="QAC_Button" Text="Затрудняюсь ответить/ Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button79"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button80" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                            <asp:Panel ID="Panel18" runat="server"  Visible="false">  
                                 <div class="comment">Другое</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA13_998" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="A13_998"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA13_998" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button97" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button98" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A13_998"  CommandName="Panel19" CommandArgument="13998"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel19" runat="server"  Visible="false"> 
                                14. Сколько Вам полных лет? 
                                 <div class="comment">СНАЧАЛА ЗАПИШИТЕ ВОЗРАСТ, ЗАТЕМ ОТМЕТЬТЕ ДИАПАЗОН</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA14" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="A14"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA14" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                 <asp:Button CommandName="Panel21" CommandArgument="999" ToolTip="142" onclick="QAC_Button" Text="Отказ от ответа" CssClass="green unibutton  big2" Width="600"  ID="Button99"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button100" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button101" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A14"  CommandName="Panel20" CommandArgument="14"  onclick="QAC_TextBox" />
                            </asp:Panel>

                                  
                              <asp:Panel ID="Panel20" runat="server"  Visible="false">  
                                <div class="comment"> 
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel21" CommandArgument="1" ToolTip="141" onclick="QAC_Button" Text="Менее 25" CssClass="green unibutton  big2" Width="600"  ID="Button102"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel21" CommandArgument="2" ToolTip="141" onclick="QAC_Button" Text="25-30" CssClass="green unibutton  big2" Width="600"  ID="Button103"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel21" CommandArgument="3" ToolTip="141" onclick="QAC_Button" Text="31-34" CssClass="green unibutton  big2" Width="600"  ID="Button104"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel21" CommandArgument="4" ToolTip="141" onclick="QAC_Button" Text="35-45" CssClass="green unibutton  big2" Width="600"  ID="Button105"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel21" CommandArgument="5" ToolTip="141" onclick="QAC_Button" Text="46 и более" CssClass="green unibutton  big2" Width="600"  ID="Button106"  runat="server" /><br/> 
                                  
                                <br/>
                                <asp:Button ID="Button108" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                               
                              <asp:Panel ID="Panel21" runat="server"  Visible="false">  
                                  15. Пол респондента? 
                                <div class="comment"> 
                                    (ОТМЕТИТЬ НЕ СПРАШИВАЯ)
                                </div>
                                <br/>
                                <asp:Button CommandName="Panel22" CommandArgument="1" ToolTip="15" onclick="QAC_Button" Text="М" CssClass="green unibutton  big2" Width="600"  ID="Button107"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel22" CommandArgument="2" ToolTip="15" onclick="QAC_Button" Text="Ж" CssClass="green unibutton  big2" Width="600"  ID="Button109"  runat="server" /><br/> 
                                   
                                <br/>
                                <asp:Button ID="Button113" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>

                            <asp:Panel ID="Panel22" runat="server"  Visible="false"> 
                                УТОЧНИТЕ ИНФОРМАЦИЮ О ВАШЕМ ПРЕДПРИЯТИИ 
                                <br/>  
                                     16. Название организации <br/> 
                                 <asp:TextBox ID="TextBoxA16" Width="400" runat="server"></asp:TextBox>   
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="A16"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA16" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               
                                <br/> 
                                 <asp:Button ID="Button111" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button112" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A16"  CommandName="Panel23" CommandArgument="16"  onclick="QAC_TextBox" />
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
