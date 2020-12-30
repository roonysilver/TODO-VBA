Public Interface ITodoList
    Function GetTodo(ByVal todo As TodoList) As TodoList
    Function GetListTodo(ByVal idUser As String, ByVal PageNumber As Integer, ByVal PageSize As Integer, ByVal ExpiredDate As Integer, Position As Integer) As List(Of TodoList)
    Function DeleteTodo(id As String, idUser As String) As Boolean
    Function UpdateTodo(todo As TodoList, positionOld As Integer) As TodoList
    Function CreateTodo(todo As TodoList) As TodoList
    Function ChangePosition(ByVal positionOld As Integer, ByVal positionNew As Integer, idUser As String) As Integer
    Function GetCount(ByVal idUser As String) As Integer
End Interface
