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
                             
                             
                                <asp:HiddenField ID="HiddenFieldResultAnketa" runat="server"  /> 
                             
                            <asp:Panel ID="Panel1_3" runat="server" ToolTip="Это компания (из базы)?" >
                                Добрый день! <span class="comment"> (если не представились):</span> Это «<asp:Label ID="LabelCompany" runat="server" Text="компания (из базы)"></asp:Label>»?
                                <br/> 
                                <asp:Button CommandName="Panel53" CommandArgument="Да" ToolTip="1" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button42_2_5"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel28" CommandArgument="Нет" ToolTip="1" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button2"  runat="server" /><br/> 
                                
                            </asp:Panel>


                             
                            <asp:Panel ID="Panel53" runat="server"  Visible="false" ToolTip="2.	Как называется ваша компания? "> 
                                2.	Как называется ваша компания? 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxQ2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ValidationGroup="Q2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button133" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button134" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q2"  CommandName="Panel28" CommandArgument="-2"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                             
                            
                            
                            <asp:Panel ID="Panel28" runat="server" Visible="false" ToolTip="Вы используете комплексное решение для мониторинга транспорта для собственного автопарка?">
                                Меня зовут «<asp:Label ID="LabelOperatorName" runat="server" Text="компания (из базы)"></asp:Label>», звоню от компании «Омникомм» - производителя решений для мониторинга транспорта. Скажите, Вы используете комплексное решение для мониторинга транспорта для собственного автопарка?
                                <br/> 
                                <asp:Button CommandName="Panel23" CommandArgument="Да" ToolTip="2" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button6"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel2" CommandArgument="Нет" ToolTip="2" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button135"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel2" CommandArgument="Затрудняется ответить " ToolTip="2" onclick="QAC_Button" Text="Затрудняется ответить " CssClass="green unibutton  big2" Width="300"  ID="Button9"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button8" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                               

                            </asp:Panel> 
                            
                            
                            <asp:Panel ID="Panel2" runat="server" Visible="false" ToolTip="4.	Вы занимаетесь установкой оборудования и систем для мониторинга транспорта?">
                                4.	Вы занимаетесь установкой оборудования и систем для мониторинга транспорта?
                                <br/> 
                                <asp:Button CommandName="Panel5" CommandArgument="Да" ToolTip="3" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button10"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel5" CommandArgument="Нет" ToolTip="3" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button11"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button12" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                               

                            </asp:Panel>  
                             
                            <asp:Panel ID="Panel5" runat="server" Visible="false" ToolTip="5.	Скажите, у Вашей компании есть собственный автопарк?">
                                5.	Скажите, у Вашей компании есть собственный автопарк?
                                <br/> 
                                <asp:Button CommandName="Panel6" CommandArgument="Есть" ToolTip="5" onclick="QAC_Button" Text="Есть" CssClass="green unibutton  big2" Width="300"  ID="Button14"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel6" CommandArgument="Нет" ToolTip="5" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button22"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button23" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                               

                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel6" runat="server" Visible="false"  ToolTip="6.	А чем занимается Ваша компания?">
                                6.	А чем занимается Ваша компания?
                                <br/> 
                                <asp:Button CommandName="Panel4" CommandArgument="Интегратор" ToolTip="6" onclick="QAC_Button" Text="a.	интегратор: установкой систем мониторинга / установкой датчика уровня топлива / терминалов / тахографов / оператор систем мониторинга транспорта ГЛОНАСС / GPS" CssClass="green unibutton  big2" Width="300"  ID="Button24"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel8" CommandArgument="Другое" ToolTip="6" onclick="QAC_Button" Text="Другое" CssClass="green unibutton  big2" Width="300"  ID="Button25"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button26" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                               

                            </asp:Panel> 
                              
                             
                             
                            <asp:Panel ID="Panel8" runat="server"  Visible="false" ToolTip="6.	А чем занимается Ваша компания: другое "> 
                                b.	другое 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxQ3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Q3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button18" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button33_" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q3"  CommandName="Panel33" CommandArgument="-4"  onclick="QAC_TextBox_End" />
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel4" runat="server" Visible="false"  ToolTip="7.	Выход на ЛПР">
                                7.	Выход на ЛПР
                                <br/> 
                                <asp:Button CommandName="Panel23" CommandArgument="да" ToolTip="-3" onclick="QAC_Button" Text="да " CssClass="green unibutton  big2" Width="300"  ID="Button13"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel9" CommandArgument="дали новый номер" ToolTip="6" onclick="QAC_Button" Text="дали новый номер" CssClass="green unibutton  big2" Width="300"  ID="Button17"  runat="server" /><br/> 
                                 <asp:Button CommandName="Panel33" CommandArgument="нет" ToolTip="6" onclick="QAC_Button_End" Text="нет" CssClass="green unibutton  big2" Width="300"  ID="Button15"  runat="server" /><br/> 
                               
                                <br/> 
                                 <asp:Button ID="Button16" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  /> 
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel9" runat="server"  Visible="false" ToolTip="Новый номер"> 
                                Новый номер
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBox1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Q3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxQ3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button21" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button27" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="Q3"  CommandName="Panel33" CommandArgument="-5"  onclick="QAC_TextBox_End" />
                            </asp:Panel> 


                             <!--  Основной сценарий (конечный клиент)-->
                             
                            <asp:Panel ID="Panel23" runat="server" Visible="false" ToolTip="Вы же используете комплексное решение для мониторинга транспорта? ">
                                «<asp:Label ID="Label1" runat="server" CssClass="fio" Text="ФИО клиент"></asp:Label>», добрый день!
                                <div class="comment">– пауза – </div>
                                Меня зовут «<asp:Label ID="Label2" runat="server" CssClass="operator" Text="Имя оператора"></asp:Label>», компания «Омникомм» - производитель решений для мониторинга транспорта. 
                                На данный момент мы обновляем контактную информацию по наши клиентам, чтобы адресно направлять предложения о скидках и новых продуктах.
                                Вы же используете комплексное решение для мониторинга транспорта? 
                                <div class="comment">– без паузы– </div> 
                                У Вас есть свой автопарк?
                                <br/> 
                                <asp:Button CommandName="Panel25" CommandArgument="Да" ToolTip="8" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button70"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel24" CommandArgument="Нет" ToolTip="8" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button69"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button74" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel24" runat="server" Visible="false" ToolTip="Вы компания-интегратор, занимаетесь установкой решения?">
                                Вы компания-интегратор, занимаетесь установкой решения?
                                <br/> 
                                <asp:Button CommandName="Panel41" CommandArgument="Да" ToolTip="9" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button71"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="Нет" ToolTip="9" onclick="QAC_Button_End" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button72"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button73" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel25" runat="server" Visible="false" ToolTip=" могли бы ответить на несколько вопросов? Это займет не более 2х минут.">
                               «<asp:Label ID="Label3" runat="server" CssClass="fio" Text="ФИО клиент"></asp:Label>», могли бы ответить на несколько вопросов? Это займет не более 2х минут.
                                <br/> 
                                <asp:Button CommandName="Panel34" CommandArgument="согласие" ToolTip="10" onclick="QAC_Button" Text="согласие" CssClass="green unibutton  big2" Width="500"  ID="Button75"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel26" CommandArgument="перезвонить" ToolTip="10" onclick="QAC_Button" Text="перезвонить" CssClass="green unibutton  big2" Width="500"  ID="Button78"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="отказ" ToolTip="10" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="500"  ID="Button79"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel30" CommandArgument="почему я должна отвечать на ваши вопросы?" ToolTip="10" onclick="QAC_Button" Text="почему я должна отвечать на ваши вопросы?" CssClass="green unibutton  big2" Width="500"  ID="Button80"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel31" CommandArgument="не интересно" ToolTip="10" onclick="QAC_Button" Text="не интересно" CssClass="green unibutton  big2" Width="500"  ID="Button76"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button77" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel30" runat="server" Visible="false" ToolTip="Мы хотим уточнить ваши контакты чтобы информировать о наших спец.предложениях и выгодных условиях покупки оборудования.">
                               Мы хотим уточнить ваши контакты чтобы информировать о наших спец.предложениях и выгодных условиях покупки оборудования.
                                <br/> 
                                <asp:Button CommandName="Panel34" CommandArgument="согласие" ToolTip="10" onclick="QAC_Button" Text="согласие" CssClass="green unibutton  big2" Width="300"  ID="Button82"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="отказ" ToolTip="10" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="300"  ID="Button84"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button87" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel31" runat="server" Visible="false" ToolTip="Мы не станем забрасывать Вас спамом. Только письма по делу с выгодными предложениями именно для Вас. ">
                                Мы не станем забрасывать Вас спамом. Только письма по делу с выгодными предложениями именно для Вас. 
                                <br/> 
                                <asp:Button CommandName="Panel34" CommandArgument="согласие" ToolTip="10" onclick="QAC_Button" Text="согласие" CssClass="green unibutton  big2" Width="300"  ID="Button83"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="отказ" ToolTip="10" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="300"  ID="Button85"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button86" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel26" runat="server" Visible="false"> 
                                Когда перезвонить? На какой номер? – 
                                <div class="comment">зафиксировать телефон, дату и время перезвона</div>  
                                <br />
                                <asp:Button ID="Button81" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                            <!-- Анкета Основной сценарий (конечный клиент) -->

                            <asp:Panel ID="Panel34" runat="server"  Visible="false" ToolTip="Вопрос1: Вы могли бы подсказать вид деятельности вашей компании? "> 
                                Вопрос1: Вы могли бы подсказать вид деятельности вашей компании? 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA1_1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="A1_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA1_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button88" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button89" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A1_1"  CommandName="Panel35" CommandArgument="1001"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel35" runat="server"  Visible="false" ToolTip="Вопрос2: Уточните, пожалуйста, адрес Вашей электронной почты"> 
                                Вопрос2: Уточните, пожалуйста, адрес Вашей электронной почты, чтобы мы могли отправлять Вам интересные спец.предложения на решения, которые подходят для Вашего вида деятельности 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA1_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="A1_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA1_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button90" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button91" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A1_2"  CommandName="Panel36" CommandArgument="1002"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                             
                             
                            <asp:Panel ID="Panel36" runat="server"  Visible="false" ToolTip="Вопрос3: По какому телефону с Вами лучше держать связь?"> 
                                Вопрос3: По какому телефону с Вами лучше держать связь? 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA1_3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="A1_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA1_3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button92" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button93" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A1_3"  CommandName="Panel37" CommandArgument="1003"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                             
                             
                            <asp:Panel ID="Panel37" runat="server"  Visible="false" ToolTip="Вопрос4: Для формирования индивидуальных предложений уточните, пожалуйста количество Ваших транспортных средств? "> 
                                Вопрос4: Для формирования индивидуальных предложений уточните, пожалуйста количество Ваших транспортных средств? 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA1_4" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ValidationGroup="A1_4"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA1_4" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button94" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button96" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A1_4"  CommandName="Panel38" CommandArgument="1004"  onclick="QAC_TextBox" />
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel38" runat="server" Visible="false" ToolTip="Вопрос5: Наш менеджер готов в ближайшее время связаться с Вами, чтобы рассказать о наших решениях. Когда Вам будет удобно принять звонок?">
                                Вопрос5: Наш менеджер готов в ближайшее время связаться с Вами, чтобы рассказать о наших решениях. Когда Вам будет удобно принять звонок?
                                <br/> 
                                <asp:Button CommandName="Panel39" CommandArgument="согласие" ToolTip="1005" onclick="QAC_Button_End" Text="согласие" CssClass="green unibutton  big2" Width="300"  ID="Button97"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel40" CommandArgument="отказ" ToolTip="1005" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="300"  ID="Button98"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button99" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel39" runat="server" Visible="false">  
                                <div class="comment">зафиксировать дату и время звонка</div>  
                                <br />
                                <asp:Button ID="Button100" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                             
                             
                            <asp:Panel ID="Panel40" runat="server" Visible="false">  
                                «<asp:Label ID="Label4" runat="server" CssClass="fio" Text="ФИО клиент"></asp:Label>», спасибо за уделенное время. До свидания!
                                <br />
                                <asp:Button ID="Button101" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             
                            <!-- End: Анкета Основной сценарий (конечный клиент) -->

                             <!-- End: Основной сценарий (конечный клиент)-->


                             <!-- Основной сценарий (интегратор) -->
                              <asp:Panel ID="Panel41" runat="server" Visible="false" ToolTip="Вы же компания-интегратор, занимаетесь установкой комплексного решения для мониторинга транспорта?"> 
                                «<asp:Label ID="Label8" runat="server" CssClass="fio" Text="ФИО клиент"></asp:Label>», добрый день! 
                                 <div class="comment">– пауза – </div>
                                  Меня зовут «<asp:Label ID="Label9" runat="server" CssClass="operator" Text="Имя оператора"></asp:Label>», компания «Омникомм» - производитель решений для мониторинга транспорта. На данный момент мы обновляем контактную информацию по наши партнерам, чтобы адресно направлять предложения о скидках и новых продуктах. Вы же компания-интегратор, 
                                  занимаетесь установкой комплексного решения для мониторинга транспорта?
                                <br/> 
                                <asp:Button CommandName="Panel43" CommandArgument="Да" ToolTip="10" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button102"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel42" CommandArgument="Нет" ToolTip="10" onclick="QAC_Button" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button103"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button104" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 

                             
                            <asp:Panel ID="Panel42" runat="server" Visible="false" ToolTip="У Вас есть собственный автопарк?">
                                – У Вас есть собственный автопарк?
                                <br/> 
                                <asp:Button CommandName="Panel23" CommandArgument="Да" ToolTip="11" onclick="QAC_Button" Text="Да" CssClass="green unibutton  big2" Width="300"  ID="Button105"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="Нет" ToolTip="11" onclick="QAC_Button_End" Text="Нет" CssClass="green unibutton  big2" Width="300"  ID="Button106"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button107" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 

                              <asp:Panel ID="Panel43" runat="server" Visible="false" ToolTip="могли бы ответить на несколько вопросов? Это займет не более 3х минут.">
                               «<asp:Label ID="Label6" runat="server" CssClass="fio" Text="ФИО клиент"></asp:Label>», могли бы ответить на несколько вопросов? Это займет не более 3х минут.
                                <br/> 
                                <asp:Button CommandName="Panel47" CommandArgument="согласие" ToolTip="10" onclick="QAC_Button" Text="согласие" CssClass="green unibutton  big2" Width="500"  ID="Button108"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel46" CommandArgument="перезвонить" ToolTip="10" onclick="QAC_Button" Text="перезвонить" CssClass="green unibutton  big2" Width="500"  ID="Button109"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="отказ" ToolTip="10" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="500"  ID="Button110"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel44" CommandArgument="почему я должна отвечать на ваши вопросы?" ToolTip="10" onclick="QAC_Button" Text="почему я должна отвечать на ваши вопросы?" CssClass="green unibutton  big2" Width="500"  ID="Button111"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel45" CommandArgument="не интересно" ToolTip="10" onclick="QAC_Button" Text="не интересно" CssClass="green unibutton  big2" Width="500"  ID="Button112"  runat="server" /><br/> 
                                  
                                <br/> 
                                 <asp:Button ID="Button113" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 


                              <asp:Panel ID="Panel44" runat="server" Visible="false" ToolTip="Мы хотим уточнить ваши контакты чтобы информировать о наших спецпредложениях и выгодных условиях покупки оборудования.">
                                Мы хотим уточнить ваши контакты чтобы информировать о наших спецпредложениях и выгодных условиях покупки оборудования.
                                <br/> 
                                <asp:Button CommandName="Panel47" CommandArgument="согласие" ToolTip="10" onclick="QAC_Button" Text="согласие" CssClass="green unibutton  big2" Width="300"  ID="Button114"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="отказ" ToolTip="10" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="300"  ID="Button115"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button116" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel45" runat="server" Visible="false" ToolTip="Мы не станем забрасывать Вас спамом. Только письма по делу с выгодными предложениями именно для Вас, которые выгодны лично Вам.">
                                Мы не станем забрасывать Вас спамом. Только письма по делу с выгодными предложениями именно для Вас, которые выгодны лично Вам.
                                <br/> 
                                <asp:Button CommandName="Panel47" CommandArgument="согласие" ToolTip="10" onclick="QAC_Button" Text="согласие" CssClass="green unibutton  big2" Width="300"  ID="Button117"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel33" CommandArgument="отказ" ToolTip="10" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="300"  ID="Button119"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button120" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel46" runat="server" Visible="false"> 
                                Когда перезвонить? На какой номер? – 
                                <div class="comment">зафиксировать телефон, дату и время перезвона</div>  
                                <br />
                                <asp:Button ID="Button121" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                             <!-- Анкета Основной сценарий (интегратор) -->

                            <asp:Panel ID="Panel47" runat="server"  Visible="false" ToolTip="Вопрос1: Уточните, пожалуйста, адрес Вашей электронной почты"> 
                                Вопрос1: Уточните, пожалуйста, адрес Вашей электронной почты, чтобы мы могли отправлять Вам интересные спец.предложения на решения и новые продукты - 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA2_1" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ValidationGroup="A2_1"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA2_1" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button122" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button123" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A2_1"  CommandName="Panel48" CommandArgument="2001"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                             
                            <asp:Panel ID="Panel48" runat="server"  Visible="false" ToolTip="Вопрос2: По какому телефону с Вами лучше держать связь? "> 
                                Вопрос2: По какому телефону с Вами лучше держать связь? 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA2_2" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ValidationGroup="A2_2"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA2_2" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button124" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button125" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A2_2"  CommandName="Panel49" CommandArgument="2002"  onclick="QAC_TextBox" />
                            </asp:Panel> 
                             
                             
                            <asp:Panel ID="Panel49" runat="server"  Visible="false" ToolTip="Вопрос3: Уточните, пожалуйста, численность Вашей компании?"> 
                                Вопрос3: Уточните, пожалуйста, численность Вашей компании? 
                                <div class="comment">зафиксировать</div>
                                <br/> 
                                <asp:TextBox ID="TextBoxA2_3" Width="400" runat="server"></asp:TextBox> 
                                <br/>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ValidationGroup="A2_3"  runat="server" ErrorMessage="Заполните поле" ControlToValidate="TextBoxA2_3" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                              
                                <br/> 
                                <br/> 
                                 <asp:Button ID="Button126" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                <asp:Button ID="Button127" runat="server" Text="Далее" CssClass="blue unibutton" ValidationGroup="A2_3"  CommandName="Panel50" CommandArgument="2003"  onclick="QAC_TextBox" />
                            </asp:Panel> 

                             
                             
                            <asp:Panel ID="Panel50" runat="server" Visible="false" ToolTip="Вопрос4: Наш менеджер готов в ближайшее время связаться с Вами, чтобы рассказать о наших решениях. Когда Вам будет удобно принять звонок?">
                                Вопрос4: Наш менеджер готов в ближайшее время связаться с Вами, чтобы рассказать о наших решениях. Когда Вам будет удобно принять звонок?
                                <br/> 
                                <asp:Button CommandName="Panel51" CommandArgument="согласие" ToolTip="2004" onclick="QAC_Button_End" Text="согласие" CssClass="green unibutton  big2" Width="300"  ID="Button128"  runat="server" /><br/> 
                                <asp:Button CommandName="Panel52" CommandArgument="отказ" ToolTip="2004" onclick="QAC_Button_End" Text="отказ" CssClass="green unibutton  big2" Width="300"  ID="Button129"  runat="server" /><br/> 
                                 
                                <br/> 
                                 <asp:Button ID="Button130" runat="server" Text="Назад" CssClass="blue unibutton"   onclick="standartPrev"  />
                                
                            </asp:Panel> 

                              <asp:Panel ID="Panel51" runat="server" Visible="false">  
                                <div class="comment">зафиксировать дату и время звонка</div>  
                                <br />
                                <asp:Button ID="Button131" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>

                             
                             
                            <asp:Panel ID="Panel52" runat="server" Visible="false">  
                                «<asp:Label ID="Label7" runat="server" CssClass="fio" Text="ФИО клиент"></asp:Label>», спасибо за уделенное время. До свидания!
                                <br />
                                <asp:Button ID="Button132" runat="server" Text="Назад" CssClass="blue unibutton" 
                                    onclick="standartPrev"  />
                            </asp:Panel>
                             

                             <!-- End: Анкета Основной сценарий (интегратор) -->

                             <!-- End: Основной сценарий (интегратор)-->

                            <asp:Panel ID="Panel29" runat="server" Visible="false" ToolTip="Результат презентации">
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
                             
                            <asp:Panel ID="PanelForms" runat="server" Visible="false"> 
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
                                         <td>Email ЛПР</td>
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
                              

                             
        <asp:HiddenField ID="HiddenFieldOut_ID" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdLead" runat="server" />
        <asp:HiddenField ID="HiddenFieldIdCompany" runat="server" />
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
