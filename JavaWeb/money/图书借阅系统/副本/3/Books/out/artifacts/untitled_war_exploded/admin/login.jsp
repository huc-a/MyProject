<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录 - 图书商城系统</title>
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
            background-image: url('../images/login1.png');
            background-size: cover;
        }

        .login-wrapper {
            display: flex;
            width: 800px;
            height: 500px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.2);
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
            position: relative;
            overflow: hidden;
        }

        .showcase-content {
            position: relative;
            z-index: 1;
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
            padding-right: 20px;
        }

        .feature-list {
            list-style: none;
            margin-top: 30px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            font-size: 13px;
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .feature-item i {
            margin-right: 10px;
            font-size: 16px;
        }

        .login-container {
            width: 440px;
            padding: 40px 50px;
            background: rgba(255, 255, 255, 0.95);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-title {
            font-size: 24px;
            color: #2d3748;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .login-subtitle {
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

        .login-btn {
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

        .login-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #718096;
        }

        .register-link a {
            color: #4299e1;
            text-decoration: none;
            margin-left: 5px;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error-msg {
            color: #e53e3e;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .user-type {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .type-option {
            padding: 10px 25px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            color: #4a5568;
            transition: all 0.3s ease;
            background: #f8fafc;
        }

        .type-option:hover {
            border-color: #4299e1;
            color: #4299e1;
        }

        .type-option.active {
            background: #4299e1;
            color: white;
            border-color: #4299e1;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="showcase">
            <div class="showcase-content">
                <h1 class="showcase-title">图书商城系统</h1>
                <p class="showcase-desc">
                    欢迎使用我们的图书商城系统。这里汇集了丰富的图书资源，
                    为您提供便捷的购书体验。
                </p>
                <ul class="feature-list">
                    <li class="feature-item">
                        <i class="fas fa-book"></i>
                        <span>海量图书资源</span>
                    </li>
                    <li class="feature-item">
                        <i class="fas fa-search"></i>
                        <span>智能搜索推荐</span>
                    </li>
                    <li class="feature-item">
                        <i class="fas fa-truck"></i>
                        <span>快速配送服务</span>
                    </li>
                    <li class="feature-item">
                        <i class="fas fa-shield-alt"></i>
                        <span>安全支付保障</span>
                    </li>
                </ul>
            </div>
        </div>

        <div class="login-container">
            <div class="login-header">
                <h2 class="login-title">用户登录</h2>
                <p class="login-subtitle">欢迎回来，请登录您的账号</p>
            </div>

            <form action="/LoginServlet" method="post">
                <div class="user-type">
                    <label class="type-option active">
                        <input type="radio" name="userType" value="user" checked style="display: none;">
                        普通用户
                    </label>
                    <label class="type-option">
                        <input type="radio" name="userType" value="admin" style="display: none;">
                        管理员
                    </label>
                </div>

                <div class="input-group">
                    <label for="username">用户名</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="input-group">
                    <label for="password">密码</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <button type="submit" class="login-btn">登 录</button>

                <div class="error-msg">
                    ${error_msg}
                </div>

                <div class="register-link">
                    还没有账号？<a href="register.jsp">立即注册</a>
                </div>
            </form>
        </div>
    </div>

    <script>
    document.querySelectorAll('.type-option').forEach(option => {
        option.addEventListener('click', function() {
            document.querySelectorAll('.type-option').forEach(opt => {
                opt.classList.remove('active');
            });
            this.classList.add('active');
            this.querySelector('input').checked = true;
        });
    });
    </script>
</body>
</html>
