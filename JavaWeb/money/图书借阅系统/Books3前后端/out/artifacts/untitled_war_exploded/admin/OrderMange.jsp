<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>借阅管理</title>
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

        .page-title {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .add-btn {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
        }
        
        .add-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.3);
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .order-table th, 
        .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .order-table th {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            padding: 12px;
            font-weight: 500;
        }

        .order-table tr:hover {
            background-color: #f8fafc;
        }

        .btn {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            margin: 0 4px;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
            box-shadow: 0 2px 4px rgba(245, 101, 101, 0.2);
        }
        
        .btn-delete:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(245, 101, 101, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">借阅管理</h2>
        
        <a href="admin/AddOrder.jsp" class="add-btn">添加借阅</a>

        <table class="order-table">
            <tr>
                <th>借阅编号</th>
                <th>图书名称</th>
                <th>借阅人</th>
                <th>借阅时间</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${sessionScope.orderList}" var="order">
                <tr>
                    <td>${order.orderid}</td>
                    <td>${order.bookname}</td>
                    <td>${order.username}</td>
                    <td>${order.time}</td>
                    <td>
                        <a href="/DelOrderServlet?id=${order.orderid}" class="btn btn-delete" 
                           onclick="return confirm('确定要删除该借阅记录吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html> 