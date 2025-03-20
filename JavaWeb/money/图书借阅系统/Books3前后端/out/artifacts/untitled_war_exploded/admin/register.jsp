<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/4
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书香城 - 用户注册</title>
    <style>
        body {
            background-image: url('../resource/login1.png');
            background-size: cover;
        }
        
        .register-container {
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
        }
        
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        
        .form-item {
            margin-bottom: 15px;
        }
        
        .form-item label {
            display: inline-block;
            width: 80px;
            text-align: right;
            margin-right: 10px;
        }
        
        .form-item input, .form-item select {
            width: 200px;
            height: 25px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        
        .submit {
            width: 200px;
            height: 35px;
            background-color: #98ecac;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            margin: 20px auto;
            display: block;
        }
        
        .login-link {
            text-align: center;
        }
        
        .login-link a {
            color: #666;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>新用户注册</h2>
        <form action="/AddUserServlet" method="post">
            <div class="form-item">
                <label>用户名：</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-item">
                <label>密码：</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-item">
                <label>邮箱：</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-item">
                <label>生日：</label>
                <input type="date" name="birthday" required>
            </div>
            <div class="form-item">
                <label>用户类型：</label>
                <select name="isadmin">
                    <option value="0">普通用户</option>
                    <option value="1">管理员</option>
                </select>
            </div>
            <input type="submit" value="注册" class="submit">
            <div class="login-link">
                <a href="login.jsp">已有账号？返回登录>></a>
            </div>
        </form>
    </div>
</body>
</html>
