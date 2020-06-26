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

                               Добрый день (вечер),   <asp:Label ID="Label1_ClientName" CssClass="fio" runat="server" Text=""></asp:Label> ?   

                                <br/> 
                                <asp:Button CommandName="Panel2_4" CommandArgument="Да" ToolTip="1" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button42_2_5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel28" CommandArgument="Нет" ToolTip="1" onclick="QAC_Button" Text="Нет" CssClass="red unibutton  big2" Width="300"  ID="Button3_2_5"  runat="server" /><br/> 
                                 
                            </asp:Panel>
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false">
                                Извините, это телефон «<asp:Label ID="Label21" CssClass="fio" runat="server" Text=""></asp:Label>» или номер ему больше не принадлежит?
                                <br/> 
                                <asp:Button CommandName="Panel29" CommandArgument="Номер клиента" ToolTip="2" onclick="QAC_Button" Text="Номер клиента" CssClass="green unibutton  big2" Width="600"  ID="Button57"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="Номер клиенту не принадлежит" ToolTip="2" onclick="QAC_Button" Text="Номер клиенту не принадлежит" CssClass="red unibutton  big2" Width="600"  ID="Button58"  runat="server" /><br/> 
                                
                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel29" runat="server" Visible="false">
                                А, как мне переговорить с «<asp:Label ID="Label22" CssClass="fio" runat="server" Text=""></asp:Label>»? 
                                <br/> 
                                <asp:Button CommandName="Panel2_4" CommandArgument="Далее по сценарию" ToolTip="3" onclick="QAC_Button" Text="Далее по сценарию" CssClass="green unibutton  big2" Width="600"  ID="Button59"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="Закончить разговор" ToolTip="3" onclick="QAC_Button" Text="Закончить разговор" CssClass="red unibutton  big2" Width="600"  ID="Button60"  runat="server" /><br/> 
                                
                            </asp:Panel> 





                              <asp:Panel ID="Panel2_4" runat="server"  Visible="false" CssClass="1">
                                 Очень приятно! Моё имя  «<asp:Label ID="Label2_2_n"     runat="server" Text=""></asp:Label> », 
                                 <b>Группа Компаний «Интерлизинг».</b>
                                 «<asp:Label ID="Label23" CssClass="fio" runat="server" Text=""></asp:Label>», Вы приобрели у нас "<asp:Label ID="LabelColumn_8" CssClass="Column_8" runat="server" Text=""></asp:Label>" <div class="comment">- пауза –</div> и в целях улучшения качества услуг, мы хотим задать Вам несколько вопросов, это займет всего пару минут.  Удобно ли будет ответить на вопросы сейчас? 
                                 <div class="comment"></div>
                                  <br/> 
                                 <asp:Button CommandName="Panel26" CommandArgument="да" ToolTip="4" onclick="QAC_Button" Text="да" OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button138_2_5_n"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel27" CommandArgument="нет"  ToolTip="4" onclick="QAC_Button" Text="нет"  OnClientClick="top.document.getElementById('id_full_anketa').value = 1;" CssClass="green unibutton  big2" Width="400"  ID="Button206_2_1_n"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button5_2_n" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>


                             
                             
                             
                               
                             
                             
                            <asp:Panel ID="Panel27" runat="server" Visible="false"> 
                                В какое время, Вам было бы удобней, что бы мы перезвонили?
                                <div class="comment">– зафиксировать –</div> Спасибо! Мы свяжемся с Вами!
                                <br />
                                <asp:Button ID="Button56" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             

                              
                                   
                            <asp:Panel ID="Panel26" runat="server"  Visible="false">
                                 Вопрос 1: «<asp:Label ID="Label24" CssClass="fio" runat="server" Text=""></asp:Label>», возникали ли какие-то проблемы по скорости и качеству работы нашей компании?
                                
                                 <div class="comment">(множественный выбор)<br/>
                                     Примечание для оператора: Не нужно озвучивать клиенту все варианты ответов. Из предложенного списка выберите тот, который наиболее точно отражает ответ клиента. Если ответ клиента, не походит к предложенным, ниже вариантам, впишите его в последнюю графу: «Свой вариант ответа». Можете указать несколько вариантов, если они подходят по смыслу к ответу клиента.
                                 </div>
                                <br/>
                                <asp:Table ID="TableA1" runat="server">
                                    <asp:TableHeaderRow>
                                        <asp:TableHeaderCell>№</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>проблема</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Комментарий</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Скажите, эта проблема уже решена?</asp:TableHeaderCell>
                                    </asp:TableHeaderRow>
                                    <asp:TableRow>
                                        <asp:TableCell>1</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox1" Text="Без замечаний" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox1" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox2" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>2</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox3" Text="Скорость. Рассмотрение сделки" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox2" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox4" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>3</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox5" Text="Скорость. Подготовка и подписание договоров" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox3" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox6" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>4</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox7" Text="Скорость. Передача в лизинг" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox4" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox8" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>5</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox9" Text="Скорость. Предоставление с/ф и актов" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox5" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox10" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>6</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox11" Text="Скорость. Сопровождение / Завершение сделки" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox6" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox12" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>8</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox15" Text="Сбой. Получение бух. Документов" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox8" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox16" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>9</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox17" Text="Сбой. Ошибки в документах" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox9" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox18" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>11</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox21" Text="Условия лизинга. Пакет документов" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox11" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox22" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>12</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox23" Text="Условия лизинга. Пени, штрафы" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox12" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox24" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>14</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox27" Text="Условия лизинга. Стоимость" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox14" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox28" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>15</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox29" Text="Страхование. Перечень СК / Скорость / Стоимость" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox15" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox30" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow> 
                                    <asp:TableRow>
                                        <asp:TableCell>19</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox37" Text="Сотрудник. Качество работы" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox19" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox38" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>20</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox39" Text="Сотрудник. Скорость работы" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox20" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox40" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>21</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox41" Text="Прочее. Проблема с поставщиком" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox21" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox42" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell>22</asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox43" Text="Прочее. Проблема с ПЛ" OnCheckedChanged="CheckBoxA1_CheckedChanged" AutoPostBack="true" runat="server" /></asp:TableCell>
                                        <asp:TableCell><asp:TextBox ID="TextBox22" Visible="false" runat="server"></asp:TextBox></asp:TableCell>
                                        <asp:TableCell><asp:CheckBox ID="CheckBox44" Visible="false" Text="Да" runat="server" /></asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                    
                                    <br/> 
                                <asp:Button ID="Button39" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button41" runat="server" Text="Далее" CssClass="blue unibutton"  ValidationGroup="A1" CommandName="Panel55" CommandArgument="5" onclick="QAC_A5" />
                            
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
                                Вопрос 2: «<asp:Label ID="Label3" CssClass="fio" runat="server" Text=""></asp:Label>», какова вероятность того, что Вы порекомендуете нас своим партнерам по шкале от 0 до 10, где 10 — «Обязательно порекомендую», а 0 — «Ни в коем случае не буду рекомендовать»?
                                <div class="comment">Примечание для оператора: Можно дать только один вариант ответа</div>
                                <br/>
                                <asp:Button CommandName="Panel4" CommandArgument="10" ToolTip="8" onclick="QAC_Button" Text="10" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_1"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="9" ToolTip="8" onclick="QAC_Button" Text="9" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_2"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="8" ToolTip="8" onclick="QAC_Button" Text="8" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_3"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="7" ToolTip="8" onclick="QAC_Button" Text="7" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_4"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="6" ToolTip="8" onclick="QAC_Button" Text="6" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_5"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="5" ToolTip="8" onclick="QAC_Button" Text="5" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_6"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="4" ToolTip="8" onclick="QAC_Button" Text="4" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_7"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="3" ToolTip="8" onclick="QAC_Button" Text="3" CssClass="green unibutton  big2" Width="600"  ID="ButtonA4_3_8"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="2" ToolTip="8" onclick="QAC_Button" Text="2" CssClass="green unibutton  big2" Width="600"  ID="Button1"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="1" ToolTip="8" onclick="QAC_Button" Text="1" CssClass="green unibutton  big2" Width="600"  ID="Button6"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="0" ToolTip="8" onclick="QAC_Button" Text="0" CssClass="green unibutton  big2" Width="600"  ID="Button10"  runat="server" /><br/> 
                
                                <br/>
                                <asp:Button ID="Button17" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>

                             
                            <asp:Panel ID="Panel4" runat="server"  Visible="false"> 
                                Вопрос 3: «<asp:Label ID="Label4" CssClass="fio" runat="server" Text=""></asp:Label>», может, хотите, что-нибудь добавить от себя?
                                <div class="comment"></div>
                                <br/>
                                <asp:Button CommandName="Panel7" CommandArgument="Есть ответ" ToolTip="9" onclick="QAC_Button" Text="Есть ответ" CssClass="green unibutton  big2" Width="600"  ID="Button8"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel13" CommandArgument="Нет ответа" ToolTip="9" onclick="QAC_Button" Text="Нет ответа" CssClass="green unibutton  big2" Width="600"  ID="Button9"  runat="server" /><br/> 
                               
                                <br/>
                                <asp:Button ID="Button54" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                            </asp:Panel>

                            <asp:Panel ID="Panel7" runat="server"  Visible="false"> 
                                 <div class="comment">зафиксировать</div>
                                <br/> 
                                 <asp:TextBox ID="TextBoxA4_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="A4_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA4_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button19" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button20" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A4_2"  CommandName="Panel13" CommandArgument="10"  onclick="QAC_TextBox" />
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
