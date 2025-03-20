<%@page import="com.shop.entity.ShopCar"%>
<%@page import="com.shop.service.ShopCarService"%>
<%@page import="java.util.List"%>
<%@ page import="com.shop.entity.User" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>购物车管理</title>
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
            <form action="<%=request.getContextPath() %>/shopCarList.jsp" method="get">
                <%--                    <label for="fieldName">查询字段名</label>--%>
                <%--                    <input class="input" id="fieldName" name="fieldName" type="text"--%>
                <%--                           value="<%=request.getParameter("fieldName") != null ? request.getParameter("fieldName") : "" %>">--%>
<%--                <button class="button_action">搜索</button>--%>
            </form>
            <br><br>
            <div class="table_box">
                <table class="table" style="width: 100%">
                    <thead>
                    <th>商品名</th>
                    <th>品牌</th>
                    <th>图片</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <%
                        //                                String fieldName = request.getParameter("fieldName");

                        ShopCarService shopCarService = new ShopCarService();

                        User loginCust = (User) request.getSession().getAttribute("loginCust");

                        // 查询所有购物车
                        List<ShopCar> shopCars = shopCarService.getAllShopCar(loginCust.getPhone());

                        request.setAttribute("shopCars", shopCars);
                    %>
                    <c:if test="${ shopCars.size() == 0 }">
                        <tr>
                            <td colspan="6">
                                购物车暂无商品，快去添加吧
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="item" items="${shopCars}">
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
                            <td>
                                <a href="<%=request.getContextPath() %>/ShopCarUpdateServlet?flag=reduce&&id=${item.id}" style="margin-right: 10px;cursor: pointer;user-select: none;" >➖</a>
                                    ${item.count}
                                <c:if test="${ item.goodsInfo.stock != 0 }">
                                    <a href="<%=request.getContextPath() %>/ShopCarUpdateServlet?flag=add&&id=${item.id}" style="margin-left: 10px;cursor: pointer;user-select: none;">➕</a>
                                </c:if>
                            </td>
                            <td>${ item.subTotal }</td>
                            <td>
                                <a href="<%=request.getContextPath() %>/ShopCarDeleteServlet?id=${item.id}">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${ shopCars.size() != 0 }">
                <div style="margin-top: 15px">
                    <a href="<%=request.getContextPath() %>/OrderAddServlet" class="button_atag" style="float: right;">结算</a>
                    <%
                        BigDecimal sum = new BigDecimal(0);
                        for (ShopCar item: shopCars) {
                            sum = sum.add(item.getGoodsInfo().getPrice().multiply(new BigDecimal(item.getCount())));
                        }
                        request.setAttribute("sum", sum);
                    %>
                    <span style="float: right; color: red; font-size: 25px; font-weight: bolder; margin-right: 10px">总价：${sum }</span>
                </div>
            </c:if>

        </div>
    </div>
</div>
</body>
</html>
