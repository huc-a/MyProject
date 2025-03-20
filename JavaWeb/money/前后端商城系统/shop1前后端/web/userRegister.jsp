<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/register.css">
</head>
<body>
	<div class="register-div">
		<h1>注册</h1>
		<div class="success_msg">${successMsg}</div>
		<div class="error_msg">${errorMsg}</div>
		<form action="<%=request.getContextPath() %>/CustRegisterServlet" method="post">
			<label for="phone">手机号：</label>
			<input id="phone" type="text" name="phone" required="required" class="input">
			<label for="username">用户名：</label>
			<input id="username" type="text" name="username" required="required" class="input">
			<label for="password">密码：</label>
			<input id="password" type="text" name="password" required="required" class="input">
			<label for="realName">真实姓名：</label>
			<input id="realName" type="text" name="realName" required="required" class="input">
			<label for="sex">性别：</label>
			<select id="sex" name="sex" required="required" class="input">
				<option value="男">男</option>
				<option value="女">女</option>
			</select>
			<label for="birthday">生日：</label>
			<input id="birthday" type="date" name="birthday" required="required" class="input">
			<label for="address">收货地址：</label>
			<input id="address" type="text" name="address" required="required" class="input">
			<button class="button_register">注册</button>
			<a href="<%=request.getContextPath()%>/userLogin.jsp" class="button_go_login">去登录</a>
		</form>

	</div>

</body>
</html>