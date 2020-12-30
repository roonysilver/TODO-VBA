Imports System.Data.SqlClient

Public Class TodoUser
    Inherits System.Web.UI.Page
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load, grvTodoList.SelectedIndexChanged, [return].Click
        If IsPostBack = False Then
            Session("sort") = 1
            Session("position") = 2
            Session("SortIcon") = "fas fa-sort"
            Databd()
        End If
    End Sub

    Protected Sub Databd()
        Try
            grvTodoList.PageSize = 10
            Dim TodoListService As New TodoListService()
            grvTodoList.VirtualItemCount = TodoListService.GetCount(Request.QueryString("id"))
            Dim dataTable As New DataTable()
            grvTodoList.DataSource = TodoListService.GetListTodo(Request.QueryString("id"), grvTodoList.PageIndex + 1, grvTodoList.PageSize, Session("sort"), Session("position"))
            grvTodoList.DataBind()
            If (grvTodoList.Rows.Count = 0) Then
                grvTodoList.DataSource = Me.Get_EmptyDataTable()
                grvTodoList.DataBind()
                grvTodoList.Rows(0).Visible = False
            End If
        Catch ex As Exception

        End Try

    End Sub

    Public Function Get_EmptyDataTable() As DataTable
        Dim dtEmpty As DataTable = New DataTable()
        dtEmpty.Columns.Add("idList", GetType(Integer))
        dtEmpty.Columns.Add("content", GetType(String))
        dtEmpty.Columns.Add("expiredDate", GetType(Date))
        dtEmpty.Columns.Add("idStatus", GetType(String))
        dtEmpty.Columns.Add("order", GetType(String))
        dtEmpty.Columns.Add("name", GetType(String))
        Dim datatRow As DataRow = dtEmpty.NewRow()
        dtEmpty.Rows.Add(datatRow)
        Return dtEmpty
    End Function

    Protected Sub grvTodoList_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles grvTodoList.PageIndexChanging
        grvTodoList.PageIndex = e.NewPageIndex
        Databd()
    End Sub

    Protected Sub return_Click(sender As Object, e As EventArgs) Handles [return].Click
        Response.Redirect("~/UserManage")
    End Sub

    'Protected Sub grvTodoList_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grvTodoList.RowDataBound
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        Dim lblStt As Label = e.Row.FindControl("lblStt")
    '        lblStt.Text = ((grvTodoList.PageIndex * grvTodoList.PageSize) + e.Row.RowIndex + 1).ToString()
    '    End If
    'End Sub

    Protected Sub grvTodoList_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvTodoList.RowCommand
        If e.CommandName.Equals("SORT") Then
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
        End If
    End Sub

    Protected Sub grvTodoList_IndexChange(sender As Object, e As GridViewPageEventArgs) Handles grvTodoList.PageIndexChanging
        grvTodoList.PageIndex = e.NewPageIndex
        Databd()
    End Sub
End Class