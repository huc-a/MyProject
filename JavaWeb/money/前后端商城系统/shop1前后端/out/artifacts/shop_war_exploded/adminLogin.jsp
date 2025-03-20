<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
</head>
<body>
	<div class="login-div">
		<h1>管理员登录</h1>
		<div class="msg">${errorMsg}</div>
		<form action="<%=request.getContextPath() %>/AdminLoginServlet" method="post">
			<label for="username">用户名：</label>
			<input id="username" type="text" name="username" required placeholder="请输入用户名" class="input"><br><br>
			<label for="password">密码：</label>
			<input id="password" type="password" name="password" required placeholder="请输入密码" class="input"><br><br>
			<button class="button_login">登录</button>
			<a href="<%=request.getContextPath()%>/userLogin.jsp" class="button_go_admin">使用顾客登录</a>
		</form>
	</div>
</body>
</html>