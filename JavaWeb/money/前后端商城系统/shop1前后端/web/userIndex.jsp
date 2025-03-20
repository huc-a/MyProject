<%@page import="com.shop.entity.Goods"%>
<%@page import="com.shop.service.GoodsService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
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
                List<Goods> goodss = null;
                try {
                    String name = request.getParameter("name");
                    String brand = request.getParameter("brand");
                    GoodsService goodsService = new GoodsService();
                    goodss = goodsService.getAllGoods(name, brand);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMsg", "系统错误：" + e.getMessage());
                }
                request.setAttribute("goodss", goodss);
            %>
            <form action="<%=request.getContextPath() %>/userIndex.jsp" method="get">
                <label for="name">名称</label>
                <input class="input" id="name" name="name" type="text"
                       value="<%=request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                <label for="brand">类别</label>
                <input class="input" id="brand" name="brand" type="text"
                       value="<%=request.getParameter("brand") != null ? request.getParameter("brand") : "" %>">
                <button class="button_action">搜索</button>
            </form>
            <br>
            <div style="text-align: center;color: green">${successMsg}</div>
            <div style="text-align: center;color: red">${errorMsg}</div>
            <br>
            <div class="list">
                <c:forEach var="item" items="${goodss}">
                    <div class="list_item">
                        <div class="list_item_info">
                            <div class="list_item_info_img">
                                <img src="<%=request.getContextPath()%>/GetImgServlet?imgPath=${ item.fileName }">
                            </div>
                            <span class="list_item_info_title">${ item.name }</span>
                            <span class="list_item_info_price">${ item.price }</span>
                            <a class="list_item_info_jump" href="<%=request.getContextPath() %>/goodsInfo.jsp?goodsId=${item.id}">详情</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
