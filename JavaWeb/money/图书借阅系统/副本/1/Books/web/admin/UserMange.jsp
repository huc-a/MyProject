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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            color: #333;
            font-size: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #4299e1;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.2);
        }

        .btn-edit {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
        }

        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .data-table th, 
        .data-table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .data-table th {
            background: #f8fafc;
            color: #4a5568;
            font-weight: 500;
            white-space: nowrap;
        }

        .data-table tr:hover {
            background-color: #f8fafc;
        }

        .data-table td {
            color: #2d3748;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .user-type {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .user-type-admin {
            background-color: #c6f6d5;
            color: #2f855a;
        }

        .user-type-normal {
            background-color: #e9d8fd;
            color: #6b46c1;
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
            font-size: 14px;
            max-width: 300px;
        }

        .search-input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2 class="page-title">
                <i class="fas fa-users"></i>
                用户管理
            </h2>
            <div class="action-buttons">
                <a href="admin/AddUser.jsp" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i>
                    添加用户
                </a>
            </div>
        </div>

        <div class="search-box">
            <input type="text" class="search-input" placeholder="搜索用户名、邮箱..." 
                   onkeyup="searchTable(this.value)">
        </div>

        <div class="table-container">
            <table class="data-table" id="userTable">
                <thead>
                    <tr>
                        <th>用户编号</th>
                        <th>用户名</th>
                        <th>邮箱</th>
                        <th>生日</th>
                        <th>用户类型</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sessionScope.userList}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.birthday}</td>
                            <td>
                                <span class="user-type ${user.isadmin == 1 ? 'user-type-admin' : 'user-type-normal'}">
                                    ${user.isadmin == 1 ? '管理员' : '普通用户'}
                                </span>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="/UpdateUserServlet?id=${user.id}" 
                                       class="btn btn-edit">
                                        <i class="fas fa-edit"></i>
                                        修改
                                    </a>
                                    <a href="/DelUserServlet?id=${user.id}" 
                                       class="btn btn-delete"
                                       onclick="return confirm('确定要删除该用户吗？')">
                                        <i class="fas fa-trash-alt"></i>
                                        删除
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
    function searchTable(keyword) {
        const table = document.getElementById('userTable');
        const rows = table.getElementsByTagName('tr');
        
        keyword = keyword.toLowerCase();
        
        // 从索引1开始,跳过表头
        for (let i = 1; i < rows.length; i++) {
            const nameCell = rows[i].getElementsByTagName('td')[1]; // 用户名列
            const emailCell = rows[i].getElementsByTagName('td')[2]; // 邮箱列
            
            if (nameCell && emailCell) {
                const name = nameCell.textContent.toLowerCase();
                const email = emailCell.textContent.toLowerCase();
                
                if (name.includes(keyword) || email.includes(keyword)) {
                    rows[i].style.display = '';
                } else {
                    rows[i].style.display = 'none';
                }
            }
        }
    }
    </script>
</body>
</html>
