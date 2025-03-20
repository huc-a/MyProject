<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑用户 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <style>
        .edit-form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #666;
        }
        
        .form-group input {
            width: 100%;
            max-width: 400px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .form-group input:focus {
            border-color: #1976d2;
            outline: none;
        }
        
        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- 左侧菜单 -->
        <div class="sidebar">
            <div class="logo">
                <h2>商城管理系统</h2>
            </div>
            <nav class="menu">
                <ul>
                    <li><a href="../index.jsp"><i class="icon">📊</i>控制台</a></li>
                    <li><a href="../product/list"><i class="icon">📦</i>商品管理</a></li>
                    <li><a href="../category/list"><i class="icon">📑</i>分类管理</a></li>
                    <li><a href="../order/list"><i class="icon">📝</i>订单管理</a></li>
                    <li><a href="list" class="active"><i class="icon">👥</i>用户管理</a></li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span> / <span>用户管理</span> / <span>编辑用户</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../../logout" class="logout">退出</a>
                </div>
            </header>

            <div class="content">
                <div class="edit-form">
                    <h2>编辑用户</h2>
                    <form action="edit" method="post">
                        <input type="hidden" name="id" value="${user.id}">
                        
                        <div class="form-group">
                            <label for="username">用户名</label>
                            <input type="text" id="username" name="username" value="${user.username}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">密码</label>
                            <input type="password" id="password" name="password" placeholder="不修改请留空">
                        </div>
                        
                        <div class="form-group">
                            <label for="email">邮箱</label>
                            <input type="email" id="email" name="email" value="${user.email}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">手机号</label>
                            <input type="tel" id="phone" name="phone" value="${user.phone}" required>
                        </div>
                        
                        <div class="button-group">
                            <button type="submit" class="btn btn-primary">保存</button>
                            <button type="button" class="btn btn-default" onclick="history.back()">返回</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 