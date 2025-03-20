<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>医院挂号系统 - 登录</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);
        }
        
        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            width: 360px;
        }
        
        h2 {
            text-align: center;
            color: #333;
            margin: 0 0 30px 0;
            font-size: 28px;
            font-weight: 500;
            letter-spacing: 1px;
        }
        
        .user-type-selector {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            gap: 20px;
        }
        
        .user-type-btn {
            padding: 10px 20px;
            border: 2px solid #4CAF50;
            background: none;
            color: #4CAF50;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s ease;
            min-width: 100px;
        }
        
        .user-type-btn:hover {
            background: rgba(76, 175, 80, 0.1);
        }
        
        .user-type-btn.active {
            background: #4CAF50;
            color: white;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
            font-size: 14px;
        }
        
        input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.2s ease;
            background: #f8f9fa;
        }
        
        input:focus {
            outline: none;
            border-color: #4CAF50;
            background: white;
            box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.1);
        }
        
        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            letter-spacing: 1px;
        }
        
        button[type="submit"]:hover {
            background-color: #45a049;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        button[type="submit"]:active {
            transform: translateY(0);
            box-shadow: none;
        }
        
        .divider {
            margin: 20px 0;
            text-align: center;
            position: relative;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 45%;
            height: 1px;
            background-color: #ddd;
        }
        
        .divider::before {
            left: 0;
        }
        
        .divider::after {
            right: 0;
        }
        
        .register-link {
            color: #666;
            text-decoration: none;
            font-size: 14px;
            display: block;
            text-align: center;
            margin-top: 20px;
            transition: color 0.3s ease;
        }
        
        .register-link:hover {
            color: #4CAF50;
        }
        
        .error-message, .success-message {
            margin: 15px 0;
            text-align: center;
            padding: 10px;
            border-radius: 4px;
            font-size: 14px;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>医院挂号系统</h2>
        <div class="user-type-selector">
            <button class="user-type-btn active" onclick="switchUserType('patient')">病人登录</button>
            <button class="user-type-btn" onclick="switchUserType('doctor')">医生登录</button>
        </div>
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                注册成功，请登录
            </div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="hidden" name="userType" id="userType" value="patient">
            <div class="form-group">
                <label for="fullName">用户名</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            <button type="submit">登录</button>
        </form>
        <div class="divider">或</div>
        <a href="${pageContext.request.contextPath}/common/register.jsp" class="register-link" id="registerLink">
            <span id="registerText">还没有账号？立即注册</span>
        </a>
    </div>

    <script>
        function switchUserType(type) {
            // 更新按钮样式
            document.querySelectorAll('.user-type-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // 更新隐藏的用户类型输入
            document.getElementById('userType').value = type;
            
            // 更新标题
            const title = document.querySelector('h2');
            title.textContent = type === 'patient' ? '病人登录' : '医生登录';
            
            // 更新注册链接文本
            const registerText = document.getElementById('registerText');
            if (type === 'patient') {
                registerText.textContent = '还没有账号？立即注册';
            } else {
                registerText.textContent = '需要入职？请联系管理员';
            }
            
            // 更新注册链接的点击行为
            const registerLink = document.getElementById('registerLink');
            registerLink.href = type === 'patient' ? 
                '${pageContext.request.contextPath}/common/register.jsp' : 
                'javascript:void(0)';  // 医生登录时禁用链接跳转
            
            // 医生登录时添加提示
            registerLink.onclick = type === 'doctor' ? 
                function(e) {
                    e.preventDefault();
                    alert('请联系医院管理员进行入职登记');
                } : null;
        }
    </script>
</body>
</html> 