<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加分类</title>
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
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
            outline: none;
        }
        
        .btn-group {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: #4299e1;
            color: white;
            flex: 1;
        }
        
        .btn-back {
            background-color: #718096;
            color: white;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            flex: 1;
        }
        
        .btn:hover {
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">添加分类</h2>
        
        <form action="/AddCategoryServlet" method="post">
            <div class="form-group">
                <label for="category_name">分类名称：</label>
                <input type="text" class="form-control" id="category_name" name="category_name" required>
            </div>
            
            <div class="form-group">
                <label for="description">分类描述：</label>
                <textarea class="form-control" id="description" name="description" rows="4"></textarea>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">添加</button>
                <a href="/IndexCategoryServlet" class="btn btn-back">返回</a>
            </div>
        </form>
    </div>
</body>
</html> 