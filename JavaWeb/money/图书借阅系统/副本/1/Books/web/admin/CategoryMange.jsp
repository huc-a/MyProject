<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>分类管理</title>
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

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #718096;
            font-size: 16px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
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
                <i class="fas fa-tags"></i>
                分类管理
            </h2>
            <div class="action-buttons">
                <a href="admin/AddCategory.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    添加分类
                </a>
            </div>
        </div>

        <div class="search-box">
            <input type="text" class="search-input" placeholder="搜索分类名称..." 
                   onkeyup="searchTable(this.value)">
        </div>

        <div class="table-container">
            <table class="data-table" id="categoryTable">
                <thead>
                    <tr>
                        <th>分类ID</th>
                        <th>分类名称</th>
                        <th>描述</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categoryList}" var="category">
                        <tr>
                            <td>${category.categoryId}</td>
                            <td>${category.categoryName}</td>
                            <td>${category.description}</td>
                            <td>
                                <div class="actions">
                                    <a href="/UpdateCategoryServlet?id=${category.categoryId}" 
                                       class="btn btn-edit">
                                        <i class="fas fa-edit"></i>
                                        修改
                                    </a>
                                    <a href="/DelCategoryServlet?id=${category.categoryId}" 
                                       class="btn btn-delete"
                                       onclick="return confirm('确定要删除该分类吗？删除分类会同时删除该分类下的所有图书！')">
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
        const table = document.getElementById('categoryTable');
        const rows = table.getElementsByTagName('tr');
        
        keyword = keyword.toLowerCase();
        
        // 从索引1开始,跳过表头
        for (let i = 1; i < rows.length; i++) {
            const nameCell = rows[i].getElementsByTagName('td')[1]; // 分类名称列
            const descCell = rows[i].getElementsByTagName('td')[2]; // 描述列
            
            if (nameCell && descCell) {
                const name = nameCell.textContent.toLowerCase();
                const desc = descCell.textContent.toLowerCase();
                
                if (name.includes(keyword) || desc.includes(keyword)) {
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