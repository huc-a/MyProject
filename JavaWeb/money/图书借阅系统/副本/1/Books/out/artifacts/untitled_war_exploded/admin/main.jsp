<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
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
            font-size: 28px;
            margin-bottom: 10px;
        }

        .welcome-text {
            opacity: 0.9;
            font-size: 16px;
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
            padding: 25px;
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
            color: #2c3e50;
            font-size: 16px;
            font-weight: 500;
        }

        .card-number {
            font-size: 28px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .card-desc {
            color: #7f8c8d;
            font-size: 14px;
        }

        .info-section {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .info-title {
            color: #2c3e50;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .info-list {
            list-style: none;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .info-label {
            color: #7f8c8d;
        }

        .info-value {
            color: #34495e;
            flex: 1;
            text-align: right;
        }

        .activity-content {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .activity-icon {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        .new-user {
            background: rgba(46, 204, 113, 0.1);
            color: #2ecc71;
        }

        .new-order {
            background: rgba(155, 89, 182, 0.1);
            color: #9b59b2;
        }

        .new-book {
            background: rgba(52, 152, 219, 0.1);
            color: #3498db;
        }

        .return-book {
            background: rgba(230, 126, 34, 0.1);
            color: #e67e22;
        }

        .activity-details {
            flex: 1;
        }

        .activity-main {
            color: #2c3e50;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .activity-time {
            color: #95a5a6;
            font-size: 12px;
        }

        .info-title {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-title i {
            color: #4299e1;
        }

        .info-item {
            padding: 15px 0;
        }
    </style>
</head>
<body>
    <div class="welcome-section">
        <h1 class="welcome-title">欢迎使用图书商城管理系统</h1>
        <p class="welcome-text">本系统提供图书管理、用户管理、订单管理等功能，使用左侧菜单可以进行相应操作。</p>
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
            <div class="card-desc">在售图书总数量</div>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="card-icon users">
                    <i class="fas fa-users"></i>
                </div>
                <h2 class="card-title">用户总数</h2>
            </div>
            <div class="card-number">847</div>
            <div class="card-desc">注册用户总数量</div>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="card-icon orders">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h2 class="card-title">订单总数</h2>
            </div>
            <div class="card-number">1,286</div>
            <div class="card-desc">累计订单总数量</div>
        </div>
    </div>

    <div class="info-section">
        <h2 class="info-title">
            <i class="fas fa-history"></i>
            最近活动
        </h2>
        <ul class="info-list">
            <li class="info-item">
                <div class="activity-content">
                    <i class="fas fa-user-plus activity-icon new-user"></i>
                    <div class="activity-details">
                        <div class="activity-main">新用户注册: 张三</div>
                        <div class="activity-time">2024-01-15 14:30</div>
                    </div>
                </div>
            </li>
            <li class="info-item">
                <div class="activity-content">
                    <i class="fas fa-shopping-cart activity-icon new-order"></i>
                    <div class="activity-details">
                        <div class="activity-main">新订单: 《Java编程思想》</div>
                        <div class="activity-time">2024-01-15 13:25</div>
                    </div>
                </div>
            </li>
            <li class="info-item">
                <div class="activity-content">
                    <i class="fas fa-book activity-icon new-book"></i>
                    <div class="activity-details">
                        <div class="activity-main">新增图书: 《Spring实战》</div>
                        <div class="activity-time">2024-01-15 11:20</div>
                    </div>
                </div>
            </li>
            <li class="info-item">
                <div class="activity-content">
                    <i class="fas fa-exchange-alt activity-icon return-book"></i>
                    <div class="activity-details">
                        <div class="activity-main">图书归还: 《MySQL必知必会》</div>
                        <div class="activity-time">2024-01-15 10:15</div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</body>
</html>
