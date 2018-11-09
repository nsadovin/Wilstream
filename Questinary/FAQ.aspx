<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="FAQ.aspx.cs" Inherits="faq" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:toolkitscriptmanager ID="Toolkitscriptmanager1" runat="server"></asp:toolkitscriptmanager>
        <h1>FAQ</h1>
    <asp:Button ID="Button4" runat="server" Text="Добавить вопрос - ответ" OnClick="Button4_Click" />

    <br />
    <br />

    <asp:Panel Visible="false" ID="Panel1" runat="server"  BorderStyle="None" BorderColor="#CCCCCC">
        <h5>Поиск</h5>
        <asp:TextBox ID="TextBox1" runat="server" Width="500px"></asp:TextBox>
        <asp:TextBoxWatermarkExtender ID="TextBox1_TextBoxWatermarkExtender" runat="server" Enabled="True" TargetControlID="TextBox1" WatermarkText="поиск по тексту">
        </asp:TextBoxWatermarkExtender>
        <asp:Button ID="Button3" runat="server" Text="ПОИСК" />

        <br />  <br />
         
    </asp:Panel>

    <asp:Panel ID="Panel2" Visible="false" runat="server" Font-Bold="False">
        <h5>Фильтры</h5>
        <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSourceReferencies" AutoGenerateColumns="False" GridLines="None" ShowHeader="False" Width="876px" Font-Size="12px">
            <Columns>
                <asp:TemplateField HeaderText="Title" SortExpression="Title">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="200px" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("ID") %>' />
                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceTerms" DataTextField="Title" DataValueField="ID" Width="400px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem Value="0">-------------------------------------------------------------------------------------</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceTerms" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [ID] FROM [crm_faq_ReferenceData] WHERE (([IsDeleted] = @IsDeleted) AND ([IdReference] = @IdReference)) ORDER BY [Title]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                                <asp:ControlParameter ControlID="HiddenField1" Name="IdReference" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BorderStyle="None" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceReferencies" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [ID] FROM [crm_faq_Reference] WHERE ([IsDeleted] = @IsDeleted) ORDER BY [Ordered] DESC">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
            </SelectParameters>
        </asp:SqlDataSource>

    <br/>
    </asp:Panel>


    <asp:Panel ID="Panel3" Visible="false" runat="server">
        <h5>Теги</h5>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceTags" InsertItemPosition="LastItem">
                        <AlternatingItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server"   AutoPostBack="True" OnCheckedChanged="CheckBox1_OnCheckedChanged"  />
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
                            <span>Нет данных.</span></EmptyDataTemplate>
            
                        <InsertItemTemplate>
                            
                           
                        </InsertItemTemplate>
                        <ItemTemplate>
                             
                            <asp:CheckBox ID="CheckBox1" runat="server"    AutoPostBack="True"  OnCheckedChanged="CheckBox1_OnCheckedChanged" />
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
                    <asp:SqlDataSource ID="SqlDataSourceTags" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>"   SelectCommand="SELECT crm_faq_Tags.Tag, crm_faq_Tags.ID  FROM crm_faq_Tags  WHERE (crm_faq_Tags.IsDeleted = @IsDeleted) ORDER BY  crm_faq_Tags.Tag" CancelSelectOnNullParameter="False">
                         
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                            <asp:QueryStringParameter DefaultValue="" Name="IdFAQ" QueryStringField="ID" />
                        </SelectParameters>
                    </asp:SqlDataSource> 
        <br/>
    </asp:Panel>

    <asp:GridView  CssClass="table-crm" ID="GridView1" runat="server" DataSourceID="SqlDataSourceFAQ" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="ID" Width="100%">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Question" HeaderText="Вопрос" SortExpression="Question" />
            <asp:TemplateField HeaderText="Ответ">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# RemoveTags(Eval("Answer").ToString(),300,"...") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# RemoveTags(Eval("Answer").ToString(),300,"...") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("ID") %>' CommandName="Edit" OnClick="Button1_Click" Text="Правка" />
                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" OnClientClick="if(!confirm('Удалить?')) return false;" CommandName="Delete" OnClick="Button2_Click" Text="Удалить" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <EmptyDataTemplate>
            Нет данных
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
        <asp:SqlDataSource ID="SqlDataSourceFAQ" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [ID],  [Question], [Answer] FROM [crm_faq_QA] WHERE
IdSection = @IdSection and
 ([IsDeleted] = @IsDeleted) 
AND (@Word is null OR ([Question] like '%'+@Word+ '%' or [Answer] like '%'+@Word+ '%' ))


AND (@IdReferenceData1 IS NULL OR ID IN (
           SELECT IdQA FROM ( 
            SELECT COUNT(*) CNT, IdQA FROM crm_faq_ReferenceDataQA WHERE IdReferenceData in (@IdReferenceData2)
            GROUP BY IdQA
            ) T WHERE T.CNT = @IdReferenceData3
             ) )


AND (@IdTag1 IS NULL OR ID IN (
           SELECT IdQA FROM ( 
            SELECT COUNT(*) CNT, IdQA FROM crm_faq_TagQA WHERE IdTag in (@IdTag2)
            GROUP BY IdQA
            ) T WHERE T.CNT = @IdTag3
             ) )


ORDER BY [ID] DESC" DeleteCommand="UPDATE crm_faq_QA SET IsDeleted = 1 WHERE (ID = @ID)" CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="IsDeleted" Type="Byte" />
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="Word" PropertyName="Text" />
                <asp:Parameter DefaultValue="" Name="IdReferenceData1" />
                <asp:Parameter Name="IdReferenceData2" />
                <asp:Parameter Name="IdReferenceData3" />
                <asp:Parameter DefaultValue="" Name="IdTag1" />
                <asp:Parameter Name="IdTag2" />
                <asp:Parameter Name="IdTag3" />
                <asp:QueryStringParameter DefaultValue="" Name="IdSection" QueryStringField="IdSection" />
            </SelectParameters>
        </asp:SqlDataSource>
</asp:Content>

