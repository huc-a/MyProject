<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑学生</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="form-container">
        <h1>编辑学生</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <p class="error">${error}</p>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/student/edit" method="post">
            <input type="hidden" name="studentId" value="${student.studentId}">
            <div class="form-group">
                <label for="studentName">姓名：</label>
                <input type="text" id="studentName" name="studentName" value="${student.studentName}" required>
            </div>
            <div class="form-group">
                <label for="studentGender">性别：</label>
                <select id="studentGender" name="studentGender" required>
                    <option value="">请选择</option>
                    <option value="男" ${student.studentGender == '男' ? 'selected' : ''}>男</option>
                    <option value="女" ${student.studentGender == '女' ? 'selected' : ''}>女</option>
                </select>
            </div>
            <div class="form-group">
                <label for="studentAge">年龄：</label>
                <input type="number" id="studentAge" name="studentAge" value="${student.studentAge}" min="1" max="150" required>
            </div>
            <div class="form-group">
                <label for="studentClass">班级：</label>
                <input type="text" id="studentClass" name="studentClass" value="${student.studentClass}" required>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-secondary" onclick="history.back()">返回</button>
            </div>
        </form>
    </div>
</body>
</html> 