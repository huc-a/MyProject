<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>旅游景点推荐系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

       .main-content {
            margin-top: 80px;
            padding: 40px 20px;
        }

       .welcome-section {
            text-align: center;
            padding: 60px 20px;
            max-width: 800px;
            margin: 0 auto 40px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

       .welcome-section h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 2.5rem;
            font-weight: 700;
        }

       .welcome-section p {
            color: #34495e;
            line-height: 1.8;
            font-size: 1.1rem;
            margin: 15px 0;
        }

       .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

       .feature-card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

       .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #2ecc71);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

       .feature-card:hover {
            transform: translateY(-10px);
        }

       .feature-card:hover::before {
            transform: scaleX(1);
        }

       .feature-card:hover a {
            text-decoration: underline; /* 鼠标指向时显示下划线 */
        }

       .feature-card i {
            font-size: 2.5rem;
            color: #3498db;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

       .feature-card:hover i {
            transform: scale(1.1);
        }

       .feature-card h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.5rem;
        }

       .feature-card p {
            color: #7f8c8d;
            line-height: 1.6;
            font-size: 1rem;
        }

       .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            background: rgba(255, 255, 255, 0.1);
            padding: 8px 16px;
            border-radius: 30px;
            backdrop-filter: blur(5px);
        }

       .user-info span {
            color: #2c3e50;
            font-weight: 600;
        }

       .logout-btn {
            background: #e74c3c;
            color: white!important;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

       .logout-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
           .welcome-section {
                padding: 40px 20px;
            }

           .welcome-section h2 {
                font-size: 2rem;
            }

           .features {
                grid-template-columns: 1fr;
                gap: 20px;
            }

           .user-info {
                flex-direction: column;
                gap: 10px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

    <div class="main-content">
        <div class="welcome-section">
            <h2><a href="#" style="text-decoration: none;">探索精彩景点</a></h2>
            <p><a href="#" style="text-decoration: none;">欢迎使用我们的旅游景点推荐系统！这里为您提供最优质的旅游景点推荐服务。</a></p>
            <p><a href="#" style="text-decoration: none;">让我们一起开启一段奇妙的旅程，发现更多精彩纷呈的景点。</a></p>
        </div>

        <div class="features">
            <div class="feature-card">
                <i class="fas fa-search"></i>
                <h3><a href="#" style="text-decoration: none;">智能筛选</a></h3>
                <p><a href="#" style="text-decoration: none;">多维度筛选功能，帮您快速找到心仪的景点，让旅行规划更加便捷。</a></p>
            </div>
            <div class="feature-card">
                <i class="fas fa-star"></i>
                <h3><a href="./recommendations.jsp" style="text-decoration: none;">个性推荐</a></h3>
                <p><a href="#" style="text-decoration: none;">基于您的兴趣和喜好，为您推荐最适合的旅游目的地，打造专属旅行体验。</a></p>
            </div>
            <div class="feature-card">
                <i class="fas fa-bookmark"></i>
                <h3><a href="./filterAttractions.jsp" style="text-decoration: none;">收藏功能</a></h3>
                <p><a href="#" style="text-decoration: none;">收藏喜欢的景点，随时查看规划行程，让旅行更加有条理。</a></p>
            </div>
        </div>
    </div>
</body>
</html>