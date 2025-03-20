<%@page import="com.shop.entity.User"%>
<%@page import="com.shop.service.UserService"%>
<%@ page import="com.shop.entity.AdminUser" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>更新用户</title>
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
                <%
                    AdminUser loginUser = (AdminUser) request.getSession().getAttribute("loginUser");
                    request.setAttribute("loginUserUserUpdatePageUse", loginUser);
                 %>
                <c:if test="${ loginUserUserUpdatePageUse != null }">
                    <a href="<%=request.getContextPath() %>/userList.jsp" class="button_back">＜返回</a>
                </c:if>
                <br>
                <br>
                <div style="text-align: center;color: green">${successMsg}</div>
                <div style="text-align: center;color: red">${errorMsg}</div>
                <%
                    // 在request中获取出需要修改的用户的phone
                    String userPhone = request.getParameter("phone");

                    // 根据phone查询用户详情
                    UserService userService = new UserService();
                    User user = userService.getUserByPhone(userPhone);
                    request.setAttribute("user", user);
                %>
                <div class="form_box">
                    <form action="<%=request.getContextPath() %>/UserUpdateServlet" method="post" class="form">
                        <table class="table">
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <h2>更新用户</h2>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="phone">手机号</label>
                                </td>
                                <td>
                                    <input id="phone" type="text" name="phone" required="required" value="${user.phone}" class="input" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="username">用户名</label>
                                </td>
                                <td>
                                    <input id="username" type="text" name="username" required="required" value="${user.username}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="password">密码</label>
                                </td>
                                <td>
                                    <input id="password" type="text" name="password" required="required" value="${user.password}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="realName">真实姓名</label>
                                </td>
                                <td>
                                    <input id="realName" type="text" name="realName" required="required" value="${user.realName}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="sex">性别</label>
                                </td>
                                <td>
                                    <select id="sex" name="sex" required="required" class="input">
                                        <option value="男"
                                                <c:if test="${user.sex == '男'}">selected</c:if>>男</option>
                                        <option value="女"
                                                <c:if test="${user.sex == '女'}">selected</c:if>>女</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="birthday">生日</label>
                                </td>
                                <td>
                                    <input id="birthday" type="date" name="birthday" required="required" value="${user.birthday}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="address">收货地址</label>
                                </td>
                                <td>
                                    <input id="address" type="text" name="address" required="required" value="${user.address}" class="input">
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
