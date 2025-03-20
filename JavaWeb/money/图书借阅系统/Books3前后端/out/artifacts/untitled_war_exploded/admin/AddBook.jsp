<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/6
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加图书</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f0f2f5;
            padding: 20px;
        }
        
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        }
        
        .page-title {
            text-align: center;
            color: #1a1a1a;
            font-size: 22px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #4a5568;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-control:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }
        
        .btn-container {
            text-align: center;
            margin-top: 25px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .btn {
            padding: 8px 20px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-primary {
            background-color: #4299e1;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #3182ce;
        }
        
        .btn-back {
            background-color: #718096;
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
        
        .btn-back:hover {
            background-color: #4a5568;
        }
        
        .file-input {
            margin-top: 5px;
        }
        
        .file-input::-webkit-file-upload-button {
            padding: 6px 12px;
            background: #edf2f7;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">添加图书</h2>
        <form action="/AddBookServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>书名</label>
                <input type="text" class="form-control" name="bookname" required>
            </div>
            
            <div class="form-group">
                <label>出版社</label>
                <input type="text" class="form-control" name="publish" required>
            </div>
            
            <div class="form-group">
                <label>价格</label>
                <input type="number" class="form-control" name="price" step="0.01" min="0" required>
            </div>
            
            <div class="form-group">
                <label>图书封面</label>
                <input type="file" class="form-control file-input" name="image" accept="image/*" required>
            </div>
            
            <div class="form-group">
                <label for="category_id">图书分类：</label>
                <select class="form-control" id="category_id" name="category_id" required>
                    <option value="">请选择分类</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.category_id}">${category.category_name}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">添加</button>
                <a href="/IndexBookServlet" class="btn btn-back">返回</a>
            </div>
        </form>
    </div>
</body>
</html>
