<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BTL_LTWNC.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
      rel="stylesheet"
    />
    <%--<link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"--%>
    <link href="Assets/font/fontawesome-free-6.4.0-web/fontawesome-free-6.4.0-web/css/all.min.css" rel="stylesheet" />
    />
    <link href="Styles/login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper__login">
            <div class="login__form">
                <div class="login__form--logo">
                    <i class="fas fa-user"></i>
                </div>
                <div class="login__form--group">
                    <label class="login__form--label">
                        <i class="far fa-user-circle"></i>
                    </label>
                    <input
                        id="userName"
                        runat="server"
                        type="text"
                        placeholder="Tài khoản"
                        class="login__form--input" />
                </div>
                <div class="login__form--group">
                    <div class="login__form--label">
                        <i class="fas fa-lock"></i>
                    </div>
                    <input
                        id="passWord"
                        runat="server"
                        type="password"
                        placeholder="Mật khẩu"
                        class="login__form--input" />
                </div>
                <p id="textError" runat="server"></p>

            </div>
            <div class="actions">
                <asp:Button ID="LOGIN" CssClass="actions--login"  runat="server" Text="LOGIN" OnClick="LOGIN_Click" />               
            </div>

        </div>

    </form>
    <script>
        console.log(document.getElementById("passWord"))
        function OnLogin() {
            
        }

        
    </script>
</body>
</html>
