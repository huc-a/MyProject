<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑图书</title>
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
            max-width: 600px;
            margin: 0 auto;
        }
        
        .page-title {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-primary {
            background-color: #7AB87A;
            color: white;
        }
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">编辑图书</h2>
        <form action="/UpdateBookServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="bookid" value="${book.bookid}">
            <input type="hidden" name="oldImage" value="${book.image}">
            
            <div class="form-group">
                <label>书名</label>
                <input type="text" class="form-control" name="bookname" value="${book.bookname}" required>
            </div>
            
            <div class="form-group">
                <label>出版社</label>
                <input type="text" class="form-control" name="publish" value="${book.publish}" required>
            </div>
            
            <div class="form-group">
                <label>价格</label>
                <input type="number" class="form-control" name="price" step="0.01" min="0" value="${book.price}" required>
            </div>
            
            <div class="form-group">
                <label>分类</label>
                <select class="form-control" name="category_id" required>
                    <option value="">请选择分类</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.category_id}" 
                                ${category.category_id == book.category_id ? 'selected' : ''}>
                            ${category.category_name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>当前图片</label>
                <img src="${book.image}" alt="当前图片" style="max-width: 200px; display: block; margin: 10px 0;">
                <label>更换图片（可选）</label>
                <input type="file" class="form-control file-input" name="image" accept="image/*">
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存修改</button>
                <a href="/IndexBookServlet" class="btn btn-back">返回</a>
            </div>
        </form>
    </div>
</body>
</html> 