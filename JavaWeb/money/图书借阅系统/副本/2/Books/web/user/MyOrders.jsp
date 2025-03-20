<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的订单</title>
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
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 20px;
            color: #2d3748;
        }

        .back-btn {
            padding: 8px 16px;
            background: #4299e1;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
        }

        .order-list {
            display: grid;
            gap: 20px;
        }

        .order-item {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            padding: 20px;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            padding-bottom: 15px;
            border-bottom: 1px solid #edf2f7;
            margin-bottom: 15px;
        }

        .order-id {
            color: #718096;
            font-size: 14px;
        }

        .order-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
        }

        .status-pending {
            background: #fef3c7;
            color: #d97706;
        }

        .status-processing {
            background: #e0f2fe;
            color: #0369a1;
        }

        .status-completed {
            background: #dcfce7;
            color: #15803d;
        }

        .status-cancelled {
            background: #fee2e2;
            color: #b91c1c;
        }

        .order-content {
            display: flex;
            gap: 20px;
        }

        .book-cover {
            width: 100px;
            height: 140px;
            object-fit: cover;
            border-radius: 4px;
        }

        .order-info {
            flex: 1;
        }

        .book-title {
            font-size: 16px;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .order-meta {
            color: #718096;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .order-price {
            color: #e53e3e;
            font-size: 18px;
            font-weight: 500;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
            <h2 class="page-title">我的订单</h2>
            <a href="/IndexBookServletForUser" class="back-btn">返回商城</a>
        </div>

        <div class="order-list">
            <c:choose>
                <c:when test="${empty sessionScope.myOrders}">
                    <div class="empty-state">
                        <i class="fas fa-shopping-cart"></i>
                        <p>暂无订单记录</p>
                        <a href="/IndexBookServletForUser" class="back-btn">去购物</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${sessionScope.myOrders}" var="order">
                        <div class="order-item">
                            <div class="order-header">
                                <span class="order-id">订单号：${order.orderid}</span>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="order-status status-pending">待付款</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="order-status status-processing">处理中</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="order-status status-completed">已完成</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="order-status status-cancelled">已取消</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="order-content">
                                <img src="${order.image}" alt="${order.bookname}" class="book-cover">
                                <div class="order-info">
                                    <h3 class="book-title">${order.bookname}</h3>
                                    <div class="order-meta">
                                        下单时间：<fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd HH:mm"/><br>
                                        收货地址：${order.address}<br>
                                        联系电话：${order.phone}
                                    </div>
                                    <div class="order-price">￥${order.totalPrice}</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html> 