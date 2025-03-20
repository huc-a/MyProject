<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>系统首页</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }

        .welcome-section {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11);
        }

        .welcome-title {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .welcome-text {
            opacity: 0.9;
            font-size: 14px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .action-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .action-card:hover {
            transform: translateY(-5px);
        }

        .action-content h3 {
            font-size: 16px;
            margin-bottom: 5px;
            color: #2d3748;
        }

        .action-content p {
            font-size: 13px;
            color: #718096;
        }
    </style>
</head>
<body>
    <div class="welcome-section">
        <h2 class="welcome-title">欢迎回来，${sessionScope.user.username}</h2>
        <p class="welcome-text">今天是 ${sessionScope.today}，祝您工作愉快！</p>
    </div>

    <div class="quick-actions">
        <a href="/IndexBookServlet" class="action-card">
            <div class="action-content">
                <h3>图书管理</h3>
                <p>管理图书信息、库存和分类</p>
            </div>
        </a>

        <a href="/IndexUserServlet" class="action-card">
            <div class="action-content">
                <h3>用户管理</h3>
                <p>管理用户账号和权限</p>
            </div>
        </a>

        <a href="/IndexOrderServlet" class="action-card">
            <div class="action-content">
                <h3>订单管理</h3>
                <p>处理订单和发货状态</p>
            </div>
        </a>

        <a href="/IndexCategoryServlet" class="action-card">
            <div class="action-content">
                <h3>分类管理</h3>
                <p>管理图书分类信息</p>
            </div>
        </a>
    </div>
</body>
</html>
