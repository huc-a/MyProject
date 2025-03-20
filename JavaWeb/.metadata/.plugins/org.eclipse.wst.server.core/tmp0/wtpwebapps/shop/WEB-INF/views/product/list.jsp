<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <nav class="nav">
        <ul>
            <li><a href="../">首页</a></li>
            <li><a href="../cart">购物车</a></li>
            <li><a href="../orders">我的订单</a></li>
        </ul>
    </nav>

    <div class="container">
        <h1>商品列表</h1>
        
        <div class="search-box">
            <form action="products/search" method="get">
                <input type="text" name="keyword" placeholder="搜索商品...">
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>
        
        <table class="table">
            <tr>
                <th>ID</th>
                <th>商品图片</th>
                <th>名称</th>
                <th>价格</th>
                <th>库存</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${products}" var="product">
                <tr>
                    <td>${product.id}</td>
                    <td>
                        <img src="../images/products/${product.id}.jpg" alt="${product.name}" 
                             style="width: 50px; height: 50px;">
                    </td>
                    <td>${product.name}</td>
                    <td>￥${product.price}</td>
                    <td>${product.stock}</td>
                    <td>
                        <a href="products/detail?id=${product.id}" class="btn btn-secondary">详情</a>
                        <a href="javascript:void(0)" onclick="addToCart(${product.id})" 
                           class="btn btn-primary">加入购物车</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <script>
    function addToCart(productId) {
        fetch('cart/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `productId=${productId}&quantity=1`
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('添加成功！');
            } else {
                alert('添加失败：' + data.message);
            }
        })
        .catch(error => {
            alert('添加失败，请重试');
        });
    }
    </script>
</body>
</html> 