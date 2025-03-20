<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑图书 - 书城管理系统</title>
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
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-title::before {
            content: '';
            width: 4px;
            height: 20px;
            background-color: #007bff;
            border-radius: 2px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
            outline: none;
        }
        
        textarea.form-control {
            height: 120px;
            resize: vertical;
        }
        
        .form-text {
            margin-top: 5px;
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .current-image {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f8f9fa;
            display: inline-block;
        }
        
        .current-image img {
            max-width: 100px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .btn-container {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: #007bff;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-1px);
        }
        
        .btn-secondary {
            background-color: #6c757d;
        }
        
        .btn-secondary:hover {
            background-color: #545b62;
            transform: translateY(-1px);
        }
        
        .error-message {
            color: #dc3545;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
            margin-bottom: 0;
        }
        
        .status-select {
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.875rem;
            margin-left: 10px;
        }
        
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="form-container">
            <h2 class="form-title">编辑图书</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/book/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${book.id}">
                
                <div class="form-group">
                    <label for="title">书名</label>
                    <input type="text" id="title" name="title" class="form-control" value="${book.title}" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="author">作者</label>
                        <input type="text" id="author" name="author" class="form-control" value="${book.author}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="publisher">出版社</label>
                        <input type="text" id="publisher" name="publisher" class="form-control" value="${book.publisher}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">价格</label>
                        <input type="number" id="price" name="price" class="form-control" step="0.01" min="0" value="${book.price}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="stock">库存</label>
                        <input type="number" id="stock" name="stock" class="form-control" min="0" value="${book.stock}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">状态</label>
                        <div class="status-select">
                            <select id="status" name="status" class="form-control" required onchange="updateStatusBadge(this)">
                                <option value="1" ${book.status == 1 ? 'selected' : ''}>上架</option>
                                <option value="0" ${book.status == 0 ? 'selected' : ''}>下架</option>
                            </select>
                            <span id="statusBadge" class="status-badge ${book.status == 1 ? 'status-active' : 'status-inactive'}">
                                ${book.status == 1 ? '已上架' : '已下架'}
                            </span>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="coverImage">封面图片</label>
                    <input type="file" id="coverImage" name="coverImage" class="form-control" accept="image/*" onchange="previewImage(this)">
                    <small class="form-text">支持jpg、jpeg、png、gif格式，大小不超过5MB</small>
                    <div class="current-image">
                        <img id="preview" src="${book.coverImage}" alt="${book.title}" onerror="this.src='${pageContext.request.contextPath}/static/images/no-image.png'">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="description">图书描述</label>
                    <textarea id="description" name="description" class="form-control">${book.description}</textarea>
                </div>
                
                <div class="btn-container">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">取消</button>
                    <button type="submit" class="btn btn-primary">保存修改</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        function updateStatusBadge(select) {
            const badge = document.getElementById('statusBadge');
            if (select.value === '1') {
                badge.className = 'status-badge status-active';
                badge.textContent = '已上架';
            } else {
                badge.className = 'status-badge status-inactive';
                badge.textContent = '已下架';
            }
        }
    </script>
</body>
</html> 