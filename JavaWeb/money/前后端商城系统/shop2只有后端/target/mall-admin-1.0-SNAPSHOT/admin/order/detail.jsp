<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单详情 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <style>
        .order-detail {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        
        .info-group {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .info-item label {
            color: #666;
            display: inline-block;
            width: 80px;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .button-group {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- 左侧菜单 -->
        <div class="sidebar">
            <div class="logo">
                <h2>商城管理系统</h2>
            </div>
            <nav class="menu">
                <ul>
                    <li><a href="../index.jsp"><i class="icon">📊</i>控制台</a></li>
                    <li><a href="../product/list"><i class="icon">📦</i>商品管理</a></li>
                    <li><a href="../category/list"><i class="icon">📑</i>分类管理</a></li>
                    <li><a href="list" class="active"><i class="icon">📝</i>订单管理</a></li>
                    <li><a href="../user/list"><i class="icon">👥</i>用户管理</a></li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span> / <span>订单管理</span> / <span>订单详情</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../../logout" class="logout">退出</a>
                </div>
            </header>

            <div class="content">
                <div class="order-detail">
                    <h3>订单信息</h3>
                    <div class="info-group">
                        <div class="info-item">
                            <label>订单号：</label>
                            <span>${order.orderNo}</span>
                        </div>
                        <div class="info-item">
                            <label>订单状态：</label>
                            <span>
                                <c:choose>
                                    <c:when test="${order.status == 0}">待付款</c:when>
                                    <c:when test="${order.status == 1}">待发货</c:when>
                                    <c:when test="${order.status == 2}">待收货</c:when>
                                    <c:when test="${order.status == 3}">已完成</c:when>
                                    <c:when test="${order.status == 4}">已取消</c:when>
                                    <c:otherwise>未知状态</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="info-item">
                            <label>收货人：</label>
                            <span>${order.receiver}</span>
                        </div>
                        <div class="info-item">
                            <label>联系电话：</label>
                            <span>${order.phone}</span>
                        </div>
                        <div class="info-item">
                            <label>收货地址：</label>
                            <span>${order.address}</span>
                        </div>
                        <div class="info-item">
                            <label>创建时间：</label>
                            <span><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </div>
                    </div>

                    <h3>商品信息</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>商品图片</th>
                                <th>商品名称</th>
                                <th>单价</th>
                                <th>数量</th>
                                <th>小计</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${items}" var="item">
                                <tr>
                                    <td>
                                        <img src="${item.productImage}" alt="${item.productName}" class="product-image">
                                    </td>
                                    <td>${item.productName}</td>
                                    <td>￥${item.price}</td>
                                    <td>${item.quantity}</td>
                                    <td>￥${item.price * item.quantity}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="text-right"><strong>订单总额：</strong></td>
                                <td><strong>￥${order.totalAmount}</strong></td>
                            </tr>
                        </tfoot>
                    </table>

                    <div class="button-group">
                        <button class="btn btn-default" onclick="history.back()">返回</button>
                        <c:if test="${order.status == 1}">
                            <button class="btn btn-primary" onclick="updateStatus(${order.id}, 2)">发货</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function updateStatus(orderId, status) {
            if (confirm('确定要更新订单状态吗？')) {
                location.href = 'updateStatus?id=' + orderId + '&status=' + status;
            }
        }
    </script>
</body>
</html> 