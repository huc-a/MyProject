<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>用户注册</title>
    <style>
        .register-container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
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
            padding: 5px;
        }
        .btn-register {
            width: 100%;
            padding: 10px;
            background: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>用户注册</h2>
        <div id="errorMsg" class="error-message"></div>
        <form id="registerForm" onsubmit="return handleRegister(event)">
            <div class="form-group">
                <label for="username">用户名：</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="email">邮箱：</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">手机号：</label>
                <input type="text" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="address">收货地址：</label>
                <input type="text" id="address" name="address">
            </div>
            <button type="submit" class="btn-register">注册</button>
        </form>
        <p style="text-align: center; margin-top: 15px;">
            已有账号？<a href="pages/user/login.jsp">立即登录</a>
        </p>
    </div>

    <script>
        function handleRegister(event) {
            event.preventDefault();
            
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const address = document.getElementById('address').value;
            
            fetch('api/user/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: username,
                    password: password,
                    email: email,
                    phone: phone,
                    address: address
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('注册成功！');
                    window.location.href = 'pages/user/login.jsp';
                } else {
                    alert(data.message || '注册失败，请稍后重试');
                }
            })
            .catch(error => {
                alert('注册失败，请稍后重试');
                console.error('Error:', error);
            });
            
            return false;
        }
    </script>
</body>
</html> 