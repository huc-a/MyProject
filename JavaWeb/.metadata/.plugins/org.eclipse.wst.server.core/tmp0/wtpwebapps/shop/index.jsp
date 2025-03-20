<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商城首页</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="nav">
        <ul>
            <li><a href="products">商品列表</a></li>
            <li><a href="cart">购物车</a></li>
            <li><a href="orders">我的订单</a></li>
            <li><a href="login">登录</a></li>
        </ul>
    </nav>

    <div class="container">
        <h1>欢迎来到商城</h1>
        
        <div class="featured-products">
            <h2>热门商品</h2>
            <div class="product-grid">
                <c:if test="${not empty featuredProducts}">
                    <c:forEach items="${featuredProducts}" var="product">
                        <div class="product-card">
                            <img src="images/products/${product.id}.jpg" alt="${product.name}">
                            <h3>${product.name}</h3>
                            <p class="price">￥${product.price}</p>
                            <a href="products/detail?id=${product.id}" class="btn btn-primary">查看详情</a>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html> 