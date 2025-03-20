<%@page import="com.shop.entity.AdminUser"%>
<%@page import="com.shop.service.AdminUserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>更新管理员用户</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/common.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/css/form.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/css/button.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/css/input.css">
</head>
<body>
    <iframe src="<%=request.getContextPath()%>/common/top.jsp" class="top"></iframe>
	<iframe src="<%=request.getContextPath()%>/common/left.jsp" class="left"></iframe>
    <div class="main">
        <div class="content">
            <div class="form_div">
                <a href="<%=request.getContextPath() %>/adminUserList.jsp" class="button_back">＜返回</a>
                <br>
                <br>
                <div style="text-align: center;color: green">${successMsg}</div>
                <div style="text-align: center;color: red">${errorMsg}</div>
                <%
                    // 在request中获取出需要修改的管理员用户的username
                    String adminUserUsername = request.getParameter("username");

                    // 根据username查询管理员用户详情
                    AdminUserService adminUserService = new AdminUserService();
                    AdminUser adminUser = adminUserService.getAdminUserByUsername(adminUserUsername);
                    request.setAttribute("adminUser", adminUser);
                %>
                <div class="form_box">
                    <form action="<%=request.getContextPath() %>/AdminUserUpdateServlet" method="post" class="form">
                        <table class="table">
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <h2>更新管理员用户</h2>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="username">用户名</label>
                                </td>
                                <td>
                                    <input id="username" type="text" name="username" required="required" value="${adminUser.username}" class="input" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="password">密码</label>
                                </td>
                                <td>
                                    <input id="password" type="text" name="password" required="required" value="${adminUser.password}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="realName">真实姓名</label>
                                </td>
                                <td>
                                    <input id="realName" type="text" name="realName" required="required" value="${adminUser.realName}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="sex">性别</label>
                                </td>
                                <td>
                                    <select id="sex" name="sex" required="required" class="input">
                                        <option value="男"
                                                <c:if test="${adminUser.sex == '男'}">selected</c:if>>男</option>
                                        <option value="女"
                                                <c:if test="${adminUser.sex == '男'}">selected</c:if>>女</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="birthday">生日</label>
                                </td>
                                <td>
                                    <input id="birthday" type="date" name="birthday" required="required" value="${adminUser.birthday}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <button class="button_action">更新</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
		</div>
    </div>
</body>
</html>
