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
		<h1>顾客登录</h1>
		<div class="msg">${errorMsg}</div>
		<form action="<%=request.getContextPath() %>/CustLoginServlet" method="post">
			<label for="phone">手机号：</label>
			<input id="phone" type="text" name="phone" required placeholder="请输入手机号" class="input"><br><br>
			<label for="password">密码：</label>
			<input id="password" type="password" name="password" required placeholder="请输入密码" class="input"><br><br>
			<button class="button_login">登录</button>
			<a href="<%=request.getContextPath() %>/userRegister.jsp" class="button_go_register">注册</a>
			<a href="<%=request.getContextPath()%>/adminLogin.jsp" class="button_go_admin">使用管理员登录</a>
		</form>
	</div>
</body>
</html>