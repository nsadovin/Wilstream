<%@ Page Title="" ValidateRequest="false" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="EditorScenario.aspx.cs" Inherits="EditorScenario" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register Namespace="CustomBoundField" TagPrefix="custom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <h1>Редактор сценария,         
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceScenario">
            <AlternatingItemTemplate>
                
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <td id="Td1" runat="server" style="">Title:
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Обновить" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Отмена" />
                </td>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table style="">
                    <tr>
                        <td>Нет данных.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <td id="Td2" runat="server" style="">Title:
                    <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Вставить" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Очистить" />
                </td>
            </InsertItemTemplate>
            <ItemTemplate>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                
            </ItemTemplate>
            <LayoutTemplate>
                <span id="Span1" runat="server" border="0" style="">
                    <span id="itemPlaceholderContainer" runat="server">
                        <span id="itemPlaceholder" runat="server"></span>
                    </span>
                </span>
                <div style="">
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <td id="Td3" runat="server" style="">Title:
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                    <br />
                </td>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceScenario" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title] FROM [crm_scenarios] WHERE ([ID] = @ID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        
        
    </h1>

<asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">

    <asp:View ID="View1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Добавить новый вопрос" OnClick="Button1_Click" />
        <br />
        <h4>Список вопросов сценария</h4>
        <asp:GridView ID="GridView1" CssClass="table-crm" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSourceQuests" ForeColor="#333333" GridLines="None" AllowPaging="True" Width="100%">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:TemplateField HeaderText="Текст вопроса" SortExpression="Quest">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Quest") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# RemoveTags(Eval("Quest").ToString(),300,"...") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Comment" HeaderText="Комментарий" SortExpression="Comment" />
                <asp:CheckBoxField DataField="Active" HeaderText="Активный" SortExpression="Active" />
                <asp:CheckBoxField DataField="IsStart" HeaderText="Стартовый" SortExpression="IsStart" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%#Eval("ID") %>'  Text="Правка" OnClick="Button1_Click1" />
                        &nbsp;<asp:Button ID="Button2" runat="server" OnClientClick="if(!confirm('Удалить ?')) return false;" CausesValidation="False" CommandName="Delete" Text="Удалить" />
                    </ItemTemplate>
                    <ItemStyle Wrap="False" />
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceQuests" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT * FROM [crm_scenario_Quests] WHERE ([IdScenario] = @IdScenario) ORDER BY [ID] DESC" DeleteCommand="DELETE FROM crm_scenario_Quests WHERE (ID = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:View>
    <asp:View ID="View2" runat="server">
        <h4>Новый вопрос</h4>

        <asp:DetailsView ID="DetailsView1" CssClass="crm-form" runat="server" Height="50px" Width="100%" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSourceQuest" DefaultMode="Insert" OnItemCommand="DetailsView1_ItemCommand" OnPageIndexChanging="DetailsView1_PageIndexChanging" OnItemInserting="DetailsView1_ItemInserting">
            <Fields>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:TemplateField HeaderText="Вопрос" SortExpression="Quest">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="editor" Text='<%# Bind("Quest") %>' TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="editor" Text='<%# Bind("Quest") %>' TextMode="MultiLine"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Quest") %>'></asp:Label>
                    </ItemTemplate> 
                </asp:TemplateField>
 
                <asp:BoundField DataField="Comment" HeaderText="Комментарий" SortExpression="Comment" />
                <asp:TemplateField HeaderText="Активный" SortExpression="Active">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="CheckBox1"  runat="server" Checked="true" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="IsStart" HeaderText="Начало?" SortExpression="IsStart" />
                <asp:TemplateField ShowHeader="False">
                    <InsertItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Создать" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="New" Text="Создать" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourceQuest" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT ID, IdScenario, Quest, Comment, isnull( Active, cast(0 as bit)) as Active, IsStart FROM crm_scenario_Quests WHERE (IdScenario = @IdScenario) AND (ID = @IdQuest)" InsertCommand="INSERT INTO crm_scenario_Quests(Quest, IdScenario, Comment, Active, IsStart) VALUES (@Quest, @IdScenario, @Comment, @Active, @IsStart); SELECT @LastID = SCOPE_IDENTITY()" OnInserted="SqlDataSourceQuest_Inserted" OnUpdated="SqlDataSourceQuest_Updated" UpdateCommand="UPDATE crm_scenario_Quests SET IdScenario = @IdScenario, Quest = @Quest, Comment = @Comment, Active = @Active, IsStart = @IsStart WHERE (ID = @ID)">
            <InsertParameters>
                <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
                <asp:Parameter Direction="Output" Name="LastID" Type="Int32" />
                <asp:Parameter Name="Active" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
                <asp:QueryStringParameter Name="IdQuest" QueryStringField="IdQuest" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ID" />
                <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </asp:View>
    <asp:View ID="View3" runat="server">
        <h4>Вопрос, <asp:ListView ID="ListView2" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceQuest">
            <AlternatingItemTemplate>
                <asp:Label ID="QuestLabel" runat="server" Text='<%# Eval("Quest") %>' />
            </AlternatingItemTemplate>
            <EmptyDataTemplate>
                <span>Нет данных.</span>
            </EmptyDataTemplate>
            <ItemTemplate>
                <asp:Label ID="QuestLabel" runat="server" Text='<%# RemoveTags(Eval("Quest").ToString()) %>' />
            </ItemTemplate>
            <LayoutTemplate>
                <span id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </span>
            </LayoutTemplate>
            </asp:ListView>
            
        </h4>
        <asp:DetailsView ID="DetailsView2" CssClass="crm-form" runat="server" Height="50px" Width="100%" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSourceQuest" DefaultMode="Edit" OnItemCommand="DetailsView1_ItemCommand" OnItemInserted="DetailsView2_ItemInserted" OnItemUpdated="DetailsView2_ItemUpdated">
            <Fields>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" /> 
                <asp:TemplateField HeaderText="Вопрос" SortExpression="Quest">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="editor" Text='<%# Bind("Quest") %>' TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="editor" Text='<%# Bind("Quest") %>' TextMode="MultiLine"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Quest") %>'></asp:Label>
                    </ItemTemplate> 
                </asp:TemplateField>
                <asp:BoundField DataField="Comment" HeaderText="Комментарий" SortExpression="Comment" />
                <asp:CheckBoxField DataField="Active" HeaderText="Активный" SortExpression="Active" />
                <asp:CheckBoxField DataField="IsStart" HeaderText="Начало?" SortExpression="IsStart" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" OnCommand="Button1_Command" />&nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить и создать новый" CommandArgument="SaveAndNew" OnCommand="Button3_Command" />&nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Создать" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Правка" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="New" Text="Создать" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>
         
        <h4>Ответы на вопрос</h4>
        <asp:Button ID="Button3" runat="server" Text="Добавить ответ" />
        <br/><br/>
        <asp:GridView ID="GridView2" CssClass="table-crm" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSourceAnswers" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Answer" HeaderText="Текст ответа" SortExpression="Answer" />
                <asp:BoundField DataField="Comment" HeaderText="Комментарий к ответу" SortExpression="Comment" />
                <asp:CheckBoxField DataField="Active" HeaderText="Активный" SortExpression="Active" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%#Eval("ID") %>' OnClick="Button1_Click2" Text="Правка" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="if(!confirm('Удалить?')) return false;" Text="Удалить" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                Нет данных
            </EmptyDataTemplate>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceAnswers" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT * FROM [crm_scenario_Answers] WHERE (([IdScenario] = @IdScenario) AND ([IdQuest] = @IdQuest)) ORDER BY [ID]" DeleteCommand="DELETE FROM crm_scenario_Answers WHERE (ID = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView2" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" Type="Int32" />
                <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
         
        <asp:Panel ID="Panel1" runat="server" CssClass="PopupModal">
            <h4>Новый ответ</h4>
            <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="False" CssClass="crm-form" DataKeyNames="ID" DataSourceID="SqlDataSourceAnswer" DefaultMode="Insert" Height="50px" Width="125px" OnItemInserting="DetailsView3_ItemInserting">
                <Fields>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="Answer" HeaderText="Ответ" SortExpression="Answer" />
                    <asp:BoundField DataField="Comment" HeaderText="Комментарий" SortExpression="Comment" />
                    <asp:TemplateField HeaderText="Активный" SortExpression="Active">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="True" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' Enabled="false" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" OnCommand="Button1_Command1" Text="Вставка" />
                            &nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="True" CommandName="Insert" OnCommand="Button3_Command1" Text="Вставка и создать новый" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Правка" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="New" Text="Создать" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
            </asp:DetailsView>
            
        </asp:Panel>
        <asp:ModalPopupExtender ID="Panel1_ModalPopupExtender"  runat="server"  Enabled="True" PopupControlID="Panel1" TargetControlID="Button3" BackgroundCssClass="modalBackground" DropShadow="True">
        </asp:ModalPopupExtender>
        <br />
