<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户注册 - 图书商城系统</title>
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
            justify-content: center;
            align-items: center;
            background: url('${pageContext.request.contextPath}/images/login1.png') no-repeat center center fixed;
            background-size: cover;
        }

        .register-container {
            width: 420px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            padding: 40px;
            animation: fadeIn 0.5s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .register-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .register-title {
            font-size: 26px;
            color: #2d3748;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .register-subtitle {
            font-size: 14px;
            color: #718096;
        }

        .input-group {
            margin-bottom: 25px;
            position: relative;
        }

        .input-group label {
            display: block;
            color: #4a5568;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .input-group input {
            width: 100%;
            padding: 12px 15px 12px 40px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: white;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 38px;
            color: #a0aec0;
        }

        .input-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }

        .register-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 1px;
            margin-top: 10px;
        }

        .register-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(66, 153, 225, 0.2);
        }

        .bottom-links {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
            font-size: 14px;
            color: #718096;
        }

        .bottom-links a {
            color: #4299e1;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .bottom-links a:hover {
            color: #3182ce;
            text-decoration: underline;
        }

        .error-msg {
            background: #fff5f5;
            color: #e53e3e;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            margin: 15px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2 class="register-title">用户注册</h2>
            <p class="register-subtitle">创建您的账号以开始使用</p>
        </div>

        <form action="/RegisterServlet" method="post">
            <div class="input-group">
                <label>用户名</label>
                <i class="fas fa-user"></i>
                <input type="text" name="username" required placeholder="请输入用户名">
            </div>

            <div class="input-group">
                <label>密码</label>
                <i class="fas fa-lock"></i>
                <input type="password" name="password" required placeholder="请输入密码">
            </div>

            <div class="input-group">
                <label>确认密码</label>
                <i class="fas fa-lock"></i>
                <input type="password" name="repassword" required placeholder="请再次输入密码">
            </div>

            <div class="input-group">
                <label>邮箱</label>
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" required placeholder="请输入邮箱">
            </div>

            <div class="input-group">
                <label>生日</label>
                <i class="fas fa-calendar"></i>
                <input type="date" name="birthday" required>
            </div>

            <c:if test="${not empty requestScope.error_msg}">
                <div class="error-msg">
                    <i class="fas fa-exclamation-circle"></i>
                    ${requestScope.error_msg}
                </div>
            </c:if>

            <button type="submit" class="register-btn">注 册</button>
        </form>

        <div class="bottom-links">
            已有账号？<a href="login.jsp">立即登录</a>
        </div>
    </div>
</body>
</html>
