<%@ page import="domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>系统首页</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        
        .welcome-card {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
        
        .welcome-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .welcome-icon {
            font-size: 40px;
            color: #7AB87A;
            margin-right: 20px;
        }
        
        .welcome-text h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        
        .welcome-text p {
            color: #666;
            font-size: 15px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            margin-top: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .username {
            color: #7AB87A;
            font-weight: bold;
            margin: 0 5px;
        }
        
        .logout-btn {
            margin-left: 15px;
            padding: 6px 15px;
            background-color: #f0f7f0;
            color: #7AB87A;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background-color: #7AB87A;
            color: #fff;
        }
        
        .date-info {
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }
        
        .system-tips {
            margin-top: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 4px;
            color: #666;
            line-height: 1.6;
        }
        
        .quick-links {
            margin-top: 20px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }
        
        .quick-link {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            text-align: center;
            transition: all 0.3s;
            text-decoration: none;
            color: #666;
        }
        
        .quick-link:hover {
            background: #7AB87A;
            color: #fff;
        }
        
        .quick-link i {
            font-size: 24px;
            margin-bottom: 8px;
            display: block;
        }
        
        .notice-board {
            margin-top: 20px;
            padding: 15px;
            background: #fff3cd;
            border-radius: 4px;
            color: #856404;
        }
        
        .notice-board h3 {
            margin-bottom: 10px;
            font-size: 16px;
        }
        
        .notice-board p {
            line-height: 1.6;
            font-size: 14px;
        }
    </style>
</head>
<body>
<%
    User user = (User)session.getAttribute("user");
%>

<div class="welcome-card">
    <div class="welcome-header">
        <div class="welcome-icon">
            <i class="fas fa-book-reader"></i>
        </div>
        <div class="welcome-text">
            <h1>欢迎来到书香城图书管理系统</h1>
            <p>今天是个阅读的好日子</p>
        </div>
    </div>
    
    <div class="user-info">
        当前用户：<span class="username"><%=user.getUsername()%></span>
        <a href="/LoginOutServlet" class="logout-btn" target="_parent" onclick="return confirm('确定要注销吗？')">
            <i class="fas fa-sign-out-alt"></i> 注销
        </a>
    </div>
    
    <div class="date-info">
        当前时间：<%= new java.text.SimpleDateFormat("yyyy年MM月dd日 EEEE", java.util.Locale.CHINESE).format(new java.util.Date()) %>
    </div>
    
    <div class="quick-links">
        <a href="/IndexBookServlet" target="main" class="quick-link">
            <i class="fas fa-book"></i>
            图书管理
        </a>
        <a href="/IndexUserServlet" target="main" class="quick-link">
            <i class="fas fa-users"></i>
            读者管理
        </a>
        <a href="/IndexOrderServlet" target="main" class="quick-link">
            <i class="fas fa-clipboard-list"></i>
            借阅管理
        </a>
    </div>
    
    <div class="notice-board">
        <h3><i class="fas fa-bullhorn"></i> 系统公告</h3>
        <p>欢迎使用书香城图书管理系统！本系统支持图书管理、读者管理、借阅管理等功能。如有问题请联系管理员。</p>
    </div>
    
    <div class="system-tips">
        <p><i class="fas fa-info-circle"></i> 系统使用小贴士：</p>
        <ul style="margin-left: 25px; margin-top: 10px;">
            <li>点击左侧菜单或上方快捷入口可以进行相应的操作</li>
            <li>图书管理：可以添加、修改、删除图书信息</li>
            <li>读者管理：可以管理用户信息和权限</li>
            <li>借阅管理：可以处理图书借还事务</li>
            <li>使用过程中如遇问题，请及时联系管理员</li>
        </ul>
    </div>
</div>

</body>
</html>
