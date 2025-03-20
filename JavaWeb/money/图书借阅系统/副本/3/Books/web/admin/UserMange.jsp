<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/4
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户管理</title>
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

        .header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 22px;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #7AB87A;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 8px 15px 8px 35px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            width: 250px;
            font-size: 14px;
        }

        .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .add-btn {
            background: #7AB87A;
            color: white;
            padding: 8px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .add-btn:hover {
            background: #68A568;
        }

        .user-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .user-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .user-header {
            padding: 20px;
            background: linear-gradient(45deg, rgba(0,0,0,0.02), rgba(255,255,255,0.1));
            border-bottom: 1px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            background: #7AB87A;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

        .user-title {
            flex: 1;
        }

        .user-name {
            font-size: 16px;
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .user-type {
            font-size: 13px;
            color: #7AB87A;
        }

        .user-content {
            padding: 20px;
        }

        .user-info {
            margin-bottom: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            color: #718096;
            font-size: 14px;
        }

        .info-item i {
            color: #a0aec0;
            width: 16px;
        }

        .user-actions {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            flex: 1;
            padding: 8px;
            border-radius: 6px;
            text-align: center;
            text-decoration: none;
            font-size: 13px;
            transition: all 0.3s;
        }

        .btn-edit {
            background: rgba(122, 184, 122, 0.1);
            color: #7AB87A;
        }

        .btn-edit:hover {
            background: rgba(122, 184, 122, 0.2);
        }

        .btn-delete {
            background: rgba(229, 62, 62, 0.1);
            color: #e53e3e;
        }

        .btn-delete:hover {
            background: rgba(229, 62, 62, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }

        .empty-state i {
            font-size: 48px;
            color: #a0aec0;
            margin-bottom: 20px;
        }

        .empty-state p {
            color: #718096;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 class="page-title">
                <i class="fas fa-users"></i>
                用户管理
            </h2>
            <div class="header-actions">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="搜索用户..." onkeyup="searchUsers(this.value)">
                </div>
                <a href="AddUser.jsp" class="add-btn">
                    <i class="fas fa-plus"></i>
                    添加用户
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty sessionScope.userList}">
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    <p>暂无用户数据</p>
                    <a href="AddUser.jsp" class="add-btn">添加第一个用户</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="user-grid">
                    <c:forEach items="${sessionScope.userList}" var="user">
                        <div class="user-card">
                            <div class="user-header">
                                <div class="user-avatar">
                                    <i class="fas fa-user"></i>
                                </div>s
                                <div class="user-title">
                                    <div class="user-name">${user.username}</div>
                                    <div class="user-type">
                                        <c:choose>
                                            <c:when test="${user.isadmin == 1}">管理员</c:when>
                                            <c:otherwise>普通用户</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            <div class="user-content">
                                <div class="user-info">
                                    <div class="info-item">
                                        <i class="fas fa-envelope"></i>
                                        <span>${user.email}</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-calendar"></i>
                                        <span>${user.birthday}</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-id-card"></i>
                                        <span>ID: ${user.id}</span>
                                    </div>
                                </div>
                                <div class="user-actions">
                                    <a href="/UpdateUserServlet?id=${user.id}" class="action-btn btn-edit">
                                        <i class="fas fa-edit"></i> 编辑
                                    </a>
                                    <a href="/DelUserServlet?id=${user.id}" 
                                       class="action-btn btn-delete"
                                       onclick="return confirm('确定要删除该用户吗？')">
                                        <i class="fas fa-trash-alt"></i> 删除
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchUsers(keyword) {
        const cards = document.querySelectorAll('.user-card');
        keyword = keyword.toLowerCase();
        
        cards.forEach(card => {
            const name = card.querySelector('.user-name').textContent.toLowerCase();
            const email = card.querySelector('.info-item span').textContent.toLowerCase();
            
            if (name.includes(keyword) || email.includes(keyword)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    }
    </script>
</body>
</html>
