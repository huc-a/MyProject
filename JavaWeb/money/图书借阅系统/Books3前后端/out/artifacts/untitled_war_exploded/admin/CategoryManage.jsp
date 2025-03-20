<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>分类管理</title>
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
        }

        .add-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.3);
        }

        .category-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .category-table th,
        .category-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .category-table th {
            background-color: #f8fafc;
            font-weight: 500;
            color: #4a5568;
        }

        .category-table tr:hover {
            background-color: #f9fafb;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            margin-right: 8px;
            transition: all 0.3s ease;
        }

        .edit-btn {
            background-color: #4299e1;
        }

        .delete-btn {
            background-color: #f56565;
        }

        .action-btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title">分类管理</h2>
        
        <a href="admin/AddCategory.jsp" class="add-btn">添加分类</a>

        <table class="category-table">
            <tr>
                <th>分类ID</th>
                <th>分类名称</th>
                <th>描述</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${sessionScope.categoryList}" var="category">
                <tr>
                    <td>${category.category_id}</td>
                    <td>${category.category_name}</td>
                    <td>${category.description}</td>
                    <td>
                        <a href="/EditCategoryServlet?id=${category.category_id}" class="action-btn edit-btn">编辑</a>
                        <a href="/DeleteCategoryServlet?id=${category.category_id}" 
                           class="action-btn delete-btn"
                           onclick="return confirm('确定要删除该分类吗？这将影响所有使用此分类的图书。')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html> 