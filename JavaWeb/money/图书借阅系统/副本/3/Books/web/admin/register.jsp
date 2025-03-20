<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册 - 图书商城系统</title>
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

        .register-wrapper {
            display: flex;
            width: 800px;
            height: 560px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            overflow: hidden;
        }

        .showcase {
            width: 360px;
            background: linear-gradient(135deg, rgba(66, 153, 225, 0.9), rgba(49, 130, 206, 0.9));
            padding: 30px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .showcase-title {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .showcase-desc {
            font-size: 14px;
            line-height: 1.6;
            opacity: 0.9;
            margin-bottom: 20px;
        }

        .register-container {
            width: 440px;
            padding: 40px 50px;
            background: rgba(255, 255, 255, 0.95);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .register-title {
            font-size: 24px;
            color: #2d3748;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .register-subtitle {
            color: #718096;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            color: #4a5568;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #f8fafc;
        }

        .input-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
        }

        .register-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            letter-spacing: 1px;
        }

        .register-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #718096;
        }

        .login-link a {
            color: #4299e1;
            text-decoration: none;
            margin-left: 5px;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error-msg {
            color: #e53e3e;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="register-wrapper">
        <div class="showcase">
            <h1 class="showcase-title">图书商城系统</h1>
            <p class="showcase-desc">
                欢迎注册成为我们的会员。注册后您可以：
                <br><br>
                • 浏览海量图书资源<br>
                • 享受会员专属优惠<br>
                • 收藏喜欢的图书<br>
                • 查看订单记录<br>
                • 获取个性化推荐
            </p>
        </div>

        <div class="register-container">
            <div class="register-header">
                <h2 class="register-title">用户注册</h2>
                <p class="register-subtitle">创建您的账号</p>
            </div>

            <form action="/AddUserServlet" method="post">
                <div class="input-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="input-group">
                    <label for="password">密码</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div class="input-group">
                    <label for="email">邮箱</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="input-group">
                    <label for="birthday">生日</label>
                    <input type="date" id="birthday" name="birthday" required>
                </div>

                <button type="submit" class="register-btn">注 册</button>

                <div class="error-msg">
                    ${error_msg}
                </div>

                <div class="login-link">
                    已有账号？<a href="login.jsp">立即登录</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
