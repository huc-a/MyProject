<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书商城 - 登录</title>
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
            align-items: center;
            justify-content: center;
            background-image: url('../images/login1.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        .login-box {
            width: 400px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-header h2 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .login-header p {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .user-type-switch {
            display: flex;
            background: #f1f3f5;
            padding: 4px;
            border-radius: 50px;
            margin-bottom: 25px;
        }
        
        .switch-option {
            flex: 1;
            padding: 10px;
            text-align: center;
            cursor: pointer;
            border-radius: 50px;
            color: #7f8c8d;
            transition: all 0.3s ease;
            font-size: 14px;
            user-select: none;
        }
        
        .switch-option.active {
            background: #4299e1;
            color: white;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.3);
        }
        
        .input-group {
            margin-bottom: 20px;
        }
        
        .input-group label {
            display: block;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .input-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .input-group input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
        }
        
        .login-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .login-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
        }
        
        .error-msg {
            color: #e53e3e;
            font-size: 14px;
            text-align: center;
            margin-top: 15px;
            min-height: 20px;
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .register-link a {
            color: #4299e1;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        
        .register-link a:hover {
            color: #3182ce;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <div class="login-header">
            <h2>图书商城系统</h2>
            <p>欢迎回来，请登录您的账号</p>
        </div>
        
        <div class="user-type-switch">
            <div class="switch-option active" onclick="switchUserType('reader')">普通用户</div>
            <div class="switch-option" onclick="switchUserType('admin')">管理员</div>
        </div>
        
        <form action="/LoginServlet" method="post">
            <div class="input-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="input-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <input type="hidden" id="userType" name="userType" value="reader">
            
            <button type="submit" class="login-btn">登 录</button>
            
            <div class="error-msg">
                ${error_msg}
            </div>
            
            <div class="register-link">
                <a href="register.jsp">还没有账号？立即注册 >></a>
            </div>
        </form>
    </div>

    <script>
    function switchUserType(type) {
        // 更新隐藏字段的值
        document.getElementById('userType').value = type;
        
        // 更新切换按钮的样式
        const options = document.querySelectorAll('.switch-option');
        options.forEach(option => {
            if(option.textContent === (type === 'reader' ? '普通用户' : '管理员')) {
                option.classList.add('active');
            } else {
                option.classList.remove('active');
            }
        });
    }
    </script>
</body>
</html>
