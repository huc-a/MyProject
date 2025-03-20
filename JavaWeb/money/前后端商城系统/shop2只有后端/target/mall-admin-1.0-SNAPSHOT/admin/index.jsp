<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../static/css/admin.css">
    <style>
        .dashboard {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .welcome-section {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #eee;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(to right, #64b5f6, #90caf9);
        }
        .welcome-title {
            font-size: 28px;
            color: #1976d2;
            margin-bottom: 15px;
            font-weight: 500;
        }
        .welcome-text {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
            font-size: 15px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
        .welcome-time {
            color: #666;
            font-size: 14px;
            background: #f5f9ff;
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            border: 1px solid #e3f2fd;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #eee;
            transition: all 0.3s ease;
            text-align: center;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }
        .stat-title {
            color: #666;
            font-size: 15px;
            margin-bottom: 12px;
            font-weight: 500;
        }
        .stat-value {
            color: #1976d2;
            font-size: 32px;
            font-weight: bold;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .welcome-section {
            animation: fadeIn 0.8s ease-out;
        }
        .dashboard {
            animation: fadeIn 0.8s ease-out 0.2s both;
        }
        .stat-trend {
            color: #00c853;
            font-size: 14px;
            margin-top: 8px;
        }
        .stat-desc {
            color: #666;
            font-size: 14px;
            margin-top: 8px;
        }
        /* 快捷操作区域 */
        .quick-actions {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #eee;
        }
        .quick-actions h3 {
            color: #333;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .action-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .action-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
        }
        .action-card:hover {
            transform: translateY(-3px);
            background: #f0f2f5;
        }
        .action-card .icon {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .action-card span {
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- 左侧菜单 -->
        <div class="sidebar">
            <div class="logo">
                <h2>商城管理系统</h2>
            </div>
            <nav class="menu">
                <ul>
                    <li class="menu-item">
                        <a href="index" class="active">
                            <i class="icon">📊</i>
                            <span>首页</span>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="product/list">
                            <i class="icon">📦</i>
                            <span>商品管理</span>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="category/list">
                            <i class="icon">📑</i>
                            <span>分类管理</span>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="order/list">
                            <i class="icon">📝</i>
                            <span>订单管理</span>
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="user/list">
                            <i class="icon">👥</i>
                            <span>用户管理</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../logout" class="logout">退出</a>
                </div>
            </header>

            <!-- 内容区域 -->
            <div class="content">
                <!-- 欢迎区域 -->
                <div class="welcome-section">
                    <h1 class="welcome-title">欢迎使用商城后台管理系统</h1>
                    <p class="welcome-text">
                        这里是您的一站式商城管理平台。您可以在这里管理商品、订单、用户和分类等信息。<br>
                        如果您有任何问题，请随时联系技术支持。
                    </p>
                    <div class="welcome-time">
                        当前时间：<span id="current-time"></span>
                    </div>
                </div>

                <!-- 数据概览 -->
                <div class="dashboard">
                    <div class="stat-card">
                        <div class="stat-title">今日访问量</div>
                        <div class="stat-value">128</div>
                        <div class="stat-trend">↑ 12.5%</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-title">今日销售额</div>
                        <div class="stat-value">￥6,280</div>
                        <div class="stat-trend">↑ 8.3%</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-title">待处理订单</div>
                        <div class="stat-value">12</div>
                        <div class="stat-desc">需要及时处理</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-title">库存预警</div>
                        <div class="stat-value">5</div>
                        <div class="stat-desc">商品库存不足</div>
                    </div>
                </div>

                <!-- 快捷操作区 -->
                <div class="quick-actions">
                    <h3>快捷操作</h3>
                    <div class="action-grid">
                        <a href="product/add" class="action-card">
                            <i class="icon">📦</i>
                            <span>添加商品</span>
                        </a>
                        <a href="order/list?status=pending" class="action-card">
                            <i class="icon">📝</i>
                            <span>处理订单</span>
                        </a>
                        <a href="product/list?stock=low" class="action-card">
                            <i class="icon">⚠️</i>
                            <span>库存管理</span>
                        </a>
                        <a href="category/list" class="action-card">
                            <i class="icon">📑</i>
                            <span>分类管理</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        // 更新当前时间
        function updateTime() {
            const now = new Date();
            const timeStr = now.toLocaleString('zh-CN', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: false
            });
            document.getElementById('current-time').textContent = timeStr;
        }
        
        // 初始更新时间
        updateTime();
        // 每秒更新一次时间
        setInterval(updateTime, 1000);
    </script>
</body>
</html> 