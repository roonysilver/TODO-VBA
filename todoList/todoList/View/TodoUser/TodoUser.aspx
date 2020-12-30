<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="TodoUser.aspx.vb" Inherits="todoList.TodoUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button ID="return" runat="server" Text="バック" CssClass="btn btn-primary btn-return pull-left" />
    <asp:GridView ID="grvTodoList" runat="server" Width="100%"
        AutoGenerateColumns="False"
        AllowPaging="True"
        PagerStyle-CssClass="page-footer"
        OnRowCommand="grvTodoList_RowCommand"
        AllowCustomPaging="true"
        CssClass="table table-hover table-bordered table-top">



        <Columns>
            <asp:TemplateField HeaderText="項番">

                <ItemTemplate>

                    <asp:Label ID="lblStt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "position") %>'></asp:Label>

                </ItemTemplate>


            </asp:TemplateField>

            <asp:TemplateField HeaderText="項番" Visible="false">

                <ItemTemplate>

                    <asp:Label ID="lblToDoID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "idList") %>' Width="25px"></asp:Label>

                </ItemTemplate>


            </asp:TemplateField>



            <asp:TemplateField HeaderText="内容">

                <ItemTemplate>

                    <asp:Label ID="lblContent" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "content") %>' Width="150px" CssClass="text-width"></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="期日">
                <HeaderTemplate>
                    <asp:Label runat="server" Text="期日"></asp:Label><asp:LinkButton ID="btn_SortingDate" runat="server" CommandName="SORT" CssClass='<%#Session("SortIcon") %>'>  </asp:LinkButton>
                </HeaderTemplate>

                <ItemTemplate>

                    <asp:Label ID="lblExpired" ReadOnly="true" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "expiredDate", "{0:MM/dd/yyyy}") %>'></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="ステータス">

                <ItemTemplate>

                    <asp:Label ID="lblStatus" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "name") %>'></asp:Label>

                </ItemTemplate>

            </asp:TemplateField>

        </Columns>

    </asp:GridView>
</asp:Content>
