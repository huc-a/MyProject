<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <li><a href="${pageContext.request.contextPath}/recommendations">
                        <i class="fas fa-thumbs-up"></i> 推荐景点
                    </a></li>
                    <li><a href="favorites.jsp"><i class="fas fa-heart"></i> 我的收藏</a></li>
                    <li class="user-menu">
                        <a href="#"><i class="fas fa-user"></i> ${sessionScope.user.username}</a>
                        <div class="dropdown-menu">
                            <a href="profile.jsp"><i class="fas fa-id-card"></i> 个人信息</a>
                            <a href="${pageContext.request.contextPath}/user?action=logout">
                                <i class="fas fa-sign-out-alt"></i> 退出登录
                            </a>
                        </div>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
</div>

<style>
    .header {
        background: rgba(255, 255, 255, 0.95);
        padding: 1rem 2rem;
        box-shadow: 0 2px 15px rgba(0,0,0,0.1);
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

    .user-menu {
        position: relative;
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        background: white;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        border-radius: 4px;
        padding: 8px 0;
        min-width: 150px;
    }

    .user-menu:hover .dropdown-menu {
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

    @media (max-width: 768px) {
        .header {
            padding: 1rem;
        }

        nav ul {
            gap: 10px;
        }
    }
</style> 