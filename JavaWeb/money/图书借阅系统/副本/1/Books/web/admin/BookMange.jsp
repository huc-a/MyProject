<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/4
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
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
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            color: #333;
            font-size: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #4299e1;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.2);
        }

        .btn-edit {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
        }

        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .data-table th, 
        .data-table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table th {
            background: #f8fafc;
            color: #4a5568;
            font-weight: 500;
            white-space: nowrap;
        }

        .data-table tr:hover {
            background-color: #f8fafc;
        }

        .data-table td {
            color: #2d3748;
            vertical-align: middle;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .book-cover {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .book-details {
            flex: 1;
        }

        .book-name {
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .book-meta {
            color: #718096;
            font-size: 13px;
        }

        .price {
            color: #e53e3e;
            font-weight: 500;
        }

        .stock {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .stock-normal {
            background-color: #c6f6d5;
            color: #2f855a;
        }

        .stock-low {
            background-color: #feebc8;
            color: #c05621;
        }

        .stock-empty {
            background-color: #fed7d7;
            color: #c53030;
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            max-width: 300px;
        }

        .search-input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
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
            <div class="action-buttons">
                <a href="admin/AddBook.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    添加图书
                </a>
            </div>
        </div>

        <div class="search-box">
            <input type="text" class="search-input" placeholder="搜索图书名称、出版社..." 
                   onkeyup="searchTable(this.value)">
        </div>

        <div class="table-container">
            <table class="data-table" id="bookTable">
                <thead>
                    <tr>
                        <th>图书信息</th>
                        <th>价格</th>
                        <th>库存</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sessionScope.bookList}" var="book">
                        <tr>
                            <td>
                                <div class="book-info">
                                    <img src="${book.image}" alt="${book.bookname}" class="book-cover">
                                    <div class="book-details">
                                        <div class="book-name">${book.bookname}</div>
                                        <div class="book-meta">出版社：${book.publish}</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="price">￥${book.price}</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${book.stock > 20}">
                                        <span class="stock stock-normal">${book.stock}本</span>
                                    </c:when>
                                    <c:when test="${book.stock > 0}">
                                        <span class="stock stock-low">${book.stock}本</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="stock stock-empty">无库存</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="/UpdateBookServlet?id=${book.bookid}" 
                                       class="btn btn-edit">
                                        <i class="fas fa-edit"></i>
                                        修改
                                    </a>
                                    <a href="/DelBookServlet?id=${book.bookid}" 
                                       class="btn btn-delete"
                                       onclick="return confirm('确定要删除《${book.bookname}》吗？')">
                                        <i class="fas fa-trash-alt"></i>
                                        删除
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
    function searchTable(keyword) {
        const table = document.getElementById('bookTable');
        const rows = table.getElementsByTagName('tr');
        
        keyword = keyword.toLowerCase();
        
        // 从索引1开始,跳过表头
        for (let i = 1; i < rows.length; i++) {
            const bookNameElem = rows[i].querySelector('.book-name');
            const publishElem = rows[i].querySelector('.book-meta');
            
            if (bookNameElem && publishElem) {
                const bookName = bookNameElem.textContent.toLowerCase();
                const publish = publishElem.textContent.toLowerCase();
                
                if (bookName.includes(keyword) || publish.includes(keyword)) {
                    rows[i].style.display = '';
                } else {
                    rows[i].style.display = 'none';
                }
            }
        }
    }
    </script>
</body>
</html>
