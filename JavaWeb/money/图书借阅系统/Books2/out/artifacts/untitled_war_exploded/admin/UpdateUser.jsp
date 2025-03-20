<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/4
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户</title>
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
            max-width: 500px;
            margin: 0 auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        
        .page-title {
            text-align: center;
            color: #333;
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
            color: #666;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-tip {
            font-size: 12px;
            color: #999;
            margin-top: 3px;
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
            background-color: #7AB87A;
            color: white;
        }
        
        .btn-back {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            margin-left: 10px;
        }
        
        .error-msg {
            color: #dc3545;
            font-size: 14px;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">修改用户</h2>
        <form action="/UpdateUserServlet2" method="post">
            <input type="hidden" name="id" value="${user1.id}"/>
            
            <div class="form-group">
                <label>用户名</label>
                <input type="text" class="form-control" name="username" value="${user1.username}" required>
            </div>
            
            <div class="form-group">
                <label>密码</label>
                <input type="password" class="form-control" name="password" value="${user1.password}" required>
            </div>
            
            <div class="form-group">
                <label>邮箱</label>
                <input type="email" class="form-control" name="email" value="${user1.email}" required>
            </div>
            
            <div class="form-group">
                <label>生日</label>
                <input type="date" class="form-control" name="birthday" value="${user1.birthday}" required>
            </div>
            
            <div class="form-group">
                <label>用户类型</label>
                <select class="form-control" name="isadmin" required>
                    <option value="0" ${user1.isadmin == 0 ? 'selected' : ''}>普通用户</option>
                    <option value="1" ${user1.isadmin == 1 ? 'selected' : ''}>管理员</option>
                </select>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存修改</button>
                <a href="/IndexUserServlet" class="btn btn-back">返回</a>
            </div>
            
            <div class="error-msg">${error_msg}</div>
        </form>
    </div>
</body>
</html>
