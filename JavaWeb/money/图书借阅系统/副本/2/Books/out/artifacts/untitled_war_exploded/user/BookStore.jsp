<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书商城</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 20px;
            color: #2d3748;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-box {
            margin-bottom: 20px;
        }

        .search-form {
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            display: flex;
            gap: 10px;
        }

        .category-select {
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            min-width: 120px;
        }

        .search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
        }

        .search-btn {
            padding: 8px 20px;
            background: #4299e1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }

        .book-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.2s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .book-card:hover {
            transform: translateY(-5px);
        }

        .book-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .book-info {
            padding: 15px;
        }

        .book-title {
            font-size: 16px;
            margin-bottom: 8px;
            color: #2d3748;
        }

        .book-meta {
            font-size: 14px;
            color: #718096;
            margin-bottom: 8px;
        }

        .book-price {
            color: #e53e3e;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .buy-btn {
            display: block;
            width: 100%;
            padding: 8px 0;
            background: #4299e1;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }

        .buy-btn.disabled {
            background: #cbd5e0;
            cursor: not-allowed;
        }

        .my-orders-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            background: #4299e1;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .logout-btn {
            padding: 8px 16px;
            background: #f1f5f9;
            color: #64748b;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <h2 class="page-title">图书商城</h2>
            </div>
            <div class="header-right">
                <span class="welcome-text">欢迎，${sessionScope.user.username}</span>
                <a href="/LogoutServlet" class="logout-btn" onclick="return confirm('确定要退出吗？')">
                    <i class="fas fa-sign-out-alt"></i>
                    退出
                </a>
            </div>
        </div>
        
        <div class="header-actions">
            <div class="search-box">
                <form action="/IndexBookServletForUser" method="get" class="search-form">
                    <select name="categoryId" class="category-select">
                        <option value="">所有分类</option>
                        <c:forEach items="${categoryList}" var="category">
                            <option value="${category.categoryId}" ${param.categoryId eq category.categoryId ? 'selected' : ''}>
                                ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                    <input type="text" 
                           class="search-input" 
                           name="keyword" 
                           placeholder="搜索图书名称、作者或出版社..."
                           value="${param.keyword}">
                    <button type="submit" class="search-btn">搜索</button>
                </form>
            </div>
            <a href="/MyOrdersServlet" class="my-orders-btn">
                <i class="fas fa-shopping-cart"></i>
                我的订单
            </a>
        </div>

        <div class="book-grid">
            <c:forEach items="${sessionScope.bookList}" var="book">
                <div class="book-card">
                    <img src="${book.image}" alt="${book.bookname}" class="book-image">
                    <div class="book-info">
                        <h3 class="book-title">${book.bookname}</h3>
                        <div class="book-meta">出版社：${book.publish}</div>
                        <div class="book-price">￥${book.price}</div>
                        <div class="book-stock">库存：${book.stock}本</div>
                        <c:choose>
                            <c:when test="${book.stock > 0}">
                                <a href="/BuyBookServlet?bookid=${book.bookid}" 
                                   class="buy-btn"
                                   onclick="return confirm('确定要购买《${book.bookname}》吗？')">
                                    立即购买
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" class="buy-btn disabled">
                                    暂时缺货
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html> 