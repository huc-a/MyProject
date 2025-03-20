<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>书城管理系统</title>
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
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .welcome {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .welcome h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .welcome h2::before {
            content: '';
            width: 4px;
            height: 24px;
            background-color: #007bff;
            border-radius: 2px;
        }
        
        .info-text {
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .menu-card {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            border: 1px solid #eee;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #333;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .menu-card i {
            font-size: 2rem;
            margin-bottom: 15px;
            display: block;
        }
        
        .menu-card.books { border-top: 4px solid #007bff; }
        .menu-card.orders { border-top: 4px solid #28a745; }
        .menu-card.users { border-top: 4px solid #ffc107; }
        .menu-card.comments { border-top: 4px solid #dc3545; }
        .menu-card.feedback { border-top: 4px solid #6f42c1; }
        .menu-card.settings { border-top: 4px solid #fd7e14; }
        
        .menu-card h3 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }
        
        .menu-card p {
            color: #666;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <div class="welcome">
            <h2>控制台</h2>
            <div class="info-text">
                <p>当前时间：<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                <p>登录用户：${sessionScope.user.realName}</p>
                <p>用户角色：管理员</p>
            </div>
            
            <div class="menu-grid">
                <a href="${pageContext.request.contextPath}/book/list" class="menu-card books">
                    <h3>图书管理</h3>
                    <p>管理图书信息、库存和分类</p>
                </a>
                
                <a href="${pageContext.request.contextPath}/order/list" class="menu-card orders">
                    <h3>订单管理</h3>
                    <p>处理订单、发货和退款</p>
                </a>
                
                <a href="${pageContext.request.contextPath}/user/list" class="menu-card users">
                    <h3>用户管理</h3>
                    <p>管理用户信息和权限</p>
                </a>
                
                <a href="${pageContext.request.contextPath}/comment/list" class="menu-card comments">
                    <h3>评论管理</h3>
                    <p>审核和回复用户评论</p>
                </a>
                
                <a href="${pageContext.request.contextPath}/feedback/list" class="menu-card feedback">
                    <h3>反馈管理</h3>
                    <p>处理用户反馈和建议</p>
                </a>
                
                <div class="menu-card settings">
                    <h3>系统设置</h3>
                    <p>配置系统参数和权限</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 