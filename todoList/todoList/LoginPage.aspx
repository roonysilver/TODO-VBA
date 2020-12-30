<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LoginPage.aspx.vb" Inherits="todoList.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: darkgray">
    <div class="login_content" style="position: absolute; left: 50%; top: 40%; transform: translateX(-50%) translateY(-50%); width: 50%; padding: 20px; border-radius: 5px; background-color: white">
        <form id="form1" runat="server">
            <h2 style="text-align: center">ログイン</h2>
            <p>
                <asp:Label ID="lblEmail" runat="server" Text="ユーザーID"></asp:Label>
            </p>
            <div class="email" style="margin-bottom: 20px">
                <asp:TextBox ID="email" runat="server" Width="100%" Height="29px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="email" ForeColor="Red" ErrorMessage="ログインIDを入力することが必要！"></asp:RequiredFieldValidator>
            </div>
            <p>
                <asp:Label ID="lblPassword" runat="server" Text="パスワード"></asp:Label>
            </p>
            <div class="password" style="margin-bottom: 20px">
                <asp:TextBox ID="password" runat="server" Width="100%" Height="29px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="password" ForeColor="Red" ErrorMessage="パスワードを入力することが必要！"></asp:RequiredFieldValidator>
            </div>
            <p>
                <asp:CheckBox ID="chkbx" runat="server" Text="ログインしたままにする" /><br />
                <asp:label ID="lblTest" runat="server" ForeColor="Red"></asp:label>
            </p>
            <div style="text-align: center">
                <asp:Button ID="submit" runat="server" Text="ログイン" Width="89px" BackColor="#333333" BorderColor="Yellow" BorderStyle="None" ForeColor="White" Height="25px" />
            </div>

        </form>
    </div>
</body>
</html>
