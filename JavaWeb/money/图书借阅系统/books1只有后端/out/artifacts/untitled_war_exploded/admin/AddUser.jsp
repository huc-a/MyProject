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
    <title>添加用户</title>
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
        
        .radio-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .radio-group label {
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        
        .radio-group input[type="radio"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">添加用户</h2>
        
        <form action="/AddUserServlet" method="post">
            <div class="form-group">
                <label for="username">用户名：</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="email">邮箱：</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="birthday">生日：</label>
                <input type="date" class="form-control" id="birthday" name="birthday" required>
            </div>
            
            <div class="form-group">
                <label>用户类型：</label>
                <div class="radio-group">
                    <label>
                        <input type="radio" name="isadmin" value="0" checked> 普通用户
                    </label>
                    <label>
                        <input type="radio" name="isadmin" value="1"> 管理员
                    </label>
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">添加</button>
            <a href="/IndexUserServlet" class="btn btn-back">返回</a>
        </form>
    </div>
</body>
</html>
