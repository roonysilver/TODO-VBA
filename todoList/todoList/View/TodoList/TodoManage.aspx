<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="TodoManage.aspx.vb" Inherits="todoList.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:TextBox ID="txtGuid" runat="server" CssClass="GUID"></asp:TextBox>
    <asp:GridView ID="grvTodoList" runat="server" Width="100%"
        AutoGenerateColumns="False" ShowFooter="True"
        PagerStyle-CssClass="page-footer disable_row"
        AllowPaging="True"
        AllowCustomPaging="true"
        OnPageIndexChanging="grvTodoList_IndexChange"
        ShowHeaderWhenEmpty="true"
        OnRowCommand="grvTodoList_RowCommand"
        OnDataBound="OndataBound"
        OnRowDeleting="grvTodoList_RowDeleting"
        OnRowUpdating="grvTodoLists_RowUpdating"
        HeaderStyle-CssClass="disable_row"
        FooterStyle-CssClass="disable_row"
        OnRowCancelingEdit="grvTodoList_RowCancelingEdit"
        OnRowEditing="grvTodoList_RowEditing" CssClass="drag_drop_grid table table-hover table-bordered table-top">

        <Columns>
            <asp:TemplateField HeaderText="">
                <HeaderTemplate>
                    <input id="chkSelect" name="Select All" type="checkbox"></input>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="clbSelect" runat="server" CssClass="clbSelect" AutoPostBack="false" Width="40px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="項番" SortExpression="TodoId">

                <ItemTemplate>
                    <asp:Label ID="lblStt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "position") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>

                    <asp:TextBox ID="txteditid" TextMode="Number" Width="50px" runat="server" Text='<%#databinder.eval(container.dataitem, "position") %>'></asp:TextBox>

                </EditItemTemplate>

                <FooterTemplate>

                    <asp:TextBox ID="txtaddid" runat="server" Width="50px" CssClass="erroradd" Visible="false"></asp:TextBox><br />

                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="IDStatus" Visible="false">
                <EditItemTemplate>
                    <asp:Label ID="lblStatusID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "idStatus") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="項番" Visible="false">

                <ItemTemplate>
                    <asp:Label ID="lblToDoID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "idList") %>'></asp:Label>

                </ItemTemplate>

                <EditItemTemplate>

                    <asp:Label ID="lblEditTodoID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "idList") %>'></asp:Label>

                </EditItemTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="内容">

                <ItemTemplate>

                    <asp:Label ID="lblContent" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "content") %>' Width="300px" CssClass="text-width"></asp:Label>

                </ItemTemplate>

                <EditItemTemplate>

                    <asp:TextBox ID="txtEditContent" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "content") %>' Width="300px" CssClass="text-width error"></asp:TextBox><br />
                    <span class="Error_Edit_Content" style="color: red; display: none">内容を入力してください</span>
                    <%--<asp:RequiredFieldValidator ID="rqv_editContent" runat="server" ControlToValidate="txtEditContent" ForeColor="Red" ErrorMessage="内容を入力してください"></asp:RequiredFieldValidator>--%>
                </EditItemTemplate>

                <FooterTemplate>

                    <asp:TextBox ID="txtAddContent" runat="server" Width="100%" CssClass="errorAdd"></asp:TextBox><br />
                    <%--<asp:Label ID="lblAddContent" Visible="false" runat="server" Text="内容を入力してください" ForeColor="Red"></asp:Label>--%>
                    <span class="Error_Add_Content" style="color: red; display: none">内容を入力してください</span>
                </FooterTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="期日">
                <HeaderTemplate>
                    <asp:Label runat="server" Text="期日"></asp:Label><asp:LinkButton ID="btn_SortingDate" runat="server" CommandName="SORT" CssClass='<%#Session("SortIcon") %>'>  </asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>

                    <asp:Label ID="lblExpired" ReadOnly="true" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "expiredDate", "{0:MM/dd/yyyy}") %>'></asp:Label>

                </ItemTemplate>

                <EditItemTemplate>

                    <asp:TextBox ID="txtEditExpired" CssClass="date-time" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "expiredDate", "{0:MM/dd/yyyy}") %>'></asp:TextBox>

                </EditItemTemplate>

                <FooterTemplate>

                    <asp:TextBox ID="datepicker" CssClass="date-time errorDate" runat="server" Width="100%"></asp:TextBox><br />
                    <%--<asp:Label ID="lblAddDate" Visible="false" runat="server" Text="日付を入力してください" ForeColor="Red"></asp:Label>--%>
                    <span class="Error_Add_Date" style="color: red; display: none">日付を入力してください</span>
                </FooterTemplate>

            </asp:TemplateField>



            <asp:TemplateField HeaderText="ステータス">

                <ItemTemplate>

                    <asp:Label ID="lblStatus" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "name") %>'></asp:Label>

                </ItemTemplate>

                <EditItemTemplate>

                    <%--<asp:TextBox ID="txtEditStatus" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "status") %>'></asp:TextBox>--%>
                    <asp:DropDownList ID="txtEditStatus" runat="server" CssClass="ddlStatus" AppendDataBoundItems="true">
                    </asp:DropDownList>

                </EditItemTemplate>

                <FooterTemplate>

                    <%--<asp:TextBox ID="txtAddStatus" runat="server" Width="100%"></asp:TextBox>--%>
                    <asp:DropDownList ID="txtAddStatus" runat="server" CssClass="mx-auto" Visible="false">
                    </asp:DropDownList>

                </FooterTemplate>

            </asp:TemplateField>







            <asp:TemplateField HeaderText="アクション">

                <ItemTemplate>

                    <asp:ImageButton ID="imgbtnEdit" runat="server" CommandName="Edit" ImageUrl="~/Image/edit.png" Height="32px" Width="32px" />

                    <asp:ImageButton ID="imgbtnDelete" runat="server" CssClass="btnDelete" CommandName="Delete" OnClientClick="return confirm('この作業を本当に削除しますか？削除後は元に戻すことはできません。');"
                        AlternateText="Delete" ImageUrl="~/Image/delete.png" Height="32px" Width="32px" />

                </ItemTemplate>

                <EditItemTemplate>

                    <asp:ImageButton ID="imgbtnUpdate" CssClass="btnUpdate" runat="server" CommandName="Update" ImageUrl="~/Image/success.png" Height="32px" Width="32px" />

                    <asp:ImageButton ID="imgbtnCancel" runat="server" CommandName="Cancel" ImageUrl="~/Image/delete.png" Height="32px" Width="32px" />

                </EditItemTemplate>

                <FooterTemplate>

                    <asp:LinkButton ID="lbtnAdd" runat="server" CommandName="ADD" CssClass=" myButton" Text="追加" Width="100px"></asp:LinkButton>
                </FooterTemplate>

            </asp:TemplateField>

        </Columns>

    </asp:GridView>

    <div>
        <asp:Button runat="server" Text="削除" CssClass="btn btn-danger btnDeleteMulti" ID="btnDeleteMulti" OnClick="Button_Deleting_Click"
            AlternateText="Delete" />

        <asp:Button ID="btntoCsv" runat="server" CssClass="btn btn-primary" Text="CSV出力" OnClick="btntoCsv_Click" />
    </div>
    <asp:TextBox ID="txtPriority" runat="server" CssClass="PriorityPosition"></asp:TextBox>
    <asp:Button ID="btnPriority" runat="server" CssClass="btn_PriorityPosition" Text="Button" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript">
        $(function () {
            $(".date-time").datepicker();
            $(".date-time").attr("readonly", "true")
        });
    </script>
    <script type="text/javascript">
    
        var numberOfCheck = 0;
        $('#chkSelect').on('change', function () {
            $(this).closest('table').find('td input:checkbox').prop('checked', this.checked);
            //count totak check box -1 
            if ($(this).prop("checked") == true) {
                numberOfCheck = $('input:checkbox:checked').length - 1;
            }
            else if ($(this).prop("checked") == false) {
                numberOfCheck = 0;
            }
            console.log(numberOfCheck);
        });
        $('.clbSelect').on('change', function () {
            //if uncheck any row then numberOfCheck++
            var input = $(this).children()
            if (input.prop("checked") == true) {
                numberOfCheck++;
            }
            else if (input.prop("checked") == false) {
                numberOfCheck--;
            }
            console.log(numberOfCheck);
            // in other hand numberOfCheck--
        });
        $('.btnDeleteMulti').on('click', function (e) {
            //keep stable if there's haven't select any row yet.
            if (numberOfCheck == 0) {
                e.preventDefault();
            } else {
                var cf = confirm('この作業を本当に削除しますか？削除後は元に戻すことはできません。');
                if (!cf) {
                    e.preventDefault();
                }
            }
            FillTxtGuid();
        })
        function createGuid() {
            function S4() {
                return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
            }
            return (S4() + S4() + "-" + S4() + "-4" + S4().substr(0, 3) + "-" + S4() + "-" + S4() + S4() + S4()).toLowerCase();
        }
        function FillTxtGuid() {
            $(".GUID").val(createGuid())
        }
        $(".sort-row").click(function () {
            FillTxtGuid()
        })

        $(".myButton").click(function () {
            FillTxtGuid()
        })
        $(".btnUpdate").click(function () {
            FillTxtGuid()
        })
        $(".btnDelete").click(function () {
            FillTxtGuid()
        })

        document.onkeydown = function (evt) {
            var keyCode = evt ? (evt.which ? evt.which : evt.keyCode) : event.keyCode;
            if (keyCode == 13) {
                evt.preventDefault()
                $("#lbtnAdd")[0].click()
            }
        }
        $(".btnUpdate").click(function (e) {
            if ($(".error").val() == "") {
                e.preventDefault()
                $(".Error_Edit_Content").css("display", "block")
            }
        })

        $(".myButton").click(function (e) {
            if ($(".errorAdd").val() == "") {
                e.preventDefault()
                $(".Error_Add_Content").css("display", "block")

            }

            if ($(".errorAdd").val() != "") {
                $(".Error_Add_Content").css("display", "none")

            }

            if ($(".errorDate").val() == "") {
                e.preventDefault()
                $(".Error_Add_Date").css("display", "block")
            }

            if ($(".errorDate").val() != "") {
                $(".Error_Add_Date").css("display", "none")
            }
        })
    </script>
    <script type="text/javascript">
        $(".disable_row tbody tr").attr("class", "disable_row")

        $(function () {
            $(".drag_drop_grid").sortable({
                items: 'tr:not(.disable_row)',
                cursor: 'crosshair',
                axis: 'y',
                dropOnEmpty: true,
                receive: function (e, ui) {
                    $(this).find("tbody").append(ui.item);
                },
                start: function (e, ui) {
                    // creates a temporary attribute on the element with the old index
                    $(this).attr('data-previndex', ui.item.index());
                },
                update: function (e, ui) {
                    var newIndex = ui.item.index();
                    var oldIndex = $(this).attr('data-previndex');
                    $('.PriorityPosition').val(newIndex + "," + oldIndex)
                    FillTxtGuid()
                    $('.btn_PriorityPosition').trigger('click')
                    $(this).removeAttr('data-previndex');
                }
            });
        });
    </script>
</asp:Content>
