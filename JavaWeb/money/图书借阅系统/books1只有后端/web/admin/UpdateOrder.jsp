<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改借阅</title>
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
        <h2 class="page-title">修改借阅</h2>
        
        <form action="/UpdateOrderServlet" method="post">
            <input type="hidden" name="orderid" value="${order.orderid}">
            
            <div class="form-group">
                <label for="bookid">图书编号：</label>
                <input type="text" class="form-control" id="bookid" name="bookid" value="${order.bookid}" required>
            </div>
            
            <div class="form-group">
                <label for="id">用户编号：</label>
                <input type="text" class="form-control" id="id" name="id" value="${order.id}" required>
            </div>
            
            <div class="form-group">
                <label for="time">借阅时间：</label>
                <input type="date" class="form-control" id="time" name="time" 
                       value="<fmt:formatDate value='${order.time}' pattern='yyyy-MM-dd'/>" required>
            </div>
            
            <button type="submit" class="btn btn-primary">保存</button>
            <a href="/IndexOrderServlet" class="btn btn-back">返回</a>
        </form>
    </div>
</body>
</html> 