<asp:SqlDataSource ID="SqlDataSourceAnswer" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT * FROM [crm_scenario_Answers] WHERE (([IdScenario] = @IdScenario) AND ([IdQuest] = @IdQuest) AND ([ID] = @ID))" InsertCommand="INSERT INTO crm_scenario_Answers(IdScenario, IdQuest, Answer, Comment, Active) VALUES (@IdScenario, @IdQuest, @Answer, @Comment, @Active)" OnInserted="SqlDataSourceAnswer_Inserted" OnUpdated="SqlDataSourceAnswer_Updated" UpdateCommand="UPDATE crm_scenario_Answers SET Answer = @Answer, Comment = @Comment, Active = @Active WHERE (ID = @ID)">
                <InsertParameters>
                    <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
                    <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" />
                    <asp:Parameter Name="Active" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" Type="Int32" />
                    <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="DetailsView4" Name="ID" PropertyName="SelectedValue" />
                </UpdateParameters>
            </asp:SqlDataSource>
        
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:Panel ID="Panel2" runat="server"  CssClass="PopupModal">
            <h4>Ответ, редактирование</h4>
            <asp:DetailsView ID="DetailsView4" runat="server" AutoGenerateRows="False" CssClass="crm-form" DataKeyNames="ID" DataSourceID="SqlDataSourceAnswer" DefaultMode="Edit" Height="50px" Width="125px">
                <Fields>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                    <asp:BoundField DataField="Answer" HeaderText="Ответ" SortExpression="Answer" />
                    <asp:BoundField DataField="Comment" HeaderText="Комментарий" SortExpression="Comment" />
                    <asp:CheckBoxField DataField="Active" HeaderText="Активный" SortExpression="Active" />
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            


        </asp:Panel>
        <asp:ModalPopupExtender ID="Panel2_ModalPopupExtender" runat="server" DynamicServicePath="" Enabled="True" PopupControlID="Panel2" TargetControlID="HiddenField1" BackgroundCssClass="modalBackground" DropShadow="True">
        </asp:ModalPopupExtender>

        <h4>Переходы с вопросами</h4>
        <asp:Button ID="Button4" runat="server" Text="Настроить"  />
 

        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="table-crm" DataKeyNames="ID" DataSourceID="SqlDataSourceChain" ForeColor="#333333" GridLines="None" Width="100%" AllowSorting="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="#" SortExpression="ID" />
                <asp:TemplateField HeaderText="Вопросы" SortExpression="Quest">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Quest") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# RemoveTags(Eval("Quest").ToString(),300) %>'></asp:Label>
                        <asp:Label ID="Label2" runat="server" Font-Italic="True" ForeColor="#CCCCCC" Text='<%# Bind("Comment") %>' Visible='<%# Eval("Quest").ToString()=="" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <EmptyDataTemplate>
                Нет настроенных переходов
            </EmptyDataTemplate>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>

        <asp:ModalPopupExtender ID="Button4_ModalPopupExtender" runat="server" DynamicServicePath="" Enabled="True"  PopupControlID="Panel3" TargetControlID="Button4" BackgroundCssClass="modalBackground" CancelControlID="Button6" Drag="True">
        </asp:ModalPopupExtender>

        <asp:Panel ID="Panel3" runat="server"  CssClass="PopupModal">
            <h4>Настройка переходов</h4><asp:Panel ID="Panel5" runat="server" ScrollBars="Auto" Height="600">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                 Сценарий:

                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceListScenarios" DataTextField="Title" DataValueField="Id" OnDataBound="DropDownList1_DataBound" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>

                    <asp:SqlDataSource ID="SqlDataSourceListScenarios" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [ID] FROM [crm_scenarios] WHERE ([IsDelete] = @IsDelete) ORDER BY [Title]">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Byte" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    

<asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" CssClass="table-crm" DataKeyNames="ID" DataSourceID="SqlDataSourceQuestsChain" ForeColor="#333333" GridLines="None" Width="100%" PageSize="100" AllowPaging="True" AllowSorting="True">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    
                    <asp:BoundField DataField="ID" HeaderText="#" SortExpression="ID" />
                    
                    <asp:TemplateField HeaderText="Текст вопроса" SortExpression="Quest">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Quest") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" Checked='<%#Eval("QuestParent") %>' />
                            <asp:Label ID="Label1" runat="server" Text='<%# RemoveTags(Eval("Quest").ToString(),500) %>'></asp:Label>
                            <asp:Label ID="Label2" runat="server" Font-Italic="True" ForeColor="#CCCCCC" Text='<%# Bind("Comment") %>' Visible='<%# Eval("Quest").ToString()=="" %>'></asp:Label>
                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("ID") %>' />
                            <asp:ListView ID="ListView3" Visible='<%#Eval("QuestParent") %>' runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceAnserwsQuest" OnPreRender="ListView3_PreRender" OnLoad="ListView3_Load" OnDataBound="ListView3_DataBound">
                                <AlternatingItemTemplate>
                                    <div>
                                    -  <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("AnswerParent") %>' Text="" />
                                    <asp:Label ID="AnswerLabel" runat="server" Text='<%# Eval("Answer") %>' />
                                    <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("ID") %>' />
                            
                                    </div>
                                </AlternatingItemTemplate>
                                <EmptyDataTemplate>
                                    <span>Нет данных.</span>
                                </EmptyDataTemplate> 
                                <ItemTemplate><div>
                                    -  <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Eval("AnswerParent") %>' Text="" />
                                    <asp:Label ID="AnswerLabel" runat="server" Text='<%# Eval("Answer") %>' />
                                    <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("ID") %>' />
                                    </div>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div id="itemPlaceholderContainer" runat="server" style="">
                                        <span runat="server" id="itemPlaceholder" />
                                    </div>
                                </LayoutTemplate> 
                            </asp:ListView>
                            <br />
                            <asp:SqlDataSource ID="SqlDataSourceAnserwsQuest" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT crm_scenario_Answers.ID, crm_scenario_Answers.IdScenario, crm_scenario_Answers.IdQuest, crm_scenario_Answers.Answer, crm_scenario_Answers.Comment, crm_scenario_Answers.Active, cast(CASE WHEN crm_scenario_Chain.IdQuest IS NULL THEN 0 ELSE 1 END as bit) AS AnswerParent FROM crm_scenario_Answers LEFT OUTER JOIN crm_scenario_Chain ON crm_scenario_Answers.ID = crm_scenario_Chain.IdParentAnswer AND crm_scenario_Answers.IdQuest = crm_scenario_Chain.IdParentQuest AND crm_scenario_Chain.IdQuest = @IdQuestChild WHERE (crm_scenario_Answers.IdQuest = @IdQuest) ORDER BY crm_scenario_Answers.ID">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField2" Name="IdQuest" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="DetailsView2" Name="IdQuestChild" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerSettings Position="TopAndBottom" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
                </asp:Panel>
            <asp:Button ID="Button5" runat="server" Text="Сохранить" OnClick="Button5_Click" />
            <asp:Button ID="Button6" runat="server" Text="Отмена" />
            <asp:SqlDataSource ID="SqlDataSourceQuestsChain" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT crm_scenario_Quests.ID, crm_scenario_Quests.IdScenario, crm_scenario_Quests.Quest, crm_scenario_Quests.Comment, crm_scenario_Quests.Active, crm_scenario_Quests.IsStart, CAST(CASE WHEN crm_scenario_Chain.IdQuest IS NULL THEN 0 ELSE 1 END AS bit) AS QuestParent FROM crm_scenario_Quests LEFT OUTER JOIN (select distinct IdParentQuest, IdQuest from crm_scenario_Chain where crm_scenario_Chain.IdQuest = @IDQuestChild) crm_scenario_Chain ON crm_scenario_Quests.ID = crm_scenario_Chain.IdParentQuest  WHERE (crm_scenario_Quests.IdScenario = @IdScenario) AND (crm_scenario_Quests.ID &lt;&gt; @ID) AND (crm_scenario_Quests.Active = @Active) ORDER BY crm_scenario_Quests.ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="IdScenario" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="DetailsView2" Name="ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="Active" />
                    <asp:ControlParameter ControlID="DetailsView2" Name="IDQuestChild" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>


        <asp:SqlDataSource ID="SqlDataSourceChain" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" DeleteCommand="DELETE FROM crm_scenario_Chain WHERE (IdQuest = @IdQuest)" InsertCommand="INSERT INTO crm_scenario_Chain(IdQuest, IdParentQuest, IdParentAnswer) VALUES (@IdQuest, @IdParentQuest, @IdParentAnswer)" SelectCommand="SELECT *  FROM crm_scenario_Quests WHERE Active = 1 AND ID in (SELECT IdParentQuest FROM crm_scenario_Chain WHERE IdQuest = @IdQuest)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" />
                <asp:Parameter Name="IdParentQuest" />
                <asp:Parameter Name="IdParentAnswer" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>


        <h4>Вопросы FAQ</h4>
        <asp:Button ID="Button7" runat="server" Text="Настроить FAQ"  />

        <br/>
        <br/>
         <asp:GridView ID="GridView6" runat="server" CssClass="table-crm" CellPadding="4" DataSourceID="SqlDataSourceScenarioFAQ" ForeColor="#333333" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="">
                 <AlternatingRowStyle BackColor="White" />
                 <Columns>
                     <asp:BoundField DataField="Question" HeaderText="Текст вопроса" SortExpression="Question" />
                     </Columns>
                 <EditRowStyle BackColor="#2461BF" />
                 <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                 <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                 <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                 <RowStyle BackColor="#EFF3FB" />
                 <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                 <SortedAscendingCellStyle BackColor="#F5F7FB" />
                 <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                 <SortedDescendingCellStyle BackColor="#E9EBEF" />
                 <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>

        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DynamicServicePath="" Enabled="True"  PopupControlID="Panel4" TargetControlID="Button7" BackgroundCssClass="modalBackground" CancelControlID="Button9" OnCancelScript="">
        </asp:ModalPopupExtender>

         <asp:Panel ID="Panel4" runat="server"  CssClass="PopupModal">
            <h4>Прикрепить FAQ</h4>
             <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
             <asp:DropDownList ID="DropDownListSectionFAQ" runat="server" AutoPostBack="True" OnDataBound="DropDownListSectionFAQ_DataBound" OnSelectedIndexChanged="DropDownListSectionFAQ_SelectedIndexChanged" DataSourceID="SqlDataSourceSectionFAQ" DataTextField="Title" DataValueField="ID"></asp:DropDownList>
             <asp:SqlDataSource ID="SqlDataSourceSectionFAQ" runat="server" ConnectionString="<%$ ConnectionStrings:QuestionaryConnectionString %>" SelectCommand="SELECT [ID], [Title] FROM [crm_faq_Sections] WHERE ([IsDeleted] = @IsDeleted) ORDER BY [Title]">
                 <SelectParameters>
                     <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Int32" />
                 </SelectParameters>
             </asp:SqlDataSource>
             <asp:GridView ID="GridView5" runat="server" CssClass="table-crm" CellPadding="4" DataSourceID="SqlDataSourceFAQ" ForeColor="#333333" GridLines="None" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID">
                 <AlternatingRowStyle BackColor="White" />
                 <Columns>
                     <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                     <asp:TemplateField>
                         <EditItemTemplate>
                             <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsSelected") %>' />
                         </EditItemTemplate>
                         <ItemTemplate>
                             <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("IsSelected") %>' />
                             <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Eval("ID") %>' />
                         </ItemTemplate>
                     </asp:TemplateField>
                     <asp:BoundField DataField="Question" HeaderText="Текст вопроса" SortExpression="Question" />
                     <asp:BoundField DataField="Answer" HeaderText="Answer" SortExpression="Answer" Visible="False" />
                     <asp:CheckBoxField DataField="IsDeleted" HeaderText="IsDeleted" SortExpression="IsDeleted" Visible="False" />
                 </Columns>
                 <EditRowStyle BackColor="#2461BF" />
                 <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                 <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                 <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                 <RowStyle BackColor="#EFF3FB" />
                 <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                 <SortedAscendingCellStyle BackColor="#F5F7FB" />
                 <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                 <SortedDescendingCellStyle BackColor="#E9EBEF" />
                 <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>

                      </ContentTemplate>
            </asp:UpdatePanel>
             <br />
             <asp:Button ID="Button8" runat="server" Text="Сохранить" OnClick="Button8_Click" />
             <asp:Button ID="Button9" runat="server" Text="Отмена" />

             <asp:SqlDataSource ID="SqlDataSourceFAQ" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT crm_faq_QA.ID, crm_faq_QA.Question, crm_faq_QA.Answer, crm_faq_QA.IsDeleted, CAST(CASE WHEN crm_scenario_FAQ.IdQuest IS NULL THEN 0 ELSE 1 END AS bit) AS IsSelected FROM crm_faq_QA LEFT OUTER JOIN crm_scenario_FAQ ON crm_faq_QA.ID = crm_scenario_FAQ.IdFAQ AND crm_scenario_FAQ.IdQuest = @IdQuest WHERE (crm_faq_QA.IsDeleted = @IsDeleted) AND IdSection =  @IdSection ORDER BY crm_faq_QA.ID DESC">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="DetailsView2" DefaultValue="" Name="IdQuest" PropertyName="SelectedValue" />
                     <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                     <asp:ControlParameter ControlID="DropDownListSectionFAQ" DefaultValue="" Name="IdSection" PropertyName="SelectedValue" />
                 </SelectParameters>
             </asp:SqlDataSource>

         </asp:Panel>

        <asp:SqlDataSource ID="SqlDataSourceScenarioFAQ" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" DeleteCommand="DELETE FROM crm_scenario_FAQ WHERE (IdQuest = @IdQuest)" 
            InsertCommand="INSERT INTO crm_scenario_FAQ(IdQuest, IdFAQ) VALUES (@IdQuest, @IdFAQ)" 
            SelectCommand="SELECT crm_faq_QA.ID,crm_faq_QA.IdSection, crm_faq_QA.Question, crm_faq_QA.Answer FROM crm_faq_QA LEFT OUTER JOIN crm_scenario_FAQ ON crm_faq_QA.ID = crm_scenario_FAQ.IdFAQ  WHERE (crm_faq_QA.IsDeleted = @IsDeleted)
AND crm_scenario_FAQ.IdQuest = @IdQuest
 ORDER BY crm_faq_QA.ID DESC">
            <DeleteParameters>
                <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DetailsView2" Name="IdQuest" PropertyName="SelectedValue" />
                <asp:Parameter Name="IdFAQ" />
            </InsertParameters>
            <SelectParameters>
                     <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                     <asp:ControlParameter ControlID="DetailsView2" DefaultValue="" Name="IdQuest" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <br/>
        <br/>


     </asp:View>
    
</asp:MultiView>
        
    
        
        
    
</asp:Content>

