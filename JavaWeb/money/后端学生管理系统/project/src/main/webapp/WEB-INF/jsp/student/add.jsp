<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加学生</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script>
        function validateForm() {
            var name = document.getElementById('studentName').value;
            var age = document.getElementById('studentAge').value;
            var className = document.getElementById('studentClass').value;
            
            if (name.length < 2 || name.length > 20) {
                alert('姓名长度必须在2-20个字符之间');
                return false;
            }
            
            if (age < 1 || age > 150) {
                alert('年龄必须在1-150岁之间');
                return false;
            }
            
            if (className.length < 2 || className.length > 50) {
                alert('班级名称长度必须在2-50个字符之间');
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="nav-brand">学生管理系统</a>
            <div class="nav-menu">
                <a href="${pageContext.request.contextPath}/students" class="nav-link">学生列表</a>
                <a href="${pageContext.request.contextPath}/student/add" class="nav-link active">添加学生</a>
            </div>
        </div>
    </nav>
    <div class="form-container">
        <h1>添加学生</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <p class="error">${error}</p>
        <% } %>
        
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
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-secondary" onclick="history.back()">返回</button>
            </div>
        </form>
    </div>
</body>
</html> 