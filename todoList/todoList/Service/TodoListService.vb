Imports System.Data.SqlClient

Public Class TodoListService
    Implements ITodoList
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Public Function GetTodo(todo As TodoList) As TodoList Implements ITodoList.GetTodo
        Throw New NotImplementedException()
    End Function

    Public Function GetListTodo(idUser As String, PageNumber As Integer, PageSize As Integer, ExpiredDate As Integer, Position As Integer) As List(Of TodoList) Implements ITodoList.GetListTodo
        Dim data As New List(Of TodoList)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "EXEC SP_GET_TODO @expiredDate,@idUser,@PageNumber,@PageSize,@position"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@idUser", idUser)
        cmd.Parameters.AddWithValue("@expiredDate", ExpiredDate)
        cmd.Parameters.AddWithValue("@PageNumber", PageNumber)
        cmd.Parameters.AddWithValue("@PageSize", PageSize)
        cmd.Parameters.AddWithValue("@position", Position)
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim todoObj As New TodoList
            todoObj.IdList = dbReader("idList").ToString
            todoObj.Content = dbReader("content").ToString
            todoObj.ExpiredDate = dbReader("expiredDate").ToString
            todoObj.idStatus = dbReader("idStatus").ToString
            todoObj.IdUser = dbReader("idUser").ToString
            todoObj.name = dbReader("name").ToString
            todoObj.position = dbReader("position").ToString
            data.Add(todoObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function DeleteTodo(id As String, idUser As String) As Boolean Implements ITodoList.DeleteTodo
        Dim rowAffected As Integer = 0
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "EXEC SP_DELETE_TODO @idList, @idUser"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@idList", id))
        cmd.Parameters.Add(New SqlParameter("@idUser", idUser))
        rowAffected = Int(cmd.ExecuteNonQuery())
        con.Close()
        Return rowAffected
    End Function

    Public Function UpdateTodo(todo As TodoList, positionOld As Integer) As TodoList Implements ITodoList.UpdateTodo
        Dim rowID As Integer = 0
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "EXEC SP_UPDATE_TODO @idList, @content,@expiredDate,@idUser,@idStatus,@positionOld,@positionNew"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@idList", todo.IdList))
        cmd.Parameters.Add(New SqlParameter("@content", todo.Content))
        cmd.Parameters.Add(New SqlParameter("@expiredDate", todo.ExpiredDate))
        cmd.Parameters.Add(New SqlParameter("@idStatus", todo.idStatus))
        cmd.Parameters.Add(New SqlParameter("@positionNew", todo.position))
        cmd.Parameters.Add(New SqlParameter("@positionOld", positionOld))
        cmd.Parameters.Add(New SqlParameter("@idUser", todo.IdUser))
        cmd.ExecuteScalar()
        con.Close()
        Return todo
    End Function

    ''' <summary>
    ''' CreateTodo
    ''' </summary>
    ''' <param name="todo"></param>
    ''' <returns></returns>
    Public Function CreateTodo(todo As TodoList) As TodoList Implements ITodoList.CreateTodo
        Dim TodoId As Integer = 0
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_ADD_TODO @content,@idStatus,@expiredDate,@idUser,@position"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@content", todo.Content))
        cmd.Parameters.Add(New SqlParameter("@expiredDate", todo.ExpiredDate))
        cmd.Parameters.Add(New SqlParameter("@idStatus", todo.idStatus))
        cmd.Parameters.Add(New SqlParameter("@idUser", todo.IdUser))
        cmd.Parameters.Add(New SqlParameter("@position", todo.position))
        cmd.ExecuteScalar()
        con.Close()
        Return todo
    End Function

    Public Function GetCount(idUser As String) As Integer Implements ITodoList.GetCount
        Dim intCountRecord As Integer
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_COUNT_RECORD @idUser"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@idUser", idUser))
        Dim dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        dbReader.Read()
        intCountRecord = dbReader("Count").ToString
        con.Close()
        Return intCountRecord
    End Function

    Public Function ChangePosition(ByVal positionOld As Integer, ByVal positionNew As Integer, idUser As String) As Integer Implements ITodoList.ChangePosition
        Try
            con.Open()
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_CHANGE_PRIORITY @positionOld, @positionNew, @idUser"
            cmd.CommandType = System.Data.CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@positionOld", positionOld)
            cmd.Parameters.AddWithValue("@positionNew", positionNew)
            cmd.Parameters.AddWithValue("@idUser", idUser)
            cmd.ExecuteNonQuery()
            con.Close()
            Return True

        Catch ex As Exception
            Return False

        End Try
    End Function
End Class
