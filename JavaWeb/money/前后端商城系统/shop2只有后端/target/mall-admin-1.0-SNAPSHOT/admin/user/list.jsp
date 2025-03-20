<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../../static/css/admin.css">
</head>
<body>
    <div class="admin-container">
        <!-- 左侧菜单 -->
        <div class="sidebar">
            <div class="logo">
                <h2>商城管理系统</h2>
            </div>
            <nav class="menu">
                <ul>
                    <li><a href="../index.jsp"><i class="icon">📊</i>控制台</a></li>
                    <li><a href="../product/list"><i class="icon">📦</i>商品管理</a></li>
                    <li><a href="../category/list"><i class="icon">📑</i>分类管理</a></li>
                    <li><a href="../order/list"><i class="icon">📝</i>订单管理</a></li>
                    <li><a href="list" class="active"><i class="icon">👥</i>用户管理</a></li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span> / <span>用户管理</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../../logout" class="logout">退出</a>
                </div>
            </header>

            <div class="content">
                <div class="toolbar">
                    <form action="list" method="get" class="search-form">
                        <div class="search-group">
                            <input type="text" name="keyword" value="${param.keyword}" placeholder="用户名/手机号/邮箱">
                            <button type="submit" class="btn btn-info">搜索</button>
                        </div>
                    </form>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>手机号</th>
                            <th>邮箱</th>
                            <th>注册时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.phone}</td>
                                <td>${user.email}</td>
                                <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <button class="btn btn-sm btn-info" onclick="location.href='edit?id=${user.id}'">编辑</button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteUser(${user.id})">删除</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function deleteUser(id) {
            if (confirm('确定要删除该用户吗？')) {
                location.href = 'delete?id=' + id;
            }
        }
    </script>
</body>
</html> 