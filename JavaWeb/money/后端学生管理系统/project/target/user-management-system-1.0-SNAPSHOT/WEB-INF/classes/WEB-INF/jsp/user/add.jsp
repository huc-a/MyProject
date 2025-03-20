<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="form-container">
        <h1>添加用户</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error">${error}</div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/user/add" method="post">
            <div class="form-group">
                <label for="username">用户名：</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="role">角色：</label>
                <select id="role" name="role" required>
                    <option value="user">普通用户</option>
                    <option value="admin">管理员</option>
                </select>
            </div>
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-secondary" onclick="history.back()">返回</button>
            </div>
        </form>
    </div>
</body>
</html> 