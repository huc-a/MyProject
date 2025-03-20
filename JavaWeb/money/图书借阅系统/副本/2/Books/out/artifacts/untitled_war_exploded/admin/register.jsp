<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: url('../images/login1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .register-box {
            width: 400px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .register-header h2 {
            color: #2d3748;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .register-header p {
            color: #718096;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            color: #4a5568;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .input-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
        }

        .register-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .register-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
        }

        .error-msg {
            color: #e53e3e;
            font-size: 14px;
            text-align: center;
            margin-top: 15px;
            min-height: 20px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #4299e1;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #3182ce;
        }
    </style>
</head>
<body>
    <div class="register-box">
        <div class="register-header">
            <h2>用户注册</h2>
            <p>创建您的账号</p>
        </div>
        
        <form action="/AddUserServlet" method="post">
            <div class="input-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="input-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="input-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="input-group">
                <label for="birthday">生日</label>
                <input type="date" id="birthday" name="birthday" required>
            </div>
            
            <button type="submit" class="register-btn">注 册</button>
            
            <div class="error-msg">
                ${error_msg}
            </div>
            
            <div class="login-link">
                <a href="login.jsp">已有账号？立即登录 >></a>
            </div>
        </form>
    </div>
</body>
</html>
