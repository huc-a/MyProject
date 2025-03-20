<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>书香城 - 图书借阅</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .nav {
            background: #fff;
            padding: 15px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-links {
            display: flex;
            gap: 20px;
        }
        
        .nav-links a {
            color: #666;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
        }
        
        .nav-links a:hover {
            background-color: #f0f0f0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
        
        .search-box {
            margin-bottom: 20px;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
        }
        
        .search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .search-btn {
            padding: 8px 20px;
            background-color: #7AB87A;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .search-btn:hover {
            background-color: #68a468;
        }
        
        .reset-btn {
            padding: 8px 20px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
        }
        
        .reset-btn:hover {
            background-color: #5a6268;
        }
        
        .book-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .book-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 8px;
            overflow: hidden;
            transition: transform .2s;
        }
        
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,.1);
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
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .book-details {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
        }
        
        .borrow-btn {
            display: block;
            width: 100%;
            padding: 8px;
            background-color: #7AB87A;
            color: white;
            text-align: center;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        
        .borrow-btn:hover {
            background-color: #68a468;
        }
        
        .borrowed {
            background-color: #95a5a6;
            cursor: not-allowed;
        }
        
        .no-results {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="nav">
        <h2>图书借阅</h2>
        <div class="nav-links">
            <a href="/BorrowBookServlet">借阅图书</a>
            <a href="/MyBooksServlet">我的借阅</a>
            <a href="/LogoutServlet">退出登录</a>
        </div>
    </div>
    
    <div class="container">
        <div class="search-box">
            <form action="/BorrowBookServlet" method="get" class="search-form">
                <input type="text" name="keyword" placeholder="输入书名或出版社搜索..." value="${param.keyword}" class="search-input">
                <button type="submit" class="search-btn">搜索</button>
                <c:if test="${not empty param.keyword}">
                    <a href="/BorrowBookServlet" class="reset-btn">重置</a>
                </c:if>
            </form>
        </div>
        
        <c:if test="${empty bookList && not empty param.keyword}">
            <div class="no-results">
                没有找到匹配的图书，请尝试其他关键词
            </div>
        </c:if>
        
        <div class="book-list">
            <c:forEach var="book" items="${bookList}">
                <div class="book-card">
                    <img src="${book.image}" alt="${book.bookname}" class="book-image">
                    <div class="book-info">
                        <div class="book-title">${book.bookname}</div>
                        <div class="book-details">
                            <p>出版社：${book.publish}</p>
                            <p>价格：￥${book.price}</p>
                        </div>
                        <c:choose>
                            <c:when test="${book.borrowed}">
                                <button class="borrow-btn borrowed" disabled>已借出</button>
                            </c:when>
                            <c:otherwise>
                                <a href="BorrowBookServlet?bookId=${book.bookid}" class="borrow-btn">借阅</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html> 