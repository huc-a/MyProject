<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shop.model.User" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>购物车</title>
    <style>
        .cart-container {
            width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .cart-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .cart-item img {
            width: 80px;
            height: 80px;
            margin-right: 20px;
        }
        .item-info {
            flex: 1;
        }
        .item-price {
            color: #f40;
            font-size: 18px;
            margin: 0 20px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-control button {
            padding: 5px 10px;
        }
        .quantity-control input {
            width: 50px;
            text-align: center;
            margin: 0 10px;
        }
        .total-price {
            text-align: right;
            margin-top: 20px;
            font-size: 20px;
        }
        .checkout-btn {
            float: right;
            margin-top: 10px;
            padding: 10px 20px;
            background: #f40;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <h2>我的购物车</h2>
        <div id="cartItems">
            <!-- 购物车项目将通过JavaScript动态加载 -->
        </div>
        <div class="total-price">
            总计：<span id="totalPrice">¥0.00</span>
        </div>
        <button class="checkout-btn" onclick="checkout()">结算</button>
    </div>

    <script>
        // 页面加载时获取购物车数据
        window.onload = function() {
            loadCartItems();
        };

        function loadCartItems() {
            fetch('api/cart/list', {
                credentials: 'include'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    displayCartItems(data.items);
                    updateTotalPrice(data.items);
                } else {
                    alert(data.message || '获取购物车失败');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('获取购物车失败，请稍后重试');
            });
        }

        function displayCartItems(items) {
            const cartContainer = document.getElementById('cartItems');
            cartContainer.innerHTML = '';
            
            items.forEach(item => {
                cartContainer.innerHTML += `
                    <div class="cart-item">
                        <img src="${item.imageUrl}" alt="${item.name}">
                        <div class="item-info">
                            <h3>${item.name}</h3>
                            <p>${item.description}</p>
                        </div>
                        <div class="item-price">¥${item.price.toFixed(2)}</div>
                        <div class="quantity-control">
                            <button onclick="updateQuantity(${item.cartItemId}, ${item.quantity - 1})">-</button>
                            <input type="number" value="${item.quantity}" min="1" 
                                onchange="updateQuantity(${item.cartItemId}, this.value)">
                            <button onclick="updateQuantity(${item.cartItemId}, ${item.quantity + 1})">+</button>
                        </div>
                        <button onclick="removeFromCart(${item.cartItemId})">删除</button>
                    </div>
                `;
            });
        }

        function updateTotalPrice(items) {
            const total = items.reduce((sum, item) => sum + item.price * item.quantity, 0);
            document.getElementById('totalPrice').textContent = `¥${total.toFixed(2)}`;
        }

        function updateQuantity(cartItemId, newQuantity) {
            if (newQuantity < 1) return;
            
            fetch('api/cart/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    cartItemId: cartItemId,
                    quantity: newQuantity
                }),
                credentials: 'include'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    loadCartItems();
                } else {
                    alert(data.message || '更新数量失败');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('更新数量失败，请稍后重试');
            });
        }

        function removeFromCart(cartItemId) {
            if (!confirm('确定要删除这个商品吗？')) return;
            
            fetch('api/cart/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    cartItemId: cartItemId
                }),
                credentials: 'include'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    loadCartItems();
                } else {
                    alert(data.message || '删除失败');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('删除失败，请稍后重试');
            });
        }

        function checkout() {
            window.location.href = 'pages/order/checkout.jsp';
        }
    </script>
</body>
</html> 