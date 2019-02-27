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
         
        <asp:HiddenField ID="HF_Abonent_ID" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_12" runat="server" /> 
        <asp:HiddenField ID="HiddenFieldColumn_3" runat="server" /> 
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
                             
                             
                             
                            <asp:Panel ID="Panel1_3" runat="server">
                                «<asp:Label ID="Label1_ClientName" CssClass="fio"  runat="server" Text="Имя клиента"></asp:Label>», добрый день(вечер)! 
                                <div class="comment">– пауза для реакции –</div> 
                                Меня зовут «<asp:Label ID="Label1"     runat="server" Text=""></asp:Label>», НПО «Прибор ганк». 
                                Наша компания с 1990 года производит газоанализаторы для контроля загазованности атмосферы и воздуха рабочей зоны.<br/>
                                Скажите, на данный момент у Вас есть какие-то проекты по контролю ПДК рабочей зоны или атмосферы, где можно было бы предложить наше решение задачи?
                                <asp:HiddenField ID="HiddenFieldA1" runat="server" />
                                <br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="есть" ToolTip="1" onclick="QAC_Button" Text="есть" CssClass="green unibutton  big2" Width="300"  ID="Button42_2_5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel28" CommandArgument="нет" ToolTip="1" onclick="QAC_Button" Text="нет" CssClass="green unibutton  big2" Width="300"  ID="Button2"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel54" CommandArgument="отказ от ответа / нет данных" ToolTip="1" onclick="QAC_Button" Text="отказ от ответа / нет данных" CssClass="red unibutton  big2" Width="300"  ID="Button3_2_5"  runat="server" /><br/> 
                                 
                            </asp:Panel>
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false">
                                А в ближайшем будущем появятся? Может, у Вас планируется закупка газоанализаторов, взамен тех, что вышли из строя?
                                <br/> 
                                <asp:HiddenField ID="HiddenFieldA2" runat="server" />
                                <asp:Button CommandName="Panel29" CommandArgument="да" ToolTip="2" onclick="QAC_Button" Text="да" CssClass="green unibutton  big2" Width="600"  ID="Button57"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="нет" ToolTip="2" onclick="QAC_Button" Text="нет" CssClass="green unibutton  big2" Width="600"  ID="Button58"  runat="server" /><br/> 
                                <br />
                                <asp:Button ID="Button6" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />

                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel29" runat="server" Visible="false">
                                Результат презентации:
                                <asp:HiddenField ID="HiddenFieldA3" runat="server" />
                                <br/> 
                                <asp:Button CommandName="Panel1" CommandArgument="звонок специалиста"  ToolTip="3" onclick="QAC_Button_Result" Text="звонок специалиста" CssClass="green unibutton  big2" Width="600"  ID="Button59"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel54" CommandArgument="отправить письмо" ToolTip="3" onclick="QAC_Button_Result" Text="отправить письмо" CssClass="green unibutton  big2" Width="600"  ID="Button3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel7" CommandArgument="отказ" ToolTip="3" onclick="QAC_Button" Text="отказ" CssClass="green unibutton  big2" Width="600"  ID="Button60"  runat="server" /><br/> 
                                <br />
                                <asp:Button ID="Button5" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />

                            </asp:Panel>  
                             
                            <asp:Panel ID="Panel27" runat="server" Visible="false"> 
                                В какое время, Вам было бы удобней, что бы мы перезвонили?
                                <div class="comment">– зафиксировать –</div> Спасибо! Мы свяжемся с Вами!
                                <br />
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
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

                               
                             

                            <asp:Panel ID="Panel7" runat="server"  Visible="false"> 
                                 <div class="comment">Причина отказа</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA4_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="A4_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button20" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4_2"  CommandName="Panel54" CommandArgument="303"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                            <asp:Panel ID="Panel1" runat="server"  Visible="false"> 
                                 <div class="comment">Дата и время звонка специалиста</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA4_3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="A4_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4_3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button4" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4_3"  CommandName="Panel54" CommandArgument="301"  onclick="QAC_TextBox_A4_3" />
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
                             
                            <asp:Panel ID="PanelForms" runat="server"> 
                                 <table border="0">
                                     <tr>
                                         <td>Кампания</td>
                                         <td><asp:TextBox ID="TextBoxNameCampaign" runat="server"></asp:TextBox></td>
                                     </tr> 
                                     <tr>
                                         <td>ФИО ЛПР</td>
                                         <td><asp:TextBox ID="TextBoxFIOLPR" runat="server"></asp:TextBox></td>
                                     </tr>
                                     <tr>
                                         <td>Должность ЛПР</td>
                                         <td><asp:TextBox ID="TextBoxDolgnostLPR" runat="server"></asp:TextBox></td>
                                     </tr>
                                     <tr>
                                         <td>Телефон ЛПР</td>
                                         <td><asp:TextBox ID="TextBoxPhoneLPR" runat="server"></asp:TextBox></td>
                                     </tr>
                                     <tr>
                                         <td>Комментарии</td>
                                         <td><asp:TextBox ID="TextBoxComment" TextMode="MultiLine" Width="500" Height="100"  runat="server"></asp:TextBox></td>
                                     </tr>

                                 </table>
                              
                            </asp:Panel> 
                              

                             
        <asp:HiddenField ID="HiddenFieldOut_ID" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdLead" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdNoteA1" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdNoteA2" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdNoteA3" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdNoteA4_3" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdNoteAComment" runat="server" />

                             

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


            <asp:TabPanel runat="server" HeaderText="CRM" Visible="false" ID="TabPanel3">
                <ContentTemplate>
                    <iframe width="100%" height="600" src="http://wil-krim.ws.local/site/Questionary/projects/AmoCrmIntegration/Gank/gank.aspx?IdChain=<%=GetIdChain() %>&Column_3=<%=GetColumn3() %>"></iframe>
                </ContentTemplate>
            </asp:TabPanel>

        </asp:TabContainer>
    
    </div>
    </form>
</body>
</html>
