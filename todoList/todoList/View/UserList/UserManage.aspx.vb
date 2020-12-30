Public Class UserManage
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            Databd()
        End If
    End Sub

    Protected Sub Databd()
        Dim userService As New UserService()
        Dim dataTable As New DataTable()
        grvUser.DataSource = userService.GetListUser()
        grvUser.DataBind()
    End Sub

    Protected Sub grvUser_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles grvUser.PageIndexChanging
        grvUser.PageIndex = e.NewPageIndex
        Databd()
    End Sub

    Protected Sub grvUser_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles grvUser.RowEditing
        grvUser.EditIndex = e.NewEditIndex
        Databd()
    End Sub

    Protected Sub grvUser_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles grvUser.RowDeleting
        Dim row As GridViewRow = grvUser.Rows(e.RowIndex)
        Dim lblDeleteId As Label = row.FindControl("lblID")
        Dim userService As New UserService
        userService.DeleteUser(Convert.ToInt32(grvUser.DataKeys(e.RowIndex).Value.ToString()))
    End Sub

    Protected Sub grvUser_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles grvUser.RowCancelingEdit
        grvUser.EditIndex = -1
        Databd()
    End Sub

    Protected Sub grvUser_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles grvUser.RowUpdating
        Dim userId = Convert.ToInt32(grvUser.DataKeys(e.RowIndex).Value.ToString())
        Dim row As GridViewRow = grvUser.Rows(e.RowIndex)
        Dim lblID As Label = row.FindControl("lblUserID")
        Dim user As New UserList
        user.Id = userId
        Dim txtEmail As TextBox = row.Cells(1).Controls(0)
        Dim txtRole As TextBox = row.Cells(2).Controls(0)
        Dim txtTel As TextBox = row.Cells(3).Controls(0)
        Dim txtFullName As TextBox = row.Cells(4).Controls(0)
        Dim txtDob As TextBox = row.Cells(5).Controls(0)
        user.Email = txtEmail.Text
        user.idRole = txtRole.Text
        user.Tel = txtTel.Text
        user.FullName = txtFullName.Text
        user.Dob = txtDob.Text
        grvUser.EditIndex = -1
        Dim userService As New UserService()
        userService.UpdateUser(user)
    End Sub


    Protected Sub grvUser_SelectedIndexChanged(sender As Object, e As EventArgs) Handles grvUser.SelectedIndexChanged

    End Sub

    Protected Sub grvTodoList_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles grvUser.RowCommand
        If e.CommandName.Equals("List") Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim lblIdUser As Label = grvUser.Rows(rowIndex).FindControl("lblUserID")
            Response.Redirect("~/TodoUser?id=" + lblIdUser.Text)
        End If
    End Sub

    Protected Sub grvUser_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grvUser.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblStt As Label = e.Row.FindControl("lblStt")
            lblStt.Text = "BRC" + ((grvUser.PageIndex * grvUser.PageSize) + e.Row.RowIndex + 1).ToString()
        End If
    End Sub
End Class