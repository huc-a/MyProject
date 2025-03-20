<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <style>
        /* 整体页面样式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        /* 标题样式 */
        h1 {
            text-align: center;
            color: #333;
            margin-top: 50px;
        }

        /* 表单相关样式 */
        form {
            width: 400px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #333;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #555;
        }

        /* 错误提示信息样式 */
        div {
            text-align: center;
            margin-top: 20px;
        }

        p {
            margin: 0;
            padding: 10px;
            border-radius: 5px;
            color: #721c24;
            background-color: #f8d7da;
        }
    </style>
</head>
<body>
<h1>用户注册</h1>
<form action="/register" method="post">
    <label for="username">用户名:</label>
    <input type="text" id="username" name="username" required><br>
    <label for="password">密码:</label>
    <input type="password" id="password" name="password" required><br>
    <label for="confirmPassword">确认密码:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required><br>
    <input type="submit" value="注册">
</form>
<div>
    <% if (request.getParameter("error")!= null) { %>
    <p>注册失败，请重试。</p>
    <% } %>
</div>
</body>
</html>