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
            background-color: #f5f5f5;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .header {
            padding: 20px;
            background: #f8f9fa;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 20px;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #7AB87A;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .search-box {
            position: relative;
        }

        .search-input {
            padding: 8px 15px 8px 35px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            width: 250px;
            font-size: 14px;
        }

        .search-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .add-btn {
            background: #7AB87A;
            color: white;
            padding: 8px 20px;
            border-radius: 6px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .add-btn:hover {
            background: #68A568;
        }

        .category-table {
            width: 100%;
            border-collapse: collapse;
        }

        .category-table th {
            background: #f8f9fa;
            padding: 12px 20px;
            text-align: left;
            font-weight: 500;
            color: #4a5568;
            font-size: 14px;
            border-bottom: 2px solid #e2e8f0;
        }

        .category-table td {
            padding: 12px 20px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
        }

        .category-name {
            font-weight: 500;
            color: #2d3748;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .category-name i {
            color: #7AB87A;
            font-size: 16px;
        }

        .category-desc {
            color: #718096;
            font-size: 13px;
            max-width: 400px;
            line-height: 1.5;
        }

        .book-count {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            background: rgba(122, 184, 122, 0.1);
            color: #7AB87A;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-edit {
            background: rgba(122, 184, 122, 0.1);
            color: #7AB87A;
        }

        .btn-edit:hover {
            background: rgba(122, 184, 122, 0.2);
        }

        .btn-delete {
            background: rgba(229, 62, 62, 0.1);
            color: #e53e3e;
        }

        .btn-delete:hover {
            background: rgba(229, 62, 62, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }

        .empty-state i {
            font-size: 48px;
            color: #a0aec0;
            margin-bottom: 20px;
        }

        .empty-state p {
            margin-bottom: 20px;
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
            <div class="header-actions">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="搜索分类..." onkeyup="searchTable(this.value)">
                </div>
                <a href="admin/AddCategory.jsp" class="add-btn">
                    <i class="fas fa-plus"></i>
                    添加分类
                </a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty sessionScope.categoryList}">
                <div class="empty-state">
                    <i class="fas fa-tags"></i>
                    <p>暂无分类数据</p>
                    <a href="admin/AddCategory.jsp" class="add-btn">添加第一个分类</a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="category-table">
                    <thead>
                        <tr>
                            <th>分类名称</th>
                            <th>描述</th>
                            <th>图书数量</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.categoryList}" var="category">
                            <tr>
                                <td>
                                    <div class="category-name">
                                        <i class="fas fa-folder"></i>
                                        ${category.categoryName}
                                    </div>
                                </td>
                                <td>
                                    <div class="category-desc">${category.description}</div>
                                </td>
                                <td>
                                    <span class="book-count">86本</span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <a href="/UpdateCategoryServlet?id=${category.categoryId}" class="btn btn-edit">
                                            <i class="fas fa-edit"></i> 编辑
                                        </a>
                                        <a href="/DelCategoryServlet?id=${category.categoryId}" 
                                           class="btn btn-delete"
                                           onclick="return confirm('确定要删除该分类吗？')">
                                            <i class="fas fa-trash-alt"></i> 删除
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

    <script>
    function searchTable(keyword) {
        const tbody = document.querySelector('.category-table tbody');
        const rows = tbody.getElementsByTagName('tr');
        keyword = keyword.toLowerCase();
        
        for (let row of rows) {
            const name = row.querySelector('.category-name').textContent.toLowerCase();
            const desc = row.querySelector('.category-desc').textContent.toLowerCase();
            
            if (name.includes(keyword) || desc.includes(keyword)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    }
    </script>
</body>
</html> 