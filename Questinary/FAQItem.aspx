<%@ Page Title="" ValidateRequest="false" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="FAQItem.aspx.cs" Inherits="FAQItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <h1><asp:Label ID="Label1" runat="server" Text="Новый вопрос-ответ"></asp:Label></h1>
    <asp:DetailsView ID="DetailsView1" CssClass="crm-form"  runat="server" Height="50px" Width="100%" AutoGenerateRows="False" DataSourceID="SqlDataSourceFAQ" DefaultMode="Insert" OnItemCommand="DetailsView1_ItemCommand" OnItemInserted="DetailsView1_ItemInserted" OnItemUpdated="DetailsView1_ItemUpdated">
        <Fields>
            <asp:TemplateField HeaderText="Вопрос" SortExpression="Question">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Question") %>' TextMode="MultiLine"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Question") %>' TextMode="MultiLine"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Question") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ответ" SortExpression="Answer">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Answer") %>' CssClass="editor" TextMode="MultiLine"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Answer") %>' CssClass="editor" TextMode="MultiLine"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Answer") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Height="100px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Параметры" ShowHeader="False">
                <EditItemTemplate>
                    <br />
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceReference" ShowHeader="False" Width="100%" BorderStyle="None" BorderWidth="0px">
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" ItemStyle-Width="100" >
                            <ControlStyle Width="250px" />
                            <ItemStyle Width="250px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="ID">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("IdReferenceData") %>' Visible="False" ></asp:Label>
                                    <asp:Label ID="Label1_" runat="server" Text='<%# Bind("ID") %>' Visible="False" ></asp:Label>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceTerms" DataTextField="Title" DataValueField="ID" AppendDataBoundItems="True" Width="300px" SelectedValue='<%# Eval("IdReferenceData").ToString() %>'>
                                        <asp:ListItem Value="0">----------------------------------------------------------------------------</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceTerms" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT case when len([Title]) > 100 then substring([Title],0,100)+' ...' else [Title] end as [Title], [ID] FROM [crm_faq_ReferenceData] WHERE (([IsDeleted] = @IsDeleted) AND ([IdReference] = @IdReference)) ORDER BY [Title]" CancelSelectOnNullParameter="False">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Label1_" DefaultValue="" Name="IdReference" PropertyName="Text" Type="Int32" />
                                            <asp:Parameter DefaultValue="0" Name="IsDeleted" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSourceReference" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT crm_faq_Reference.Title, crm_faq_Reference.ID, isnull(crm_faq_ReferenceDataQA.IdReferenceData,0) as IdReferenceData FROM crm_faq_Reference LEFT JOIN crm_faq_ReferenceDataQA ON crm_faq_Reference.ID = crm_faq_ReferenceDataQA.IdReference AND (crm_faq_ReferenceDataQA.IdQA = @IdFAQ) WHERE (crm_faq_Reference.IsDeleted = @IsDeleted)  ORDER BY crm_faq_Reference.Ordered DESC">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                            <asp:QueryStringParameter DefaultValue="" Name="IdFAQ" QueryStringField="ID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <br />
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceReference" ShowHeader="False" Width="100%" BorderStyle="None" BorderWidth="0px">
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" ItemStyle-Width="100" >
                            <ControlStyle Width="250px" />
                            <ItemStyle Width="250px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="ID">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1_" runat="server" Text='<%# Bind("ID") %>' Visible="False" ></asp:Label>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceTerms" DataTextField="Title" DataValueField="ID" AppendDataBoundItems="True" Width="300px">
                                        <asp:ListItem Value="0">----------------------------------------------------------------------------</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceTerms" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT case when len([Title]) > 100 then substring([Title],0,100)+' ...' else [Title] end as [Title], [ID] FROM [crm_faq_ReferenceData] WHERE (([IsDeleted] = @IsDeleted) AND ([IdReference] = @IdReference)) ORDER BY [Title]" CancelSelectOnNullParameter="False">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Label1_" DefaultValue="" Name="IdReference" PropertyName="Text" Type="Int32" />
                                            <asp:Parameter DefaultValue="0" Name="IsDeleted" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSourceReference" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [ID] FROM [crm_faq_Reference] WHERE ([IsDeleted] = @IsDeleted) ORDER BY [Ordered] DESC">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Теги" Visible="False">
                <EditItemTemplate>
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceTags" InsertItemPosition="LastItem">
                        <AlternatingItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsChecked")) %>' />
                                <asp:Label ID="TagLabel" runat="server" Text='<%# Eval("Tag") %>' />
                             , 
                            <asp:Label ID="IDLabel" runat="server" Visible="false"  Text='<%# Eval("ID") %>' />
                           
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <span style="">Tag: <asp:TextBox ID="TagTextBox" runat="server" Text='<%# Bind("Tag") %>' />
                            <br />
                            ID: <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                            <br />
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Обновить" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Отмена" />
                            <br />
                            <br />
                            </span>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <span>Нет данных.</span></EmptyDataTemplate><InsertItemTemplate>
                            
                            <div style="">
                            <asp:TextBox ID="TagTextBox" Width="150" runat="server" Text='<%# Bind("Tag") %>' />
                             
                            <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Добавить" />
                            <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Очистить" />
                             
                            
                            </div>
                        </InsertItemTemplate>
                        <ItemTemplate>
                             
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsChecked")) %>' />
                                <asp:Label ID="TagLabel" runat="server" Text='<%# Eval("Tag") %>' />
                            , <asp:Label ID="IDLabel" runat="server" Visible="false" Text='<%# Eval("ID") %>' />
                           
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server" style="">
                                <span runat="server" id="itemPlaceholder" />
                            </div>
                            <div style="">
                            </div>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <span style="">Tag: <asp:Label ID="TagLabel" runat="server" Text='<%# Eval("Tag") %>' />
                            <br />
                            ID: <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                            <br />
                            <br />
                            </span>
                        </SelectedItemTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" InsertCommand="INSERT INTO crm_faq_Tags(Tag, IsDeleted) VALUES (@Tag, @IsDeleted)" SelectCommand="SELECT crm_faq_Tags.Tag, crm_faq_Tags.ID, CASE WHEN crm_faq_TagQA.IdQA IS NULL THEN 0 ELSE 1 END AS IsChecked FROM crm_faq_Tags LEFT JOIN crm_faq_TagQA ON crm_faq_Tags.ID = crm_faq_TagQA.IdTag AND (crm_faq_TagQA.IdQA = @IdFAQ) WHERE (crm_faq_Tags.IsDeleted = @IsDeleted) ORDER BY CASE WHEN crm_faq_TagQA.IdQA IS NULL THEN 0 ELSE 1 END DESC, crm_faq_Tags.Tag" CancelSelectOnNullParameter="False">
                        <InsertParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                            <asp:QueryStringParameter DefaultValue="" Name="IdFAQ" QueryStringField="ID" />
                        </SelectParameters>
                    </asp:SqlDataSource>                     
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceTags" InsertItemPosition="LastItem">
                        <AlternatingItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsChecked")) %>' />
                                <asp:Label ID="TagLabel" runat="server" Text='<%# Eval("Tag") %>' />
                             , 
                            <asp:Label ID="IDLabel" runat="server" Visible="false"  Text='<%# Eval("ID") %>' />
                           
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <span style="">Tag: <asp:TextBox ID="TagTextBox" runat="server" Text='<%# Bind("Tag") %>' />
                            <br />
                            ID: <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                            <br />
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Обновить" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Отмена" />
                            <br />
                            <br />
                            </span>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <span>Нет данных.</span></EmptyDataTemplate><InsertItemTemplate>
                            
                            <div style="">
                            <asp:TextBox ID="TagTextBox" Width="150" runat="server" Text='<%# Bind("Tag") %>' />
                             
                            <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Добавить" />
                            <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Очистить" />
                             
                            
                            </div>
                        </InsertItemTemplate>
                        <ItemTemplate>
                             
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsChecked")) %>' />
                                <asp:Label ID="TagLabel" runat="server" Text='<%# Eval("Tag") %>' />
                            , <asp:Label ID="IDLabel" runat="server" Visible="false" Text='<%# Eval("ID") %>' />
                           
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server" style="">
                                <span runat="server" id="itemPlaceholder" />
                            </div>
                            <div style="">
                            </div>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <span style="">Tag: <asp:Label ID="TagLabel" runat="server" Text='<%# Eval("Tag") %>' />
                            <br />
                            ID: <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                            <br />
                            <br />
                            </span>
                        </SelectedItemTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" InsertCommand="INSERT INTO crm_faq_Tags(Tag, IsDeleted) VALUES (@Tag, @IsDeleted)" SelectCommand="SELECT crm_faq_Tags.Tag, crm_faq_Tags.ID, CASE WHEN crm_faq_TagQA.IdQA IS NULL THEN 0 ELSE 1 END AS IsChecked FROM crm_faq_Tags LEFT JOIN crm_faq_TagQA ON crm_faq_Tags.ID = crm_faq_TagQA.IdTag AND (crm_faq_TagQA.IdQA = @IdFAQ) WHERE (crm_faq_Tags.IsDeleted = @IsDeleted) ORDER BY crm_faq_Tags.Tag" CancelSelectOnNullParameter="False">
                        <InsertParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                            <asp:QueryStringParameter DefaultValue="" Name="IdFAQ" QueryStringField="ID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Button" ShowEditButton="True" ShowInsertButton="True" />
        </Fields>
       </asp:DetailsView>

       <asp:SqlDataSource ID="SqlDataSourceFAQ" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Question], [Answer] FROM [crm_faq_QA] WHERE ([IsDeleted] = @IsDeleted) AND ID = @ID" InsertCommand="INSERT INTO crm_faq_QA(Question, Answer, IdSection) VALUES (@Question, @Answer, @IdSection) set @IdFAQ = SCOPE_IDENTITY() select @IdFAQ" UpdateCommand="UPDATE crm_faq_QA SET Question = @Question, Answer = @Answer WHERE (ID = @ID)" OnInserted="SqlDataSourceFAQ_Inserted" OnUpdated="SqlDataSourceFAQ_Updated">
           <SelectParameters>
               <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />  
               <asp:QueryStringParameter DefaultValue="" Name="ID" QueryStringField="ID" />
           </SelectParameters>
           <UpdateParameters>
               <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
           </UpdateParameters>
           <InsertParameters>
               <asp:Parameter Direction="Output" Name="IdFAQ" Type="Int32" />
               <asp:QueryStringParameter Name="IdSection" QueryStringField="IdSection" />
           </InsertParameters>
       </asp:SqlDataSource>

       <asp:SqlDataSource ID="SqlDataSourceFAQReference" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" InsertCommand="INSERT INTO crm_faq_ReferenceDataQA(IdReference, IdReferenceData, IdQA) VALUES (@IdReference, @IdReferenceData, @IdQA)" SelectCommand="SELECT * FROM [crm_faq_ReferenceDataQA]" DeleteCommand="DELETE FROM crm_faq_ReferenceDataQA WHERE (IdQA = @IdFAQ)">
           <DeleteParameters>
               <asp:QueryStringParameter Name="IdFAQ" QueryStringField="ID" />
           </DeleteParameters>
           <InsertParameters>
               <asp:Parameter Name="IdReference" />
               <asp:Parameter Name="IdReferenceData" />
               <asp:QueryStringParameter Name="IdQA" QueryStringField="ID" />
           </InsertParameters>
       </asp:SqlDataSource>

       <asp:SqlDataSource ID="SqlDataSourceFAQTags" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" InsertCommand="INSERT INTO crm_faq_TagQA(IdTag, IdQA) VALUES (@IdTag, @IdQA)" SelectCommand="SELECT * FROM [crm_faq_TagQA]" DeleteCommand="DELETE FROM crm_faq_TagQA WHERE (IdQA = @IdFAQ)">
           <DeleteParameters>
               <asp:QueryStringParameter Name="IdFAQ" QueryStringField="ID" />
           </DeleteParameters>
           <InsertParameters>
               <asp:Parameter Name="IdTag" />
               <asp:QueryStringParameter Name="IdQA" QueryStringField="ID" />
           </InsertParameters>
       </asp:SqlDataSource>

</asp:Content>

