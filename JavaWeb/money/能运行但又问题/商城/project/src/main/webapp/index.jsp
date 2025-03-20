<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shop.model.User" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>网上商城 - 首页</title>
    <style>
        .container {
            width: 1200px;
            margin: 0 auto;
        }
        .header {
            background: #333;
            color: white;
            padding: 10px 0;
        }
        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }
        .products {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px 0;
        }
        .product-item {
            width: 280px;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 8px;
            transition: transform 0.2s;
        }
        .product-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .product-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
        }
        .product-price {
            color: #f40;
            font-size: 20px;
            font-weight: bold;
        }
        .product-description {
            color: #666;
            font-size: 14px;
            margin: 8px 0;
        }
        .stock-info {
            color: #999;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="nav">
                <h1>网上商城</h1>
                <div>
                    <a href="index.jsp">首页</a>
                    <%
                        User user = (User)session.getAttribute("user");
                        if(user == null) {
                    %>
                        <a href="pages/user/login.jsp">登录</a>
                        <a href="pages/user/register.jsp">注册</a>
                    <%
                        } else {
                    %>
                        <span>欢迎，<%=user.getUsername()%></span>
                        <a href="api/user/logout">退出</a>
                    <%
                        }
                    %>
                    <a href="pages/cart/cart.jsp">购物车</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="products">
            <div class="product-item">
                <img src="static/images/iphone15.jpg" alt="iPhone 15">
                <h3>iPhone 15</h3>
                <p class="product-description">苹果最新旗舰手机，A17芯片</p>
                <p class="product-price">¥6999.00</p>
                <p class="stock-info">库存：100件</p>
                <button onclick="addToCart(1)">加入购物车</button>
            </div>
            <div class="product-item">
                <img src="static/images/mate60.jpg" alt="华为 Mate 60">
                <h3>华为 Mate 60</h3>
                <p class="product-description">华为新一代旗舰手机</p>
                <p class="product-price">¥6299.00</p>
                <p class="stock-info">库存：50件</p>
                <button onclick="addToCart(2)">加入购物车</button>
            </div>
            <div class="product-item">
                <img src="static/images/macbook.jpg" alt="MacBook Pro">
                <h3>MacBook Pro</h3>
                <p class="product-description">M2芯片版本MacBook Pro</p>
                <p class="product-price">¥12999.00</p>
                <p class="stock-info">库存：30件</p>
                <button onclick="addToCart(3)">加入购物车</button>
            </div>
            <div class="product-item">
                <img src="static/images/airpods.jpg" alt="AirPods Pro">
                <h3>AirPods Pro</h3>
                <p class="product-description">主动降噪无线耳机</p>
                <p class="product-price">¥1999.00</p>
                <p class="stock-info">库存：200件</p>
                <button onclick="addToCart(4)">加入购物车</button>
            </div>
            <div class="product-item">
                <img src="static/images/miband.jpg" alt="小米手环8">
                <h3>小米手环8</h3>
                <p class="product-description">智能运动手环</p>
                <p class="product-price">¥299.00</p>
                <p class="stock-info">库存：500件</p>
                <button onclick="addToCart(5)">加入购物车</button>
            </div>
        </div>
    </div>

    <script>
        function addToCart(productId) {
            fetch(`api/cart/add?productId=${productId}`, {
                method: 'POST',
                credentials: 'include'
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('商品已成功添加到购物车！');
                } else {
                    alert('添加失败：' + data.message);
                }
            })
            .catch(error => {
                alert('添加失败，请稍后重试');
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html> 