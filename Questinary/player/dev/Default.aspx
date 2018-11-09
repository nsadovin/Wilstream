<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="player_Default" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     
    <script src="js/jquery.js"></script>
    <script src="js/main.js"></script>
    
    <script src="../templates/default/js/ckeditor/ckeditor.js"></script>
    <script src="../templates/default/js/ckeditor/adapters/jquery.js"></script>
    <script>
        $(document).ready(function () {
           // $('textarea.editor').ckeditor();
            <% if(IsEdit) { %>
             var ckEditor = CKEDITOR.replace('ListView1$ctrl0$TextBoxQuest');

            ckEditor.on("change", function (event) {
                event.editor.updateElement();
            });  
            <% } %>
        });
    </script>
    <link href="css/style.css?v=2" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>

                            <asp:HiddenField ID="HiddenFieldIsSaveAnswer" runat="server"  />  
                            <asp:HiddenField ID="HiddenFieldIdSession" runat="server"  />  
                            <asp:HiddenField ID="HiddenFieldIdQuestScenario" runat="server"  />  
        <asp:HiddenField ID="HiddenFieldIdScenario" Value="11" runat="server" />
                                       <asp:HiddenField ID="HiddenFieldIdParentQuest" runat="server" />

                            <asp:DataList ID="DataListFaq" runat="server" DataSourceID="SqlDataSourceFAQs" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                <ItemTemplate>
                                     
                                    <asp:Button ID="ButtonQuest" runat="server" CssClass="helper" Text='<%# Eval("Question") %>' /> 
                                    <asp:ModalPopupExtender ID="Panel1_ModalPopupExtender"  runat="server"  
                                        Enabled="True" PopupControlID="PanelAnswer" TargetControlID="ButtonQuest" 
                                        BackgroundCssClass="modalBackground" DropShadow="False" OkControlID="ButtonCancel">
                                        </asp:ModalPopupExtender>
                                    <asp:Panel ID="PanelAnswer" CssClass="PopupModal" runat="server">
                                        <asp:Button ID="ButtonCancel" runat="server" CausesValidation="False"  CssClass="close-popup" Text="Закрыть" />
                                       <div style="clear:both;"></div>
                                        <asp:Panel ID="PanelScrollBars" runat="server" ScrollBars="Auto" Height="450">
                                    <asp:Label ID="AnswerLabel" runat="server" Text='<%# Eval("Answer") %>' />
                                            </asp:Panel>
                                        <asp:Button ID="ButtonCancelBottom" Visible="false" runat="server" CausesValidation="False"  CssClass="close-popup"  Text="Закрыть" />
                                     </asp:Panel>
                                </ItemTemplate>
                            </asp:DataList>
                            <div style="clear:both;"></div>

                             
                            <asp:SqlDataSource ID="SqlDataSourceFAQs" runat="server" ConnectionString="<%$ ConnectionStrings:QuestionaryConnectionString %>" SelectCommand="SELECT  crm_faq_QA.Question, crm_faq_QA.Answer FROM crm_faq_QA LEFT OUTER JOIN crm_scenario_FAQ ON crm_faq_QA.ID = crm_scenario_FAQ.IdFAQ  WHERE (crm_faq_QA.IsDeleted = 0)
