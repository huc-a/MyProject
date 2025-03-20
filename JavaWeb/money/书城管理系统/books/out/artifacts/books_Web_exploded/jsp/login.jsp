<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书城登录</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .login-container h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .login-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: #dc3545;
            margin: 10px 0;
            text-align: center;
        }
        .login-tip {
            font-size: 12px;
            color: #666;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>书城管理系统</h2>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div>
                <input type="text" name="username" placeholder="用户名" required>
            </div>
            <div>
                <input type="password" name="password" placeholder="密码" required>
            </div>
            <div>
                <input type="submit" value="登录">
            </div>
        </form>
        <div class="login-tip">
            提示：默认管理员账号 admin，密码 123456
        </div>
    </div>
</body>
</html> 