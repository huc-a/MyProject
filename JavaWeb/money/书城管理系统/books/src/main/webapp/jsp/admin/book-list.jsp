<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>图书管理 - 书城管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
        }
        
        .container {
            margin-top: 130px;
            padding: 20px;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .action-bar {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .search-box {
            display: flex;
            gap: 10px;
        }
        
        .search-box input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 200px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background-color: #007bff;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .btn-success {
            background-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .book-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .book-table th,
        .book-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .book-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: #333;
        }
        
        .book-table tr:hover {
            background-color: #f8f9fa;
        }
        
        .book-cover {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85rem;
        }
        
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        
        .pagination a {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #007bff;
        }
        
        .pagination a:hover {
            background-color: #f8f9fa;
        }
        
        .pagination .active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="action-bar">
            <div class="search-box">
                <input type="text" placeholder="搜索图书..." id="searchInput">
                <button class="btn btn-primary" onclick="searchBooks()">搜索</button>
            </div>
            <button class="btn btn-success" onclick="showAddBookModal()">添加图书</button>
        </div>
        
        <table class="book-table">
            <thead>
                <tr>
                    <th>封面</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>出版社</th>
                    <th>价格</th>
                    <th>库存</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${books}" var="book">
                    <tr>
                        <td>
                            <img src="${book.coverImage}" alt="${book.title}" class="book-cover">
                        </td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td>${book.publisher}</td>
                        <td>￥${book.price}</td>
                        <td>${book.stock}</td>
                        <td>
                            <span class="status-badge ${book.status == 1 ? 'status-active' : 'status-inactive'}">
                                ${book.status == 1 ? '上架' : '下架'}
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <button class="btn btn-primary" onclick="editBook(${book.id})">编辑</button>
                                <button class="btn btn-danger" onclick="deleteBook(${book.id})">删除</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}">上一页</a>
            </c:if>
            
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="?page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a>
            </c:forEach>
            
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}">下一页</a>
            </c:if>
        </div>
    </div>

    <script>
        function searchBooks() {
            const searchText = document.getElementById('searchInput').value;
            window.location.href = '${pageContext.request.contextPath}/book/list?search=' + encodeURIComponent(searchText);
        }
        
        function showAddBookModal() {
            // TODO: 实现添加图书的模态框
            window.location.href = '${pageContext.request.contextPath}/book/add';
        }
        
        function editBook(id) {
            window.location.href = '${pageContext.request.contextPath}/book/edit?id=' + id;
        }
        
        function deleteBook(id) {
            if (confirm('确定要删除这本书吗？')) {
                window.location.href = '${pageContext.request.contextPath}/book/delete?id=' + id;
            }
        }
    </script>
</body>
</html> 