<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录 - 学生管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-graduation-cap"></i>
            <h1>学生管理系统</h1>
            <p style="color: #666; margin-top: 0.5rem;">欢迎使用学生管理系统</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        <% } %>
        
        <% if (session.getAttribute("message") != null) { %>
            <div class="message success">
                <i class="fas fa-check-circle"></i>
                ${message}
            </div>
            <% session.removeAttribute("message"); %>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
            <div class="form-group">
                <label for="username">用户名：</label>
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" 
                           placeholder="请输入用户名" required>
                </div>
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" 
                           placeholder="请输入密码" required>
                </div>
            </div>
            <div class="form-group">
                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> 登录
                </button>
            </div>
        </form>
    </div>
</body>
</html> 