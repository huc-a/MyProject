<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑商品 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../../static/css/admin.css">
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
                    <li><a href="list" class="active"><i class="icon">📦</i>商品管理</a></li>
                    <li><a href="../category/list"><i class="icon">📑</i>分类管理</a></li>
                    <li><a href="../order/list"><i class="icon">📝</i>订单管理</a></li>
                    <li><a href="../user/list"><i class="icon">👥</i>用户管理</a></li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span> / <span>商品管理</span> / <span>编辑商品</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../../logout" class="logout">退出</a>
                </div>
            </header>

            <div class="content">
                <form action="edit" method="post" enctype="multipart/form-data" class="form">
                    <input type="hidden" name="id" value="${product.id}">
                    <div class="form-group">
                        <label for="name">商品名称</label>
                        <input type="text" id="name" name="name" value="${product.name}" required>
                    </div>
                    <div class="form-group">
                        <label for="description">商品描述</label>
                        <textarea id="description" name="description" rows="4">${product.description}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="price">价格</label>
                        <input type="number" id="price" name="price" step="0.01" value="${product.price}" required>
                    </div>
                    <div class="form-group">
                        <label for="stock">库存</label>
                        <input type="number" id="stock" name="stock" value="${product.stock}" required>
                    </div>
                    <div class="form-group">
                        <label for="categoryId">分类</label>
                        <select id="categoryId" name="categoryId" required>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}" ${category.id == product.categoryId ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="image">商品图片</label>
                        <input type="file" id="image" name="image" accept="image/*">
                        <c:if test="${not empty product.image}">
                            <div class="current-image">
                                <img src="${product.image}" alt="${product.name}" class="product-thumb">
                                <span>当前图片</span>
                            </div>
                        </c:if>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">保存</button>
                        <a href="list" class="btn">返回</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 