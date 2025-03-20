<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户列表</title>
    <style>
        .error {
            color: red;
            margin: 10px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f5f5f5;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
            color: #0066cc;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .add-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .add-link:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>用户列表</h1>
    
    <% if (session.getAttribute("error") != null) { %>
        <p class="error">${error}</p>
        <% session.removeAttribute("error"); %>
    <% } %>
    
    <table border="1">
        <tr>
            <th>ID</th>
            <th>用户名</th>
            <th>邮箱</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${users}" var="user">
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td class="action-links">
                    <a href="${pageContext.request.contextPath}/user/edit?id=${user.id}">编辑</a>
                    <a href="${pageContext.request.contextPath}/user/delete?id=${user.id}" 
                       onclick="return confirm('确定要删除吗？')">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <p><a href="${pageContext.request.contextPath}/user/add" class="add-link">添加新用户</a></p>
</body>
</html> 