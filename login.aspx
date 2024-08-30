<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            background: url('https://th.bing.com/th/id/OIP.QiLu02W-p8yMzPvUh8QCUwHaE8?w=600&h=400&rs=1&pid=ImgDetMain') no-repeat center center fixed;
            background-size: cover;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            /*  margin-right:230px;
    margin-top:100px;*/
        }

        .login-box {
            /*background-color:white ;*/
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2);
        }

            .login-box h2 {
                margin-bottom: 20px;
                color: darkslateblue;
            }

        .input-group {
            margin-bottom: 15px;
        }

            .input-group .lbl {
                display: block;
                font-size: 20px;
                margin-bottom: 5px;
                color: #333;
            }

            .input-group .txtbox {
                background-color: aliceblue;
                width: 100%;
                padding: 10px;
                font-size: 20px;
                border: 1px solid #ccc;
                border-radius: 20px;
            }

        .btn-login {
            width: 100%;
            padding: 10px;
            background: linear-gradient(90deg, darkslateblue 0%, darkslateblue 100%);
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 20px;
            cursor: pointer;
            transition: background 0.3s;
             text-decoration:none;
             color:
        }

            .btn-login:hover {
            background: linear-gradient(90deg, mediumpurple 0%, darkslateblue 100%);
            }

        .forgot-password {
            display: block;
            margin: 10px 0;
            color: #666;
            font-size: 20px;
            text-decoration: none;
        }

        .social-login p {
            margin: 20px 0 10px;
            color: #666;
            font-size: 14px;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            font-size: 20px;
        }

            .social-icons a {
                display: block;
                width: 50px;
                height: 32px;
                color: darkslateblue;
            }

        @media screen and (max-width: 480px) {
            .login-box {
                width: 90%;
                padding: 15px;
            }

            .btn-login {
               
                padding: 8px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container mt-4 ">
            <div class="login-box">
                <h2>Login</h2>
                <hr />
                <div class="input-group">
                    <asp:Label Text="Username" CssClass="lbl" runat="server" />
                    <asp:TextBox runat="server" CssClass="txtbox" placeholder="Type your username" />
                </div>
                <div class="input-group">
                    <asp:Label Text="Password" CssClass="lbl" runat="server" />
                    <asp:TextBox runat="server" type="password" CssClass="txtbox" placeholder="Type your password"/>

                </div>
                <a href="#" class="forgot-password">Forgot password?</a>
                <asp:LinkButton ID="LinkButton2" runat="server" class="btn-login" PostBackUrl="~/index.aspx">Login</asp:LinkButton>

                <div class="social-login">
                    <p>Or Sign Up Using</p>
                    <div class="social-icons">
                        <a href="#"><i class="bi bi-github"></i></a>
                        <a href="#"><i class="bi bi-twitter-x"></i></a>
                        <a href="#"><i class="bi bi-google"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
