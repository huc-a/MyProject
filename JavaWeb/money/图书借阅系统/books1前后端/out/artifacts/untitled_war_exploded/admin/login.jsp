<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书香城</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-image: url('../resource/login1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            width: 420px;
            backdrop-filter: blur(10px);
            transform: translateY(0);
            transition: all 0.3s ease;
            animation: fadeIn 0.6s ease-out;
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .login-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        form {
            width: 100%;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #34495e;
            font-weight: 500;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .form-group input:focus {
            border-color: #98ecac;
            outline: none;
            box-shadow: 0 0 0 4px rgba(152, 236, 172, 0.1);
            background-color: #fff;
        }

        .form-group input::placeholder {
            color: #95a5a6;
            font-size: 14px;
        }

        .submit {
            width: 100%;
            padding: 14px;
            background: linear-gradient(145deg, #98ecac, #7ed992);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            letter-spacing: 1px;
        }

        .submit:hover {
            background: linear-gradient(145deg, #7ed992, #98ecac);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(126, 217, 146, 0.3);
        }

        .submit:active {
            transform: translateY(0);
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .register-link a {
            color: #7ed992;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .register-link a:hover {
            color: #98ecac;
        }

        .register-link a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -4px;
            left: 0;
            background-color: #98ecac;
            transition: width 0.3s ease;
        }

        .register-link a:hover::after {
            width: 100%;
        }

        .error-msg {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 8px;
            background-color: rgba(231, 76, 60, 0.1);
            font-size: 14px;
            display: ${error_msg == null ? 'none' : 'block'};
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">欢迎来到书香城</h2>
        <div class="error-msg">${error_msg}</div>
        <form action="/LoginServlet" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入您的用户名" autocomplete="off" />
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入您的密码" />
            </div>
            <button type="submit" class="submit" onclick="javascript:loginSuccess();">登 录</button>
            <div class="register-link">
                <a href="../admin/register.jsp">还没有账号？立即注册 >></a>
            </div>
        </form>
    </div>

    <script>
        function loginSuccess() {
            window.parent.postMessage('loginSuccess', '*');
        }
    </script>
</body>
</html>
