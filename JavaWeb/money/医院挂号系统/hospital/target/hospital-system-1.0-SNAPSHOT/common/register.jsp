<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .register-container {
            max-width: 400px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .error-message {
            color: #ff4444;
            margin: 15px 0;
            text-align: center;
            padding: 10px;
            background-color: #ffe6e6;
            border: 1px solid #ffcccc;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .success-message {
            color: #4CAF50;
            margin: 15px 0;
            text-align: center;
            padding: 10px;
            background-color: #e8f5e9;
            border: 1px solid #c8e6c9;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .message-icon {
            margin-right: 8px;
            font-size: 18px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        a {
            color: #666;
            text-decoration: none;
        }
        a:hover {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>用户注册</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <span class="message-icon">❌</span>
                ${error}
            </div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message">
                <span class="message-icon">✅</span>
                ${success}
            </div>
        <% } %>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label>手机号</label>
                <input type="text" name="phone" required value="${param.phone}">
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>姓名</label>
                <input type="text" name="fullName" required value="${param.fullName}">
            </div>
            <div class="form-group">
                <label>身份证号</label>
                <input type="text" name="idCardNumber" value="${param.idCardNumber}">
            </div>
            <div class="form-group">
                <label>用户类型</label>
                <select name="userType" required>
                    <option value="patient">病人</option>
                    <option value="doctor">医生</option>
                </select>
            </div>
            <div class="button-group">
                <button type="submit">注册</button>
                <a href="${pageContext.request.contextPath}/common/login.jsp">返回登录</a>
            </div>
        </form>
    </div>
</body>
</html> 