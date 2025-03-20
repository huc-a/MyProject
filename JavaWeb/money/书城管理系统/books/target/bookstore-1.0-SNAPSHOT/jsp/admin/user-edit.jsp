<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>编辑用户 - 书城管理系统</title>
    <style>
        .container {
            margin-top: 130px;
            padding: 20px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
        }
        .btn-primary { background-color: #007bff; }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/nav.jsp"/>
    
    <div class="container">
        <h2>编辑用户</h2>
        <form id="editForm">
            <input type="hidden" name="id" value="${user.id}">
            
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" value="${user.username}" required>
            </div>
            
            <div class="form-group">
                <label for="realName">姓名</label>
                <input type="text" id="realName" name="realName" value="${user.realName}" required>
            </div>
            
            <div class="form-group">
                <label for="phone">手机号</label>
                <input type="text" id="phone" name="phone" value="${user.phone}">
            </div>
            
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email" value="${user.email}">
            </div>
            
            <button type="button" onclick="updateUser()" class="btn btn-primary">保存</button>
        </form>
    </div>

    <script>
    function updateUser() {
        const formData = new FormData(document.getElementById('editForm'));
        const data = new URLSearchParams();
        for (const pair of formData) {
            data.append(pair[0], pair[1]);
        }
        
        fetch('${pageContext.request.contextPath}/user/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                alert('更新成功');
                window.location.href = '${pageContext.request.contextPath}/user/list';
            } else {
                alert('更新失败');
            }
        });
    }
    </script>
</body>
</html> 