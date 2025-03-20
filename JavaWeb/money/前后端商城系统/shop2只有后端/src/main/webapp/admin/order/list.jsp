<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理 - 商城后台管理系统</title>
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
                    <li><a href="list" class="active"><i class="icon">📝</i>订单管理</a></li>
                    <li><a href="../user/list"><i class="icon">👥</i>用户管理</a></li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span> / <span>订单管理</span>
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
                            <input type="text" name="keyword" value="${param.keyword}" placeholder="订单号/收货人/手机号">
                            <button type="submit" class="btn btn-info">搜索</button>
                        </div>
                    </form>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>收货人</th>
                            <th>手机号</th>
                            <th>总金额</th>
                            <th>订单状态</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td>${order.orderNo}</td>
                                <td>${order.receiver}</td>
                                <td>${order.phone}</td>
                                <td>￥${order.totalAmount}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 0}">待付款</c:when>
                                        <c:when test="${order.status == 1}">待发货</c:when>
                                        <c:when test="${order.status == 2}">待收货</c:when>
                                        <c:when test="${order.status == 3}">已完成</c:when>
                                        <c:when test="${order.status == 4}">已取消</c:when>
                                        <c:otherwise>未知状态</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <button class="btn btn-sm btn-info" onclick="showOrderDetail('${order.orderNo}')">详情</button>
                                    <c:if test="${order.status == 1}">
                                        <button class="btn btn-sm btn-primary" onclick="updateStatus(${order.id}, 2)">发货</button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function showOrderDetail(orderNo) {
            location.href = 'detail?orderNo=' + orderNo;
        }

        function updateStatus(orderId, status) {
            if (confirm('确定要更新订单状态吗？')) {
                location.href = 'updateStatus?id=' + orderId + '&status=' + status;
            }
        }
    </script>
</body>
</html> 