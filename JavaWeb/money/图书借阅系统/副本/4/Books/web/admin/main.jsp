<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统首页</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .welcome-section {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(76, 175, 80, 0.15);
        }

        .welcome-title {
            font-size: 28px;
            font-weight: 500;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .welcome-text {
            font-size: 15px;
            opacity: 0.9;
            line-height: 1.6;
            max-width: 600px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid rgba(255,255,255,0.2);
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 13px;
            opacity: 0.8;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: flex-start;
            gap: 20px;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            border-color: #4CAF50;
        }

        .feature-icon {
            width: 50px;
            height: 50px;
            background: #f0f9f0;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: #4CAF50;
        }

        .feature-content {
            flex: 1;
        }

        .feature-title {
            font-size: 18px;
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .feature-desc {
            font-size: 14px;
            color: #718096;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .feature-meta {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
            font-size: 13px;
        }

        .meta-stat {
            color: #4CAF50;
            font-weight: 500;
        }

        .meta-time {
            color: #a0aec0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-section">
            <h2 class="welcome-title">
                <i class="fas fa-tachometer-alt"></i>
                欢迎回来，${sessionScope.user.username}
            </h2>
            <p class="welcome-text">
                今天是个适合工作的好日子。您可以在这里管理图书商城的所有内容，包括用户、图书、订单和分类信息。
            </p>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-value">2,458</div>
                    <div class="stat-label">总访问量</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">186</div>
                    <div class="stat-label">今日订单</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">￥12,580</div>
                    <div class="stat-label">今日销售额</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">98%</div>
                    <div class="stat-label">好评率</div>
                </div>
            </div>
        </div>

        <div class="feature-grid">
            <a href="/IndexBookServlet" class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="feature-content">
                    <h3 class="feature-title">图书管理</h3>
                    <p class="feature-desc">管理所有图书信息，包括添加新书、更新库存和修改信息等操作。</p>
                    <div class="feature-meta">
                        <span class="meta-stat">共1,245本图书</span>
                        <span class="meta-time">最近更新：2分钟前</span>
                    </div>
                </div>
            </a>

            <a href="/IndexUserServlet" class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="feature-content">
                    <h3 class="feature-title">用户管理</h3>
                    <p class="feature-desc">管理用户账户，查看用户信息，处理用户反馈和权限设置。</p>
                    <div class="feature-meta">
                        <span class="meta-stat">活跃用户：856人</span>
                        <span class="meta-time">最近更新：10分钟前</span>
                    </div>
                </div>
            </a>

            <a href="/IndexOrderServlet" class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="feature-content">
                    <h3 class="feature-title">订单管理</h3>
                    <p class="feature-desc">处理用户订单，查看订单状态，管理发货和退款事务。</p>
                    <div class="feature-meta">
                        <span class="meta-stat">待处理：12个订单</span>
                        <span class="meta-time">最近更新：5分钟前</span>
                    </div>
                </div>
            </a>

            <a href="/IndexCategoryServlet" class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-tags"></i>
                </div>
                <div class="feature-content">
                    <h3 class="feature-title">分类管理</h3>
                    <p class="feature-desc">管理图书分类，优化分类结构，提升用户浏览体验。</p>
                    <div class="feature-meta">
                        <span class="meta-stat">当前分类：16个</span>
                        <span class="meta-time">最近更新：1小时前</span>
                    </div>
                </div>
            </a>
        </div>
    </div>
</body>
</html>
