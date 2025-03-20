<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>订单管理 - 书城管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        
        .container {
            margin-top: 130px;
            padding: 20px;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .order-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .order-table th,
        .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .order-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: #333;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85rem;
        }
        
        .status-0 { background-color: #fff3cd; color: #856404; }
        .status-1 { background-color: #d4edda; color: #155724; }
        .status-2 { background-color: #cce5ff; color: #004085; }
        .status-3 { background-color: #d1ecf1; color: #0c5460; }
        .status-4 { background-color: #f8d7da; color: #721c24; }
        
        .search-box {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }
        
        .search-box input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }
        
        .btn-primary {
            background-color: #007bff;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
        }
        
        .modal-content {
            position: relative;
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            width: 80%;
            max-width: 800px;
            border-radius: 8px;
        }
        
        .close {
            position: absolute;
            right: 20px;
            top: 10px;
            font-size: 24px;
            cursor: pointer;
        }
        
        .btn-danger {
            background-color: #dc3545;
            margin-left: 8px;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="搜索订单号或收货人..." value="${search}">
            <button onclick="searchOrders()" class="btn btn-primary">搜索</button>
        </div>
        
        <table class="order-table">
            <thead>
                <tr>
                    <th>订单号</th>
                    <th>收货人</th>
                    <th>金额</th>
                    <th>状态</th>
                    <th>下单时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>${order.orderNo}</td>
                        <td>${order.receiver}</td>
                        <td>￥${order.amount}</td>
                        <td>
                            <span class="status-badge status-${order.status}">
                                ${order.status == 0 ? '待付款' : 
                                  order.status == 1 ? '已付款' : 
                                  order.status == 2 ? '已发货' : 
                                  order.status == 3 ? '已完成' : '已取消'}
                            </span>
                        </td>
                        <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <a href="javascript:void(0)" onclick="showOrderDetail(${order.id})" class="btn btn-primary">查看详情</a>
                            <button onclick="deleteOrder(${order.id})" class="btn btn-danger">删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div id="orderDetailModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>订单详情</h2>
            <div id="orderDetailContent"></div>
        </div>
    </div>

    <script>
    function searchOrders() {
        var search = document.getElementById('searchInput').value;
        window.location.href = '${pageContext.request.contextPath}/order/list?search=' + encodeURIComponent(search);
    }

    function showOrderDetail(orderId) {
        fetch('${pageContext.request.contextPath}/order/detail?id=' + orderId)
            .then(response => response.text())
            .then(html => {
                document.getElementById('orderDetailContent').innerHTML = html;
                document.getElementById('orderDetailModal').style.display = 'block';
            });
    }

    document.querySelector('.close').onclick = function() {
        document.getElementById('orderDetailModal').style.display = 'none';
    }

    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchOrders();
        }
    });

    function deleteOrder(orderId) {
        if (confirm('确定要删除这个订单吗？此操作不可恢复！')) {
            fetch('${pageContext.request.contextPath}/order/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'id=' + orderId
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert('删除成功');
                    window.location.reload();
                } else {
                    alert('删除失败');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('删除失败');
            });
        }
    }
    </script>
</body>
</html> 