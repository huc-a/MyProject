<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 商城后台管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: url('./static/images/login-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background: white;
            background-color: rgba(255, 255, 255, 0.85);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            width: 360px;
        }
        .login-title {
            text-align: center;
            margin-bottom: 30px;
            color: #fc55ee;
            font-size: 24px;
            font-weight: 500;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #5c7080;
            font-size: 14px;
            font-weight: 500;
        }
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-group input:focus {
            outline: none;
            border-color: #fc55ee;
            box-shadow: 0 0 0 2px rgba(252, 85, 238, 0.2);
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            background: #fc55ee;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .login-btn:hover {
            background: #e840d4;
        }
        .error-message {
            color: #e74c3c;
            margin-bottom: 15px;
            text-align: center;
            background: #fde8e7;
            padding: 10px;
            border-radius: 4px;
            font-size: 14px;
        }
        ::placeholder {
            color: #a3b1c6;
        }
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 30px white inset;
            -webkit-text-fill-color: #333;
        }
        .captcha-wrapper {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .captcha-wrapper input {
            width: 100px !important;
        }
        .captcha-code {
            display: inline-block;
            padding: 8px 15px;
            background: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 3px;
            cursor: pointer;
            user-select: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 class="login-title">商城后台管理系统</h2>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">${error}</div>
        <% } %>
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">确认密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="form-group">
                <label for="captcha">验证码</label>
                <div class="captcha-wrapper">
                    <input type="text" id="captcha" name="captcha" maxlength="4" required>
                    <span id="captchaCode" class="captcha-code" onclick="refreshCaptcha()">1234</span>
                </div>
            </div>
            <button type="submit" class="login-btn">登录</button>
        </form>
    </div>
    <script>
    function generateCaptcha() {
        return Math.floor(1000 + Math.random() * 9000);
    }

    function refreshCaptcha() {
        document.getElementById('captchaCode').textContent = generateCaptcha();
    }

    // 页面加载时生成验证码
    window.onload = refreshCaptcha;

    // 表单提交前验证
    document.querySelector('form').onsubmit = function(e) {
        const inputCode = document.getElementById('captcha').value;
        const correctCode = document.getElementById('captchaCode').textContent;
        
        if (inputCode !== correctCode) {
            e.preventDefault();
            alert('验证码错误');
            refreshCaptcha();
            document.getElementById('captcha').value = '';
            return false;
        }
        return true;
    };
    </script>
</body>
</html> 