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
                             
                             
                             
                            <asp:Panel ID="Panel1_3" runat="server">
                                Добрый день/вечер, меня зовут «<asp:Label ID="Label2_2_n"     runat="server" Text=""></asp:Label>» компания «Хот вай фай», чем я могу Вам помочь?
                                  
                                <br/> 
                                <asp:Button CommandName="Panel2_4"  onclick="standartNext" Text="Далее" CssClass="green unibutton  big2" Width="300"  ID="Button42_2_5"  runat="server" /><br/> 
                                  
                            </asp:Panel>
                             

                              <asp:Panel ID="Panel2_4" runat="server"  Visible="false" CssClass="1">
                                Как я могу к Вам обращаться? 
                                <br/> 
                                 <asp:TextBox ID="TextBoxAbonentName" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="F5_2_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxAbonentName" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button57" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button58" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F5_2_1"  CommandName="Panel1_2" CommandArgument="2"  onclick="QAC_TextBox" />
                            </asp:Panel>  
                            
                             
                            <asp:Panel ID="Panel1_2" runat="server" Visible="false"> 
                                «<asp:Label ID="Label1_fio"   CssClass="fio"    runat="server" Text=""></asp:Label>», подскажите пожалуйста, Вы являетесь нашим действующим клиентом? 
                                <br/> 
                                <asp:Button CommandName="Panel2_2" CommandArgument="Да" ToolTip="3" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button42_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel26" CommandArgument="Нет" ToolTip="3" onclick="QAC_Button" Text="Нет" CssClass="red unibutton  big2" Width="600"  ID="Button3_2"  runat="server" /><br/> 
                                <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel>
                            
                            
                            
                            <asp:Panel ID="Panel2_2" runat="server"  Visible="false" CssClass="1">
                                Договор заключен напрямую с компанией или с партнером?
                                 <div class="comment"></div>
                                  <br/> 
                                <asp:Button CommandName="Panel26" CommandArgument="С кампанией" ToolTip="4" onclick="QAC_Button" Text="С кампанией" CssClass="green unibutton  big2" Width="600"  ID="Button138_2_5"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel26" CommandArgument="С партнером"  ToolTip="4" onclick="QAC_Button" Text="С партнером" CssClass="green unibutton  big2" Width="600"  ID="Button206_2_1"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button5_2" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel27" runat="server" Visible="false"> 
                                Всего доброго, до свидания! (Перезвонить) <br />
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                             
                            <asp:Panel ID="Panel33" runat="server" Visible="false"> 
                                Всего доброго, до свидания! <br />
                                <asp:Button ID="Button35" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                             
                               

                            <asp:Panel ID="Panel3" runat="server" Visible="false">
                                <asp:Label ID="LBQuoteMsg" runat="server" Text="" Visible="False" CssClass="warning"></asp:Label>
                                ЗАКОНЧИТЬ ИНТЕРВЬЮ<br />
                                <asp:Button ID="Button7" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel26" runat="server"  Visible="false" CssClass="1">
                                
                                 <div class="comment"></div>
                                  <br/> 
                                <asp:Button CommandName="Panel37" CommandArgument="Действующий клиент (технические запросы)" ToolTip="5" onclick="QAC_Button" Text="Действующий клиент (технические запросы)" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button11"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3" CommandArgument="Действующий партнер (технические запросы)" ToolTip="5" onclick="QAC_Button" Text="Действующий партнер (технические запросы)" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button54"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3" CommandArgument="Клиент партнера (технические запросы)" ToolTip="5" onclick="QAC_Button" Text="Клиент партнера (технические запросы)" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button59"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3" CommandArgument="Действующий клиент (продуктовые запросы)" ToolTip="5" onclick="QAC_Button" Text="Действующий клиент (продуктовые запросы)" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button60"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3" CommandArgument="Действующий партнер (продуктовые запросы)" ToolTip="5" onclick="QAC_Button" Text="Действующий партнер (продуктовые запросы)" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button61"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3" CommandArgument="Клиент партнера (продуктовые запросы)" ToolTip="5" onclick="QAC_Button" Text="Клиент партнера (продуктовые запросы)" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button62"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3" CommandArgument="Новый клиент" ToolTip="5" onclick="QAC_Button" Text="Новый клиент" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button52"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel2_3_1" CommandArgument="Новый партнер"  ToolTip="5" onclick="QAC_Button" Text="Новый партнер"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="600"  ID="Button53"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button55" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                                         
                             
                            <asp:Panel ID="Panel37" runat="server"  Visible="false">
                                 
                                 <div class="comment"> 
                                 </div> 
                                <asp:Button CommandName="Panel5" CommandArgument="Нет"  ToolTip="3" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button36"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel22" CommandArgument="Да" ToolTip="3" onclick="QAC_Button_F3" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button9"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button37" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel> 

                            <asp:Panel ID="Panel5" runat="server"  Visible="false">                                
                                В таком случае, «<asp:Label ID="Label3_33"    CssClass="fio" runat="server" Text=""></asp:Label>», приглашаю Вас посетить веб-сайт «интерчАрм точка ру» (Intercharm.ru) и познакомиться с выставкой и ее участниками поближе. Там же Вы сможете приобрести билет <b style="background-color: yellow;">со скидкой!</b> Мы будем рады видеть вас в числе посетителей выставки!
                                «<asp:Label ID="Label3_34"    CssClass="fio" runat="server" Text=""></asp:Label>», благодарю Вас за разговор. Всего доброго, до свидания!
                                <div class="comment"> </div>
                                <br/> 
                               <br/>
                                <asp:Button ID="Button8" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                              
                             
                              
                            
                            <asp:Panel ID="Panel22" runat="server"  Visible="false">                             
                                Фраза4: <div class="comment">Если в таблице НЕ УКАЗАНА профессия/должность</div>
                                <asp:Label ID="Label3_35"    CssClass="fio" runat="server" Text=""></asp:Label> уточните, пожалуйста, вашу профессию<br/> 
                                <div class=comment>(можно подсказать: мастер ногтевого сервиса, парикмахер, визажист, массажист, администратор, владелец и др., может быть просто любитель)</div>
                                <br/>
                                <asp:Button CommandName="Panel57_F4_1" CommandArgument="косметолог (сюда же относятся дерматовенерологи, дерматологи, специалисты эстетической медицины)"    ToolTip="4" onclick="QAC_Button" Text="косметолог (сюда же относятся дерматовенерологи, дерматологи, специалисты эстетической медицины)" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_1"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_2" CommandArgument="мастер ногтевого сервиса"                                                                            ToolTip="4" onclick="QAC_Button" Text="мастер ногтевого сервиса" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_3" CommandArgument="парикмахер или стилист"                                                                              ToolTip="4" onclick="QAC_Button" Text="парикмахер или стилист" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_4" CommandArgument="Визажист"                                                                                            ToolTip="4" onclick="QAC_Button" Text="Визажист" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_4"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_5" CommandArgument="массажист"                                                                                           ToolTip="4" onclick="QAC_Button" Text="массажист" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_5"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_6" CommandArgument="владелец/руководитель/администратор"                                                                 ToolTip="4" onclick="QAC_Button" Text="владелец/руководитель/администратор" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_6"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_8" CommandArgument="врач, трихолог, подолог"                                                                             ToolTip="4" onclick="QAC_Button" Text="врач, трихолог, подолог" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_8"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_9" CommandArgument="мастер перманентного макияжа"                                                                        ToolTip="4" onclick="QAC_Button" Text="мастер перманентного макияжа" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_9"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_7" CommandArgument="любая иная должность/профессия, не указанная выше"                                                   ToolTip="4" onclick="QAC_Button" Text="любая иная должность/профессия, не указанная выше" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_7"  runat="server" /><br/> 
                                
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                            </asp:Panel> 
                              
                              
                            
                            <asp:Panel ID="Panel22_2" runat="server"  Visible="false">                             
                                Фраза4:  
                                <asp:Label ID="Label3_38"    CssClass="fio" runat="server" Text=""></asp:Label>, Вы посещали ранее нашу выставку как «<asp:Label ID="Label3_37"    runat="server" Text=""></asp:Label>», верно?
                                 
                                <br/>
                                <asp:Button CommandName="Panel57" CommandArgument="Да"    ToolTip="401" onclick="QAC_Button_F4" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="ButtonF4_1_1"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel22_2_1" CommandArgument="Нет"   ToolTip="401" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="ButtonF4_1_2"  runat="server" /><br/> 
                              
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_9" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                            </asp:Panel> 
                            
                            
                            
                            <asp:Panel ID="Panel22_2_1" runat="server"  Visible="false">                             
                                
                                <asp:Label ID="Label3_39"    CssClass="fio" runat="server" Text=""></asp:Label> уточните, пожалуйста, вашу профессию<br/> 
                                <div class=comment>(можно подсказать: мастер ногтевого сервиса, парикмахер, визажист, массажист, администратор, владелец и др., может быть просто любитель)</div>
                                <br/>
                                <asp:Button CommandName="Panel57_F4_1" CommandArgument="косметолог (сюда же относятся дерматовенерологи, дерматологи, специалисты эстетической медицины)"    ToolTip="4" onclick="QAC_Button" Text="косметолог (сюда же относятся дерматовенерологи, дерматологи, специалисты эстетической медицины)" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_1_3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_2" CommandArgument="мастер ногтевого сервиса"                                                                            ToolTip="4" onclick="QAC_Button" Text="мастер ногтевого сервиса" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_2_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_3" CommandArgument="парикмахер или стилист"                                                                              ToolTip="4" onclick="QAC_Button" Text="парикмахер или стилист" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_3_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_4" CommandArgument="Визажист"                                                                                            ToolTip="4" onclick="QAC_Button" Text="Визажист" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_4_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_5" CommandArgument="массажист"                                                                                           ToolTip="4" onclick="QAC_Button" Text="массажист" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_5_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_6" CommandArgument="владелец/руководитель/администратор"                                                                 ToolTip="4" onclick="QAC_Button" Text="владелец/руководитель/администратор" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_6_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_8" CommandArgument="врач, трихолог, подолог"                                                                 ToolTip="4" onclick="QAC_Button" Text="врач, трихолог, подолог" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_8_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_9" CommandArgument="мастер перманентного макияжа"                                                                 ToolTip="4" onclick="QAC_Button" Text="мастер перманентного макияжа" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_9_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel57_F4_7" CommandArgument="любая иная должность/профессия, не указанная выше"                                                   ToolTip="4" onclick="QAC_Button" Text="любая иная должность/профессия, не указанная выше" CssClass="green unibutton  big2" Width="820"  ID="ButtonF4_7_2"  runat="server" /><br/> 
                                
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_10" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                            </asp:Panel> 

                            
                            <asp:Panel ID="Panel57_F4_1" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_1"    CssClass="fio" runat="server" Text=""></asp:Label>», для косметологов <b>Интершарм</b> – это возможность познакомиться с основными игроками российского и зарубежного рынков косметологии и эстетической медицины, оценить предложения дистрибьюторов, посмотреть мастер-классы, побеседовать с ведущими методистами и выбрать для себя направления, в которых Вам будет интересно и перспективно развиваться как специалисту. 
                                <span class="comment"> Мини-пауза.</span> Помимо насыщенной экспозиции на выставке Вас ждет целая серия специализированных мероприятий. Например, наш премьерный Косметологический конгресс Интершарм 
                                <span class="comment">(пауза)</span> Мед  – это трёхдневная серия конференций, посвященных современным методам в косметологии и эстетической медицине. Программа конференции подойдет как начинающим косметологом, так и опытным практикующим. Каждый найдет для себя что-то интересное и новое. Мы специально сделали билет доступным, чтобы любой профессионал смог ее посетить.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 

                            
                            <asp:Panel ID="Panel57_F4_2" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_f4_2"    CssClass="fio" runat="server" Text=""></asp:Label>»,  для мастеров ногтевого сервиса <b>Интершарм</b> – это возможность познакомиться с многообразием компаний, представляющих продукцию для маникюра и педикюра, гель-лаки, украшения и инструменты для дизайна ногтей и профессиональные инструментов. На выставке вы сможете наглядно увидеть применение современных техник и методик нэйл-индустрии на многочисленных мастер-классах и мероприятиях от ведущих специалистов. Также по билету любой категории Вы сможете принять участие в мастер-классах от известных блогеров в рамках нашего проекта «Команда красоты» и в серии мастер-классов «Нэйл Дисант». Подробное расписание программы доступно на нашем сайте.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_2" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_2" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel57_F4_3" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_f4_3"    CssClass="fio" runat="server" Text=""></asp:Label>», для мастеров парикмахерского искусства и стилистов <b>Интершарм</b> – это возможность познакомиться с многообразием компаний, представляющих продукцию для ухода за волосами, окрашивания, средства укладки, расходные материалы, профессиональные инструменты и аксессуары. На выставке вы сможете наглядно увидеть применение современных техник и методик парикмахерского искусства на многочисленных мастер-классах и мероприятиях от ведущих специалистов. В этом году мы планируем обширную программу для стилистов и парикмахеров: 3 дня программы МОНЭ импрэшэн, в рамках которой выступят известные мировые стилисты, а также большие мастер-классы от команды Анны Эшвуд и академии Тониэндгай и еще много всего интересного.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_3" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_3" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 
                            
                            <asp:Panel ID="Panel57_F4_4" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_f4_4"    CssClass="fio" runat="server" Text=""></asp:Label>», для визажистов и бровистов <b>Интершарм</b> – это возможность познакомиться с многообразием компаний, представляющих профессиональную декоративную косметику, кисти, профессиональные кейсы, световое оборудование. На выставке вы сможете наглядно увидеть и попробовать современные техник и методики владения искусством макияжа на многочисленных мастер-классах и мероприятиях от ведущих специалистов. Здесь вы узнаете все о тенденциях в архитектуре бровей и наращивании ресниц. В этом году мы впервые проводим Интершарм  Бьюти Токс, где глянцевые издания будут обсуждать актуальные тренды индустрии вместе с бьюти-блогерами и селебрити. Также по билету любой категории Вы сможете принять участие в мастер-классах от известных блогеров в рамках нашего проекта «Команда красоты». Подробное расписание программы доступно на нашем сайте.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_4" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_4" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 
                            
                            <asp:Panel ID="Panel57_F4_5" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_f4_5"    CssClass="fio" runat="server" Text=""></asp:Label>», для массажистов <b>Интершарм</b> – это возможность познакомиться с многообразием компаний, представляющих продукцию от расходных материалов и массажных масел до профессионального массажного оборудования, массажеров и мебели. На выставке вы сможете наглядно увидеть современные техники и методики на многочисленных мастер-классах и мероприятиях от ведущих специалистов. В этот раз на выставке мы проводим семинар "Эргономика в массаже". Также в рамках выставки центр подготовки и развития массажистов проводит чемпионат для мастеров-универсалов по эстетической косметологии. Вы можете стать зрителем и того и другого мероприятия по билету любой категории.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_5" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_5" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 
                            
                            <asp:Panel ID="Panel57_F4_6" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_f4_6"    CssClass="fio" runat="server" Text=""></asp:Label>», для владельцев и руководителей <b>Интершарм</b> – это возможность познакомиться с современными конкурентнособными решениями в области управления бизнесом, договориться о поставках продукции для косметологических, эстетических, маникюрных, педикюрных, парикмахерских и других услуг бьюти-индустрии, получить знания о новых тенденциях и лучших практиках, препаратах и методиках. Иными словами, во время Интершарма вы можете полностью укомплектовать свой салон. На выставке вы также сможете узнать о возможностях обучения ваших специалистах в учебных центрах и пообщаться с экспертами рынка на бизнес-мероприятиях и презентациях. Среди бизнес мероприятий, который могут быть вам интересны: Форум Как создать бьюти бренд? И конференция о тенденциях в индустрии – «РитЭйл конЕкт».  Также в этом году мы впервые вводим специальную программу для руководителей салонов красоты Интершарм Премиум. Программа будет действовать круглый год. В ней очень много преимуществ. Можете на сайте подробно с ней ознакомиться, если будет интересно.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_6" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_6" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 
                            
                            <asp:Panel ID="Panel57_F4_7" runat="server"  Visible="false">  
                                «<asp:Label ID="Label4_f4_7"    CssClass="fio" runat="server" Text=""></asp:Label>», придя на <b>Интершарм</b> Вы сможете увидеть лучшие бренды профессиональной косметики, новых производителей, новинки опытных компаний,  последние тенденции и технологии, познакомиться со специалистами и с удовольствием провести время на крупнейшей весенней выставке индустрии красоты в России. На выставке проходят сотни мастер-классов, на которых вы узнаете о модных решениях в области макияжа, маникюра и стрижек, а также новейших процедурах в косметологии. В этом году мы впервые проводим Бьюти Токс, где известные глянцевые издания будут обсуждать актуальные тренды бьюти индустрии вместе с публичными личностями.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_7" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_7" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel>  
                              
                            <asp:Panel ID="Panel57_F4_8" runat="server"  Visible="false">  
                                «<asp:Label ID="Label5"    CssClass="fio" runat="server" Text=""></asp:Label>», для врачей <b>Интершарм</b> – это возможность познакомиться с основными игроками российского и зарубежного рынков косметологии и эстетической медицины, оценить предложения и новинки в таких областях, как: менеджмент осложнений, здоровье кожи головы, лица и тела, волос и головы. Посмотреть мастер-классы, побеседовать с ведущими врачами. Выставку традиционно посещает много врачей разной направленности, в том числе пластические хирурги, трихологи и подологи. <span class="comment">Мини-пауза</span>. Помимо насыщенной экспозиции на выставке Вас ждет целая серия специализированных мероприятий. Например, наш премьерный Косметологический конгресс Интершарм <span class="comment">(пауза)</span> Мед – это трёхдневная серия конференций, посвященных современным методам в косметологии и эстетической медицине. Мы специально сделали билет доступным, чтобы любой профессионал смог ее посетить. Также в рамках выставки проводится чемпионат для мастеров-универсалов по эстетической косметологии.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_8" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_8" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel>   
                              
                            <asp:Panel ID="Panel57_F4_9" runat="server"  Visible="false">  
                                «<asp:Label ID="Label6"    CssClass="fio" runat="server" Text=""></asp:Label>», для мастеров перманентного макияжа <b>Интершарм</b> – то возможность познакомиться с основными игроками российского и зарубежного рынка, оценить предложения дистрибьюторов на пигменты и инструменты для перманентного макияжа, посмотреть мастер-классы, побеседовать с ведущими специалистами и выбрать для себя направления, в которых Вам будет интересно и перспективно развиваться как специалисту.
                                <br/> 
                                <br/> 
                                <asp:Button ID="Button6_1_9" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_1_9" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel4"    onclick="standartNext" />
                            </asp:Panel> 
                             
                             
                            <asp:Panel ID="Panel4" runat="server"  Visible="false">
                                Фраза5:  
                                <asp:Panel ID="Panel12_1" runat="server"  Visible="false">
                                    «<asp:Label ID="Label7"    CssClass="fio" runat="server" Text=""></asp:Label>», по моей информации Вы работаете «<asp:Label ID="Label11" CssClass="Column_11" runat="server" Text=""></asp:Label>» в компании «<asp:Label ID="Label13" CssClass="Column_9" runat="server" Text=""></asp:Label>» и она занимается "<asp:Label ID="Label14" CssClass="Column_13" runat="server" Text=""></asp:Label>"
                                    <br/>Все верно?
                                    
                                </asp:Panel>
                                <asp:Panel ID="Panel12_2" runat="server"  Visible="false">
                                    «<asp:Label ID="Label8"    CssClass="fio" runat="server" Text=""></asp:Label>», по моей информации вы работаете «<asp:Label ID="Label12" CssClass="Column_11" runat="server" Text=""></asp:Label>». 
                                    Верно?
                                                                    
                                </asp:Panel>
                                <asp:Panel ID="Panel12_3" runat="server"  Visible="false">
                                    «<asp:Label ID="Label9"    CssClass="fio" runat="server" Text=""></asp:Label>», Подскажите, пожалуйста, Вы работаете на себя или в какой-то компании?
                                </asp:Panel>

                                
                                <asp:Button ID="Button13_2" Visible="false" runat="server" Text="Все верно" CssClass="blue unibutton"    CommandName="Panel11"    onclick="standartNext" />    
                                <asp:CheckBoxList ID="CheckBoxListF5" runat="server"   >
                                        <asp:ListItem Value="1">должность указана не верно</asp:ListItem>  
                                        <asp:ListItem Value="2">компания указана неверно</asp:ListItem>  
                                        <asp:ListItem Value="3">отрасль указана не верно</asp:ListItem>    
                                 </asp:CheckBoxList>
                                <br/> 
                                <asp:Button ID="Button12" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />                             
                                <asp:Button ID="Button13" Visible="false" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel11"    onclick="standartNext_F5" />
                                <br/> 
                                
                                
                                <asp:Button CommandName="Panel55_1" Visible="false" CommandArgument="на себя" ToolTip="5" onclick="QAC_Button" Text="на себя" CssClass="green unibutton  big2" Width="820"  ID="Button14"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel11" Visible="false" CommandArgument="в компании" ToolTip="5" onclick="QAC_Button" Text="в компании" CssClass="green unibutton  big2" Width="820"  ID="Button15"  runat="server" /><br/> 
                                

                                <asp:Button CommandName="Panel_F5_2" Visible="false" CommandArgument="да" ToolTip="508" onclick="QAC_Button" Text="да" CssClass="green unibutton  big2" Width="820"  ID="Button14_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel_F5_2_1" Visible="false" CommandArgument="нет" ToolTip="508" onclick="QAC_Button" Text="нет" CssClass="green unibutton  big2" Width="820"  ID="Button15_2"  runat="server" /><br/> 
                                

                            </asp:Panel>    
                            
                            
                            <asp:Panel ID="Panel_F5_1_1" runat="server"  Visible="false"> 
                                
                                <asp:Panel ID="Panel_F5_Dolgnost" runat="server"  Visible="false"> 
                                    <span class="comment">Должность</span>
                                    <br/> 
                                     <asp:TextBox ID="TextBoxF5_1_1" Width="400" runat="server"></asp:TextBox> 
                                    <br/>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidatorF5_1_1" ValidationGroup="F5_1_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF5_1_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               </asp:Panel> 
                               
                               
                                <asp:Panel ID="Panel_F5_Company" runat="server"  Visible="false"> 
                                    <span class="comment">Компания</span>
                                    <br/> 
                                     <asp:TextBox ID="TextBoxF5_1_2" Width="400" runat="server"></asp:TextBox> 
                                    <br/>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidatorF5_1_2" ValidationGroup="F5_1_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF5_1_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               </asp:Panel> 
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button121F5_1_1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button128F5_1_1" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F5_1_1"  CommandName="Panel_F5_2"    onclick="standartNext_F5_1" />
                            </asp:Panel> 
                              
                              
                            
                            
                            <asp:Panel ID="Panel_F5_2_1" runat="server"  Visible="false"> 
                                <span class="comment">Должность</span>
                                <br/> 
                                 <asp:TextBox ID="TextBoxF5_2_1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorF5_2_1" ValidationGroup="F5_2_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF5_2_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button121F5_2_1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button128F5_2_1" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F5_2_1"  CommandName="Panel11" CommandArgument="509"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                              
                              
                            <asp:Panel ID="Panel_F5_2" runat="server"  Visible="false">  
                                Подскажите, пожалуйста, Вы работаете на себя или в какой-то компании?    
                                <br/> 
                                
                                <asp:Button CommandName="Panel55_1"   CommandArgument="на себя" ToolTip="5" onclick="QAC_Button" Text="на себя" CssClass="green unibutton  big2" Width="820"  ID="Button14F5_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel11"   CommandArgument="в компании" ToolTip="5" onclick="QAC_Button" Text="в компании" CssClass="green unibutton  big2" Width="820"  ID="Button15F5_2"  runat="server" /><br/> 
                                

                                <asp:Button ID="Button6_1_9_3" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                                
                            </asp:Panel> 
                             
                              
                             
                            <asp:Panel ID="Panel11" runat="server"  Visible="false">
                                 Фраза5.1:  
                                Скажите, чем занимается Ваша компания <span class="comment">(далее очень четко и медленно произнести, не смешивая слова воедино)</span> 
                                 <b style="background-color: yellow;"> услугами, дистрибуцией, торговлей или производством?</b>
                                 

                                <div class="comment">Зафиксировать</div>
                                <br/>

                                  <asp:CheckBoxList ID="CheckBoxListA4_2" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="QAC_CheckBoxList_OnSelectedIndexChanged">
                                        <asp:ListItem Value="1">Услугами</asp:ListItem>  
                                        <asp:ListItem Value="2">Дистрибуцией</asp:ListItem>  
                                        <asp:ListItem Value="3">Торговлей</asp:ListItem>   
                                        <asp:ListItem Value="4">Производством</asp:ListItem>       
                                 </asp:CheckBoxList>
                                <br/> 
                                <asp:Button CommandName="Panel55_1" CommandArgument="Я мастер / Работаю сама на себя" ToolTip="501" onclick="QAC_Button" Text="Я мастер / Работаю сама на себя" CssClass="green unibutton  big2" Width="600"  ID="Button123"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel55_1" CommandArgument="Компания не занимается косметикой / Я хожу для себя / Я покупатель" ToolTip="502" onclick="QAC_Button" Text="[Компания не занимается косметикой / Я хожу для себя / Я покупатель" CssClass="green unibutton  big2" Width="600"  ID="Button124"  runat="server" /><br/> 
                
                                    <br/> 
                                <asp:Button ID="Button39" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button41" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A4_2" CommandName="Panel9" CommandArgument="503" onclick="QAC_CheckBoxList_A4_2" />
                            
                            </asp:Panel>


                             
                            <asp:Panel ID="Panel55" runat="server"  Visible="false"> 
                                В какой сфере работаете?
                                <br/> 
                                 <asp:TextBox ID="TextBoxA52" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="A52"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA52" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button121" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button128" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A52"  CommandName="Panel55_1" CommandArgument="52"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                              
                             
                            <asp:Panel ID="Panel6" runat="server"  Visible="false">
                                Уточните, пожалуйста, какими услугами занимается Ваша компания?
                                <div class="comment">Зафиксировать, если затруднения при ответе – помочь, произнеся варианты на выбор, как в таблице выходных данных</div>
                                <br/>
                                <asp:Button CommandName="Panel8" CommandArgument="Салон красоты" ToolTip="504" onclick="QAC_Button" Text="Салон красоты" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_1"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Клиника" ToolTip="504" onclick="QAC_Button" Text="Клиника" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Парикмахерская" ToolTip="504" onclick="QAC_Button" Text="Парикмахерская" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Ногтевая студия" ToolTip="504" onclick="QAC_Button" Text="Ногтевая студия" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_4"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Спа-центр" ToolTip="504" onclick="QAC_Button" Text="Спа-центр" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_5"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Медицинский центр" ToolTip="504" onclick="QAC_Button" Text="Медицинский центр" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_6"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Лечебное учреждение" ToolTip="504" onclick="QAC_Button" Text="Лечебное учреждение" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_7"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel8" CommandArgument="Фитнес-центр" ToolTip="504" onclick="QAC_Button" Text="Фитнес-центр" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_8"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel7" CommandArgument="Другое: " ToolTip="504" onclick="QAC_Button" Text="Другое (указать, что именно)" CssClass="green unibutton  big2" Width="600"  ID="Button10"  runat="server" /><br/> 
                
                                <br/>
                                <asp:Button ID="Button17" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel7" runat="server"  Visible="false"> 
                                 <div class="comment">(указать, что именно) </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA4_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="A4_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button20" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4_2"  CommandName="Panel8" CommandArgument="50401"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                            <asp:Panel ID="Panel8" runat="server"  Visible="false">
                                Уточните, пожалуйста, дистрибутором какой продукции является Ваша компания?
                                <div class="comment">Зафиксировать, если затруднения при ответе – помочь, произнеся варианты на выбор, как в таблице выходных данных</div>
                                <br/> 
                              
                                 <asp:Button CommandName="Panel9" CommandArgument="Парфюмерия и косметика" ToolTip="505" onclick="QAC_Button" Text="Парфюмерия и косметика" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_4_1"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel9" CommandArgument="Профессиональная косметика" ToolTip="505" onclick="QAC_Button" Text="Профессиональная косметика" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_4_2"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel9" CommandArgument="Оборудование для салонов красоты" ToolTip="505" onclick="QAC_Button" Text="Оборудование для салонов красоты" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_4_3"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel9" CommandArgument="Упаковка для парфюмерии и косметики" ToolTip="505" onclick="QAC_Button" Text="Упаковка для парфюмерии и косметики" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_4_4"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel9" CommandArgument="Сырье для парфюмерии и косметики" ToolTip="505" onclick="QAC_Button" Text="Сырье для парфюмерии и косметики" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_4_5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel9" CommandArgument="Бытовая химия" ToolTip="505" onclick="QAC_Button" Text="Бытовая химия" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_4_6"  runat="server" /><br/> 
                                  
                                 <br/> 
                                 <br/> 
                                 <asp:Button ID="Button22" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                               
                            </asp:Panel> 
                              
                              
                            <asp:Panel ID="Panel9" runat="server"  Visible="false">
                                Уточните, пожалуйста, производителем какой продукции является Ваша компания?
                                <div class="comment">Зафиксировать, если затруднения при ответе – помочь, произнеся варианты на выбор, как в таблице выходных данных</div>
                                <br/>
                                 <asp:Button CommandName="Panel55_1" CommandArgument="Парфюмерия и косметика" ToolTip="506" onclick="QAC_Button" Text="Парфюмерия и косметика" CssClass="green unibutton  big2" Width="600"  ID="Button21"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55_1" CommandArgument="Профессиональная косметика" ToolTip="506" onclick="QAC_Button" Text="Профессиональная косметика" CssClass="green unibutton  big2" Width="600"  ID="Button24"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55_1" CommandArgument="Оборудование для салонов красоты" ToolTip="506" onclick="QAC_Button" Text="Оборудование для салонов красоты" CssClass="green unibutton  big2" Width="600"  ID="Button25"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55_1" CommandArgument="Упаковка для парфюмерии и косметики" ToolTip="506" onclick="QAC_Button" Text="Упаковка для парфюмерии и косметики" CssClass="green unibutton  big2" Width="600"  ID="Button26"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55_1" CommandArgument="Сырье для парфюмерии и косметики" ToolTip="506" onclick="QAC_Button" Text="Сырье для парфюмерии и косметики" CssClass="green unibutton  big2" Width="600"  ID="Button66"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55_1" CommandArgument="Бытовая химия" ToolTip="506" onclick="QAC_Button" Text="Бытовая химия" CssClass="green unibutton  big2" Width="600"  ID="Button122"  runat="server" /><br/> 
                                  
                                <br/>
                                <asp:Button ID="Button27" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                             
                             
                             
                            <asp:Panel ID="Panel10" runat="server"  Visible="false"> 
                                «<asp:Label ID="Label4_3_1"    CssClass="fio" runat="server" Text=""></asp:Label>», уточните, пожалуйста, вашу профессию
                                <div class="comment"> (можно подсказать: мастер ногтевого сервиса, парикмахер, визажист, массажист, администратор, владелец и др., может быть просто любитель)
                                <br/> Зафиксировать</div>

                                <br/> 
                                 <asp:TextBox ID="TextBoxA4_6_1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11_1" ValidationGroup="A4_6_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4_6_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button121_1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button128_1" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4_6_1"  CommandName="Panel55_1" CommandArgument="406"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                              
                             
                              
                             
                             
                            <asp:Panel ID="Panel55_1" runat="server"  Visible="false">
                                Фраза6:
                                «<asp:Label ID="Label10"    CssClass="fio" runat="server" Text=""></asp:Label>», могу ли я уточнить Ваш электронный адрес?
                                <br/>
                                <asp:Button CommandName="Panel60_2" CommandArgument="Да" ToolTip="6" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="400"  ID="ButtonA8_2"  runat="server" /><br/>                                 
                                <asp:Button CommandName="Panel60_3" CommandArgument="Нет" ToolTip="6" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="400"  ID="ButtonA8_1"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button43" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                            
                            
                            
                            
                            <asp:Panel ID="Panel60_3" runat="server"  Visible="false">
                            
                                «<asp:Label ID="Label10_11"    CssClass="fio" runat="server" Text=""></asp:Label>», в таком случае позвольте пригласить вас и ваших коллег на веб-сайт «интерчАрм точка ру» (Intercharm.ru), где Вы сможете познакомиться с выставкой и ее участниками поближе. Там же Вы сможете приобрести билет со <b>скидкой!</b> Обращаю ваше внимание, что билет на выставку – это не просто посетить стенды, обязательно посмотрите, что входит в билет на сайте. Мы постарались сделать так, чтобы выставка для вас прошла еще более интересно. Скажите, пожалуйста, у Вас остались ко мне какие-то вопросы?
                                <br/> 
                                <br/> 
                                <asp:Button CommandName="Panel12" CommandArgument="есть вопросы" ToolTip="602" onclick="QAC_Button" Text="есть вопросы" CssClass="green unibutton  big2" Width="400"  ID="Button16"  runat="server" /><br/>                                 
                                <asp:Button CommandName="Panel14" CommandArgument="нет вопросов" ToolTip="602" onclick="QAC_Button" Text="нет вопросов" CssClass="green unibutton  big2" Width="400"  ID="Button18"  runat="server" /><br/> 
                                
                                <asp:Button ID="Button6_2_15" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                         
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel12" runat="server"  Visible="false"> 
                                <div class="comment">зафиксировать вопрос и ответить по возможности. Если нет ответа, то </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxF6_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="F6_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF6_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                                <br/>- «<asp:Label ID="Label16"    CssClass="fio" runat="server" Text=""></asp:Label>», я записала ваш вопрос и обязательно передам его коллегам. Они свяжутся с вами! Мы будем ждать встречи с Вами на выставке! 
                                 
                                <br/> 
                                 <asp:Button ID="Button23" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button28" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F6_2"  CommandName="Panel13" CommandArgument="603"  onclick="QAC_TextBox" />
                       
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel13" runat="server"  Visible="false"> 
                                 <br/> 
                                 Благодарю Вас за разговор. Всего Вам доброго! 
                                <br/> 
                                 <asp:Button ID="Button29" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                              
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel14" runat="server"  Visible="false"> 
                                В таком случае, благодарю Вас за разговор. Мы будем ждать встречи с Вами на выставке! Всего Вам доброго!
                                <br/> 
                                 <asp:Button ID="Button30" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                              
                            </asp:Panel> 
                              
                            
                            <asp:Panel ID="Panel60_2" runat="server"  Visible="false"> 
                                <div class="comment">Зафиксировать адрес, проверить по буквам.</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxF6_1" Width="400" runat="server"></asp:TextBox> - Благодарю Вас!
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1_2F6_1" ValidationGroup="F6_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF6_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button6_2" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_2" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F6_1"  CommandName="Panel19" CommandArgument="601"  onclick="QAC_TextBox_F6" />
                      
                         
                            </asp:Panel> 


                             
                            <asp:Panel ID="Panel1" runat="server"  Visible="false"> 
                               <!-- <div class="comment">если совпадает</div>-->
                                «<asp:Label ID="Label1"    CssClass="fio" runat="server" Text=""></asp:Label>», ! В таком случае, Вы знаете, что при покупке билета через интернет на сайте интерчарм точка ру Вы очень экономите! 
                                На сайте Вы можете купить билет с максимальной <b style="background-color: yellow;">скидкой в размере трехсот пятидесяти рублей</b>! Приглашаю вас посетить интернет-сайт «интерчАрм точка ру» (Intercharm.ru) и познакомиться с выставкой и ее участниками поближе.
                                <br/> 
                                 <asp:Button ID="Button2" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button3" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel20"   onclick="standartNext" />
                      
                         
                            </asp:Panel> 

                             
                            <!--Фраза7:-->
                            <!--Если адрес НЕ совпадает ИЛИ изначально отсутствовал--> 
                            <asp:Panel ID="Panel2" runat="server"  Visible="false">
                                
                                 «<asp:Label ID="Label2"    CssClass="fio" runat="server" Text=""></asp:Label>» 
                                Спасибо! На Ваш электронный адрес мы вышлем дополнительную информацию.  Напоминаю, международная <b>выставка Интершарм</b> пройдет <b style="background-color: yellow;">с 24 по 27 октября</b> в Москве, в «Крокус Экспо». Приглашаю вас посетить веб-сайт «интерчАрм точка ру» (Intercharm.ru) и познакомиться с выставкой и ее участниками поближе.

                                <br/>
                                <asp:Button ID="Button4" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button5" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel20"   onclick="standartNext" />
                      
                            </asp:Panel>
                            <!--End Если адрес НЕ совпадает ИЛИ изначально отсутствовал--> 
                              
                                      
                            <!--  Если адрес совпадает, но в таблице стоит FALSE, то есть мы знаем, что письма не доходят--> 
                            <asp:Panel ID="Panel60" runat="server"  Visible="false"> 
                                 «<asp:Label ID="Label4_2"    CssClass="fio" runat="server" Text=""></asp:Label>», по моей информации письма на этот адрес не доставляются. 
                                Вероятно, это потому что он больше не используется вами, а может быть где-то ошибка. Давайте проверим еще раз! 
                                <div class="comment">Зафиксировать адрес, проверить по буквам.</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA4_1_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1_2" ValidationGroup="A4_1_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4_1_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                             
                                <br/> 
                                 <asp:Button ID="Button6_2_55" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_2_56" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4_1_2"  CommandName="Panel20" CommandArgument="7"  onclick="QAC_TextBox_7" />
                       
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel15_netot" runat="server"  Visible="false"> 
                                 <div class="comment">зафиксировать </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxF7_3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="F7_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF7_3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               Спасибо большое.
                                <br/> 
                                 <asp:Button ID="Button46" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button47" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F7_3"  CommandName="Panel18" CommandArgument="703"  onclick="QAC_TextBox" />
                       
                            </asp:Panel> 
                              
                            <asp:Panel ID="Panel15_tot" runat="server"  Visible="false"> 
                                Да, именно на этот адрес не приходят наши письма! Подскажите, пожалуйста, может быть есть какая-то другая почта, которой вы пользуетесь?
                                <br/> 
                                <asp:Button CommandName="Panel16" CommandArgument="есть" ToolTip="701" onclick="QAC_Button" Text="есть" CssClass="green unibutton  big2" Width="400"  ID="Button31"  runat="server" /><br/>                                 
                                <asp:Button CommandName="Panel19" CommandArgument="нет" ToolTip="701" onclick="QAC_Button" Text="нет" CssClass="green unibutton  big2" Width="400"  ID="Button32"  runat="server" /><br/> 
                                
                                <asp:Button ID="Button33" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel>
                             
                            <asp:Panel ID="Panel19" runat="server"  Visible="false">
                                 Что ж, мы тогда проверим еще раз у себя в базе. Спасибо Вам.
                                <br/>
                                <asp:Button ID="Button44" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button45" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel18"   onclick="standartNext" />
                      
                            </asp:Panel>
   

                             
                            <asp:Panel ID="Panel16" runat="server"  Visible="false"> 
                                 <div class="comment">зафиксировать </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxF7_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="F7_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxF7_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                               Спасибо большое.
                                <br/> 
                                 <asp:Button ID="Button34" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button38" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="F7_2"  CommandName="Panel18" CommandArgument="702"  onclick="QAC_TextBox" />
                       
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel18" runat="server"  Visible="false">
                                 «<asp:Label ID="Label17"    CssClass="fio" runat="server" Text=""></asp:Label>», на Ваш электронный адрес мы вышлем дополнительную информацию.  Напоминаю, международная <b>выставка Интершарм</b> пройдет <b style="background-color: yellow;">с 24 по 27 октября</b> в Москве, в «Крокус Экспо». Приглашаю вас посетить веб-сайт «интерчАрм точка ру» (Intercharm.ru) и познакомиться с выставкой и ее участниками поближе.
                                 
                                <br/>
                                <asp:Button ID="Button40" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button42" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel20"   onclick="standartNext" />
                      
                            </asp:Panel>
   
                            <!--End:  Если адрес совпадает, но в таблице стоит FALSE, то есть мы знаем, что письма не доходят-->
                              
                            <!-- Если адрес совпадает и в таблице стоит TRUE, то есть мы знаем, что письма доходят-->
                               
                            <asp:Panel ID="Panel17" runat="server"  Visible="false">
                                 «<asp:Label ID="Label15"    CssClass="fio" runat="server" Text=""></asp:Label>», прекрасно! В таком случае, Вы знаете, что при покупке билета на веб-сайте интерчарм точка ру Вы сильно экономите! На сайте Вы можете купить билет с максимальной! Приглашаю вас посетить веб-сайт «интерчАрм точка ру» (Intercharm.ru) и познакомиться с выставкой и ее участниками поближе.
                                <br/> 
                                
                                 
                                <br/>
                                <asp:Button ID="Button68" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12_2_59" runat="server" Text="Далее" CssClass="blue unibutton"    CommandName="Panel20"   onclick="standartNext" />
                      
                            </asp:Panel>

                             <!-- end: Если адрес совпадает и в таблице стоит TRUE, то есть мы знаем, что письма доходят-->
                              
   
                             
                            <asp:Panel ID="Panel20" runat="server"  Visible="false">
                                Фраза8: «<asp:Label ID="Label15_2"    CssClass="fio" runat="server" Text=""></asp:Label>», у Вас есть какие-нибудь комментарии или предложения по работе выставки?
                                <div class="comment"> </div>
                                <br/>
                                <asp:Button CommandName="Panel21" CommandArgument="Да" ToolTip="8" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="600"  ID="Button79"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel24" CommandArgument="Нет" ToolTip="8" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="600"  ID="Button80"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button83" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel21" runat="server"  Visible="false"> 
                                 <div class="comment">зафиксировать комментарий</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="A11"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button84" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button85" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11"  CommandName="Panel23" CommandArgument="9"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel21r" runat="server"  Visible="false"> 
                                 <div class="comment">Зафиксировать адрес, обязательно проверить по буквам. </div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11r" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5r" ValidationGroup="A11r"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11r" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button84r" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button85r" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11r"  CommandName="Panel54" CommandArgument="11"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                            
                            
                             

                             
                             <asp:Panel ID="Panel23" runat="server"  Visible="false"> 
                             
                                <br/>«<asp:Label ID="Label19_11"    CssClass="fio" runat="server" Text=""></asp:Label>», спасибо за комментарий! 
                                Я обязательно передам его коллегам. Мы будем ждать встречи с Вами на выставке! Благодарю Вас за разговор. Всего Вам доброго!
 
                                 <br/> 
                                  <br/> 
                                <asp:Button ID="Button86" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />  
                            </asp:Panel> 

                             
                             
                             
                            <asp:Panel ID="Panel24" runat="server"  Visible="false">
                                «<asp:Label ID="Label18"    CssClass="fio" runat="server" Text=""></asp:Label>», позвольте, я поделюсь с Вами изменениями, которые были сделаны на основе комментариев других посетителей, которые мы получили в прошлом году. Вы также сможете воспользоваться этими нововведениями. В прошлом году мы получили отзывы об очередях и на этот раз сделали абсолютно новую систему входа, теперь вам не нужно активировать нигде билет, вы сразу со своим распечатанным билетом проходите в нужный зал. И еще хорошая новость – на выставке в этом году будет работать зона отдыха Нью Бьюти Лаунж, в которой вы сможете с комфортном отдохнуть во время выставки. «<asp:Label ID="Label19"    CssClass="fio" runat="server" Text=""></asp:Label>», пожалуйста, если все же у вас есть какие-то комментарии, не стесняйтесь нам об этом говорить, мы всегда стараемся сделать выставку еще более комфортной для наших посетителей.
                                <div class="comment"> </div>
                                <br/>
                                <asp:Button CommandName="Panel21" CommandArgument="есть комментарий" ToolTip="802" onclick="QAC_Button" Text="есть комментарий" CssClass="green unibutton  big2" Width="600"  ID="Button48"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel25" CommandArgument="нет комментариев" ToolTip="802" onclick="QAC_Button" Text="нет комментариев" CssClass="green unibutton  big2" Width="600"  ID="Button49"  runat="server" /><br/> 
                                 
                                <br/>
                                <asp:Button ID="Button50" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel> 
                                
                            <asp:Panel ID="Panel25" runat="server"  Visible="false">
                                В таком случае, благодарю Вас за разговор. Мы будем ждать встречи с Вами на выставке! Всего Вам доброго!
                                <br/>
                                <asp:Button ID="Button51" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                            </asp:Panel>

                              
                            <asp:Panel ID="Panel15" runat="server"  Visible="false">
                                «<asp:Label ID="Label20"    CssClass="fio" runat="server" Text=""></asp:Label>», я благодарю Вас за разговор. Мы будем ждать встречи с Вами на выставке! Всего Вам доброго!
                                <br/>
                                <asp:Button ID="Button92" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel53" runat="server"  Visible="false" CssClass="1"> 
                                 <div class="comment">Интерес собеседника
                                    <br/> 
                                     Да - если получены ответы без наводящих фраз и вопросов (среди ответов нет отрицательных, таких как "Нет, не надо", "Нам не интересно" и др.)
                                        Нет - если в ходе разговора звучали отрицательные ответы, такие как "Нет, не надо", "Нам не интересно" и др.)
                                 </div>
                                  <br/> 
                                <asp:Button CommandName="Panel54" CommandArgument="Нет" ToolTip="51" onclick="QAC_Button" Text="Нет" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button89"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel54" CommandArgument="Да"  ToolTip="51" onclick="QAC_Button" Text="Да"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button90"  runat="server" /><br/> 
                                
                                <br/>
                                <asp:Button ID="Button91" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
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


            <asp:TabPanel runat="server" HeaderText="Реакции на фразы собеседника " ID="TabPanel2">
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


            <asp:TabPanel runat="server" HeaderText="Информация" ID="TabPanel3">
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
