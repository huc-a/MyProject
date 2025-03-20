<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/6
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        
        .page-title {
            text-align: center;
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
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
            font-size: 15px;
        }
        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .btn-container {
            text-align: center;
            margin-top: 30px;
        }
        
        .btn {
            padding: 10px 24px;
            font-size: 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background-color: #7AB87A;
            color: white;
        }
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">添加用户</h2>
        <form action="/AddUserServlet" method="post">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" class="form-control" name="username" required>
            </div>
            
            <div class="form-group">
                <label>密码</label>
                <input type="password" class="form-control" name="password" required>
            </div>
            
            <div class="form-group">
                <label>邮箱</label>
                <input type="email" class="form-control" name="email" required>
            </div>
            
            <div class="form-group">
                <label>生日</label>
                <input type="date" class="form-control" name="birthday" required>
            </div>
            
            <div class="form-group">
                <label>用户类型</label>
                <select class="form-control" name="isadmin" required>
                    <option value="0">普通用户</option>
                    <option value="1">管理员</option>
                </select>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">添加</button>
                <a href="/IndexUserServlet" class="btn btn-back">返回</a>
            </div>
        </form>
    </div>
</body>
</html>
