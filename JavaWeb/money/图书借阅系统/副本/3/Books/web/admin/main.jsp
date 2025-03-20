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
            background-color: #f8f9fa;
            padding: 20px;
            color: #2d3748;
        }

        .welcome-section {
            background: linear-gradient(135deg, #7AB87A, #68A568);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(122, 184, 122, 0.2);
        }

        .welcome-title {
            font-size: 24px;
            margin-bottom: 15px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-text {
            opacity: 0.95;
            font-size: 14px;
            line-height: 1.8;
        }

        .system-status {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid rgba(255,255,255,0.2);
            display: flex;
            gap: 20px;
        }

        .status-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-item i {
            font-size: 16px;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 30px;
        }

        .feature-card {
            background: white;
            padding: 0;
            border-radius: 15px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            overflow: hidden;
            border: 1px solid #e9ecef;
            display: block;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            border-color: #7AB87A;
        }

        .feature-header {
            padding: 20px;
            background: linear-gradient(45deg, rgba(0,0,0,0.02), rgba(255,255,255,0.1));
            border-bottom: 1px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .feature-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
            flex-shrink: 0;
        }

        .feature-title {
            font-size: 18px;
            font-weight: 500;
            color: #343a40;
            margin: 0;
        }

        .feature-content {
            padding: 20px;
        }

        .feature-desc {
            color: #6c757d;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }

        .feature-stats {
            display: flex;
            gap: 20px;
        }

        .stat-item {
            flex: 1;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
            text-align: center;
        }

        .stat-value {
            font-size: 20px;
            font-weight: 600;
            color: #7AB87A;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 12px;
            color: #6c757d;
        }

        .feature-footer {
            padding: 15px 20px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            font-size: 13px;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .footer-action {
            color: #7AB87A;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .footer-action i {
            font-size: 12px;
        }

        .icon-books { background: linear-gradient(135deg, #7AB87A, #68A568); }
        .icon-users { background: linear-gradient(135deg, #6B8DD6, #5C7EC9); }
        .icon-orders { background: linear-gradient(135deg, #E6A23C, #D69220); }
        .icon-categories { background: linear-gradient(135deg, #8E72D6, #7A5EC9); }
    </style>
</head>
<body>
    <div class="welcome-section">
        <h2 class="welcome-title">
            <i class="fas fa-tachometer-alt"></i>
            系统管理控制台
        </h2>
        <p class="welcome-text">
            尊敬的 ${sessionScope.user.username} 管理员，欢迎访问图书商城管理系统。<br>
            今日待处理订单 3 个，新增用户 5 位，库存预警图书 2 本。请及时处理相关业务，确保系统正常运转。
        </p>
        <div class="system-status">
            <div class="status-item">
                <i class="fas fa-check-circle"></i>
                <span>系统运行正常</span>
            </div>
            <div class="status-item">
                <i class="fas fa-clock"></i>
                <span>上次更新：2024-01-05 15:30</span>
            </div>
        </div>
    </div>

    <div class="feature-grid">
        <a href="/IndexBookServlet" class="feature-card">
            <div class="feature-header">
                <div class="feature-icon icon-books">
                    <i class="fas fa-book"></i>
                </div>
                <h3 class="feature-title">图书管理</h3>
            </div>
            <div class="feature-content">
                <p class="feature-desc">管理图书信息、库存和价格，确保商城图书信息的准确性和及时更新。</p>
                <div class="feature-stats">
                    <div class="stat-item">
                        <div class="stat-value">126</div>
                        <div class="stat-label">总库存</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">2</div>
                        <div class="stat-label">库存预警</div>
                    </div>
                </div>
            </div>
            <div class="feature-footer">
                <span>最近更新：今天 12:30</span>
                <span class="footer-action">
                    管理图书 <i class="fas fa-chevron-right"></i>
                </span>
            </div>
        </a>

        <a href="/IndexUserServlet" class="feature-card">
            <div class="feature-header">
                <div class="feature-icon icon-users">
                    <i class="fas fa-users"></i>
                </div>
                <h3 class="feature-title">用户管理</h3>
            </div>
            <div class="feature-content">
                <p class="feature-desc">管理用户账号和权限设置，维护用户数据和安全信息。</p>
                <div class="feature-stats">
                    <div class="stat-item">
                        <div class="stat-value">58</div>
                        <div class="stat-label">总用户</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">5</div>
                        <div class="stat-label">今日新增</div>
                    </div>
                </div>
            </div>
            <div class="feature-footer">
                <span>最近更新：今天 14:20</span>
                <span class="footer-action">
                    管理用户 <i class="fas fa-chevron-right"></i>
                </span>
            </div>
        </a>

        <a href="/IndexOrderServlet" class="feature-card">
            <div class="feature-header">
                <div class="feature-icon icon-orders">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h3 class="feature-title">订单管理</h3>
            </div>
            <div class="feature-content">
                <p class="feature-desc">处理订单和查看销售情况，及时响应用户的购买需求。</p>
                <div class="feature-stats">
                    <div class="stat-item">
                        <div class="stat-value">3</div>
                        <div class="stat-label">待处理</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">28</div>
                        <div class="stat-label">本月订单</div>
                    </div>
                </div>
            </div>
            <div class="feature-footer">
                <span>最近更新：今天 15:45</span>
                <span class="footer-action">
                    管理订单 <i class="fas fa-chevron-right"></i>
                </span>
            </div>
        </a>

        <a href="/IndexCategoryServlet" class="feature-card">
            <div class="feature-header">
                <div class="feature-icon icon-categories">
                    <i class="fas fa-tags"></i>
                </div>
                <h3 class="feature-title">分类管理</h3>
            </div>
            <div class="feature-content">
                <p class="feature-desc">管理图书分类和类别信息，优化商城的浏览体验。</p>
                <div class="feature-stats">
                    <div class="stat-item">
                        <div class="stat-value">12</div>
                        <div class="stat-label">分类总数</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">86</div>
                        <div class="stat-label">已分类图书</div>
                    </div>
                </div>
            </div>
            <div class="feature-footer">
                <span>最近更新：今天 11:20</span>
                <span class="footer-action">
                    管理分类 <i class="fas fa-chevron-right"></i>
                </span>
            </div>
        </a>
    </div>
</body>
</html>
