<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书管理</title>
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
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .header {
            padding: 20px;
            background: #f8f9fa;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 20px;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #7AB87A;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 8px 15px 8px 35px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            width: 250px;
            font-size: 14px;
        }

        .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .add-btn {
            background: #7AB87A;
            color: white;
            padding: 8px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .add-btn:hover {
            background: #68A568;
        }

        .book-list {
            padding: 20px;
        }

        .book-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .book-item:hover {
            background: #f0f2f5;
        }

        .book-info {
            flex: 1;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .book-cover {
            width: 60px;
            height: 80px;
            border-radius: 4px;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-details {
            flex: 1;
        }

        .book-name {
            font-size: 16px;
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .book-meta {
            color: #718096;
            font-size: 13px;
            display: flex;
            gap: 15px;
        }

        .book-price {
            min-width: 80px;
            text-align: right;
            font-weight: 500;
            color: #e53e3e;
        }

        .stock-status {
            min-width: 100px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .stock-normal { background: #d4edda; color: #155724; }
        .stock-low { background: #fff3cd; color: #856404; }
        .stock-out { background: #f8d7da; color: #721c24; }

        .actions {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-edit {
            background: rgba(122, 184, 122, 0.1);
            color: #7AB87A;
        }

        .btn-edit:hover {
            background: rgba(122, 184, 122, 0.2);
        }

        .btn-delete {
            background: rgba(229, 62, 62, 0.1);
            color: #e53e3e;
        }

        .btn-delete:hover {
            background: rgba(229, 62, 62, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }

        .empty-state i {
            font-size: 48px;
            color: #a0aec0;
            margin-bottom: 20px;
        }

        .empty-state p {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 class="page-title">
                <i class="fas fa-book"></i>
                图书管理
            </h2>
            <div class="header-actions">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="搜索图书..." onkeyup="searchBooks(this.value)">
                </div>
                <a href="admin/AddBook.jsp" class="add-btn">
                    <i class="fas fa-plus"></i>
                    添加图书
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty sessionScope.bookList}">
                <div class="empty-state">
                    <i class="fas fa-book"></i>
                    <p>暂无图书数据</p>
                    <a href="admin/AddBook.jsp" class="add-btn">添加第一本图书</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="book-list">
                    <c:forEach items="${sessionScope.bookList}" var="book">
                        <div class="book-item">
                            <div class="book-info">
                                <div class="book-cover">
                                    <img src="${book.image}" alt="${book.bookname}">
                                </div>
                                <div class="book-details">
                                    <div class="book-name">${book.bookname}</div>
                                    <div class="book-meta">
                                        <span>出版社：${book.publish}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="book-price">￥${book.price}</div>

                            <div class="stock-status">
                                <c:choose>
                                    <c:when test="${book.stock > 10}">
                                        <span class="status-badge stock-normal">库存充足 (${book.stock})</span>
                                    </c:when>
                                    <c:when test="${book.stock > 0}">
                                        <span class="status-badge stock-low">库存不足 (${book.stock})</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge stock-out">缺货</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="actions">
                                <a href="/UpdateBookServlet?id=${book.bookid}" class="btn btn-edit">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="/DelBookServlet?id=${book.bookid}" 
                                   class="btn btn-delete"
                                   onclick="return confirm('确定要删除《${book.bookname}》吗？')">
                                    <i class="fas fa-trash-alt"></i> 删除
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchBooks(keyword) {
        const books = document.querySelectorAll('.book-item');
        keyword = keyword.toLowerCase();
        
        books.forEach(book => {
            const bookInfo = book.querySelector('.book-details').textContent.toLowerCase();
            
            if (bookInfo.includes(keyword)) {
                book.style.display = '';
            } else {
                book.style.display = 'none';
            }
        });
    }
    </script>
</body>
</html>
