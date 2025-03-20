<%@ page import="com.shop.entity.AdminUser" %>
<%@ page import="com.shop.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .head {
            width: 100%;
            height: 60px;
            /*text-align: right;*/
            line-height: 60px;
            box-sizing: border-box;
            background-color: #fff;
            border-bottom: 1px solid #e3e3e3;
        }
        .head div:first-child {
            float: left;
            width: 50%;
            margin: 0 auto;
            height: 60px;
            text-align: left;
            line-height: 58px;
        }
        .head div:first-child .title{
            float: left;
            width: 20%;
            height: 60px;
        }
        .head div:first-child .title span {
            width: 100%;
            display: inline-block;
            font-size: 25px;
            font-weight: bold;
            text-align: center;
            background-color: #FCB792;
            color: white;
        }

        .head div:first-child div{
            float: left;
            width: 10%;
        }
        .head div:first-child .item {
            height: 60px;
            line-height: 60px;
            text-align: center;
            font-size: 15px;
            border-right: 1px solid#bebebe;
        }
        .head div:first-child .item{

            cursor: pointer;
        }
        .head div:first-child .item:hover {
            background-color: #f2f2f2;
        }
        .head .login_time{
            width: 20%;
            float: left;
        }
        .head .username{
            float: right;
            width: 5%;
            margin: 0 auto;
            height: 60px;
            text-align: center;
            line-height: 58px;
            background-color: #FCB792;
            color: white;
            font-size: 15px;
        }
    </style>
</head>
<body>
    <%
        AdminUser loginUser = (AdminUser) request.getSession().getAttribute("loginUser");
        User loginCust = (User)  request.getSession().getAttribute("loginCust");
        request.setAttribute("loginUserTopUse", loginUser);
        request.setAttribute("loginCustTopUse", loginCust);

        // 在Cookie中获取上次登录时间
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (loginCust != null) {
                    if (cookie.getName().equals(loginCust.getPhone() + "-lastLoginDate")) {
                        request.setAttribute("cust_lastLoginDate", cookie.getValue());
                    }
                    if (cookie.getName().equals(loginCust.getPhone() + "-lastLoginTime")) {
                        request.setAttribute("cust_lastLoginTime", cookie.getValue());
                    }
                }
                if (loginUser != null) {
                    if (cookie.getName().equals(loginUser.getUsername() + "-lastLoginDate")) {
                        request.setAttribute("admin_lastLoginDate", cookie.getValue());
                    }
                    if (cookie.getName().equals(loginUser.getUsername() + "-lastLoginTime")) {
                        request.setAttribute("admin_lastLoginTime", cookie.getValue());
                    }
                }

            }
        }
    %>
    <div class="head">
        <div>
            <div class="title">
                <span class="title">网上商城</span>
            </div>
            <c:if test="${loginUserTopUse == null && loginCustTopUse == null}">
                <div class="item" onclick="parent.location.href = '../userIndex.jsp'">
                    <span>首页</span>
                </div>
                <div class="item" onclick="parent.location.href = '../userLogin.jsp'">
                    <span>登录</span>
                </div>
            </c:if>

            <c:if test="${loginUserTopUse != null}">
                <div class="item" onclick="parent.location.href = '../goodsList.jsp'">
                    <span>商品管理</span>
                </div>
                <div class="item" onclick="parent.location.href = '../orderList.jsp'">
                    <span>订单管理</span>
                </div>
                <div class="item" onclick="parent.location.href = '../userList.jsp'">
                    <span>用户管理</span>
                </div>
                <div class="item" onclick="parent.location.href = '../adminUserList.jsp'">
                    <span>管理员管理</span>
                </div>
                <div class="item" onclick="parent.location.href = '<%=request.getContextPath()%>/AdminLogoutServlet'">
                    <span>退出</span>
                </div>

            </c:if>

            <c:if test="${loginCustTopUse != null}">
                <div class="item" onclick="parent.location.href = '../userIndex.jsp'">
                    <span>首页</span>
                </div>
                <div class="item" onclick="parent.location.href = '../shopCarList.jsp'">
                    <span>购物车</span>
                </div>
                <div class="item" onclick="parent.location.href = '../userOrderList.jsp'">
                    <span>我的订单</span>
                </div>
                <div class="item" onclick="parent.location.href = '../userUpdate.jsp?phone=${loginCustTopUse.phone}'">
                    <span>个人信息</span>
                </div>
                <div class="item" onclick="parent.location.href = '<%=request.getContextPath()%>/CustLogoutServlet'">
                    <span>退出</span>
                </div>

            </c:if>
        </div>

        <c:if test="${ admin_lastLoginDate != null}">
            <div class="login_time">
                上次登录时间：${ admin_lastLoginDate } ${ admin_lastLoginTime }
            </div>
        </c:if>
        <c:if test="${ cust_lastLoginDate != null}">
            <div class="login_time">
                上次登录时间：${ cust_lastLoginDate } ${ cust_lastLoginTime }
            </div>
        </c:if>

        <div class="username">

            <c:if test="${ loginUserTopUse != null }">
                ${ loginUserTopUse.realName }
            </c:if>
            <c:if test="${ loginCustTopUse != null }">
                ${ loginCustTopUse.realName }
            </c:if>
        </div>
    </div>
</body>
</html>
