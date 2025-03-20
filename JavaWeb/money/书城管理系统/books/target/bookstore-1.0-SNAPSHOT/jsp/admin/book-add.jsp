<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加图书 - 书城管理系统</title>
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
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .form-title {
            margin-bottom: 20px;
            color: #333;
            font-size: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        
        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }
        
        textarea.form-control {
            height: 100px;
            resize: vertical;
        }
        
        .btn-container {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 20px;
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
        
        .btn-secondary {
            background-color: #6c757d;
        }
        
        .btn-secondary:hover {
            background-color: #545b62;
        }
        
        .error-message {
            color: #dc3545;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="form-container">
            <h2 class="form-title">添加图书</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/book/add" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title">书名</label>
                    <input type="text" id="title" name="title" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="author">作者</label>
                    <input type="text" id="author" name="author" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="publisher">出版社</label>
                    <input type="text" id="publisher" name="publisher" class="form-control" required>
                </div>
                
                <div class="form-group">
                    <label for="price">价格</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="stock">库存</label>
                    <input type="number" id="stock" name="stock" class="form-control" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="coverImage">封面图片</label>
                    <input type="file" id="coverImage" name="coverImage" class="form-control" accept="image/*" required>
                </div>
                
                <div class="form-group">
                    <label for="description">图书描述</label>
                    <textarea id="description" name="description" class="form-control"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="status">状态</label>
                    <select id="status" name="status" class="form-control" required>
                        <option value="1">上架</option>
                        <option value="0">下架</option>
                    </select>
                </div>
                
                <div class="btn-container">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html> 