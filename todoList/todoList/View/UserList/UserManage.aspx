<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="UserManage.aspx.vb" Inherits="todoList.UserManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <asp:GridView ID="grvUser" runat="server" Width="100%"
        AutoGenerateColumns="False"
        AllowPaging="True"
        OnRowDeleting="grvUser_RowDeleting"
        OnRowUpdating="grvUser_RowUpdating"
        OnRowCancelingEdit="grvUser_RowCancelingEdit"
        OnRowEditing="grvUser_RowEditing" CssClass="table table-hover table-bordered table-top"
        OnRowCommand="grvTodoList_RowCommand">
        <Columns>

            <asp:TemplateField HeaderText="項番">
                <ItemTemplate>
                    <asp:Label ID="lblStt" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="項番" Visible="false">

                <ItemTemplate>

                    <asp:Label ID="lblUserID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "id") %>'></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="メール">

                <ItemTemplate>

                    <asp:Label ID="lblEmail" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "email") %>'></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="フルネーム">

                <ItemTemplate>

                    <asp:Label ID="lblFullName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "fullName") %>'></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="生年月日">

                <ItemTemplate>

                    <asp:Label ID="lblDob" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "dob", "{0:dd/MM/yyyy}") %>'></asp:Label>

                </ItemTemplate>


            </asp:TemplateField>

            <asp:TemplateField HeaderText="電話番号">

                <ItemTemplate>

                    <asp:Label ID="lblTel" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "tel") %>'></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>

            <%--<asp:TemplateField HeaderText="Role">

                    <ItemTemplate>

                        <asp:Label ID="lblRole" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "idRole") %>'></asp:Label>

                    </ItemTemplate>

                </asp:TemplateField>--%>

            <asp:TemplateField HeaderText="">

                <ItemTemplate>

                    <asp:ImageButton ID="imgbtnEdit" runat="server" CommandName="List" ImageUrl="~/Image/list.png" Height="32px" Width="32px" CommandArgument="<%# Container.DataItemIndex %>" />

                </ItemTemplate>

            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</asp:Content>
