<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>推荐景点 - 旅游景点推荐系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

       .header {
            background: rgba(255, 255, 255, 0.95);
            padding: 1rem 2rem;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            backdrop-filter: blur(10px);
        }

       .logo {
            color: #2c3e50;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: transform 0.3s ease;
        }

       .logo:hover {
            transform: scale(1.05);
        }

       .logo i {
            color: #3498db;
            font-size: 1.8rem;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
            align-items: center;
        }

        nav a {
            color: #2c3e50;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
            transition: all 0.3s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        nav a:not(.logout-btn):hover {
            background: #ecf0f1;
            transform: translateY(-2px);
        }

       .container {
            max-width: 1200px;
            margin: 80px auto 20px;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 2.5rem;
            font-weight: 700;
        }

       .user-menu {
            position: relative;
        }

       .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 4px;
            padding: 8px 0;
            min-width: 150px;
        }

       .user-menu:hover.dropdown-menu {
            display: block;
        }

       .dropdown-menu a {
            display: block;
            padding: 8px 16px;
            color: #333;
            text-decoration: none;
        }

       .dropdown-menu a:hover {
            background: #f5f5f5;
        }

       .dropdown-menu i {
            margin-right: 8px;
            width: 16px;
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

       .recommendations-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

       .attraction-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            position: relative; /* 添加相对定位，方便伪元素绝对定位 */
        }

       .attraction-card:hover {
            transform: translateY(-5px);
        }

       .attraction-card:hover::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/8.jpg') no-repeat center center; /* 替换为你实际的图片路径 */
            background-size: cover;
            opacity: 0.5; /* 调整透明度 */
            z-index: 1;
        }

       .attraction-info {
            padding: 20px;
            position: relative; /* 让景点信息处于图片遮盖之上 */
            z-index: 2;
        }

       .attraction-info h3 {
            color: #2c3e50;
            margin: 0 0 15px 0;
            font-size: 1.3rem;
        }

       .attraction-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }

       .attraction-meta span {
            color: #7f8c8d;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

       .description {
            color: #34495e;
            margin: 15px 0;
            line-height: 1.5;
        }

       .attraction-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
            color: #7f8c8d;
            font-size: 0.9rem;
        }

       .attraction-details span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

       .recommendation-reason {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            color: #27ae60;
            font-style: italic;
        }

        @media (max-width: 768px) {
           .recommendations-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="index.jsp" class="logo">
            <i class="fas fa-map-marked-alt"></i>
            旅游景点推荐系统
        </a>
        <nav>
            <ul>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> 登录</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="filterAttractions.jsp"><i class="fas fa-filter"></i> 筛选景点</a></li>
                        <li><a href="recommendations.jsp"><i class="fas fa-thumbs-up"></i> 推荐景点</a></li>
                        <li><a href="favorites.jsp"><i class="fas fa-heart"></i> 我的收藏</a></li>
                        <li class="user-menu">
                            <a href="#"><i class="fas fa-user"></i> ${sessionScope.user.username}</a>
                            <div class="dropdown-menu">
                                <a href="profile.jsp"><i class="fas fa-id-card"></i> 个人信息</a>
                                <a href="${pageContext.request.contextPath}/user?action=logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>

    <div class="container">
        <h1>为您推荐的景点</h1>

        <!-- 推荐景点列表 -->
        <div class="recommendations-list">
            <c:forEach items="${recommendations}" var="attraction">
                <div class="attraction-card">
                    <div class="attraction-info">
                        <h3>${attraction.name}</h3>
                        <div class="attraction-meta">
                            <span><i class="fas fa-map-marker-alt"></i> ${attraction.city}</span>
                            <span><i class="fas fa-star"></i> ${attraction.level}</span>
                            <span><i class="fas fa-ticket-alt"></i>
                                <c:choose>
                                    <c:when test="${attraction.ticketPrice == 0}">免费</c:when>
                                    <c:otherwise>￥${attraction.ticketPrice}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <p class="description">${attraction.description}</p>
                        <div class="attraction-details">
                            <span><i class="fas fa-clock"></i> ${attraction.openingHours}</span>
                            <span><i class="fas fa-hourglass-half"></i> 建议游玩 ${attraction.suggestedDuration} 小时</span>
                        </div>
                        <div class="recommendation-reason">
                            <i class="fas fa-lightbulb"></i> 推荐理由：根据您的兴趣为您推荐
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>