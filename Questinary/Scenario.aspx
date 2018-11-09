<%@ Page Title="" Language="C#" MasterPageFile="~/templates/default/MasterPage.master" AutoEventWireup="true" CodeFile="Scenario.aspx.cs" Inherits="Scenario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1><asp:Label ID="Label1" runat="server" Text="Новый сценарий"></asp:Label></h1>

     <asp:DetailsView ID="DetailsView1" OnItemUpdated="DetailsView1_ItemUpdated" OnItemCommand="DetailsView1_ItemCommand" OnItemInserted="DetailsView1_ItemInserted" CssClass="crm-form" runat="server" DataSourceID="SqlDataSourceTypeClient" AutoGenerateRows="False" DefaultMode="Insert" OnPageIndexChanging="DetailsView1_PageIndexChanging" OnItemCreated="DetailsView1_ItemCreated" OnItemUpdating="DetailsView1_ItemUpdating">
            <Fields>
                <asp:TemplateField HeaderText="Наименование">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Описание">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Активный">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Назначить" Visible="False">
                    <EditItemTemplate>
                        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSourceListTypeClients">
                            <AlternatingItemTemplate>
                                <div style="">
                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("Checked")) %>' Text='<%# Eval("Title") %>' />
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ID") %>' />
                                </div>
                            </AlternatingItemTemplate>
                            <EditItemTemplate>
                                <span style="">Title:
                                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <asp:CheckBox ID="ActiveCheckBox0" runat="server" Checked='<%# Bind("Active") %>' Text="Active" />
                                <br />
                                ID:
                                <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                                <br />
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Обновить" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Отмена" />
                                <br />
                                <br />
                                </span>
                            </EditItemTemplate>
                            <EmptyDataTemplate>
                                <span>Нет данных.</span>
                            </EmptyDataTemplate>
                            <InsertItemTemplate>
                                <span style="">Title:
                                <asp:TextBox ID="TitleTextBox0" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <asp:CheckBox ID="ActiveCheckBox1" runat="server" Checked='<%# Bind("Active") %>' Text="Active" />
                                <br />
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Вставить" />
                                <asp:Button ID="CancelButton0" runat="server" CommandName="Cancel" Text="Очистить" />
                                <br />
                                <br />
                                </span>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <div style="">
                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("Checked")) %>' Text='<%# Eval("Title") %>' />
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ID") %>' />
                                </div>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div id="itemPlaceholderContainer" runat="server" style="">
                                    <span runat="server" id="itemPlaceholder" />
                                </div>
                                <div style="">
                                </div>
                            </LayoutTemplate>
                            <SelectedItemTemplate>
                                <span style="">Title:
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                                <br />
                                <asp:CheckBox ID="ActiveCheckBox3" runat="server" Checked='<%# Convert.ToBoolean(Eval("Active")) %>' Enabled="false" Text="Active" />
                                <br />
                                ID:
                                <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                                <br />
                                <br />
                                </span>
                            </SelectedItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SqlDataSourceListTypeClients" runat="server" CancelSelectOnNullParameter="False" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [Active], ct.[ID] ,isnull([IdScenario],0) as [Checked] FROM [crm_scenario_ClientTypes] ct LEFT JOIN [crm_scenario_client_Relations] cr ON ct.ID = cr.[IdClientType] and IdScenario = @IdScenario   WHERE ([IsDelete] = @IsDelete) ORDER BY [Title]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Byte" />
                                <asp:QueryStringParameter DefaultValue="" Name="IdScenario" QueryStringField="ID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceListTypeClients" DataKeyNames="ID">
                            <AlternatingItemTemplate>
                                <div style="">
                                <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("Checked")) %>'  Text='<%# Eval("Title") %>' />
                                <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ID") %>' runat="server" />
                                </div>
                            </AlternatingItemTemplate>
                            <EditItemTemplate>
                                <span style="">Title:
                                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' Text="Active" />
                                <br />
                                ID:
                                <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                                <br />
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Обновить" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Отмена" />
                                <br />
                                <br />
                                </span>
                            </EditItemTemplate>
                            <EmptyDataTemplate>
                                <span>Нет данных.</span>
                            </EmptyDataTemplate>
                            <InsertItemTemplate>
                                <span style="">Title:
                                <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                                <br />
                                <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' Text="Active" />
                                <br />
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Вставить" />
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Очистить" />
                                <br />
                                <br />
                                </span>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <div style="">
                                <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("Checked")) %>'  Text='<%# Eval("Title") %>' />
                                <asp:HiddenField ID="HiddenField1" Value='<%# Eval("ID") %>' runat="server" />
                                </div>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div id="itemPlaceholderContainer" runat="server" style="">
                                    <span runat="server" id="itemPlaceholder" />
                                </div>
                                <div style="">
                                </div>
                            </LayoutTemplate>
                            <SelectedItemTemplate>
                                <span style="">Title:
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                                <br />
                                <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("Active")) %>' Enabled="false" Text="Active" />
                                <br />
                                ID:
                                <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                                <br />
                                <br />
                                </span>
                            </SelectedItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SqlDataSourceListTypeClients" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT [Title], [Active], ct.[ID] ,0 as [Checked] FROM [crm_scenario_ClientTypes] ct LEFT JOIN [crm_scenario_client_Relations] cr ON ct.ID = cr.[IdClientType] and IdScenario = @IdScenario   WHERE ([IsDelete] = @IsDelete) ORDER BY [Title]" CancelSelectOnNullParameter="False">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Byte" />
                                <asp:QueryStringParameter DefaultValue="" Name="IdScenario" QueryStringField="ID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Пункт IVR(если несколько, то через запятую)" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <HeaderTemplate>
                        Пункт IVR<br/>(если несколько, то через запятую)
                    </HeaderTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Обновить" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Вставка" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Отмена" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Правка" />
                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="New" Text="Создать" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>
    
    <asp:SqlDataSource ID="SqlDataSourceTypeClient" OnUpdated="SqlDataSourceScenario_Updated" OnInserted="SqlDataSourceScenario_Inserted" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" SelectCommand="SELECT * FROM [crm_scenarios] WHERE (([ID] = @ID) AND ([IsDelete] = @IsDelete))" InsertCommand="INSERT INTO crm_scenarios(Title, Description, Active, IsDelete) VALUES (@Title,@Description, @Active, 0) set @IdScenario = SCOPE_IDENTITY() select @IdScenario" UpdateCommand="UPDATE crm_scenarios SET Title = @Title,Description = @Description, Active = @Active WHERE ID = @ID" OnSelecting="SqlDataSourceTypeClient_Selecting">
        <InsertParameters>
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="Active" />
            <asp:Parameter Name="Description" />
               <asp:Parameter Direction="Output" Name="IdScenario" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="IsDelete" Type="Byte" />
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceScenarioTypeClient" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" DeleteCommand="DELETE FROM crm_scenario_client_Relations WHERE IdScenario = @IdScenario" InsertCommand="INSERT INTO crm_scenario_client_Relations(IdClientType, IdScenario, IsDefault) VALUES (@IdClientType, @IdScenario, 0)" SelectCommand="SELECT [IdClientType], [IdScenario] FROM [crm_scenario_client_Relations]" OnSelecting="SqlDataSourceScenarioTypeClient_Selecting">
        <DeleteParameters>
            <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="IdClientType" />
            <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceIVR" runat="server" ConnectionString="<%$ ConnectionStrings:CRMCISCOConnectionString %>" DeleteCommand="DELETE FROM crm_scenario_IVR WHERE (IdScenario = @IdScenario)" InsertCommand="INSERT INTO crm_scenario_IVR(IdScenario, Button) VALUES (@IdScenario, @Button)" SelectCommand="SELECT * FROM [crm_scenario_IVR] WHERE IdScenario = @IdScenario">
        <DeleteParameters>
            <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
            <asp:Parameter Name="Button" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="IdScenario" QueryStringField="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

