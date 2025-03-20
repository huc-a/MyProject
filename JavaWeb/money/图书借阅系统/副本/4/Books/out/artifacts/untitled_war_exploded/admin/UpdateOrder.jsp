<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>修改订单</title>
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
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        
        .page-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #666;
        }
        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .book-info {
            background: #f8fafc;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .book-info h3 {
            color: #2d3748;
            margin-bottom: 10px;
        }
        
        .book-meta {
            color: #718096;
            font-size: 14px;
        }
        
        .btn-container {
            margin-top: 30px;
            text-align: center;
        }
        
        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }
        
        .btn-back {
            background: #718096;
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">修改订单</h2>
        
        <div class="book-info">
            <h3>${order.bookname}</h3>
            <div class="book-meta">
                <p>订单编号：${order.orderid}</p>
                <p>购买数量：${order.quantity}</p>
                <p>订单金额：￥${order.totalPrice}</p>
                <p>下单时间：<fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
            </div>
        </div>
        
        <form action="/UpdateOrderServlet" method="post">
            <input type="hidden" name="orderid" value="${order.orderid}">
            
            <div class="form-group">
                <label>订单状态</label>
                <select class="form-control" name="status">
                    <option value="0" ${order.status == 0 ? 'selected' : ''}>待付款</option>
                    <option value="1" ${order.status == 1 ? 'selected' : ''}>已付款</option>
                    <option value="2" ${order.status == 2 ? 'selected' : ''}>已发货</option>
                    <option value="3" ${order.status == 3 ? 'selected' : ''}>已完成</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>收货地址</label>
                <input type="text" class="form-control" name="address" value="${order.address}" required>
            </div>
            
            <div class="form-group">
                <label>联系电话</label>
                <input type="text" class="form-control" name="phone" value="${order.phone}" required>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存修改</button>
                <a href="/IndexOrderServlet" class="btn btn-back">返回</a>
            </div>
        </form>
    </div>
</body>
</html> 