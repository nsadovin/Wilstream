<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="biocad.aspx.cs" Inherits="biocad" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2><asp:Label ID="Label1" runat="server" Text="(БИОКАД) ИЗВЕЩЕНИЕ О НЕЖЕЛАТЕЛЬНОЙ РЕАКЦИИ ИЛИ ОТСУТСТВИИ ТЕРАПЕВТИЧЕСКОГО ЭФФЕКТА ЛЕКАРСТВЕННОГО ПРЕПАРАТА"></asp:Label></h2>
            <asp:CheckBox ID="CheckBoxIsFirst" runat="server" Text="Первичное " />
            <asp:CheckBox ID="CheckBoxIsDopInfo" runat="server" Text="Дополнительная информация к сообщению" />
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size:12.0pt;font-family:&quot;Calibri&quot;,sans-serif;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-ansi-language:RU;mso-fareast-language:
RU;mso-bidi-language:AR-SA">№<asp:TextBox ID="TextBoxDopInfoNumber" runat="server"></asp:TextBox>
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; от<span style="font-size: 12.0pt; font-family: &quot;Calibri&quot;,sans-serif; mso-fareast-font-family: &quot;Times New Roman&quot;; mso-ansi-language: RU; mso-fareast-language: RU; mso-bidi-language: AR-SA"><asp:TextBox ID="TextBoxDopInfoNumberOt" runat="server"></asp:TextBox>
            <br />
            <asp:Table ID="TableAnketa" Width="100%" runat="server">
                <asp:TableHeaderRow runat="server">
                    <asp:TableHeaderCell runat="server" HorizontalAlign="Left" BackColor="LightGray">Данные пациента </asp:TableHeaderCell> 
                </asp:TableHeaderRow>
                <asp:TableRow runat="server">
                    <asp:TableCell runat="server">
                            <b>Инициалы пациента</b> (код пациента)*    <asp:TextBox ID="TextBoxCodOrFIO" Width="300" runat="server"></asp:TextBox> Пол  <asp:RadioButtonList ID="RadioButtonListSex"  runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"><asp:ListItem Value="M">M</asp:ListItem><asp:ListItem Value="Ж">Ж</asp:ListItem></asp:RadioButtonList>                         
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Вес <asp:TextBox ID="TextBoxWeight" Width="100" TextMode="Number" runat="server"></asp:TextBox> кг
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Возраст <asp:TextBox ID="TextBoxAge" Width="100" TextMode="Number" runat="server"></asp:TextBox> 
                        Беременность  <asp:CheckBox ID="CheckBoxPregnancy" runat="server" />,
                        срок <asp:TextBox ID="TextBoxPregnancyWeeks" Width="50" TextMode="Number" runat="server"></asp:TextBox>  недель 
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Аллергия <asp:RadioButtonList ID="RadioButtonListAllergy"  runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"><asp:ListItem Value="Нет">Нет</asp:ListItem><asp:ListItem Value="Есть">Есть</asp:ListItem></asp:RadioButtonList>, на  <asp:TextBox ID="TextBoxAllergyInfo" Width="500" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Лечение <asp:RadioButtonList ID="RadioButtonListTreatment"  runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"><asp:ListItem Value="амбулаторное">амбулаторное</asp:ListItem><asp:ListItem Value="стационарное">стационарное</asp:ListItem><asp:ListItem Value="самолечение">самолечение</asp:ListItem></asp:RadioButtonList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell HorizontalAlign="Left" BackColor="LightGray">Лекарственные средства, предположительно вызвавшие НР </asp:TableHeaderCell> 
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <asp:Table ID="TableMedicines" Width="100%" runat="server">
                            <asp:TableHeaderRow>
                                <asp:TableCell runat="server"></asp:TableCell>
                                <asp:TableCell runat="server">Наименование ЛС (торговое)*</asp:TableCell>
                                <asp:TableCell runat="server">Производитель</asp:TableCell>
                                <asp:TableCell runat="server">Номер серии</asp:TableCell>
                                <asp:TableCell runat="server">Доза, путь введения</asp:TableCell>
                                <asp:TableCell runat="server">Дата начала терапии</asp:TableCell>
                                <asp:TableCell runat="server">Дата окончания терапии</asp:TableCell>
                                <asp:TableCell runat="server">Показание</asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">1</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxNameLs1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxManufacture1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxNumberSeria1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxPathInto1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxTerapiaStart1" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxTerapiaEnd1" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxIndication1" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">2</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxNameLs2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxManufacture2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxNumberSeria2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxPathInto2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxTerapiaStart2" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxTerapiaEnd2" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxIndication2" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">3</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxNameLs3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxManufacture3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxNumberSeria3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxPathInto3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxTerapiaStart3" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxTerapiaEnd3" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxIndication3" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <asp:Table ID="TableReaction" Width="100%" runat="server">
                            <asp:TableHeaderRow>
                                <asp:TableCell Width="66%"  HorizontalAlign="Left" BackColor="LightGray">Нежелательная реакция </asp:TableCell>
                                <asp:TableCell runat="server">Дата начала НР <asp:TextBox ID="TextBoxDateStartHP" TextMode="Date" runat="server"></asp:TextBox> </asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">
                                    <b>Описание реакции*</b> (укажите все детали, включая данные лабораторных исследований) 
                                    <asp:TextBox ID="TextBoxDescriptionReaction" TextMode="MultiLine" Width="100%" Height="200" runat="server"></asp:TextBox>
                                    <br/>
                                    Дата разрешения НР <asp:TextBox ID="TextBoxPermitDate" TextMode="Date" runat="server"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell VerticalAlign="Top">
                                    Критерии серьезности НР: 
                                    <br/>
                                    <asp:CheckBox ID="CheckBoxCriteriaIsDeath" Text="Смерть" runat="server" /><br/>
                                    <asp:CheckBox ID="CheckBoxThreatOfLife" Text="Угроза жизни" runat="server" /><br/>
                                    <asp:CheckBox ID="CheckBoxHospitalization" Text="Госпитализация или ее продление" runat="server" /><br/>
                                    <asp:CheckBox ID="CheckBoxDisability" Text="Инвалидность" runat="server" /><br/>
                                    <asp:CheckBox ID="CheckBoxAnomalies" Text="Врожденные аномалии" runat="server" /><br/>
                                    <asp:CheckBox ID="CheckBoxMedicalIntervention" Text="Требует медицинского вмешательства для предотвращения развития перечисленных состояний" runat="server" /><br/>
                                    <asp:CheckBox ID="CheckBoxNotApplicable" Text="Не применимо" runat="server" /><br/>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow> 
                
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell HorizontalAlign="Left" BackColor="LightGray">Предпринятые меры</asp:TableHeaderCell> 
                </asp:TableHeaderRow>

                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <asp:RadioButtonList ID="RadioButtonListMeasuresTaken"  runat="server">
                            <asp:ListItem Value="Без лечения">Без лечения</asp:ListItem>
                            <asp:ListItem Value="Отмена подозреваемого ЛС">Отмена подозреваемого ЛС</asp:ListItem>
                            <asp:ListItem Value="Снижение дозы ЛС">Снижение дозы ЛС</asp:ListItem> 
                            <asp:ListItem Value="Немедикаментозная терапия (в т.ч. хирургическое вмешательство)">Немедикаментозная терапия (в т.ч. хирургическое вмешательство)</asp:ListItem> 
                            <asp:ListItem Value="Лекарственная терапия">Лекарственная терапия</asp:ListItem> 
                        </asp:RadioButtonList>  
                        <asp:TextBox ID="TextBoxDrugTherapyInfo" Width="300" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                
                
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell HorizontalAlign="Left" BackColor="LightGray">Исход</asp:TableHeaderCell> 
                </asp:TableHeaderRow>
                
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <asp:RadioButtonList ID="RadioButtonListExodus"  runat="server">
                            <asp:ListItem>Выздоровление без последствий</asp:ListItem>
                            <asp:ListItem>Улучшение состояние</asp:ListItem>
                            <asp:ListItem>Состояние без изменений</asp:ListItem>
                            <asp:ListItem>Выздоровление с последствиями (указать)</asp:ListItem>
                            <asp:ListItem>Смерть</asp:ListItem>
                            <asp:ListItem>Неизвестно</asp:ListItem>
                            <asp:ListItem>Не применимо</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:TextBox ID="TextBoxRecoveryWithConsequencesInfo" Width="300" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>                
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Сопровождалась ли отмена ЛС исчезновением НР? 
                        <asp:RadioButtonList ID="RadioButtonListDisappearance" RepeatLayout="Flow"  runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Нет</asp:ListItem>
                            <asp:ListItem>Да</asp:ListItem>
                            <asp:ListItem>ЛС не отменялось</asp:ListItem>
                            <asp:ListItem>Не применимо</asp:ListItem> 
                        </asp:RadioButtonList> 
                    </asp:TableCell>
                </asp:TableRow>                
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Назначалось ли лекарство повторно?  
                        <asp:RadioButtonList ID="RadioButtonListMedicineAgain" RepeatLayout="Flow"  runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Нет</asp:ListItem>
                            <asp:ListItem>Да</asp:ListItem> 
                        </asp:RadioButtonList> 
                        Отмечено ли повторное возникновение НР ?
                        <asp:RadioButtonList ID="RadioButtonListReoccurrenceHP" RepeatLayout="Flow"  runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Нет</asp:ListItem>
                            <asp:ListItem>Да</asp:ListItem> 
                            <asp:ListItem>Не применимо</asp:ListItem> 
                        </asp:RadioButtonList> 

                    </asp:TableCell>
                </asp:TableRow>

                
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell HorizontalAlign="Left" BackColor="LightGray">Другие лекарственные средства, принимаемые в течение последних 3 месяцев, включая ЛС принимаемые пациентом самостоятельно (по собственному желанию) </asp:TableHeaderCell> 
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <asp:Table ID="Table1" Width="100%" runat="server">
                            <asp:TableHeaderRow>
                                <asp:TableCell runat="server"></asp:TableCell>
                                <asp:TableCell runat="server">Наименование ЛС (торговое)*</asp:TableCell>
                                <asp:TableCell runat="server">Производитель</asp:TableCell>
                                <asp:TableCell runat="server">Номер серии</asp:TableCell>
                                <asp:TableCell runat="server">Доза, путь введения</asp:TableCell>
                                <asp:TableCell runat="server">Дата начала терапии</asp:TableCell>
                                <asp:TableCell runat="server">Дата окончания терапии</asp:TableCell>
                                <asp:TableCell runat="server">Показание</asp:TableCell>
                            </asp:TableHeaderRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">1</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNameLs1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherManufacture1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNumberSeria1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherPathInto1" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaStart1" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaEnd1" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherIndication1" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">2</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNameLs2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherManufacture2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNumberSeria2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherPathInto2" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaStart2" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaEnd2" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherIndication2" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server">3</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNameLs3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherManufacture3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNumberSeria3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherPathInto3" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaStart3" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaEnd3" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherIndication3" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow> 
                            <asp:TableRow>
                                <asp:TableCell runat="server">4</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNameLs4" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherManufacture4" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNumberSeria4" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherPathInto4" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaStart4" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaEnd4" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherIndication4" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow> 
                            <asp:TableRow>
                                <asp:TableCell runat="server">5</asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNameLs5" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherManufacture5" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherNumberSeria5" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherPathInto5" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaStart5" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherTerapiaEnd5" TextMode="Date" runat="server"></asp:TextBox></asp:TableCell>
                                <asp:TableCell runat="server"><asp:TextBox ID="TextBoxOtherIndication5" runat="server"></asp:TextBox></asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell HorizontalAlign="Left" BackColor="LightGray">Данные сообщающего лица </asp:TableHeaderCell> 
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <asp:RadioButtonList ID="RadioButtonListWhois" RepeatLayout="Flow"  runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Врач</asp:ListItem>
                            <asp:ListItem>Другой специалист системы здравоохранения</asp:ListItem> 
                            <asp:ListItem>Пациент</asp:ListItem> 
                            <asp:ListItem>Иной</asp:ListItem> 
                        </asp:RadioButtonList>   
                    </asp:TableCell>
                </asp:TableRow>
                
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <b>Контактный телефон/e-mail:* </b> <asp:TextBox ID="TextBoxContact" Width="400"   runat="server"></asp:TextBox> кг
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                         Ф.И.О    <asp:TextBox ID="TextBoxFIO" Width="400"   runat="server"></asp:TextBox> кг
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Область, город   <asp:TextBox ID="TextBoxRegionCity" Width="400"   runat="server"></asp:TextBox> кг
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Должность и место работы <asp:TextBox ID="TextBoxWork" Width="400"   runat="server"></asp:TextBox> кг
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        Дата сообщения <asp:TextBox ID="TextBoxDateMessage"  TextMode="Date"   runat="server"></asp:TextBox> кг
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <b>Клиент согласен на повторный контакт с сотрудником БИОКАД:</b>
                        <asp:RadioButtonList ID="RadioButtonListAgreeRecontact" RepeatLayout="Flow"  runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Да (согласие получено устно)</asp:ListItem>
                            <asp:ListItem>Нет</asp:ListItem>  
                        </asp:RadioButtonList>   
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">
                        <b>Клиент согласен на обработку персональных данных (в том объеме, в котором предоставлены)*:</b>
                        <asp:RadioButtonList ID="RadioButtonListAgreePersonalData" RepeatLayout="Flow"  runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem>Да</asp:ListItem>
                            <asp:ListItem>Нет</asp:ListItem>  
                        </asp:RadioButtonList>   
                    </asp:TableCell>
                </asp:TableRow>

                
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell HorizontalAlign="Left" BackColor="LightGray">Дополнительные комментарии</asp:TableHeaderCell> 
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell runat="server">  
                        <asp:TextBox ID="TextBoxComment" TextMode="MultiLine" Height="300" Width="100%" runat="server"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow> 

            </asp:Table>

                 <asp:Button ID="ButtonSendToEmail" runat="server" Text="Отправить" OnClick="ButtonSendToEmail_Click" />
            </span></span>
        </div>
    </form>
</body>
</html>
