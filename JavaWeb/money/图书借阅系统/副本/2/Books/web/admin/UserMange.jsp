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
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #2d3748;
            font-size: 24px;
        }

        .page-title i {
            color: #4299e1;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 8px 15px;
            padding-left: 35px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #4299e1;
            box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .add-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .add-btn:hover {
            background: linear-gradient(135deg, #3182ce, #2c5282);
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: #f7fafc;
            padding: 12px;
            text-align: left;
            font-weight: 500;
            font-size: 14px;
            color: #4a5568;
            border-bottom: 2px solid #e2e8f0;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
            color: #2d3748;
        }

        tr:hover {
            background: #f7fafc;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: rgba(66, 153, 225, 0.1);
            color: #3182ce;
        }

        .btn-edit:hover {
            background: rgba(66, 153, 225, 0.2);
        }

        .btn-delete {
            background: rgba(245, 101, 101, 0.1);
            color: #e53e3e;
        }

        .btn-delete:hover {
            background: rgba(245, 101, 101, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #718096;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 20px;
            color: #a0aec0;
        }

        .empty-state p {
            font-size: 16px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h2 class="page-title">
                <i class="fas fa-users"></i>
                用户管理
            </h2>
            <div class="header-actions">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" 
                           class="search-input" 
                           placeholder="搜索用户..." 
                           onkeyup="searchTable(this.value)">
                </div>
                <a href="AddUser.jsp" class="add-btn">
                    <i class="fas fa-plus"></i>
                    添加用户
                </a>
            </div>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${empty sessionScope.userList}">
                    <div class="empty-state">
                        <i class="fas fa-users"></i>
                        <p>暂无用户数据</p>
                        <a href="AddUser.jsp" class="add-btn">添加第一个用户</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
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
                                        <c:choose>
                                            <c:when test="${user.isadmin == 1}">管理员</c:when>
                                            <c:otherwise>普通用户</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/UpdateUserServlet?id=${user.id}" class="btn btn-edit">
                                                <i class="fas fa-edit"></i>
                                                编辑
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
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
    function searchTable(keyword) {
        const table = document.querySelector('table');
        const rows = table.getElementsByTagName('tr');
        
        keyword = keyword.toLowerCase();
        
        // 从索引1开始,跳过表头
        for (let i = 1; i < rows.length; i++) {
            const nameCell = rows[i].cells[1];
            const emailCell = rows[i].cells[2];
            
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
