Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Services

Public Class WebForm1
    Inherits System.Web.UI.Page
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim todoListService As New TodoListService()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load, grvTodoList.SelectedIndexChanged
        grvTodoList.EditIndex = -1
        If IsPostBack = False Then
            Session("sort") = 1
            Session("RowNum") = 0
            Session("SortIcon") = "sort-row fas fa-sort"
            Session("GUID") = ""
            Session("position") = 2
            Session("positionOld") = 1
            Databd()
        End If
    End Sub

    Protected Sub Databd()
        grvTodoList.PageSize = 10
        grvTodoList.VirtualItemCount = TodoListService.GetCount(UserCookieData.GetUserData.Id)
        Dim dataTable As New DataTable()
        grvTodoList.DataSource = TodoListService.GetListTodo(UserCookieData.GetUserData.Id, grvTodoList.PageIndex + 1, grvTodoList.PageSize, Session("sort"), Session("position"))
        grvTodoList.DataBind()
        If (grvTodoList.Rows.Count = 0) Then
            grvTodoList.DataSource = Me.Get_EmptyDataTable()
            grvTodoList.DataBind()
            grvTodoList.Rows(0).Visible = False
        End If
    End Sub

    Public Function Get_EmptyDataTable() As DataTable
        Dim dtEmpty As DataTable = New DataTable()
        dtEmpty.Columns.Add("idList", GetType(String))
        dtEmpty.Columns.Add("content", GetType(String))
        dtEmpty.Columns.Add("expiredDate", GetType(Date))
        dtEmpty.Columns.Add("idStatus", GetType(String))
        dtEmpty.Columns.Add("name", GetType(String))
        dtEmpty.Columns.Add("position", GetType(String))
        Dim datatRow As DataRow = dtEmpty.NewRow()
        dtEmpty.Rows.Add(datatRow)
        Return dtEmpty
    End Function

    Protected Sub grvTodoList_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles grvTodoList.RowCancelingEdit
        grvTodoList.EditIndex = -1
        Databd()
    End Sub

    Protected Sub grvTodoList_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvTodoList.RowCommand
        ''Event SORT with stable and DECS sort on expiredDate
        If e.CommandName.Equals("SORT") Then
            If Session("GUID").ToString() Like txtGuid.Text = False Then
                Session("GUID") = txtGuid.Text
                grvTodoList.HeaderRow.FindControl("btn_SortingDate")
                If Session("sort") = 1 Then
                    Session("sort") = 2
                    Session("position") = 0
                    Session("SortIcon") = "sort-row fas fa-sort-down"
                ElseIf Session("sort") = 2 Then
                    Session("sort") = 3
                    Session("position") = 0
                    Session("SortIcon") = "sort-row fas fa-sort-up"
                ElseIf Session("sort") = 3 Then
                    Session("sort") = 1
                    Session("position") = 2
                    Session("SortIcon") = "sort-row fas fa-sort"

                End If
                Databd()

            Else
                Databd()
            End If
        End If


        ''Handle command ADD with new column and check with validate label
        If e.CommandName.Equals("ADD") Then
            Try
                If Session("GUID").ToString() Like txtGuid.Text = False Then
                    Session("GUID") = txtGuid.Text
                    Dim txtAddId As TextBox = CType(grvTodoList.FooterRow.FindControl("txtAddId"), TextBox)
                    Dim txtContent As TextBox = CType(grvTodoList.FooterRow.FindControl("txtAddContent"), TextBox)
                    Dim lblAddContent As Label = grvTodoList.FooterRow.FindControl("lblAddContent")
                    Dim lblAddDate As Label = grvTodoList.FooterRow.FindControl("lblAddDate")
                    'If txtContent.Text Like "" Then
                    '    lblAddContent.Visible = True
                    'Else
                    '    lblAddContent.Visible = False
                    'End If
                    Dim txtExpiredDate As TextBox = CType(grvTodoList.FooterRow.FindControl("datepicker"), TextBox)
                    'If txtExpiredDate.Text Like "" Then
                    '    lblAddDate.Visible = True
                    'Else
                    '    lblAddDate.Visible = False
                    'End If
                    Dim txtStatus As DropDownList = CType(grvTodoList.FooterRow.FindControl("txtAddStatus"), DropDownList)
                    If txtContent.Text Like "" <> False And txtExpiredDate.Text Like "" <> False Then
                        Response.Redirect("~/TodoManage")
                    End If
                    Dim objAddTodo As New TodoList
                    If txtAddId.Text Like "" = True Then
                        objAddTodo.position = -123321
                    Else
                        objAddTodo.position = txtAddId.Text
                    End If
                    objAddTodo.Content = txtContent.Text
                    objAddTodo.ExpiredDate = txtExpiredDate.Text
                    objAddTodo.idStatus = [Enum].Parse(GetType(ActiveStatus), txtStatus.SelectedValue, True)
                    objAddTodo.IdUser = UserCookieData.GetUserData().Id
                    todoListService.CreateTodo(objAddTodo)
                    Dim toastr As String = "iziToast.success({
                title: 'Succeeded',
                message: '正常に挿入されました!',
            })"
                    Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                    Databd()
                    'End If
                Else
                    Databd()
                End If
            Catch ex As Exception

            End Try

        End If
    End Sub

    Protected Sub grvTodoList_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles grvTodoList.RowDeleting
        If Session("GUID").ToString() Like txtGuid.Text = False Then
            Session("GUID") = txtGuid.Text
            Try
                Dim todoListId As Label = grvTodoList.Rows(e.RowIndex).FindControl("lblToDoID")
                todoListService.DeleteTodo(todoListId.Text, UserCookieData.GetUserData.Id)
                Dim toastr As String = "iziToast.success({
                title: 'Deleted',
                message: '正常に削除されました!',
            })"
                Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                grvTodoList.EditIndex = -1
                Databd()
            Catch ex As Exception

            End Try
        Else
            Databd()
        End If



    End Sub

    Protected Sub grvTodoList_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles grvTodoList.RowEditing
        grvTodoList.EditIndex = e.NewEditIndex
        Databd()
        Dim txtEditIDold As TextBox = grvTodoList.Rows(e.NewEditIndex).FindControl("txtEditID")
        Session("positionOld") = txtEditIDold.Text
    End Sub

    Protected Sub grvTodoLists_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles grvTodoList.RowUpdating
        If Session("GUID").ToString() Like txtGuid.Text = False Then
            Try
                Session("GUID") = txtGuid.Text
                Dim txtEditID As TextBox = grvTodoList.Rows(e.RowIndex).FindControl("txtEditID")
                Dim todoListId As Label = grvTodoList.Rows(e.RowIndex).FindControl("lblEditTodoID")
                Dim row As GridViewRow = grvTodoList.Rows(e.RowIndex)
                Dim lblID As Label = row.FindControl("lblToDoID")
                Dim todoList As New TodoList
                todoList.IdList = todoListId.Text
                Dim txtContent As TextBox = grvTodoList.Rows(e.RowIndex).FindControl("txtEditContent")
                Dim txtExpiredDate As TextBox = grvTodoList.Rows(e.RowIndex).FindControl("txtEditExpired")
                Dim txtStatus As DropDownList = grvTodoList.Rows(e.RowIndex).FindControl("txtEditStatus")
                'Dim lblEditContent As Label = grvTodoList.Rows(e.RowIndex).FindControl("lblEditContent")
                If txtContent.Text Like "" <> True Then
                    todoList.position = txtEditID.Text
                    todoList.Content = txtContent.Text
                    todoList.IdUser = UserCookieData.GetUserData.Id
                    todoList.ExpiredDate = txtExpiredDate.Text
                    todoList.idStatus = txtStatus.SelectedValue
                    todoListService.UpdateTodo(todoList, Session("positionOld"))
                    grvTodoList.EditIndex = -1
                    Dim toastr As String = "iziToast.success({
                title: 'Updated',
                message: '正常に更新されました!',
            })"
                    Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                    Databd()
                Else
                    Response.Redirect("~/TodoManage")
                End If
            Catch ex As Exception
                Response.Redirect("~/TodoManage")
            End Try
        Else
            Databd()
        End If

    End Sub

    Protected Sub grvTodoList_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles grvTodoList.PageIndexChanging
        grvTodoList.PageIndex = e.NewPageIndex
        Databd()
    End Sub

    Protected Sub grvTodoList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grvTodoList.RowDataBound
        If grvTodoList.EditIndex = e.Row.RowIndex AndAlso e.Row.RowType = DataControlRowType.DataRow Then
            Dim con As New SqlConnection(connectionString)
            con.Open()
            Dim txtEditStatus As DropDownList = (TryCast(e.Row.FindControl("txtEditStatus"), DropDownList))
            Dim lblStatus As Label = (TryCast(e.Row.FindControl("lblStatusID"), Label))
            Dim cmd As SqlCommand = New SqlCommand("select * from STATUS", con)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            con.Close()
            txtEditStatus.DataSource = dt
            txtEditStatus.DataTextField = "name"
            txtEditStatus.DataValueField = "idStatus"
            txtEditStatus.SelectedValue = lblStatus.Text
            txtEditStatus.DataBind()
        End If

        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim lblStt As Label = e.Row.FindControl("lblStt")
        '    lblStt.Text = ((grvTodoList.PageIndex * grvTodoList.PageSize) + e.Row.RowIndex + 1).ToString()
        'End If
    End Sub

    Protected Sub OndataBound(sender As Object, e As EventArgs) Handles grvTodoList.DataBound
        Try
            Dim con As New SqlConnection(connectionString)
            con.Open()
            Dim txtAddStatus As DropDownList = (TryCast(grvTodoList.FooterRow.FindControl("txtAddStatus"), DropDownList))
            Dim cmd As SqlCommand = New SqlCommand("select * from STATUS", con)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            con.Close()
            txtAddStatus.DataSource = dt
            txtAddStatus.DataTextField = "name"
            txtAddStatus.DataValueField = "idStatus"
            txtAddStatus.DataBind()
        Catch ex As Exception

        End Try
        'txtStatus.Items.Insert(0, New ListItem("--Select Qualification--", "0"))
    End Sub

    Protected Sub Button_Deleting_Click(sender As Object, e As EventArgs) Handles btnDeleteMulti.Click
        If Session("GUID").ToString() Like txtGuid.Text = False Then
            Session("GUID") = txtGuid.Text
            For Each row As GridViewRow In grvTodoList.Rows
                Dim chkDelete As CheckBox = row.FindControl("clbSelect")
                If chkDelete.Checked Then
                    Dim lblToDoID As Label = row.Cells(1).FindControl("lblTodoID")
                    If lblToDoID Is Nothing Then
                        lblToDoID = row.Cells(1).FindControl("lblEditTodoID")
                    End If
                    Dim intToDoID As String = lblToDoID.Text
                    Dim TodoService As New TodoListService()
                    Dim objTodo = TodoService.DeleteTodo(intToDoID, UserCookieData.GetUserData.Id)
                    Dim toastr As String = "iziToast.success({
                title: 'Deleted',
                message: '正常に削除されました!',
            })"
                    Page.ClientScript.RegisterStartupScript(Me.[GetType](), "CallMyFunction", toastr, True)
                    'Response.Redirect("TodoManage")
                    Databd()
                End If
            Next
        Else
            Databd()
        End If


    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'Tell the compiler that the control is rendered
        'explicitly by overriding the VerifyRenderingInServerForm event.
    End Sub
    Protected Sub btntoCsv_Click(sender As Object, e As EventArgs) Handles btntoCsv.Click
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.csv")
        Response.Charset = ""
        Response.ContentType = "application/text"
        Response.ContentEncoding = System.Text.Encoding.UTF8
        Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble())
        grvTodoList.AllowPaging = False
        'grvTodoList.DataBind()
        Dim sb As StringBuilder = New StringBuilder()
        For k As Integer = 3 To grvTodoList.Columns.Count - 2
            sb.Append(grvTodoList.Columns(k).HeaderText + ","c)
        Next
        sb.Append(vbCrLf)
        Dim lstTodo As List(Of TodoList)
        lstTodo = todoListService.GetListTodo(UserCookieData.GetUserData.Id, 1, 1000, Session("sort"), Session("position"))
        For Each objTodo As TodoList In lstTodo
            sb.Append(objTodo.position.ToString + ","c)
            sb.Append("「“ + objTodo.Content + “」" + ","c)
            sb.Append(objTodo.ExpiredDate.ToString("yyyy/MM/dd") + ","c)
            sb.Append(objTodo.name + ","c)
            'Dim lblID As Label = grvTodoList.Rows(i).FindControl("lblToDoID")
            'sb.Append(lblID.Text + ","c)
            'Dim lblContent As Label = grvTodoList.Rows(i).FindControl("lblContent")
            'sb.Append(lblContent.Text + ","c)
            'Dim lblExpired As Label = grvTodoList.Rows(i).FindControl("lblExpired")
            'sb.Append(lblExpired.Text + ","c)
            'Dim lblStatus As Label = grvTodoList.Rows(i).FindControl("lblStatus")
            'sb.Append(lblStatus.Text + ","c)
            'Next
            sb.Append(vbCrLf)
        Next
        Response.Output.Write(sb.ToString())
        Response.Flush()
        Response.End()
    End Sub

    Protected Sub grvTodoList_IndexChange(sender As Object, e As GridViewPageEventArgs) Handles grvTodoList.PageIndexChanging
        grvTodoList.PageIndex = e.NewPageIndex
        Databd()
    End Sub

    Protected Sub btnPriority_Click(sender As Object, e As EventArgs) Handles btnPriority.Click
        If Session("GUID").ToString() Like txtGuid.Text = False Then
            Session("GUID") = txtGuid.Text
            Dim arrayPosition = txtPriority.Text.Split(",")
            Dim newPossition As Integer = grvTodoList.PageIndex * grvTodoList.PageSize + arrayPosition(0)
            Dim oldPossition As Integer = grvTodoList.PageIndex * grvTodoList.PageSize + arrayPosition(1)
            todoListService.ChangePosition(oldPossition, newPossition, UserCookieData.GetUserData.Id)
            'Dim arrPosition = txtPriority.Text.Split(",")
            'todoListService.ChangePosition(arrPosition(0), arrPosition(1), UserCookieData.GetUserData.Id)
            Databd()
        Else
            Databd()
        End If
    End Sub
End Class