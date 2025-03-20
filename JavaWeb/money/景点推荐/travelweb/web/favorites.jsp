<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的收藏 - 旅游景点推荐系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f7fa;
        }

        .main-content {
            margin-top: 80px;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-title {
            text-align: center;
            color: #2c3e50;
            margin: 20px 0 30px;
            font-size: 24px;
            position: relative;
        }

        .page-title:after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: #3498db;
            margin: 10px auto;
            border-radius: 3px;
        }

        .favorites-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            padding: 20px;
        }

        .attraction-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            position: relative;
            transition: all 0.3s ease;
        }

        .attraction-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .remove-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: #e74c3c;
            cursor: pointer;
            padding: 5px;
            border-radius: 50%;
            transition: all 0.3s ease;
            opacity: 0;
        }

        .attraction-card:hover .remove-btn {
            opacity: 1;
        }

        .remove-btn:hover {
            background: #fde8e7;
            transform: scale(1.1);
        }

        .attraction-card h3 {
            color: #2c3e50;
            margin: 0 0 15px 0;
            font-size: 20px;
            padding-right: 30px;
        }

        .info-group {
            margin: 15px 0;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 14px;
        }

        .info-item i {
            color: #3498db;
            width: 16px;
        }

        .description {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            color: #666;
            font-size: 14px;
            line-height: 1.6;
        }

        .empty-favorites {
            text-align: center;
            padding: 50px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        .empty-favorites i {
            font-size: 50px;
            color: #bdc3c7;
            margin-bottom: 20px;
        }

        .empty-favorites p {
            color: #7f8c8d;
            margin: 10px 0;
        }

        .empty-favorites p:last-child {
            font-size: 14px;
            color: #95a5a6;
        }

        @media (max-width: 768px) {
            .favorites-list {
                grid-template-columns: 1fr;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="main-content">
        <div class="container">
            <h1 class="page-title">我的收藏</h1>
            
            <div class="favorites-list">
                <c:choose>
                    <c:when test="${empty favorites}">
                        <div class="empty-favorites">
                            <i class="far fa-heart"></i>
                            <p>您还没有收藏任何景点</p>
                            <p>浏览景点时点击收藏按钮即可添加到这里</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${favorites}" var="attraction">
                            <div class="attraction-card">
                                <button class="remove-btn" onclick="removeFavorite(${attraction.id})" 
                                        title="取消收藏">
                                    <i class="fas fa-times"></i>
                                </button>
                                <h3>${attraction.name}</h3>
                                <div class="info-group">
                                    <div class="info-item">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>${attraction.city}</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-star"></i>
                                        <span>${attraction.level}</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-ticket-alt"></i>
                                        <span>
                                            <c:choose>
                                                <c:when test="${attraction.ticketPrice == 0}">免费</c:when>
                                                <c:otherwise>￥${attraction.ticketPrice}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-clock"></i>
                                        <span>${attraction.openingHours}</span>
                                    </div>
                                </div>
                                <div class="description">
                                    ${attraction.description}
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        function removeFavorite(attractionId) {
            if (confirm('确定要取消收藏这个景点吗？')) {
                window.location.href = '${pageContext.request.contextPath}/favorites?action=remove&id=' + attractionId;
            }
        }
    </script>
</body>
</html> 