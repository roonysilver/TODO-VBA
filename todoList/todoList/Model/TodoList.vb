Public Class TodoList
    Public Property IdList As String
    Public Property Content As String
    Public Property ExpiredDate As Date
    Public Property idStatus As String
    Public Property Deleted As Integer = 0
    Public Property IdUser As String
    Public Property name As String
    Public Property rowNum As Integer
    Public Property position As Integer
End Class

Public Enum ActiveStatus
    processing
    done
    canceled
End Enum