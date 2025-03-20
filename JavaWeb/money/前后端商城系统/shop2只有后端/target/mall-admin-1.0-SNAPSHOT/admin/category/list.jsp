<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>分类管理 - 商城后台管理系统</title>
    <link rel="stylesheet" href="../../static/css/admin.css">
    <style>
        /* 简单的表格美化 */
        .data-table {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .data-table thead {
            background-color: #f8f9fa;
        }
        
        .data-table th {
            padding: 15px;
            font-weight: 500;
            color: #333;
        }
        
        .data-table td {
            padding: 12px 15px;
            vertical-align: middle;
        }
        
        /* 按钮样式优化 */
        .btn-sm {
            padding: 5px 10px;
            margin: 0 3px;
        }
        
        /* 模态框美化 */
        .modal-content {
            border-radius: 8px;
            padding: 25px;
        }
        
        .modal-content h3 {
            margin-bottom: 20px;
            color: #333;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
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
                    <li><a href="list" class="active"><i class="icon">📑</i>分类管理</a></li>
                    <li><a href="../order/list"><i class="icon">📝</i>订单管理</a></li>
                    <li><a href="../user/list"><i class="icon">👥</i>用户管理</a></li>
                </ul>
            </nav>
        </div>

        <!-- 右侧内容区 -->
        <div class="main-content">
            <header class="top-bar">
                <div class="breadcrumb">
                    <span>首页</span> / <span>分类管理</span>
                </div>
                <div class="user-info">
                    <span>欢迎，${sessionScope.username}</span>
                    <a href="../../logout" class="logout">退出</a>
                </div>
            </header>

            <div class="content">
                <div class="toolbar">
                    <button class="btn btn-primary" onclick="showAddForm()">添加分类</button>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>分类名称</th>
                            <th>描述</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categories}" var="category">
                            <tr>
                                <td>${category.id}</td>
                                <td>${category.name}</td>
                                <td>${category.description}</td>
                                <td>${category.createTime}</td>
                                <td>
                                    <button class="btn btn-sm btn-info" onclick="showEditForm(${category.id}, '${category.name}', '${category.description}')">编辑</button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteCategory(${category.id})">删除</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 添加分类的弹窗 -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <h3>添加分类</h3>
            <form action="add" method="post" class="form">
                <div class="form-group">
                    <label for="name">分类名称</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="description">描述</label>
                    <textarea id="description" name="description" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn" onclick="hideModal('addModal')">取消</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 编辑分类的弹窗 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <h3>编辑分类</h3>
            <form action="edit" method="post" class="form">
                <input type="hidden" id="editId" name="id">
                <div class="form-group">
                    <label for="editName">分类名称</label>
                    <input type="text" id="editName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="editDescription">描述</label>
                    <textarea id="editDescription" name="description" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn" onclick="hideModal('editModal')">取消</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showAddForm() {
            document.getElementById('addModal').style.display = 'block';
        }

        function showEditForm(id, name, description) {
            document.getElementById('editId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editDescription').value = description;
            document.getElementById('editModal').style.display = 'block';
        }

        function hideModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        function deleteCategory(id) {
            if (confirm('确定要删除这个分类吗？删除后该分类下的商品将无法显示！')) {
                location.href = 'delete?id=' + id;
            }
        }

        // 点击模态框外部时关闭
        window.onclick = function(event) {
            if (event.target.className === 'modal') {
                event.target.style.display = 'none';
            }
        }
    </script>
</body>
</html> 