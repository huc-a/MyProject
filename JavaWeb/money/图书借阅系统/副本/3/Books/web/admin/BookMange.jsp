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

        .book-table {
            width: 100%;
            border-collapse: collapse;
        }

        .book-table th {
            background: #f8f9fa;
            padding: 12px 20px;
            text-align: left;
            font-weight: 500;
            color: #4a5568;
            font-size: 14px;
            border-bottom: 2px solid #e2e8f0;
        }

        .book-table td {
            padding: 12px 20px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 15px;
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

        .book-details h3 {
            font-size: 15px;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .book-meta {
            color: #718096;
            font-size: 13px;
        }

        .stock-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .stock-normal { 
            background: rgba(72, 187, 120, 0.1);
            color: #48bb78;
        }

        .stock-low {
            background: rgba(246, 173, 85, 0.1);
            color: #ed8936;
        }

        .stock-out {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
        }

        .price {
            font-weight: 500;
            color: #e53e3e;
        }

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
                    <input type="text" class="search-input" placeholder="搜索图书..." onkeyup="searchTable(this.value)">
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
                <table class="book-table">
                    <thead>
                        <tr>
                            <th>图书信息</th>
                            <th>价格</th>
                            <th>库存状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.bookList}" var="book">
                            <tr>
                                <td>
                                    <div class="book-info">
                                        <div class="book-cover">
                                            <img src="${book.image}" alt="${book.bookname}">
                                        </div>
                                        <div class="book-details">
                                            <h3>${book.bookname}</h3>
                                            <div class="book-meta">${book.publish}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="price">￥${book.price}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${book.stock > 10}">
                                            <span class="stock-badge stock-normal">库存充足 (${book.stock})</span>
                                        </c:when>
                                        <c:when test="${book.stock > 0}">
                                            <span class="stock-badge stock-low">库存不足 (${book.stock})</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-badge stock-out">缺货</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
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
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
    function searchTable(keyword) {
        const tbody = document.querySelector('.book-table tbody');
        const rows = tbody.getElementsByTagName('tr');
        keyword = keyword.toLowerCase();
        
        for (let row of rows) {
            const title = row.querySelector('.book-details h3').textContent.toLowerCase();
            const publish = row.querySelector('.book-meta').textContent.toLowerCase();
            
            if (title.includes(keyword) || publish.includes(keyword)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }
    </script>
</body>
</html>
