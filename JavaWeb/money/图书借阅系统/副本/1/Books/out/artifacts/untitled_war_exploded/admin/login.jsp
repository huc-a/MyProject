<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书商城 - 登录</title>
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
        
        .login-box {
            width: 400px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-header h2 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .login-header p {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .input-group {
            position: relative;
            margin-bottom: 30px;
        }
        
        .input-group input, .input-group select {
            width: 100%;
            padding: 12px 20px;
            font-size: 16px;
            color: #2c3e50;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .input-group input:focus, .input-group select:focus {
            outline: none;
            box-shadow: 0 0 0 2px #3498db;
            border-color: #3498db;
        }
        
        .input-group label {
            position: absolute;
            left: 20px;
            top: -10px;
            background: white;
            padding: 0 5px;
            color: #7f8c8d;
            font-size: 14px;
            z-index: 1;
        }
        
        .login-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }
        
        .error-msg {
            text-align: center;
            color: #e74c3c;
            margin-top: 15px;
            font-size: 14px;
            min-height: 20px;
            background: rgba(231, 76, 60, 0.1);
            padding: 8px;
            border-radius: 4px;
            display: ${error_msg != null ? 'block' : 'none'};
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .register-link a {
            color: #3498db;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }
        
        .register-link a:hover {
            color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <div class="login-header">
            <h2>图书商城系统</h2>
            <p>欢迎回来，请登录您的账号</p>
        </div>
        
        <form action="/LoginServlet" method="post">
            <div class="input-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="input-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="input-group">
                <label for="userType">用户类型</label>
                <select id="userType" name="userType" required>
                    <option value="reader">普通用户</option>
                    <option value="admin">管理员</option>
                </select>
            </div>
            
            <button type="submit" class="login-btn">登 录</button>
            
            <div class="error-msg">
                ${error_msg}
            </div>
            
            <div class="register-link">
                <a href="register.jsp">还没有账号？立即注册 >></a>
            </div>
        </form>
    </div>
</body>
</html>
