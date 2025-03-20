<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品管理 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <style>
        /* 空状态提示 */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            background: #f8f9fa;
            border-radius: 8px;
            margin: 20px 0;
        }
        
        .empty-state .icon {
            font-size: 48px;
            margin-bottom: 16px;
            color: #ccc;
        }
        
        .empty-state h3 {
            color: #666;
            font-size: 18px;
            margin-bottom: 8px;
        }
        
        .empty-state p {
            color: #999;
            font-size: 14px;
            margin-bottom: 16px;
        }
        
        /* 操作提示 */
        .operation-tips {
            background: #f5f9ff;
            border: 1px solid #e3f2fd;
            border-radius: 8px;
            padding: 15px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .operation-tips .icon {
            color: #1976d2;
            font-size: 20px;
        }
        
        .operation-tips .text {
            color: #666;
            font-size: 14px;
        }
        
        /* 操作按钮样式优化 */
        .btn-group {
            display: flex;
            gap: 8px;
        }
        
        .btn-edit, .btn-delete {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            transition: all 0.3s;
        }
        
        .btn-edit {
            background: #f5f9ff;
            color: #1976d2;
            border: 1px solid #e3f2fd;
        }
        
        .btn-edit:hover {
            background: #e3f2fd;
        }
        
        .btn-delete {
            background: #fff5f5;
            color: #dc3545;
            border: 1px solid #ffe3e3;
        }
        
        .btn-delete:hover {
            background: #ffe3e3;
        }
        
        /* 库存状态标签 */
        .stock-status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
        }
        
        .stock-normal {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .stock-low {
            background: #fff3e0;
            color: #ef6c00;
        }
        
        .stock-out {
            background: #ffebee;
            color: #c62828;
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
                    <span>首页</span> / <span>商品管理</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../../logout" class="logout">退出</a>
                </div>
            </header>

            <div class="content">
                <!-- 操作提示 -->
                <div class="operation-tips">
                    <span class="icon">💡</span>
                    <div class="text">
                        提示：您可以通过搜索框查找商品，或点击"添加商品"来新增商品。库存不足的商品会有特殊标记。
                    </div>
                </div>

                <div class="toolbar">
                    <form action="list" method="get" class="search-form">
                        <div class="search-group">
                            <input type="text" name="keyword" value="${param.keyword}" placeholder="商品名称">
                            <select name="categoryId">
                                <option value="">所有分类</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <button type="submit" class="btn btn-info">搜索</button>
                        </div>
                    </form>
                    <button class="btn btn-primary" onclick="location.href='add'">添加商品</button>
                </div>

                <!-- 根据是否有数据显示不同内容 -->
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="empty-state">
                            <div class="icon">📦</div>
                            <h3>暂无商品数据</h3>
                            <p>您可以点击"添加商品"按钮来添加新的商品</p>
                            <button class="btn btn-primary" onclick="location.href='add'">添加商品</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-container">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>图片</th>
                                        <th>商品名称</th>
                                        <th>价格</th>
                                        <th>库存</th>
                                        <th>分类</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${products}" var="product">
                                        <tr>
                                            <td>${product.id}</td>
                                            <td>
                                                <img src="${product.image}" alt="${product.name}" class="product-thumb">
                                            </td>
                                            <td>${product.name}</td>
                                            <td>￥${product.price}</td>
                                            <td>
                                                <span class="stock-status ${product.stock > 20 ? 'stock-normal' : 
                                                    (product.stock > 0 ? 'stock-low' : 'stock-out')}">
                                                    ${product.stock > 20 ? '库存充足' : 
                                                      (product.stock > 0 ? '库存不足' : '无库存')}
                                                    (${product.stock})
                                                </span>
                                            </td>
                                            <td>${product.categoryId}</td>
                                            <td>
                                                <div class="btn-group">
                                                    <a href="edit?id=${product.id}" class="btn btn-edit">编辑</a>
                                                    <a href="javascript:void(0)" onclick="deleteProduct(${product.id})" 
                                                       class="btn btn-delete">删除</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <script>
        function deleteProduct(id) {
            if (confirm('确定要删除这个商品吗？')) {
                location.href = 'delete?id=' + id;
            }
        }
    </script>
</body>
</html> 