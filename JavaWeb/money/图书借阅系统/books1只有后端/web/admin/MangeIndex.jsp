<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/4
  Time: 18:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>书香城图书管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
        }
        
        .frame-header {
            height: 60px;
            background-color: #2B2F3A;
            display: flex;
            align-items: center;
            padding: 0 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        
        .frame-header .logo {
            display: flex;
            align-items: center;
        }
        
        .frame-header .logo-icon {
            font-size: 28px;
            color: #7AB87A;
            margin-right: 15px;
            display: flex;
            align-items: center;
        }
        
        .frame-header .logo-icon i {
            filter: drop-shadow(0 0 2px rgba(122, 184, 122, 0.4));
        }
        
        .frame-header h1 {
            color: #fff;
            font-size: 22px;
            font-weight: 500;
            text-shadow: 0 1px 2px rgba(0,0,0,.1);
        }
        
        .frame-side {
            position: fixed;
            top: 60px;
            left: 0;
            bottom: 0;
            width: 220px;
            scrollbar-width: none;
            -ms-overflow-style: none;
            overflow-x: hidden;
            overflow-y: auto;
            background-color: #fff;
            box-shadow: 2px 0 8px rgba(0,0,0,.1);
        }
        
        .frame-side::-webkit-scrollbar {
            display: none;
        }
        
        .side-menu {
            padding: 20px 0;
            list-style: none;
        }
        
        .side-menu li {
            padding: 14px 25px;
            transition: all 0.3s;
            margin: 4px 0;
        }
        
        .side-menu li:hover {
            background-color: #f0f7f0;
        }
        
        .side-menu a {
            color: #666;
            text-decoration: none;
            font-size: 15px;
            display: block;
        }
        
        .side-menu i {
            margin-right: 10px;
            color: #7AB87A;
            width: 20px;
            text-align: center;
        }
        
        .side-menu li:hover a {
            color: #7AB87A;
        }
        
        .frame-main {
            position: absolute;
            left: 220px;
            top: 60px;
            right: 0;
            bottom: 0;
            overflow: hidden;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        iframe {
            border: none;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
    </style>
</head>

<body>
<div class="frame-header">
    <div class="logo">
        <div class="logo-icon">
            <i class="fas fa-book-reader"></i>
        </div>
        <h1>书香城图书管理系统</h1>
    </div>
</div>
<div class="frame-side">
    <ul class="side-menu">
        <li><a href="main.jsp" target="main">
            <i class="fas fa-home"></i>系统首页</a>
        </li>
        <li><a href="/IndexUserServlet" target="main">
            <i class="fas fa-users"></i>读者管理</a>
        </li>
        <li><a href="/IndexBookServlet" target="main">
            <i class="fas fa-book"></i>图书管理</a>
        </li>
        <li><a href="/IndexOrderServlet" target="main">
            <i class="fas fa-clipboard-list"></i>借阅管理</a>
        </li>
    </ul>
</div>
<div class="frame-main">
    <iframe name="main" src="main.jsp" width="100%" height="100%"></iframe>
</div>
</body>
</html>