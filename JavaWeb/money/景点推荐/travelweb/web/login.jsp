<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录 - 旅游景点推荐系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 400px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .tab {
            flex: 1;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            color: #666;
            font-weight: bold;
        }

        .tab.active {
            color: #3498db;
            border-bottom: 2px solid #3498db;
            margin-bottom: -1px;
        }

        .form-container {
            display: none;
        }

        .form-container.active {
            display: block;
        }

        .input-group {
            margin-bottom: 15px;
            position: relative;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            top: 12px;
            color: #666;
        }

        input {
            width: 100%;
            padding: 10px 10px 10px 35px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input:focus {
            outline: none;
            border-color: #3498db;
        }

        button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #3498db;
            color: white;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin: 10px 0;
            font-size: 14px;
        }

        .success-message {
            color: #2ecc71;
            text-align: center;
            margin: 10px 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="tabs">
            <div class="tab active" id="loginTab">登录</div>
            <div class="tab" id="registerTab">注册</div>
        </div>

        <div class="form-container active" id="loginForm">
            <form action="${pageContext.request.contextPath}/user" method="post">
                <input type="hidden" name="action" value="login">
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" placeholder="用户名" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="密码" required>
                </div>
                <% 
                if("true".equals(request.getParameter("error"))) { 
                %>
                    <div class="error-message">用户名或密码错误</div>
                <% 
                } else if("success".equals(request.getParameter("register"))) {
                %>
                    <div class="success-message">注册成功！请登录</div>
                <% } %>
                <button type="submit">登录</button>
            </form>
        </div>

        <div class="form-container" id="registerForm">
            <form action="${pageContext.request.contextPath}/user" method="post">
                <input type="hidden" name="action" value="register">
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" placeholder="用户名" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" placeholder="邮箱" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" placeholder="密码" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="confirmPassword" placeholder="确认密码" required>
                </div>
                <% 
                String error = request.getParameter("error");
                String register = request.getParameter("register");
                if (error != null) { 
                %>
                    <div class="error-message">
                        <%
                        if ("password_mismatch".equals(error)) {
                            out.print("两次输入的密码不匹配");
                        } else if ("register_failed".equals(error)) {
                            out.print("注册失败，请重试");
                        }
                        %>
                    </div>
                <% 
                } else if ("success".equals(register)) { 
                %>
                    <div class="success-message">注册成功！请登录</div>
                <% } %>
                <button type="submit">注册</button>
            </form>
        </div>
    </div>

    <script>
        const loginTab = document.getElementById('loginTab');
        const registerTab = document.getElementById('registerTab');
        const loginForm = document.getElementById('loginForm');
        const registerForm = document.getElementById('registerForm');

        // 检查URL中是否有错误参数或hash
        if (window.location.hash === '#register' || 
            window.location.search.includes('error=register_failed') || 
            window.location.search.includes('error=password_mismatch')) {
            // 如果有错误，显示注册表单
            registerTab.click();
        } else if (window.location.search.includes('register=success')) {
            // 如果注册成功，显示登录表单
            loginTab.click();
        }

        loginTab.addEventListener('click', () => {
            loginTab.classList.add('active');
            registerTab.classList.remove('active');
            loginForm.classList.add('active');
            registerForm.classList.remove('active');
        });

        registerTab.addEventListener('click', () => {
            registerTab.classList.add('active');
            loginTab.classList.remove('active');
            registerForm.classList.add('active');
            loginForm.classList.remove('active');
        });
    </script>
</body>
</html>