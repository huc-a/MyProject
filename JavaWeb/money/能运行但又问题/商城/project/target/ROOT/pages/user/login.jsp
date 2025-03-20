<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户登录</title>
    <style>
        .login-container {
            width: 400px;
            margin: 100px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-login {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-login:hover {
            background: #0056b3;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>用户登录</h2>
        <div id="errorMsg" class="error-message"></div>
        <form id="loginForm" onsubmit="return handleLogin(event)">
            <div class="form-group">
                <label for="username">用户名：</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn-login">登录</button>
        </form>
        <p style="text-align: center; margin-top: 15px;">
            还没有账号？<a href="pages/user/register.jsp">立即注册</a>
        </p>
    </div>

    <script>
        function handleLogin(event) {
            event.preventDefault();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const errorMsg = document.getElementById('errorMsg');
            
            fetch('api/user/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: username,
                    password: password
                }),
                credentials: 'include'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = 'index.jsp';
                } else {
                    errorMsg.style.display = 'block';
                    errorMsg.textContent = data.message || '登录失败，请检查用户名和密码';
                }
            })
            .catch(error => {
                errorMsg.style.display = 'block';
                errorMsg.textContent = '登录失败，请稍后重试';
                console.error('Error:', error);
            });
            
            return false;
        }
    </script>
</body>
</html> 