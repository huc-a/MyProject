<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.name} - 商品详情</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <nav class="nav">
        <ul>
            <li><a href="../">首页</a></li>
            <li><a href="../products">商品列表</a></li>
            <li><a href="../cart">购物车</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="product-detail">
            <div class="product-image">
                <img src="../images/products/${product.id}.jpg" alt="${product.name}">
            </div>
            
            <div class="product-info">
                <h1>${product.name}</h1>
                <p class="price">￥${product.price}</p>
                <p class="stock">库存：${product.stock}件</p>
                
                <form id="addToCartForm" class="add-to-cart-form">
                    <input type="hidden" name="productId" value="${product.id}">
                    <div class="quantity-selector">
                        <label for="quantity">数量：</label>
                        <button type="button" onclick="updateQuantity(-1)">-</button>
                        <input type="number" id="quantity" name="quantity" value="1" 
                               min="1" max="${product.stock}">
                        <button type="button" onclick="updateQuantity(1)">+</button>
                    </div>
                    <button type="submit" class="btn btn-primary">加入购物车</button>
                </form>
            </div>
            
            <div class="product-description">
                <h2>商品描述</h2>
                <p>${product.description}</p>
            </div>
        </div>
    </div>

    <script>
    function updateQuantity(delta) {
        const input = document.getElementById('quantity');
        const newValue = parseInt(input.value) + delta;
        if (newValue >= 1 && newValue <= ${product.stock}) {
            input.value = newValue;
        }
    }

    document.getElementById('addToCartForm').onsubmit = function(e) {
        e.preventDefault();
        const formData = new FormData(this);
        
        fetch('../cart/add', {
            method: 'POST',
            body: new URLSearchParams(formData)
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
    };
    </script>
</body>
</html> 