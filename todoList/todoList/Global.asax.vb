Imports System.Security.Principal
Imports System.Web.Optimization

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(sender As Object, e As EventArgs)
        ' Fires when the application is started
        RouteConfig.RegisterRoutes(RouteTable.Routes)
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        RegisterRoutes(RouteTable.Routes)
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        If HttpContext.Current.User IsNot Nothing Then
            If HttpContext.Current.User.Identity.IsAuthenticated Then
                If TypeOf HttpContext.Current.User.Identity Is FormsIdentity Then
                    Dim id As FormsIdentity = DirectCast(HttpContext.Current.User.Identity, FormsIdentity)
                    Dim ticket As FormsAuthenticationTicket = id.Ticket
                    Dim userData As String = UserCookieData.CookieStringToUser(ticket.UserData).name
                    Dim roles As String() = userData.Split(","c)
                    HttpContext.Current.User = New GenericPrincipal(id, roles)
                End If
            End If
        End If
    End Sub

    Private Shared Sub RegisterRoutes(routes As RouteCollection)
        routes.MapPageRoute("TodoManage", "TodoManage", "~/View/TodoList/TodoManage.aspx")
        routes.MapPageRoute("", "", "~/View/TodoList/TodoManage.aspx")
        routes.MapPageRoute("UserManage", "UserManage", "~/View/UserList/UserManage.aspx")
        routes.MapPageRoute("TodoUser", "TodoUser", "~/View/TodoUser/TodoUser.aspx?id=")
        routes.MapPageRoute("LoginPage", "LoginPage", "~/LoginPage.aspx")
    End Sub
End Class