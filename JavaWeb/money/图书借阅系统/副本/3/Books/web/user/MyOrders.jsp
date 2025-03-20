<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的购物车</title>
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
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: white;
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 22px;
            color: #2d3748;
            font-weight: 600;
        }

        .back-btn {
            padding: 8px 16px;
            background: #4299e1;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .back-btn:hover {
            background: #3182ce;
        }

        .orders-grid {
            display: grid;
            gap: 20px;
        }

        .order-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 15px;
        }

        .order-id {
            color: #4a5568;
            font-size: 14px;
        }

        .order-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background: #cce5ff;
            color: #004085;
        }

        .status-completed {
            background: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .order-content {
            display: flex;
            gap: 20px;
        }

        .book-cover {
            width: 120px;
            height: 160px;
            object-fit: cover;
            border-radius: 6px;
        }

        .order-info {
            flex: 1;
        }

        .book-title {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .order-meta {
            font-size: 14px;
            color: #718096;
            margin-bottom: 10px;
        }

        .order-price {
            color: #e53e3e;
            font-size: 18px;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .empty-state i {
            font-size: 48px;
            color: #cbd5e0;
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
            <h2 class="page-title">我的购物车</h2>
            <a href="/IndexBookServletForUser" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                返回商城
            </a>
        </div>

        <div class="orders-grid">
            <c:choose>
                <c:when test="${empty sessionScope.myOrders}">
                    <div class="empty-state">
                        <i class="fas fa-shopping-cart"></i>
                        <p>购物车还是空的，去商城逛逛吧~</p>
                        <a href="/IndexBookServletForUser" class="back-btn">
                            <i class="fas fa-shopping-bag"></i>
                            去购物
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${sessionScope.myOrders}" var="order">
                        <div class="order-card">
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