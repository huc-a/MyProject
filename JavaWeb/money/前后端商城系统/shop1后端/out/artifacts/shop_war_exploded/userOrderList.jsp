<%@page import="com.shop.entity.Order"%>
<%@page import="com.shop.service.OrderService"%>
<%@page import="java.util.List"%>
<%@ page import="com.shop.entity.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单管理</title>
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
            <br><br>
            <div class="table_box">
                <table class="table" style="width: 100%">
                    <thead>
                    <th>订单编号</th>
                    <th>总价格</th>
                    <th>状态</th>
                    <th>下单时间</th>
                    <th>发货时间</th>
                    <th>签收时间</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <%
                        //                                String fieldName = request.getParameter("fieldName");

                        OrderService orderService = new OrderService();

                        User loginCust = (User) request.getSession().getAttribute("loginCust");

                        // 查询所有订单
                        List<Order> orders = orderService.getAllOrder(loginCust.getPhone());

                        request.setAttribute("orders", orders);
                    %>
                    <c:if test="${ orders.size() == 0 }">
                        <tr>
                            <td colspan="7">
                                暂无订单
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="item" items="${orders}">
                        <tr>
                            <td>${item.id}</td>
                            <td>${item.totalPrice}</td>
                            <td style="color: red">
                                <c:if test="${ item.issueDatetime == null }">待发货</c:if>
                                <c:if test="${ item.issueDatetime != null && item.receivedDatetime == null }">待收货</c:if>
                                <c:if test="${ item.issueDatetime != null && item.receivedDatetime !=null }">已完成</c:if>
                            </td>
                            <td>${item.createDatetime}</td>
                            <td>${item.issueDatetime}</td>
                            <td>${item.receivedDatetime}</td>

                            <td>
                                <a href="<%=request.getContextPath() %>/orderDetailsList.jsp?id=${item.id}">详情</a>
                                <c:if test="${ item.issueDatetime != null && item.receivedDatetime == null }">
                                    &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath() %>/ReceivedGoodsServlet?id=${item.id}">收货</a>
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