AND crm_scenario_FAQ.IdQuest = @IdQuest
 ORDER BY crm_scenario_FAQ.OrderBy, crm_faq_QA.ID ASC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenFieldIdQuestScenario" Name="IdQuest" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                             
                           <asp:Label ID="Label17" runat="server" Text=""></asp:Label>
                    
    <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound"  DataSourceID="SqlDataSourceQuests" DataKeyNames="ID" OnItemCreated="ListView1_ItemCreated" OnDataBound="ListView1_DataBound">
        
        <EmptyDataTemplate>
            <span>Конец сценария.
                <br/>
                <br/>
            <asp:Button ID="Button10" OnClick="Button10_Click" runat="server" CssClass="scenario-answer back-button" Text="Назад" />

            </span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <asp:Label Visible="false" ID="IDLabel" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
            
            <asp:Button ID="Button10_top" OnClick="Button10_Click" runat="server" CssClass="scenario-answer back-button" Text="Назад" />
            
            <asp:Label ID="QuestLabel" runat="server" Text='<%# Eval("Quest") %>'></asp:Label>
            <asp:LinkButton ID="LinkButtonEdit" CommandName="Edit"  runat="server">[Править]</asp:LinkButton>
            <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' Font-Size="14px" Font-Bold="true" CssClass="blockquote" ForeColor="Black"></asp:Label>
            
            <asp:Button ID="Button10" OnClick="Button10_Click" runat="server" CssClass="scenario-answer back-button" Text="Назад" />

            <asp:ListView ID="ListView3" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceAnswers">
              
                <EmptyDataTemplate>
                    <span></span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    
                    <span style="">
                    <asp:Label ID="IDLabel" Visible="false" runat="server" Text='<%# Eval("ID") %>' />
                    <asp:Label ID="IdQuestLabel" Visible="false" runat="server" Text='<%# Eval("IdQuest") %>' />
                    <asp:Button ID="Button9" CssClass="scenario-answer" OnClick="Button9_Click" CommandArgument='<%# Eval("ID") %>' runat="server" Text='<%# Eval("Answer") %>' />
                    <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' Font-Size="14px" Font-Bold="true" ForeColor="Black" />
                    </span>
                </ItemTemplate>
                <LayoutTemplate>
                    <span id="itemPlaceholderContainer" runat="server" style="">
                        
                        <span runat="server" id="itemPlaceholder" />
                    </span> 
                </LayoutTemplate>
            </asp:ListView>
               
             <asp:SqlDataSource ID="SqlDataSourceAnswers" runat="server" ConnectionString="<%$ ConnectionStrings:QuestionaryConnectionString %>" SelectCommand="SELECT * FROM [crm_scenario_Answers] WHERE (([IdScenario] = @IdScenario) AND ([Active] = @Active) AND ([IdQuest] = @IdQuest)) ORDER BY OrderBy , ID">
                            <SelectParameters>
                                
                            <asp:ControlParameter ControlID="HiddenFieldIdScenario" Name="IdScenario" PropertyName="Value" Type="Int32" /> 
                                <asp:Parameter DefaultValue="1" Name="Active" Type="Byte" />
                                <asp:ControlParameter ControlID="IDLabel" Name="IdQuest" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                       
        </ItemTemplate>
        
                <EditItemTemplate>
                         <asp:TextBox ID="TextBoxQuest" runat="server" CssClass="editor" Text='<%# Bind("Quest") %>' TextMode="MultiLine"></asp:TextBox>
                       <br/> <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                </EditItemTemplate>
        <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span id="itemPlaceholder" runat="server"></span>
                       
                    </div>
                    <div style="">
                    </div>
        </LayoutTemplate>
        </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSourceQuests"  runat="server" ConnectionString="<%$ ConnectionStrings:QuestionaryConnectionString %>" SelectCommand="SELECT * FROM [crm_scenario_Quests] WHERE ([Active] = @Active) AND ([IdScenario] = @IdScenario) AND ([ID] = @ID OR (@ID is null AND IsStart = 1 AND  @IdQuest is null ) OR (@ID is null AND [ID] = @IdQuest ))" CancelSelectOnNullParameter="False" UpdateCommand="UPDATE crm_scenario_Quests SET Quest = @Quest WHERE (ID = @ID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="Active" Type="Byte" />
                            
                            <asp:ControlParameter ControlID="HiddenFieldIdScenario" Name="IdScenario" PropertyName="Value" Type="Int32" /> 
                            <asp:QueryStringParameter Name="IdQuest" QueryStringField="IdQuest" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenFieldIdParentQuest" Name="ID" PropertyName="Value" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="ListView1" Name="ID" PropertyName="SelectedValue" />
                        </UpdateParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceChain" runat="server" ConnectionString="<%$ ConnectionStrings:QuestionaryConnectionString %>" SelectCommand="SELECT IdQuest, (select top 1  IdScenario from [dbo].[crm_scenario_Quests] sq with(nolock) where sq.ID = IdQuest) as IdScenario FROM [crm_scenario_Chain] WHERE (([IdParentAnswer] = @IdParentAnswer) AND ([IdParentQuest] = @IdParentQuest))">
        <SelectParameters>
            <asp:Parameter Name="IdParentAnswer" Type="Int32" />
            <asp:ControlParameter ControlID="ListView1" Name="IdParentQuest" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        </asp:SqlDataSource>

                              

                              </ContentTemplate>
                    </asp:UpdatePanel>
                 
    </div>
    </form>
</body>
</html>
