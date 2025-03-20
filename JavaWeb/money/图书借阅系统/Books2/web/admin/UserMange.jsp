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
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .header {
            padding: 20px;
            background: #f8f9fa;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 20px;
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

        .user-list {
            padding: 20px;
        }

        .user-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-item:hover {
            background: #f0f2f5;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background: #e2e8f0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #718096;
            font-size: 20px;
        }

        .user-info {
            flex: 1;
        }

        .user-name {
            font-size: 16px;
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .user-meta {
            display: flex;
            gap: 20px;
            color: #718096;
            font-size: 13px;
        }

        .user-type {
            min-width: 80px;
        }

        .type-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .type-admin { background: #cce5ff; color: #004085; }
        .type-user { background: #d4edda; color: #155724; }

        .actions {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            text-decoration: none;
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
            padding: 60px 20px;
            color: #718096;
        }

        .empty-state i {
            font-size: 48px;
            color: #a0aec0;
            margin-bottom: 20px;
        }

        .empty-state p {
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
                <a href="admin/AddUser.jsp" class="add-btn">
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
                    <a href="admin/AddUser.jsp" class="add-btn">添加第一个用户</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="user-list">
                    <c:forEach items="${sessionScope.userList}" var="user">
                        <div class="user-item">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="user-info">
                                <div class="user-name">${user.username}</div>
                                <div class="user-meta">
                                    <span>邮箱：${user.email}</span>
                                    <span>生日：${user.birthday}</span>
                                    <span>ID：${user.id}</span>
                                </div>
                            </div>

                            <div class="user-type">
                                <c:choose>
                                    <c:when test="${user.isadmin == 1}">
                                        <span class="type-badge type-admin">管理员</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="type-badge type-user">普通用户</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="actions">
                                <a href="/UpdateUserServlet?id=${user.id}" class="btn btn-edit">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="/DelUserServlet?id=${user.id}" 
                                   class="btn btn-delete"
                                   onclick="return confirm('确定要删除该用户吗？')">
                                    <i class="fas fa-trash-alt"></i> 删除
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchUsers(keyword) {
        const users = document.querySelectorAll('.user-item');
        keyword = keyword.toLowerCase();
        
        users.forEach(user => {
            const userInfo = user.querySelector('.user-info').textContent.toLowerCase();
            
            if (userInfo.includes(keyword)) {
                user.style.display = '';
            } else {
                user.style.display = 'none';
            }
        });
    }
    </script>
</body>
</html>
