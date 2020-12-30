Imports System.Data.SqlClient
Imports System.Security.Cryptography

Public Class UserService
    Implements IUser
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Public Function GetUser(user As UserList) As UserList Implements IUser.GetUser
        Dim password = GetMD5(user.Password)
        Dim data As New UserList
        Dim con As New SqlConnection(connectionString)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "SP_GET_USERLIST @email,@password"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@email", user.Email)
        cmd.Parameters.AddWithValue("@password", password)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim userObj As New UserList
            userObj.Id = dbReader("id").ToString
            userObj.Email = dbReader("Email").ToString
            userObj.Password = dbReader("PassWord").ToString
            userObj.idRole = dbReader("idRole").ToString
            userObj.name = dbReader("name").ToString
            userObj.FullName = dbReader("FullName").ToString
            userObj.Tel = dbReader("Tel").ToString
            data = userObj
        Loop
        con.Close()
        Return data
    End Function

    Public Function GetMD5(ByVal str As String) As String
        Dim md5 As New MD5CryptoServiceProvider()

        Dim bHash As Byte() = md5.ComputeHash(Encoding.UTF8.GetBytes(str))

        Dim sbHash As New StringBuilder()
        For Each b As Byte In bHash
            sbHash.Append(String.Format("{0:x2}", b))
        Next b
        Return sbHash.ToString()
    End Function

    Public Function GetListUser() As List(Of UserList) Implements IUser.GetListUser
        Dim data As New List(Of UserList)
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "EXEC SP_GET_USER"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While dbReader.Read()
            Dim userObj As New UserList
            userObj.Id = dbReader("Id").ToString
            userObj.Email = dbReader("Email").ToString
            userObj.idRole = dbReader("name").ToString
            userObj.FullName = dbReader("FullName").ToString
            userObj.Dob = dbReader("Dob").ToString
            userObj.Tel = dbReader("Tel").ToString
            data.Add(userObj)
        Loop
        con.Close()
        Return data
    End Function

    Public Function DeleteUser(id As String) As Boolean Implements IUser.DeleteUser
        Dim rowAffected As Integer = 0
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "UPDATE [UserList] SET delete = 1 WHERE [UserList].id=@id"
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@Id", id))
        rowAffected = Int(cmd.ExecuteNonQuery())
        con.Close()
        Return rowAffected
    End Function

    Public Function UpdateUser(user As UserList) As UserList Implements IUser.UpdateUser
        Dim rowId As Integer = 0
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "UPDATE [UserList] SET email=@email,idRole=@idRole,Fullname=@fullname,dob=@dob,tel=@tel SELECT @@IDENTITY"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@id", user.Id))
        cmd.Parameters.Add(New SqlParameter("@email", user.Email))
        cmd.Parameters.Add(New SqlParameter("@idRole", user.idRole.ToString))
        cmd.Parameters.Add(New SqlParameter("@fullname", user.FullName))
        cmd.Parameters.Add(New SqlParameter("@dob", user.Dob))
        cmd.Parameters.Add(New SqlParameter("@tel", user.Tel))
        cmd.ExecuteScalar()
        con.Close()
        Return user
    End Function

    Public Function CreateUser(user As UserList) As UserList Implements IUser.CreateUser
        con.Open()
        Dim cmd = New SqlCommand()
        cmd.CommandText = "INSERT INTO [UserList] (email,password,fullname,dob,tel,idRole) VALUES (@email,@password,@fullname,@dob,@tel,@idRole)"
        cmd.CommandType = System.Data.CommandType.Text
        cmd.Connection = con
        cmd.Parameters.Add(New SqlParameter("@id", user.Id))
        cmd.Parameters.Add(New SqlParameter("@email", user.Email))
        cmd.Parameters.Add(New SqlParameter("@idRole", user.idRole))
        cmd.Parameters.Add(New SqlParameter("@fullname", user.FullName))
        cmd.Parameters.Add(New SqlParameter("@dob", user.Dob))
        cmd.Parameters.Add(New SqlParameter("@tel", user.Tel))
        cmd.ExecuteScalar()
        con.Close()
        Return user
    End Function
End Class
