<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>景点管理 - 管理后台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

       .header {
            background: rgba(255, 255, 255, 0.95);
            padding: 1rem 2rem;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-sizing: border-box;
            backdrop-filter: blur(10px);
        }

       .logo {
            color: #2c3e50;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 10px;
        }

       .logo i {
            color: #3498db;
        }

       .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

       .admin-info span {
            color: #2c3e50;
            font-weight: 500;
        }

       .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

       .logout-btn:hover {
            background: #c0392b;
        }

       .header-buttons {
            display: flex;
            gap: 10px;
        }

       .header-button {
            background: #3498db;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }

       .header-button:hover {
            background: #2980b9;
        }

       .admin-container {
            max-width: 800px;
            margin: 80px auto 20px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 2rem;
        }

       .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
        }

        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #3498db;
            outline: none;
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        button {
            background: #3498db;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #2980b9;
        }

       .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }

       .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

       .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

       .form-title {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
            color: #2c3e50;
            font-size: 1.5rem;
        }

       .form-title i {
            color: #3498db;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-link {
            color: #2c3e50;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(52, 152, 219, 0.1);
        }

        .nav-link.active {
            background: #3498db;
            color: white;
        }

        .attraction-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .attraction-table th, 
        .attraction-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
        }

        .attraction-table td {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .attraction-table th {
            background: #f5f7fa;
            font-weight: bold;
            color: #2c3e50;
        }

        .attraction-table tr:hover {
            background: #f8f9fa;
        }

        .delete-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .delete-btn:hover {
            background: #c0392b;
        }

        /* 添加提示框样式 */
        [title] {
            cursor: help;
            border-bottom: 1px dotted #666;
        }

        .filter-section {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-input, .filter-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-input {
            flex: 1;
        }

        .table-container {
            overflow-x: auto;
        }

        .attraction-name {
            position: relative;
            cursor: pointer;
        }

        .description-preview {
            display: none;
            position: absolute;
            background: white;
            padding: 10px;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            width: 200px;
            z-index: 1;
            top: 100%;
            left: 0;
        }

        .attraction-name:hover .description-preview {
            display: block;
        }

        .category-tag {
            background: #e1f5fe;
            color: #0277bd;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .level-badge {
            background: #fff3e0;
            color: #e65100;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .free-tag {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 12px;
        }

        .action-buttons {
            display: flex;
            gap: 5px;
        }

        .edit-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .edit-btn:hover {
            background: #2980b9;
        }

        .delete-btn {
            width: auto;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
            position: relative;
            max-height: 90vh;
            overflow-y: auto;
        }

        .close-btn {
            position: absolute;
            right: 20px;
            top: 10px;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .close-btn:hover {
            color: #000;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="../index.jsp" class="logo">
            <i class="fas fa-cog"></i>
            旅游景点推荐系统 - 管理后台
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/attraction" class="nav-link ${currentPage != 'list' ? 'active' : ''}">
                <i class="fas fa-plus"></i> 添加景点
            </a>
            <a href="${pageContext.request.contextPath}/admin/attraction?page=list" class="nav-link ${currentPage == 'list' ? 'active' : ''}">
                <i class="fas fa-list"></i> 景点列表
            </a>
        </div>
        <div class="admin-info">
            <span>管理员：${sessionScope.user.username}</span>
            <a href="${pageContext.request.contextPath}/user?action=logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> 退出
            </a>
        </div>
    </div>

    <div class="admin-container">
        <h1>管理后台</h1>

        <!-- 成功消息 -->
        <c:if test="${param.success == 'true'}">
            <div class="message success">
                ${param.message}
            </div>
        </c:if>

        <!-- 错误消息 -->
        <c:if test="${param.error == 'true'}">
            <div class="message error">
                ${param.message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${param.page == 'list'}">
                <div class="form-title">
                    <i class="fas fa-list"></i>
                    景点列表
                </div>
                
                <!-- 添加搜索和筛选功能 -->
                <div class="filter-section">
                    <input type="text" id="searchInput" placeholder="搜索景点..." class="search-input">
                    <select id="categoryFilter" class="filter-select">
                        <option value="">所有分类</option>
                        <option value="自然风光">自然风光</option>
                        <option value="人文古迹">人文古迹</option>
                        <option value="红色文化">红色文化</option>
                        <option value="科技文化">科技文化</option>
                        <option value="宗教寺庙">宗教寺庙</option>
                    </select>
                    <select id="levelFilter" class="filter-select">
                        <option value="">所有等级</option>
                        <option value="5A">5A</option>
                        <option value="4A">4A</option>
                        <option value="3A">3A</option>
                    </select>
                </div>

                <div class="table-container">
                    <table class="attraction-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>景点名称</th>
                                <th>城市</th>
                                <th>分类</th>
                                <th>等级</th>
                                <th>门票价格</th>
                                <th>开放时间</th>
                                <th>建议游玩</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${attractions}" var="attraction">
                                <tr>
                                    <td>${attraction.id}</td>
                                    <td>
                                        <span class="attraction-name" title="${attraction.description}">
                                            ${attraction.name}
                                        </span>
                                    </td>
                                    <td>${attraction.city}</td>
                                    <td><span class="category-tag">${attraction.categoryName}</span></td>
                                    <td><span class="level-badge">${attraction.level}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${attraction.ticketPrice == 0}">
                                                <span class="free-tag">免费</span>
                                            </c:when>
                                            <c:otherwise>
                                                ￥${attraction.ticketPrice}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${attraction.openingHours}</td>
                                    <td>${attraction.suggestedDuration}小时</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="edit-btn" onclick="editAttraction(${attraction.id})">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <form action="${pageContext.request.contextPath}/admin/attraction" 
                                                  method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${attraction.id}">
                                                <button type="submit" class="delete-btn" 
                                                        onclick="return confirm('确定要删除景点【${attraction.name}】吗？')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- 添加搜索和筛选功能的JavaScript -->
                <script>
                    document.getElementById('searchInput').addEventListener('input', filterTable);
                    document.getElementById('categoryFilter').addEventListener('change', filterTable);
                    document.getElementById('levelFilter').addEventListener('change', filterTable);

                    function filterTable() {
                        const searchText = document.getElementById('searchInput').value.toLowerCase();
                        const categoryFilter = document.getElementById('categoryFilter').value;
                        const levelFilter = document.getElementById('levelFilter').value;
                        const rows = document.querySelectorAll('.attraction-table tbody tr');

                        rows.forEach(row => {
                            const name = row.cells[1].textContent.toLowerCase();
                            const category = row.cells[3].textContent;
                            const level = row.cells[4].textContent;
                            const matchesSearch = name.includes(searchText);
                            const matchesCategory = !categoryFilter || category === categoryFilter;
                            const matchesLevel = !levelFilter || level === levelFilter;

                            row.style.display = matchesSearch && matchesCategory && matchesLevel ? '' : 'none';
                        });
                    }

                    function editAttraction(id) {
                        // 获取当前行的数据
                        const row = event.target.closest('tr');
                        const name = row.cells[1].querySelector('.attraction-name').textContent.trim();
                        const city = row.cells[2].textContent.trim();
                        const category = row.cells[3].textContent.trim();
                        const level = row.cells[4].textContent.trim();
                        const price = row.cells[5].textContent.trim().replace('￥', '').replace('免费', '0');
                        const hours = row.cells[6].textContent.trim();
                        const duration = row.cells[7].textContent.trim().replace('小时', '');
                        const description = row.cells[1].querySelector('.attraction-name').getAttribute('title');

                        // 填充表单
                        document.getElementById('edit_id').value = id;
                        document.getElementById('edit_name').value = name;
                        document.getElementById('edit_city').value = city;
                        document.getElementById('edit_level').value = level;
                        document.getElementById('edit_ticket_price').value = price;
                        document.getElementById('edit_opening_hours').value = hours;
                        document.getElementById('edit_suggested_duration').value = duration;
                        document.getElementById('edit_description').value = description;

                        // 设置分类
                        const categorySelect = document.getElementById('edit_category_id');
                        for (let i = 0; i < categorySelect.options.length; i++) {
                            if (categorySelect.options[i].text === category) {
                                categorySelect.selectedIndex = i;
                                break;
                            }
                        }

                        // 显示弹窗
                        document.getElementById('editModal').style.display = 'block';
                    }

                    function closeEditModal() {
                        document.getElementById('editModal').style.display = 'none';
                    }

                    // 点击弹窗外部关闭
                    window.onclick = function(event) {
                        const modal = document.getElementById('editModal');
                        if (event.target == modal) {
                            closeEditModal();
                        }
                    }
                </script>
            </c:when>
            <c:otherwise>
                <!-- 添加景点表单 -->
                <div class="form-title">
                    <i class="fas fa-plus"></i>
                    添加新景点
                </div>
                <form action="${pageContext.request.contextPath}/admin/attraction" method="post">
                    <div class="form-group">
                        <label for="name">景点名称：</label>
                        <input type="text" id="name" name="name" required>
                    </div>

                    <div class="form-group">
                        <label for="city">所在城市：</label>
                        <input type="text" id="city" name="city" value="绵阳" required>
                    </div>

                    <div class="form-group">
                        <label for="category_id">景点分类：</label>
                        <select id="category_id" name="category_id" required>
                            <option value="1">自然风光</option>
                            <option value="2">人文古迹</option>
                            <option value="3">红色文化</option>
                            <option value="4">科技文化</option>
                            <option value="5">宗教寺庙</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="level">景区等级：</label>
                        <select id="level" name="level" required>
                            <option value="5A">5A</option>
                            <option value="4A">4A</option>
                            <option value="3A">3A</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="description">景点描述：</label>
                        <textarea id="description" name="description" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="ticket_price">门票价格：</label>
                        <input type="number" id="ticket_price" name="ticket_price" min="0" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label for="opening_hours">开放时间：</label>
                        <input type="text" id="opening_hours" name="opening_hours" placeholder="例如：09:00-17:00" required>
                    </div>

                    <div class="form-group">
                        <label for="suggested_duration">建议游玩时长（小时）：</label>
                        <input type="number" id="suggested_duration" name="suggested_duration" min="1" required>
                    </div>

                    <button type="submit">
                        <i class="fas fa-plus"></i>
                        添加景点
                    </button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 在 body 标签结束前添加修改弹窗 -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeEditModal()">&times;</span>
            <h2>修改景点信息</h2>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/attraction" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="edit_id">
                
                <div class="form-group">
                    <label for="edit_name">景点名称：</label>
                    <input type="text" id="edit_name" name="name" required>
                </div>

                <div class="form-group">
                    <label for="edit_city">所在城市：</label>
                    <input type="text" id="edit_city" name="city" required>
                </div>

                <div class="form-group">
                    <label for="edit_category_id">景点分类：</label>
                    <select id="edit_category_id" name="category_id" required>
                        <option value="1">自然风光</option>
                        <option value="2">人文古迹</option>
                        <option value="3">红色文化</option>
                        <option value="4">科技文化</option>
                        <option value="5">宗教寺庙</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="edit_level">景区等级：</label>
                    <select id="edit_level" name="level" required>
                        <option value="5A">5A</option>
                        <option value="4A">4A</option>
                        <option value="3A">3A</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="edit_ticket_price">门票价格：</label>
                    <input type="number" id="edit_ticket_price" name="ticket_price" min="0" step="0.01" required>
                </div>

                <div class="form-group">
                    <label for="edit_opening_hours">开放时间：</label>
                    <input type="text" id="edit_opening_hours" name="opening_hours" required>
                </div>

                <div class="form-group">
                    <label for="edit_suggested_duration">建议游玩时长（小时）：</label>
                    <input type="number" id="edit_suggested_duration" name="suggested_duration" min="1" required>
                </div>

                <div class="form-group">
                    <label for="edit_description">景点描述：</label>
                    <textarea id="edit_description" name="description" required></textarea>
                </div>

                <button type="submit">保存修改</button>
            </form>
        </div>
    </div>
</body>
</html>