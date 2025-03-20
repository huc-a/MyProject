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
    <style>
        /* 基础样式 */
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
        
        /* 容器样式 */
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
        
        /* 标题样式 */
        .page-title {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        /* 添加按钮样式 */
        .add-btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: #7AB87A;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        /* 表格样式 */
        .book-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .book-table th, 
        .book-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .book-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: normal;
        }
        
        .book-table tr:hover {
            background-color: #f5f5f5;
        }
        
        /* 图片样式 */
        .book-image {
            max-width: 80px;
            height: auto;
        }
        
        /* 按钮样式 */
        .btn {
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            margin-right: 5px;
        }
        
        .btn-edit {
            background-color: #7AB87A;
            color: white;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 页面标题 -->
        <h2 class="page-title">图书管理</h2>
        
        <!-- 添加图书按钮 -->
        <a href="admin/AddBook.jsp" class="add-btn">添加图书</a>

        <!-- 图书列表表格 -->
        <table class="book-table">
            <!-- 表格头部 -->
            <tr>
                <th>图书编号</th>
                <th>图书名</th>
                <th>出版社</th>
                <th>价格</th>
                <th>图片</th>
                <th>操作</th>
            </tr>
            
            <!-- 图书列表数据 -->
            <c:forEach items="${sessionScope.bookList}" var="book">
                <tr>
                    <td>${book.bookid}</td>
                    <td>${book.bookname}</td>
                    <td>${book.publish}</td>
                    <td>${book.price}</td>
                    <td>
                        <img src="${book.image}" alt="" class="book-image">
                    </td>
                    <td>
                        <a href="/UpdateBookServlet?id=${book.bookid}" class="btn btn-edit">修改</a>
                        <a href="/DelBookServlet?id=${book.bookid}" 
                           class="btn btn-delete" 
                           onclick="return confirm('确定要删除该图书吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
