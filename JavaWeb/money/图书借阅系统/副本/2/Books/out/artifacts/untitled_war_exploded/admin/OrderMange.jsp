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
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #2d3748;
            font-size: 24px;
        }

        .page-title i {
            color: #4299e1;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 8px 15px;
            padding-left: 35px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: #f7fafc;
            padding: 12px;
            text-align: left;
            font-weight: 500;
            font-size: 14px;
            color: #4a5568;
            border-bottom: 2px solid #e2e8f0;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
            color: #2d3748;
            vertical-align: top;
        }

        tr:hover {
            background: #f7fafc;
        }

        .order-info {
            display: flex;
            gap: 15px;
        }

        .book-cover {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .order-details {
            flex: 1;
        }

        .order-id {
            color: #718096;
            font-size: 13px;
            margin-bottom: 4px;
        }

        .book-title {
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .order-date {
            color: #718096;
            font-size: 13px;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .user-name {
            font-weight: 500;
            color: #2d3748;
        }

        .user-contact {
            color: #718096;
            font-size: 13px;
        }

        .price {
            font-weight: 500;
            color: #e53e3e;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-pending {
            background: rgba(246, 173, 85, 0.1);
            color: #dd6b20;
        }

        .status-processing {
            background: rgba(66, 153, 225, 0.1);
            color: #3182ce;
        }

        .status-completed {
            background: rgba(72, 187, 120, 0.1);
            color: #38a169;
        }

        .status-cancelled {
            background: rgba(245, 101, 101, 0.1);
            color: #e53e3e;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: rgba(66, 153, 225, 0.1);
            color: #3182ce;
        }

        .btn-edit:hover {
            background: rgba(66, 153, 225, 0.2);
        }

        .btn-delete {
            background: rgba(245, 101, 101, 0.1);
            color: #e53e3e;
        }

        .btn-delete:hover {
            background: rgba(245, 101, 101, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #718096;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 20px;
            color: #a0aec0;
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h2 class="page-title">
                <i class="fas fa-shopping-cart"></i>
                订单管理
            </h2>
            <div class="header-actions">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" 
                           class="search-input" 
                           placeholder="搜索订单号、图书名称..." 
                           onkeyup="searchTable(this.value)">
                </div>
            </div>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty sessionScope.orderList}">
                    <div class="empty-state">
                        <i class="fas fa-shopping-cart"></i>
                        <p>暂无订单数据</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
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
                                            <img src="${order.image}" alt="${order.bookname}" class="book-cover">
                                            <div class="order-details">
                                                <div class="order-id">订单号：${order.orderid}</div>
                                                <div class="book-title">${order.bookname}</div>
                                                <div class="order-date">
                                                    <fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd HH:mm"/>
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
                                                <span class="status-badge status-pending">
                                                    <i class="fas fa-clock"></i>
                                                    待付款
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 1}">
                                                <span class="status-badge status-processing">
                                                    <i class="fas fa-spinner fa-spin"></i>
                                                    处理中
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="status-badge status-completed">
                                                    <i class="fas fa-check"></i>
                                                    已完成
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-cancelled">
                                                    <i class="fas fa-times"></i>
                                                    已取消
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/UpdateOrderServlet?id=${order.orderid}" class="btn btn-edit">
                                                <i class="fas fa-edit"></i>
                                                编辑
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
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
    function searchTable(keyword) {
        const table = document.querySelector('table');
        const rows = table.getElementsByTagName('tr');
        
        keyword = keyword.toLowerCase();
        
        for (let i = 1; i < rows.length; i++) {
            const orderIdElem = rows[i].querySelector('.order-id');
            const bookTitleElem = rows[i].querySelector('.book-title');
            
            if (orderIdElem && bookTitleElem) {
                const orderId = orderIdElem.textContent.toLowerCase();
                const bookTitle = bookTitleElem.textContent.toLowerCase();
                
                if (orderId.includes(keyword) || bookTitle.includes(keyword)) {
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