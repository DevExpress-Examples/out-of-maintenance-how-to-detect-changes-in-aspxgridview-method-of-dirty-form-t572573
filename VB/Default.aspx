<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="Default" %>
<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.2.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASPxGridView - Detecting Changes (Dirty Form)</title>
    <script src="JavaScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGlobalEvents ID="globalEvents" runat="server">
            <ClientSideEvents ControlsInitialized="onControlsInitialized" />
        </dx:ASPxGlobalEvents>
        <asp:SqlDataSource ID="dataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
            DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = @ProductID" 
            InsertCommand="INSERT INTO [Products] ([ProductID], [ProductName], [UnitPrice], [Discontinued], [CategoryID]) VALUES (@ProductID, @ProductName, @UnitPrice, @Discontinued, @CategoryID)" 
            SelectCommand="SELECT [ProductID], [ProductName], [UnitPrice], [Discontinued], [CategoryID] FROM [Products]" 
            UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [UnitPrice] = @UnitPrice, [Discontinued] = @Discontinued, [CategoryID] = @CategoryID WHERE [ProductID] = @ProductID" >
            <DeleteParameters>
                <asp:Parameter Name="ProductID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ProductID" Type="Int32" />
                <asp:Parameter Name="ProductName" Type="String" />
                <asp:Parameter Name="UnitPrice" Type="Decimal" />
                <asp:Parameter Name="Discontinued" Type="Boolean" />
                <asp:Parameter Name="CategoryID" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProductName" Type="String" />
                <asp:Parameter Name="UnitPrice" Type="Decimal" />
                <asp:Parameter Name="Discontinued" Type="Boolean" />
                <asp:Parameter Name="CategoryID" Type="Int32" />
                <asp:Parameter Name="ProductID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="detailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"
            SelectCommand="SELECT [CategoryName], [CategoryID] FROM [Categories] ">
        </asp:SqlDataSource>
        <dx:ASPxGridView AutoGenerateColumns="False" DataSourceID="dataSource" KeyFieldName="ProductID"
            ClientInstanceName="grid" ID="grid" runat="server">
            <Columns>
                <dx:GridViewCommandColumn ShowEditButton="true" ShowCancelButton="true">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProductName">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn Caption="Category Name" FieldName="CategoryID">
                    <PropertiesComboBox TextField="CategoryName" ValueField="CategoryID" DataSourceID="detailDataSource">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="UnitPrice">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Discontinued">
                </dx:GridViewDataCheckColumn>
            </Columns>
            <Templates>
                <EditForm>
                    <dx:ASPxGridViewTemplateReplacement ID="editFormEditors" ReplacementType="EditFormEditors" runat="server" />
                    <div>
                        <dx:ASPxButton AutoPostBack="false" Text="Save" ClientEnabled="false"
                            ClientInstanceName="saveBtn" ID="saveBtn" runat="server">
                            <ClientSideEvents Click="onSaveChanges" />
                        </dx:ASPxButton>
                        <dx:ASPxButton AutoPostBack="false" Text="Clear" ClientEnabled="false"
                            ClientInstanceName="clearBtn" ID="clearBtn" runat="server">
                            <ClientSideEvents Click="onClearChanges" />
                        </dx:ASPxButton>
                        <dx:ASPxButton AutoPostBack="false" Text="Cancel" ClientInstanceName="cancelBtn"
                            ID="cancelBtn" runat="server">
                            <ClientSideEvents Click="onCancelEdit" />
                        </dx:ASPxButton>
                    </div>
                </EditForm>
            </Templates>
            <SettingsEditing Mode="EditForm"></SettingsEditing>
        </dx:ASPxGridView>
    </div>
    </form>
</body>
</html>