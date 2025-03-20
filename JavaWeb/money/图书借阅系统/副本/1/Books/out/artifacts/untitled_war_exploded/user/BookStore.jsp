<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书商城</title>
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
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            color: #333;
            font-size: 24px;
        }

        .header-actions {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-input {
            width: 300px;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-btn {
            padding: 8px 20px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .my-orders-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            background: #7AB87A;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .book-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .book-card:hover {
            transform: translateY(-5px);
        }

        .book-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        .book-info {
            padding: 15px;
        }

        .book-title {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 8px;
            color: #2d3748;
        }

        .book-meta {
            color: #718096;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .book-price {
            color: #e53e3e;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .book-stock {
            color: #718096;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .buy-btn {
            display: block;
            width: 100%;
            padding: 8px 0;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .buy-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
        }

        .buy-btn.disabled {
            background: #cbd5e0;
            cursor: not-allowed;
        }

        .welcome-text {
            color: #4a5568;
            font-size: 14px;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            background: rgba(0, 0, 0, 0.1);
            color: #4a5568;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: rgba(0, 0, 0, 0.2);
        }

        .category-nav {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px 0;
            border-bottom: 1px solid #e2e8f0;
            overflow-x: auto;
            scrollbar-width: none;
            -ms-overflow-style: none;
        }
        
        .category-nav::-webkit-scrollbar {
            display: none;
        }
        
        .category-item {
            padding: 6px 16px;
            border-radius: 20px;
            color: #4a5568;
            text-decoration: none;
            font-size: 14px;
            white-space: nowrap;
            transition: all 0.3s ease;
        }
        
        .category-item:hover {
            background: #edf2f7;
        }
        
        .category-item.active {
            background: #4299e1;
            color: white;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        
        <div class="category-nav">
            <a href="/IndexBookServletForUser" class="category-item ${empty param.categoryId ? 'active' : ''}">
                全部
            </a>
            <c:forEach items="${categoryList}" var="category">
                <a href="/IndexBookServletForUser?categoryId=${category.categoryId}" 
                   class="category-item ${param.categoryId eq category.categoryId ? 'active' : ''}">
                    ${category.categoryName}
                </a>
            </c:forEach>
        </div>
        
        <div class="header-actions">
            <div class="search-box">
                <form action="/IndexBookServletForUser" method="get" class="search-form">
                    <input type="text" class="search-input" name="keyword" placeholder="搜索图书名称、作者或出版社...">
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