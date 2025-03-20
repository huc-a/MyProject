<%@page import="com.shop.entity.User"%>
<%@page import="com.shop.service.UserService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
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
            <form action="<%=request.getContextPath() %>/userList.jsp" method="get">
                <label for="phone">手机号</label>
                <input class="input" id="phone" name="phone" type="text"
                       value="<%=request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
                <label for="realName">真实姓名</label>
                <input class="input" id="realName" name="realName" type="text"
                       value="<%=request.getParameter("realName") != null ? request.getParameter("realName") : "" %>">
                <button class="button_action">搜索</button>
            </form>
            <br>
            <a href="<%=request.getContextPath() %>/userAdd.jsp" class="button_atag" style="float: left">添加用户</a>
            <br><br>
            <div class="table_box">
                <table class="table" style="width: 100%">
                    <thead>
                    <th>手机号</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>真实姓名</th>
                    <th>性别</th>
                    <th>生日</th>
                    <th>收货地址</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <%
                        String phone = request.getParameter("phone");
                        String realName = request.getParameter("realName");

                        UserService userService = new UserService();

                        // 查询所有用户
                        List<User> users = userService.getAllUser(phone, realName);

                        request.setAttribute("users", users);
                    %>
                    <c:forEach var="item" items="${users}">
                        <tr>
                            <td>${item.phone}</td>
                            <td>${item.username}</td>
                            <td>${item.password}</td>
                            <td>${item.realName}</td>
                            <td>${item.sex}</td>
                            <td>${item.birthday}</td>
                            <td>${item.address}</td>
                            <td>${item.createDatetime}</td>
                            <td>${item.updateDatetime}</td>
                            <td>
                                <a href="<%=request.getContextPath() %>/userUpdate.jsp?phone=${item.phone}">更新</a> |
                                <a href="<%=request.getContextPath() %>/UserDeleteServlet?phone=${item.phone}">删除</a>
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
