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

        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .card-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 20px;
        }

        .books {
            background: rgba(52, 152, 219, 0.1);
            color: #3498db;
        }

        .users {
            background: rgba(46, 204, 113, 0.1);
            color: #2ecc71;
        }

        .orders {
            background: rgba(155, 89, 182, 0.1);
            color: #9b59b2;
        }

        .card-title {
            font-size: 18px;
            color: #2c3e50;
            font-weight: 500;
        }

        .card-number {
            font-size: 28px;
            font-weight: 600;
            color: #34495e;
            margin: 10px 0;
        }

        .card-desc {
            color: #7f8c8d;
            font-size: 14px;
        }

        .welcome-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .welcome-title {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .welcome-text {
            color: #7f8c8d;
            line-height: 1.6;
        }

        .info-section {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .info-title {
            font-size: 20px;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .info-list {
            list-style: none;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px dashed #eee;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #7f8c8d;
            width: 120px;
        }

        .info-value {
            color: #34495e;
            flex: 1;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="welcome-section">
        <h1 class="welcome-title">欢迎使用图书管理系统</h1>
        <p class="welcome-text">本系统提供图书管理、用户管理、借阅管理等功能，使用左侧菜单可以进行相应操作。</p>
    </div>

    <div class="dashboard">
        <div class="card">
            <div class="card-header">
                <div class="card-icon books">
                    <i class="fas fa-book"></i>
                </div>
                <h2 class="card-title">图书总数</h2>
            </div>
            <div class="card-number">2,451</div>
            <div class="card-desc">当前系统中的图书总数量</div>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="card-icon users">
                    <i class="fas fa-users"></i>
                </div>
                <h2 class="card-title">用户总数</h2>
            </div>
            <div class="card-number">847</div>
            <div class="card-desc">注册用户的总数量</div>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="card-icon orders">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <h2 class="card-title">借阅总数</h2>
            </div>
            <div class="card-number">1,286</div>
            <div class="card-desc">累计借阅订单数量</div>
        </div>
    </div>

    <div class="info-section">
        <h2 class="info-title">系统信息</h2>
        <ul class="info-list">
            <li class="info-item">
                <span class="info-label">操作系统</span>
                <span class="info-value">Windows Server 2019</span>
            </li>
            <li class="info-item">
                <span class="info-label">服务器环境</span>
                <span class="info-value">Apache Tomcat 9.0</span>
            </li>
            <li class="info-item">
                <span class="info-label">开发框架</span>
                <span class="info-value">JavaWeb + MySQL</span>
            </li>
            <li class="info-item">
                <span class="info-label">系统版本</span>
                <span class="info-value">v2.0.0</span>
            </li>
        </ul>
    </div>
</body>
</html>
