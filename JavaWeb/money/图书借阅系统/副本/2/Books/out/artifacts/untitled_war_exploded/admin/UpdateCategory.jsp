<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改分类</title>
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
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        
        .page-title {
            text-align: center;
            color: #333;
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #666;
        }
        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-control:focus {
            border-color: #4299e1;
            outline: none;
        }
        
        .btn-container {
            text-align: center;
            margin-top: 25px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
        
        .btn {
            padding: 8px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }
        
        .btn-back {
            background: #718096;
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">修改分类</h2>
        
        <form action="/UpdateCategoryServlet" method="post">
            <input type="hidden" name="categoryId" value="${category.categoryId}">
            
            <div class="form-group">
                <label>分类名称</label>
                <input type="text" class="form-control" name="categoryName" 
                       value="${category.categoryName}" required>
            </div>
            
            <div class="form-group">
                <label>描述</label>
                <textarea class="form-control" name="description" rows="4" required>${category.description}</textarea>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存修改</button>
                <a href="/IndexCategoryServlet" class="btn btn-back">返回</a>
            </div>
        </form>
    </div>
</body>
</html> 