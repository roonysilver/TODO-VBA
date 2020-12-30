Imports System.Security.Principal

Public Class UserCookieData
    Public Shared Function GetUserData() As UserList
        Dim genericPrincipal As System.Security.Principal.GenericPrincipal = CType(HttpContext.Current.User, System.Security.Principal.GenericPrincipal)
        Dim user As New UserList
        Dim id As FormsIdentity = DirectCast(HttpContext.Current.User.Identity, FormsIdentity)
        Dim ticket As FormsAuthenticationTicket = id.Ticket
        Dim userData As String = ticket.UserData
        user = CookieStringToUser(userData)
        Return user
    End Function
    Public Shared Function UserToCookieString(ByVal user As UserList) As String
        Return String.Format($"{user.Id}|{user.FullName}|{user.Dob}|{user.Tel}|{user.name}")
    End Function
    Public Shared Function CookieStringToUser(ByVal cookieString As String) As UserList

        Dim infos As String() = cookieString.Split("|")
        Dim user As New UserList
        user.Id = infos(0)
        user.FullName = infos(1)
        user.Dob = infos(2)
        user.Tel = infos(3)
        user.name = infos(4)
        Return user
    End Function
End Class
