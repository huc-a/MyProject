<%@page import="com.shop.entity.AdminUser"%>
<%@page import="com.shop.service.AdminUserService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员用户管理</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/table.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/input.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/button.css">
</head>
<body>
<iframe src="<%=request.getContextPath()%>/common/top.jsp" class="top"></iframe>
<iframe src="<%=request.getContextPath()%>/common/left.jsp" class="left"></iframe>
<div class="main">
    <div class="content">
        <div class="table_div">
            <form action="<%=request.getContextPath() %>/adminUserList.jsp" method="get">
                <label for="username">用户名</label>
                <input class="input" id="username" name="username" type="text"
                       value="<%=request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                <button class="button_action">搜索</button>
            </form>
            <br>
            <a href="<%=request.getContextPath() %>/adminUserAdd.jsp" class="button_atag" style="float: left">添加管理员</a>
            <br><br>
            <div class="table_box">
                <table class="table" style="width: 100%">
                    <thead>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>真实姓名</th>
                    <th>性别</th>
                    <th>生日</th>
                    <th>创建日期</th>
                    <th>更新时间</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <%
                        String username = request.getParameter("username");

                        AdminUserService adminUserService = new AdminUserService();

                        // 查询所有管理员用户
                        List<AdminUser> adminUsers = adminUserService.getAllAdminUser(username);

                        request.setAttribute("adminUsers", adminUsers);
                    %>
                    <c:forEach var="item" items="${adminUsers}">
                        <tr>
                            <td>${item.username}</td>
                            <td>${item.password}</td>
                            <td>${item.realName}</td>
                            <td>${item.sex}</td>
                            <td>${item.birthday}</td>
                            <td>${item.createDatetime}</td>
                            <td>${item.updateDatetime}</td>
                            <td>
                                <c:if test="${item.username != 'admin'}">
                                    <a href="<%=request.getContextPath() %>/adminUserUpdate.jsp?username=${item.username}">更新</a> |
                                    <a href="<%=request.getContextPath() %>/AdminUserDeleteServlet?username=${item.username}">删除</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
