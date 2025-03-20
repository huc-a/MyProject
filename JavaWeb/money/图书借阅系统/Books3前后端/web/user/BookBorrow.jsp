<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书借阅</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }

        .page-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .search-filter-area {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 25px;
        }

        .search-box {
            display: flex;
            gap: 12px;
            margin-bottom: 15px;
        }

        .search-form {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .search-input {
            flex: 1;
            min-width: 200px;
            padding: 10px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
            outline: none;
        }

        .category-select {
            width: 180px;
            flex-shrink: 0;
            padding: 10px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%234a5568' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 35px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }

        .category-select:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
            outline: none;
        }

        .search-btn {
            flex-shrink: 0;
            padding: 10px 24px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .search-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
            transform: translateY(-1px);
        }

        .search-btn i {
            font-size: 16px;
        }

        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .book-card {
            display: flex;
            flex-direction: column;
            height: 100%;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .book-cover {
            position: relative;
            width: 100%;
            padding-top: 140%; /* 设置固定的宽高比 10:14 */
            background-color: #f7fafc;
            overflow: hidden;
        }

        .book-cover img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; /* 保持图片比例并填充容器 */
            transition: transform 0.3s ease;
        }

        .book-cover img:not([src]), 
        .book-cover img[src=""], 
        .book-cover img[src="null"] {
            visibility: hidden;
        }

        .book-cover img:not([src])::after, 
        .book-cover img[src=""]::after, 
        .book-cover img[src="null"]::after {
            content: '暂无图片';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #a0aec0;
            font-size: 14px;
            visibility: visible;
        }

        .book-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 15px;
            background: white;
        }

        .book-title {
            font-size: 16px;
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 8px;
            /* 文本超出显示省略号 */
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            line-height: 1.4;
            max-height: 2.8em;
        }

        .book-meta {
            color: #718096;
            font-size: 14px;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .book-price {
            color: #e53e3e;
            font-size: 16px;
            font-weight: 500;
            margin: 10px 0;
        }

        .borrow-btn {
            margin-top: auto;
            display: block;
            width: 100%;
            padding: 10px 0;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-size: 14px;
            font-weight: 500;
        }

        .borrow-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
            transform: translateY(-1px);
        }

        .borrow-btn.disabled {
            background: #cbd5e0;
            cursor: not-allowed;
        }

        .status-tag {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            margin-left: 5px;
        }

        .status-available {
            background-color: #c6f6d5;
            color: #2f855a;
        }

        .status-borrowed {
            background-color: #fed7d7;
            color: #c53030;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .borrow-records-btn {
            margin-left: auto;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
        }

        .borrow-records-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.3);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
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
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(245, 101, 101, 0.2);
        }

        .logout-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(245, 101, 101, 0.3);
        }

        .logout-btn i {
            font-size: 16px;
        }

        .category-tag {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            background-color: #ebf4ff;
            color: #4299e1;
            border-radius: 16px;
            font-size: 12px;
            font-weight: 500;
            margin-left: 8px;
            transition: all 0.3s ease;
        }

        .category-tag:hover {
            background-color: #4299e1;
            color: white;
        }

        .filter-info {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #718096;
            font-size: 13px;
            margin-top: 10px;
        }

        .filter-info i {
            color: #4299e1;
        }

        .actions-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <h2 class="page-title">图书借阅</h2>
            </div>
            <div class="header-right">
                <span class="welcome-text">欢迎，${sessionScope.user.username}</span>
                <a href="/LogoutServlet" class="logout-btn" onclick="return confirm('确定要退出吗？')">
                    <i class="fas fa-sign-out-alt"></i>
                    退出
                </a>
            </div>
        </div>

        <div class="actions-area">
            <div class="search-filter-area">
                <form action="/IndexBookServletForUser" method="get" class="search-form">
                    <input type="text" 
                           class="search-input" 
                           name="keyword" 
                           placeholder="搜索图书名称、作者或出版社..."
                           value="${param.keyword}">
                    <select name="category" class="category-select">
                        <option value="">全部分类</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.category_id}" 
                                    ${param.category == category.category_id ? 'selected' : ''}>
                                ${category.category_name}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i>
                        搜索
                    </button>
                </form>

                <c:if test="${not empty param.keyword || not empty param.category}">
                    <div class="filter-info">
                        <i class="fas fa-filter"></i>
                        当前筛选：
                        <c:if test="${not empty param.keyword}">
                            关键词"${param.keyword}"
                        </c:if>
                        <c:if test="${not empty param.category}">
                            <c:forEach items="${categories}" var="category">
                                <c:if test="${param.category == category.category_id}">
                                    分类"${category.category_name}"
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:if>
            </div>
            <a href="/MyBorrowsServlet" class="borrow-records-btn">
                <i class="fas fa-book-reader"></i>
                我的借阅记录
            </a>
        </div>

        <div class="book-grid">
            <c:forEach items="${sessionScope.bookList}" var="book">
                <div class="book-card" data-category="${book.category_id}">
                    <div class="book-cover">
                        <img src="${book.image}" alt="${book.bookname}" 
                             onerror="this.style.display='none';this.parentElement.innerHTML='<div style=\'position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);color:#a0aec0;font-size:14px;\'>暂无图片</div>'">
                    </div>
                    <div class="book-info">
                        <h3 class="book-title">${book.bookname}</h3>
                        <div class="book-meta">
                            <span>出版社：${book.publish}</span>
                            <span class="category-tag">${book.category_name}</span>
                        </div>
                        <div class="book-price">￥${book.price}</div>
                        <a href="/BorrowBookServlet?bookid=${book.bookid}" 
                           class="borrow-btn"
                           onclick="return confirm('确定要借阅《${book.bookname}》吗？')">
                            <i class="fas fa-book-reader"></i>
                            借阅
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        // 分类筛选功能
        document.getElementById('categoryFilter').addEventListener('change', function() {
            const categoryId = this.value;
            const bookCards = document.querySelectorAll('.book-card');
            
            bookCards.forEach(card => {
                const cardCategoryId = card.getAttribute('data-category');
                if (!categoryId || cardCategoryId === categoryId) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        // 修改现有的搜索功能，结合分类筛选
        document.querySelector('.search-btn').addEventListener('click', function() {
            const searchText = document.querySelector('.search-input').value.toLowerCase();
            const categoryId = document.getElementById('categoryFilter').value;
            const bookCards = document.querySelectorAll('.book-card');
            
            bookCards.forEach(card => {
                const title = card.querySelector('.book-title').textContent.toLowerCase();
                const info = card.querySelector('.book-meta').textContent.toLowerCase();
                const cardCategoryId = card.getAttribute('data-category');
                
                const matchesSearch = title.includes(searchText) || info.includes(searchText);
                const matchesCategory = !categoryId || cardCategoryId === categoryId;
                
                if (matchesSearch && matchesCategory) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html> 