Public Class LoginPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub submit_Click(sender As Object, e As EventArgs) Handles submit.Click
        Dim userObj As New UserList
        userObj.Email = email.Text
        userObj.Password = password.Text
        Dim checkLogin As New UserService
        If checkLogin.GetUser(userObj).Email IsNot Nothing Then
            Dim tkt As New FormsAuthenticationTicket(1, email.Text, DateTime.Now, DateTime.Now.AddDays(5), chkbx.Checked, UserCookieData.UserToCookieString(checkLogin.GetUser(userObj)))
            Dim cookiestr As String
            Dim ck As HttpCookie
            cookiestr = FormsAuthentication.Encrypt(tkt)
            ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr)
            If chkbx.Checked Then
                ck.Expires = tkt.Expiration
            End If
            ck.Path = FormsAuthentication.FormsCookiePath
            Response.Cookies.Add(ck)
            Dim redirectPage = Request("ReturnUrl")
            If redirectPage Is Nothing Then
                redirectPage = "TodoManage"
            End If
            Response.Redirect(redirectPage)

        Else
            lblTest.Text = "ログインIDとパスワードが正しくありません。 もう一度やり直してください！"
        End If
    End Sub
End Class