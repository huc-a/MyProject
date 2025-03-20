<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2024/12/4
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户管理</title>
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
        }

        .page-title {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .add-btn {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
        }
        
        .add-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.3);
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .user-table th, 
        .user-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .user-table th {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            padding: 12px;
            font-weight: 500;
        }

        .user-table tr:hover {
            background-color: #f8fafc;
        }

        .btn {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            margin: 0 4px;
        }

        .btn-edit {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
        }
        
        .btn-edit:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.3);
        }

        .btn-delete {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
            box-shadow: 0 2px 4px rgba(245, 101, 101, 0.2);
        }
        
        .btn-delete:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(245, 101, 101, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">用户管理</h2>
        
        <a href="admin/AddUser.jsp" class="add-btn">添加用户</a>

        <table class="user-table">
            <tr>
                <th>用户编号</th>
                <th>用户名</th>
                <th>密码</th>
                <th>邮箱</th>
                <th>生日</th>
                <th>用户类型</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${sessionScope.userList}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.password}</td>
                    <td>${user.email}</td>
                    <td>${user.birthday}</td>
                    <td>${user.isadmin == 1 ? '管理员' : '普通用户'}</td>
                    <td>
                        <a href="/UpdateUserServlet?id=${user.id}" class="btn btn-edit">修改</a>
                        <a href="/DelUserServlet?id=${user.id}" class="btn btn-delete" 
                           onclick="return confirm('确定要删除该用户吗？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
