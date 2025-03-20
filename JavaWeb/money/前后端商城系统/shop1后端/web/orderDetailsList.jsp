<%@page import="com.shop.entity.OrderDetails"%>
<%@page import="com.shop.service.OrderDetailsService"%>
<%@page import="java.util.List"%>
<%@ page import="com.shop.service.OrderService" %>
<%@ page import="com.shop.entity.User" %>
<%@ page import="com.shop.entity.AdminUser" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单详情管理</title>
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
            <%
                User loginCust = (User) request.getSession().getAttribute("loginCust");
                AdminUser loginUser = (AdminUser) request.getSession().getAttribute("loginUser");
                request.setAttribute("loginCustOrderDetailUse", loginCust);
                request.setAttribute("loginUserOrderDetailUse", loginUser);
             %>
            <c:if test="${ loginCustOrderDetailUse != null }">
                <a href="<%=request.getContextPath() %>/userOrderList.jsp" class="button_back">＜返回</a>
            </c:if>
            <c:if test="${ loginUserOrderDetailUse != null }">
                <a href="<%=request.getContextPath() %>/orderList.jsp" class="button_back">＜返回</a>
            </c:if>

            <br><br>
            <%
                String orderId = request.getParameter("id");

                OrderDetailsService orderDetailsService = new OrderDetailsService();

                request.setAttribute("orderInformation", new OrderService().getOrderById(orderId));

                // 查询所有订单详情
                List<OrderDetails> orderDetailss = orderDetailsService.getAllOrderDetails(orderId);

                request.setAttribute("orderDetailss", orderDetailss);
            %>
            <div style="font-size: 28px; font-weight: bold;">
                订单编号：${ orderInformation.id }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                订单金额：${ orderInformation.totalPrice }
            </div>
            <div class="table_box">

                <table class="table" style="width: 100%">
                    <thead>
                    <th>名称</th>
                    <th>类别</th>
                    <th>图片</th>
                    <th>数量</th>
                    <th>小计</th>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${orderDetailss}">
                        <tr>
                            <td>${item.goodsInfo.name}</td>
                            <td>${item.goodsInfo.brand}</td>
                            <td>
                                <c:if test="${item.goodsInfo.fileName != null}">
                                    <img src="<%=request.getContextPath()%>/GetImgServlet?imgPath=${item.goodsInfo.fileName }" width="80" height="80">
                                </c:if>
                                <c:if test="${ item.goodsInfo.fileName == null }">
                                    暂无图片
                                </c:if>
                            </td>
                            <td>${item.count}</td>
                            <td>${item.subTotal}</td>

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
