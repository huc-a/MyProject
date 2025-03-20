<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>借阅管理</title>
    <style>
        /* 基础样式 */
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
        
        /* 容器样式 */
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
        
        /* 标题样式 */
        .page-title {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        /* 添加按钮样式 */
        .add-btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #7AB87A;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        /* 表格样式 */
        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .order-table th, 
        .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .order-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: normal;
        }
        
        .order-table tr:hover {
            background-color: #f5f5f5;
        }
        
        /* 按钮样式 */
        .btn {
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            margin-right: 5px;
        }
        
        .btn-edit {
            background-color: #7AB87A;
            color: white;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 页面标题 -->
        <h2 class="page-title">借阅管理</h2>
        
        <!-- 添加借阅按钮 -->
        <a href="admin/AddOrder.jsp" class="add-btn">添加借阅</a>

        <!-- 在表格之前添加调试信息 -->
        <div style="display: none;">
            <p>Debug Info:</p>
            <p>orderList size: ${sessionScope.orderList.size()}</p>
            <c:forEach items="${sessionScope.orderList}" var="order">
                <p>Order: ${order.orderid} - ${order.bookname} - ${order.username}</p>
            </c:forEach>
        </div>

        <!-- 借阅列表表格 -->
        <table class="order-table">
            <!-- 表格头部 -->
            <tr>
                <th>借阅编号</th>
                <th>图书名称</th>
                <th>借阅人</th>
                <th>借阅时间</th>
                <th>操作</th>
            </tr>
            
            <!-- 借阅列表数据 -->
            <c:forEach items="${sessionScope.orderList}" var="order">
                <tr>
                    <td>${order.orderid}</td>
                    <td>${order.bookname}</td>
                    <td>${order.username}</td>
                    <td>${order.time}</td>
                    <td>
                        <a href="/UpdateOrderServlet?id=${order.orderid}" class="btn btn-edit">修改</a>
                        <a href="/DelOrderServlet?id=${order.orderid}" 
                           class="btn btn-delete" 
                           onclick="return confirm('确定要删除该借阅记录吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html> 