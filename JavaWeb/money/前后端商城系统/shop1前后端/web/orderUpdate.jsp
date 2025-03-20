<%@page import="com.shop.entity.Order"%>
<%@page import="com.shop.service.OrderService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>更新订单</title>
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
                <a href="<%=request.getContextPath() %>/orderList.jsp" class="button_back">＜返回</a>
                <br>
                <br>
                <div style="text-align: center;color: green">${successMsg}</div>
                <div style="text-align: center;color: red">${errorMsg}</div>
                <%
                    // 在request中获取出需要修改的订单的id
                    String orderId = request.getParameter("id");

                    // 根据id查询订单详情
                    OrderService orderService = new OrderService();
                    Order order = orderService.getOrderById(orderId);
                    request.setAttribute("order", order);
                %>
                <div class="form_box">
                    <form action="<%=request.getContextPath() %>/OrderUpdateServlet" method="post" class="form">
                        <table class="table">
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <h2>更新订单</h2>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="id">主键id</label>
                                </td>
                                <td>
                                    <input id="id" type="text" name="id" required="required" value="${order.id}" class="input" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="userPhone">用户名</label>
                                </td>
                                <td>
                                    <input id="userPhone" type="text" name="userPhone" required="required" value="${order.userPhone}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="totalPrice">总价格</label>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="issueDatetime">发货时间</label>
                                </td>
                                <td>
                                    <input id="issueDatetime" type="date" name="issueDatetime" required="required" value="${order.issueDatetime}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="receivedDatetime">签收时间</label>
                                </td>
                                <td>
                                    <input id="receivedDatetime" type="date" name="receivedDatetime" required="required" value="${order.receivedDatetime}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="createDatetime">创建日期</label>
                                </td>
                                <td>
                                    <input id="createDatetime" type="date" name="createDatetime" required="required" value="${order.createDatetime}" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="updateDatetime">更新时间</label>
                                </td>
                                <td>
                                    <input id="updateDatetime" type="date" name="updateDatetime" required="required" value="${order.updateDatetime}" class="input">
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
