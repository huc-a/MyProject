<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改图书</title>
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
        <h2 class="page-title">修改图书</h2>
        
        <form action="/UpdateBookServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="bookid" value="${book.bookid}">
            
            <div class="form-group">
                <label for="bookname">图书名称：</label>
                <input type="text" class="form-control" id="bookname" name="bookname" value="${book.bookname}" required>
            </div>
            
            <div class="form-group">
                <label for="publish">出版社：</label>
                <input type="text" class="form-control" id="publish" name="publish" value="${book.publish}" required>
            </div>
            
            <div class="form-group">
                <label for="price">价格：</label>
                <input type="number" step="0.01" class="form-control" id="price" name="price" value="${book.price}" required>
            </div>
            
            <div class="form-group">
                <label for="imageFile">图片上传：</label>
                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                <small class="form-text text-muted">如果不上传新图片则保持原图片不变</small>
                <img id="preview" class="preview-image" src="${book.image}" style="display: block;">
            </div>
            
            <button type="submit" class="btn btn-primary">保存</button>
            <a href="/IndexBookServlet" class="btn btn-back">返回</a>
        </form>
    </div>

    <script>
        // 图片预览功能
        document.getElementById('imageFile').onchange = function(e) {
            var file = e.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                    document.getElementById('preview').style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html> 