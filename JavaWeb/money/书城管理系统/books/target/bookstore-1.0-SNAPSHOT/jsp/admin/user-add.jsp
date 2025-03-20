<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户 - 书城管理系统</title>
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
        <h2>添加用户</h2>
        <form id="addForm">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="realName">姓名</label>
                <input type="text" id="realName" name="realName" required>
            </div>
            
            <div class="form-group">
                <label for="phone">手机号</label>
                <input type="text" id="phone" name="phone">
            </div>
            
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email">
            </div>
            
            <button type="button" onclick="createUser()" class="btn btn-primary">保存</button>
        </form>
    </div>

    <script>
    function createUser() {
        const formData = new FormData(document.getElementById('addForm'));
        const data = new URLSearchParams();
        for (const pair of formData) {
            data.append(pair[0], pair[1]);
        }
        
        fetch('${pageContext.request.contextPath}/user/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: data
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                alert('添加成功');
                window.location.href = '${pageContext.request.contextPath}/user/list';
            } else {
                alert('添加失败');
            }
        });
    }
    </script>
</body>
</html> 