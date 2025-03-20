<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>订单管理</title>
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

        .order-table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th {
            background: #f8f9fa;
            padding: 12px 20px;
            text-align: left;
            font-weight: 500;
            color: #4a5568;
            font-size: 14px;
            border-bottom: 2px solid #e2e8f0;
        }

        .order-table td {
            padding: 12px 20px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
        }

        .order-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .book-cover {
            width: 60px;
            height: 80px;
            border-radius: 4px;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .order-details h3 {
            font-size: 15px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .order-meta {
            color: #718096;
            font-size: 13px;
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pending {
            background: rgba(246, 173, 85, 0.1);
            color: #ed8936;
        }

        .status-processing {
            background: rgba(66, 153, 225, 0.1);
            color: #3182ce;
        }

        .status-completed {
            background: rgba(72, 187, 120, 0.1);
            color: #48bb78;
        }

        .status-cancelled {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
        }

        .price {
            font-weight: 500;
            color: #e53e3e;
        }

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

        .user-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
            font-size: 13px;
        }

        .user-name {
            color: #2d3748;
            font-weight: 500;
        }

        .user-contact {
            color: #718096;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 class="page-title">
                <i class="fas fa-shopping-cart"></i>
                订单管理
            </h2>
            <div class="search-box">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="搜索订单..." onkeyup="searchTable(this.value)">
            </div>
        </div>

        <c:choose>
            <c:when test="${empty sessionScope.orderList}">
                <div class="empty-state">
                    <i class="fas fa-shopping-cart"></i>
                    <p>暂无订单数据</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>订单信息</th>
                            <th>用户信息</th>
                            <th>金额</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.orderList}" var="order">
                            <tr>
                                <td>
                                    <div class="order-info">
                                        <div class="book-cover">
                                            <img src="${order.image}" alt="${order.bookname}">
                                        </div>
                                        <div class="order-details">
                                            <h3>${order.bookname}</h3>
                                            <div class="order-meta">
                                                <span>订单号：${order.orderid}</span>
                                                <span>下单时间：<fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd HH:mm"/></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="user-info">
                                        <div class="user-name">${order.username}</div>
                                        <div class="user-contact">${order.address}</div>
                                        <div class="user-contact">${order.phone}</div>
                                    </div>
                                </td>
                                <td class="price">￥${order.totalPrice}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 0}">
                                            <span class="status-badge status-pending">待付款</span>
                                        </c:when>
                                        <c:when test="${order.status == 1}">
                                            <span class="status-badge status-processing">处理中</span>
                                        </c:when>
                                        <c:when test="${order.status == 2}">
                                            <span class="status-badge status-completed">已完成</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-cancelled">已取消</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="/UpdateOrderServlet?id=${order.orderid}" class="btn btn-edit">
                                            <i class="fas fa-edit"></i> 编辑
                                        </a>
                                        <a href="/DelOrderServlet?id=${order.orderid}" 
                                           class="btn btn-delete"
                                           onclick="return confirm('确定要删除该订单吗？')">
                                            <i class="fas fa-trash-alt"></i> 删除
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchTable(keyword) {
        const tbody = document.querySelector('.order-table tbody');
        const rows = tbody.getElementsByTagName('tr');
        keyword = keyword.toLowerCase();
        
        for (let row of rows) {
            const orderInfo = row.querySelector('.order-details').textContent.toLowerCase();
            const userName = row.querySelector('.user-name').textContent.toLowerCase();
            
            if (orderInfo.includes(keyword) || userName.includes(keyword)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }
    </script>
</body>
</html> 