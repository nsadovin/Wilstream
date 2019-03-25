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

                               1.	На сегодняшний день есть потребность в привлечении кредитных ресурсов у компании?  

                                <br/> 
                                <asp:Button CommandName="Panel28" CommandArgument="да, на исполнение гос. контракта" ToolTip="1" onclick="QAC_Button" Text="да, на исполнение гос. контракта" CssClass="green unibutton  big2" Width="400"  ID="Button42_2_5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel8" CommandArgument="да, на пополнение оборотных средств" ToolTip="1" onclick="QAC_Button" Text="да, на пополнение оборотных средств" CssClass="green unibutton  big2" Width="400"  ID="Button2"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel15" CommandArgument="нет" ToolTip="1" onclick="QAC_Button" Text="нет" CssClass="red unibutton  big2" Width="400"  ID="Button3_2_5"  runat="server" /><br/> 
                                 
                            </asp:Panel>
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false">
                                2.	В каком регионе Вы зарегистрированы?
                                <br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="Москва" ToolTip="2" onclick="QAC_Button" Text="Москва" CssClass="green unibutton  big2" Width="600"  ID="Button57"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="Московская область" ToolTip="2" onclick="QAC_Button" Text="Московская область" CssClass="green unibutton  big2" Width="600"  ID="Button3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel1" CommandArgument="Другой " ToolTip="2" onclick="QAC_Button" Text="Другой " CssClass="green unibutton  big2" Width="600"  ID="Button58"  runat="server" /><br/> 
                                <br/> 
                                <asp:Button ID="Button46" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                       
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel1" runat="server"  Visible="false"> 
                                 <div class="comment">зафиксировать</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA2_3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="A2_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA2_3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button4" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button5" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A2_3"  CommandName="Panel29" CommandArgument="203"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                            
                            
                            <asp:Panel ID="Panel29" runat="server" Visible="false">
                                3.	Какой объем кредитования необходим?
                                <br/> 
                                 <asp:TextBox ID="TextBoxA3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="A3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button11" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button12" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A3"  CommandName="Panel2_4" CommandArgument="3"  onclick="QAC_TextBox" />
                     
                            </asp:Panel> 





                              <asp:Panel ID="Panel2_4" runat="server"  Visible="false" CssClass="1">
                                 4.	Рассматриваете возможность предоставить залог?
                                 <br/> 
                                 <asp:Button CommandName="Panel55" CommandArgument="да" ToolTip="4" onclick="QAC_Button" Text="да" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button138_2_5_n"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel55" CommandArgument="нет"  ToolTip="4" onclick="QAC_Button" Text="нет"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button206_2_1_n"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button5_2_n" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>

                             
                             
                            <asp:Panel ID="Panel55" runat="server"  Visible="false"> 
                                5.	Кто является заказчиком по Вашему предполагаемому к финансированию контракту?
                                <br/> 
                                 <asp:TextBox ID="TextBoxA5" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="A5"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button1" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button6" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A5"  CommandName="Panel4" CommandArgument="5"  onclick="QAC_TextBox" />
                    
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel4" runat="server"  Visible="false"> 
                                6.	В каком регионе зарегистрирован заказчик?
                                   <br/> 
                                 <asp:TextBox ID="TextBoxA6" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="A6"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA6" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button8" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button9" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A6"  CommandName="Panel2" CommandArgument="6"  onclick="QAC_TextBox" />
                    
                            </asp:Panel>

                             

                              <asp:Panel ID="Panel2" runat="server"  Visible="false">
                                 7.	У вас уже есть опыт выполнения аналогичных по характеру исполнения и соизмеримых по сумме гос контрактов?
                                 <br/> 
                                 <asp:Button CommandName="Panel5" CommandArgument="да" ToolTip="7" onclick="QAC_Button" Text="да" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button10"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel5" CommandArgument="нет"  ToolTip="7" onclick="QAC_Button" Text="нет"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button13"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button14" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                              <asp:Panel ID="Panel5" runat="server"  Visible="false" >
                                 8.	На какую сумму ваша действующая контрактная база?
                                     <br/> 
                                 <asp:TextBox ID="TextBoxA8" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="A8"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA8" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button15" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button16" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A8"  CommandName="Panel6" CommandArgument="8"  onclick="QAC_TextBox" />
                    
                            </asp:Panel>


                             
                              <asp:Panel ID="Panel6" runat="server"  Visible="false">
                                 9.	Вам подходят данные условия?
                                 <br/> 
                                 <asp:Button CommandName="Panel15" CommandArgument="да" ToolTip="9" onclick="QAC_Button" Text="да" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button17"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel15" CommandArgument="нет"  ToolTip="9" onclick="QAC_Button" Text="нет"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button18"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button21" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                             
                            <asp:Panel ID="Panel8" runat="server" Visible="false">
                                10.	В каком регионе Вы зарегистрированы?
                                <br/> 
                                <asp:Button CommandName="Panel10" CommandArgument="Москва" ToolTip="10" onclick="QAC_Button" Text="Москва" CssClass="green unibutton  big2" Width="600"  ID="Button22"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel11" CommandArgument="Московская область" ToolTip="10" onclick="QAC_Button" Text="Московская область" CssClass="green unibutton  big2" Width="600"  ID="Button23"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel9" CommandArgument="Другой " ToolTip="10" onclick="QAC_Button" Text="Другой " CssClass="green unibutton  big2" Width="600"  ID="Button24"  runat="server" /><br/> 
                                <br/>
                                <asp:Button ID="Button45" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                          
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel9" runat="server"  Visible="false"> 
                                 <div class="comment">зафиксировать</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA10_3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="A10_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA10_3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button25" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button26" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A10_3"  CommandName="Panel11" CommandArgument="1003"  onclick="QAC_TextBox" />
                            </asp:Panel>

                             
                            
                            <asp:Panel ID="Panel10" runat="server" Visible="false">
                                11.	Какой объем кредитования необходим?
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="A11"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button27" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button28" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11"  CommandName="Panel12" CommandArgument="11"  onclick="QAC_TextBox" />
                     
                            </asp:Panel> 


                               <asp:Panel ID="Panel12" runat="server"  Visible="false">
                                 12.	Вы сможете предоставить залог?
                                 <br/> 
                                 <asp:Button CommandName="Panel15" CommandArgument="да" ToolTip="12" onclick="QAC_Button" Text="да" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button32"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel15" CommandArgument="нет"  ToolTip="12" onclick="QAC_Button" Text="нет"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button33"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button34" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                            
                            <asp:Panel ID="Panel11" runat="server" Visible="false">
                                11.	Какой объем кредитования необходим?
                                <br/> 
                                 <asp:TextBox ID="TextBoxA11_" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="A11_"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA11_" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button30" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button31" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A11_"  CommandName="Panel14" CommandArgument="11"  onclick="QAC_TextBox" />
                     
                            </asp:Panel> 


                             
                               <asp:Panel ID="Panel14" runat="server"  Visible="false">
                                 13.	Вы сможете предоставить залог в размере 50% от требуемой суммы кредита?
                                 <br/> 
                                 <asp:Button CommandName="Panel15" CommandArgument="да" ToolTip="13" onclick="QAC_Button" Text="да"   CssClass="green unibutton  big2" Width="400"  ID="Button36"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel3" CommandArgument="нет"  ToolTip="13" onclick="QAC_Button" Text="нет"    CssClass="green unibutton  big2" Width="400"  ID="Button37"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button38" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             
                             
                             
                               <asp:Panel ID="Panel15" runat="server"  Visible="false">
                                 14.	Результат презентации
                                 <br/> 
                                 <asp:Button CommandName="Panel16" CommandArgument="звонок специалиста" ToolTip="14" onclick="QAC_Button" Text="звонок специалиста"   CssClass="green unibutton  big2" Width="400"  ID="Button39"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel3" CommandArgument="отправить письмо"  ToolTip="14" onclick="QAC_Button" Text="отправить письмо"    CssClass="green unibutton  big2" Width="400"  ID="Button42"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel7" CommandArgument="отказ"  ToolTip="14" onclick="QAC_Button" Text="отказ"    CssClass="green unibutton  big2" Width="400"  ID="Button40"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button41" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>
                             


                            <asp:Panel ID="Panel7" runat="server"  Visible="false"> 
                                15.	Причина отказа 
                                <br/> 
                                 <asp:TextBox ID="TextBoxA15" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="A15"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA15" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button20" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A15"  CommandName="Panel3" CommandArgument="15"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                            
                           
                              

                            <asp:Panel ID="Panel16" runat="server"  Visible="false"> 
                                16.	Дата и время звонка специалиста 
                                <br/> 
                                 <asp:TextBox ID="TextBoxA16" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="A16"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA16" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button43" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button44" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A16"  CommandName="Panel3" CommandArgument="16"  onclick="QAC_TextBox" />
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
                                         <td>ФИО ЛПР</td>
                                         <td><asp:TextBox ID="TextBoxFIOLPR" runat="server"></asp:TextBox></td>
                                     </tr>
                                     <tr>
                                         <td>Должность ЛПР</td>
                                         <td><asp:TextBox ID="TextBoxDolgnostLPR" runat="server"></asp:TextBox></td>
                                     </tr>
                                     <tr>
                                         <td>E-mail ЛПР</td>
                                         <td><asp:TextBox ID="TextBoxEmailLPR" runat="server"></asp:TextBox></td>
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
