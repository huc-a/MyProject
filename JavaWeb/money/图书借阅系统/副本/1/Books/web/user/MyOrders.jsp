<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的订单</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            color: #333;
            font-size: 24px;
        }

        .stats {
            display: flex;
            gap: 20px;
        }

        .stat-item {
            background: #f8fafc;
            padding: 10px 20px;
            border-radius: 4px;
            text-align: center;
        }

        .stat-number {
            font-size: 24px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .order-table th, 
        .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .order-table th {
            background: #f8fafc;
            color: #4a5568;
            font-weight: 500;
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .book-cover {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
        }

        .book-details {
            flex: 1;
        }

        .book-name {
            font-weight: 500;
            margin-bottom: 4px;
        }

        .book-meta {
            font-size: 12px;
            color: #718096;
        }

        .status-tag {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            color: white;
        }

        .status-pending {
            background-color: #f6ad55;
        }

        .status-paid {
            background-color: #68d391;
        }

        .status-shipped {
            background-color: #4299e1;
        }

        .status-completed {
            background-color: #9f7aea;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            background: #7AB87A;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: #68a268;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 class="page-title">我的订单</h2>
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-number">${totalOrders}</div>
                    <div class="stat-label">总订单数</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${pendingCount}</div>
                    <div class="stat-label">待付款</div>
                </div>
            </div>
        </div>

        <table class="order-table">
            <tr>
                <th>订单编号</th>
                <th>图书信息</th>
                <th>购买数量</th>
                <th>总价</th>
                <th>订单状态</th>
                <th>下单时间</th>
                <th>收货信息</th>
            </tr>
            <c:forEach items="${myOrders}" var="order">
                <tr>
                    <td>${order.orderid}</td>
                    <td>
                        <div class="book-info">
                            <img src="${order.image}" alt="${order.bookname}" class="book-cover">
                            <div class="book-details">
                                <div class="book-name">${order.bookname}</div>
                                <div class="book-meta">出版社：${order.publish}</div>
                            </div>
                        </div>
                    </td>
                    <td>${order.quantity}</td>
                    <td>￥${order.totalPrice}</td>
                    <td>
                        <c:choose>
                            <c:when test="${order.status == 0}">
                                <span class="status-tag status-pending">待付款</span>
                            </c:when>
                            <c:when test="${order.status == 1}">
                                <span class="status-tag status-paid">已付款</span>
                            </c:when>
                            <c:when test="${order.status == 2}">
                                <span class="status-tag status-shipped">已发货</span>
                            </c:when>
                            <c:when test="${order.status == 3}">
                                <span class="status-tag status-completed">已完成</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>
                        <fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                        <div>${order.address}</div>
                        <div>${order.phone}</div>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div style="margin-top: 20px;">
            <a href="/IndexBookServletForUser" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                返回商城
            </a>
        </div>
    </div>
</body>
</html> 