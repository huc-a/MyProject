<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>用户管理 - 书城管理系统</title>
    <style>
        .container {
            margin-top: 130px;
            padding: 20px;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .search-box {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .search-box input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            font-size: 14px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        
        .btn-primary { 
            background-color: #007bff; 
        }
        
        .btn-primary:hover { 
            background-color: #0056b3; 
        }
        
        .btn-danger { 
            background-color: #dc3545; 
        }
        
        .btn-danger:hover { 
            background-color: #c82333; 
        }
        
        .user-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .user-table th,
        .user-table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .user-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: #333;
        }
        
        .user-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .user-table td:last-child {
            white-space: nowrap;
        }
        
        .page-title {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
            font-weight: 500;
        }
        
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="搜索用户名、姓名或手机号..." value="${search}">
            <button onclick="searchUsers()" class="btn btn-primary">搜索</button>
            <a href="${pageContext.request.contextPath}/user/add" class="btn btn-primary">添加用户</a>
        </div>
        
        <table class="user-table">
            <thead>
                <tr>
                    <th>用户名</th>
                    <th>姓名</th>
                    <th>手机号</th>
                    <th>邮箱</th>
                    <th>注册时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty users}">
                        <tr>
                            <td colspan="6" class="empty-message">暂无用户数据</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td>${user.username}</td>
                                <td>${user.realName}</td>
                                <td>${user.phone}</td>
                                <td>${user.email}</td>
                                <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/user/edit?id=${user.id}" class="btn btn-primary">编辑</a>
                                    <button onclick="deleteUser(${user.id})" class="btn btn-danger">删除</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <script>
    function searchUsers() {
        var search = document.getElementById('searchInput').value;
        window.location.href = '${pageContext.request.contextPath}/user/list?search=' + encodeURIComponent(search);
    }
    
    function deleteUser(userId) {
        if (confirm('确定要删除该用户吗？此操作不可恢复！')) {
            fetch('${pageContext.request.contextPath}/user/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'id=' + userId
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    window.location.reload();
                } else {
                    alert('删除失败');
                }
            });
        }
    }
    
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchUsers();
        }
    });
    </script>
</body>
</html> 