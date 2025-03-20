<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>学生列表 - 学生管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script>
        function openAddModal() {
            document.getElementById('addStudentModal').style.display = 'flex';
        }
        
        function closeAddModal() {
            document.getElementById('addStudentModal').style.display = 'none';
        }
        
        // 点击模态框外部关闭
        window.onclick = function(event) {
            if (event.target == document.getElementById('addStudentModal')) {
                closeAddModal();
            }
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/students" class="nav-brand">
                <i class="fas fa-graduation-cap"></i>
                学生管理系统
            </a>
            <div class="nav-menu">
                <a href="${pageContext.request.contextPath}/students" class="nav-link active">
                    <i class="fas fa-list"></i> 学生列表
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="fas fa-sign-out-alt"></i> 退出登录
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="header-container">
            <h1><i class="fas fa-users"></i> 学生列表</h1>
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/students" method="get" class="search-form">
                    <div class="search-input-group">
                        <i class="fas fa-search"></i>
                        <input type="text" name="keyword" value="${param.keyword}" 
                               placeholder="搜索学生姓名或班级...">
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> 搜索
                    </button>
                </form>
                <button onclick="openAddModal()" class="btn btn-success">
                    <i class="fas fa-plus"></i> 添加学生
                </button>
            </div>
        </div>

        <% if (session.getAttribute("message") != null) { %>
            <div class="message success">
                <i class="fas fa-check-circle"></i>
                ${message}
            </div>
            <% session.removeAttribute("message"); %>
        <% } %>
        
        <% if (session.getAttribute("error") != null) { %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>年龄</th>
                        <th>班级</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty students}">
                            <tr class="empty-state">
                                <td colspan="6">
                                    <div class="empty-state-content">
                                        <i class="fas fa-inbox"></i>
                                        <p>暂无学生数据</p>
                                        <a href="${pageContext.request.contextPath}/student/add" 
                                           class="btn btn-primary">
                                            <i class="fas fa-plus"></i> 添加学生
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${students}" var="student">
                                <tr>
                                    <td>${student.studentId}</td>
                                    <td>${student.studentName}</td>
                                    <td>${student.studentGender}</td>
                                    <td>${student.studentAge}</td>
                                    <td>${student.studentClass}</td>
                                    <td class="table-actions">
                                        <a href="${pageContext.request.contextPath}/student/edit?id=${student.studentId}" 
                                           class="btn btn-small btn-primary" title="编辑">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/student/delete?id=${student.studentId}" 
                                           class="btn btn-small btn-danger" title="删除"
                                           onclick="return confirm('确定要删除该学生吗？')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 添加学生的模态框 -->
    <div id="addStudentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-user-plus"></i> 添加学生</h2>
                <span class="close" onclick="closeAddModal()">&times;</span>
            </div>
            <form action="${pageContext.request.contextPath}/student/add" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="studentName">姓名：</label>
                    <input type="text" id="studentName" name="studentName" required>
                </div>
                <div class="form-group">
                    <label for="studentGender">性别：</label>
                    <select id="studentGender" name="studentGender" required>
                        <option value="">请选择</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="studentAge">年龄：</label>
                    <input type="number" id="studentAge" name="studentAge" min="1" max="150" required>
                </div>
                <div class="form-group">
                    <label for="studentClass">班级：</label>
                    <input type="text" id="studentClass" name="studentClass" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeAddModal()">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html> 