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
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            color: #333;
            font-size: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #4299e1;
        }

        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            flex: 1;
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
        }

        .stat-value {
            font-size: 24px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-edit {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
        }

        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .data-table th, 
        .data-table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table th {
            background: #f8fafc;
            color: #4a5568;
            font-weight: 500;
            white-space: nowrap;
        }

        .data-table tr:hover {
            background-color: #f8fafc;
        }

        .data-table td {
            color: #2d3748;
            vertical-align: middle;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .book-cover {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .book-details {
            flex: 1;
        }

        .book-name {
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .book-meta {
            color: #718096;
            font-size: 13px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-pending {
            background-color: #feebc8;
            color: #c05621;
        }

        .status-paid {
            background-color: #c6f6d5;
            color: #2f855a;
        }

        .status-shipped {
            background-color: #bee3f8;
            color: #2c5282;
        }

        .status-completed {
            background-color: #e9d8fd;
            color: #553c9a;
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            max-width: 300px;
        }

        .search-input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }

        .contact-info {
            font-size: 13px;
            color: #718096;
        }

        .contact-info div {
            margin-bottom: 2px;
        }

        .price {
            color: #e53e3e;
            font-weight: 500;
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
        </div>

        <div class="stats">
            <div class="stat-card">
                <div class="stat-value">
                    ${orderStats.total}
                </div>
                <div class="stat-label">总订单数</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">
                    ${orderStats.pending}
                </div>
                <div class="stat-label">待付款</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">
                    ${orderStats.processing}
                </div>
                <div class="stat-label">处理中</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">
                    ${orderStats.completed}
                </div>
                <div class="stat-label">已完成</div>
            </div>
        </div>

        <div class="search-box">
            <input type="text" class="search-input" placeholder="搜索订单..." 
                   onkeyup="searchTable(this.value)">
        </div>

        <div class="table-container">
            <table class="data-table" id="orderTable">
                <thead>
                    <tr>
                        <th>订单编号</th>
                        <th>图书信息</th>
                        <th>订单金额</th>
                        <th>订单状态</th>
                        <th>下单时间</th>
                        <th>收货信息</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sessionScope.orderList}" var="order">
                        <tr>
                            <td>${order.orderid}</td>
                            <td>
                                <div class="book-info">
                                    <img src="${order.image}" alt="${order.bookname}" class="book-cover">
                                    <div class="book-details">
                                        <div class="book-name">${order.bookname}</div>
                                        <div class="book-meta">
                                            出版社：${order.publish}<br>
                                            数量：${order.quantity}
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="price">￥${order.totalPrice}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="status-badge status-pending">待付款</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="status-badge status-paid">已付款</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="status-badge status-shipped">已发货</span>
                                    </c:when>
                                    <c:when test="${order.status == 3}">
                                        <span class="status-badge status-completed">已完成</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                            <td>
                                <div class="contact-info">
                                    <div>${order.address}</div>
                                    <div>${order.phone}</div>
                                </div>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="/UpdateOrderServlet?id=${order.orderid}" 
                                       class="btn btn-edit">
                                        <i class="fas fa-edit"></i>
                                        修改
                                    </a>
                                    <a href="/DelOrderServlet?id=${order.orderid}" 
                                       class="btn btn-delete"
                                       onclick="return confirm('确定要删除该订单吗？')">
                                        <i class="fas fa-trash-alt"></i>
                                        删除
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
    function searchTable(keyword) {
        const table = document.getElementById('orderTable');
        const rows = table.getElementsByTagName('tr');
        
        keyword = keyword.toLowerCase();
        
        // 从索引1开始,跳过表头
        for (let i = 1; i < rows.length; i++) {
            const orderIdCell = rows[i].cells[0];
            const bookNameElem = rows[i].querySelector('.book-name');
            const addressElem = rows[i].querySelector('.contact-info');
            
            if (orderIdCell && bookNameElem && addressElem) {
                const orderId = orderIdCell.textContent.toLowerCase();
                const bookName = bookNameElem.textContent.toLowerCase();
                const address = addressElem.textContent.toLowerCase();
                
                if (orderId.includes(keyword) || 
                    bookName.includes(keyword) || 
                    address.includes(keyword)) {
                    rows[i].style.display = '';
                } else {
                    rows[i].style.display = 'none';
                }
            }
        }
    }
    </script>
</body>
</html> 
    </div>
</body>
</html> 