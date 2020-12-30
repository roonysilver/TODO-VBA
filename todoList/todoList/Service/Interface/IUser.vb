Public Interface IUser
    Function GetUser(ByVal user As UserList) As UserList
    Function GetListUser() As List(Of UserList)
    Function DeleteUser(id As String) As Boolean
    Function UpdateUser(user As UserList) As UserList
    Function CreateUser(user As UserList) As UserList
End Interface
