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
            <form action="<%=request.getContextPath() %>/goodsList.jsp" method="get">
                <label for="name">名称</label>
                <input class="input" id="name" name="name" type="text"
                       value="<%=request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                <label for="brand">类别</label>
                <input class="input" id="brand" name="brand" type="text"
                       value="<%=request.getParameter("brand") != null ? request.getParameter("brand") : "" %>">
                <button class="button_action">搜索</button>
            </form>
            <br>
            <a href="<%=request.getContextPath() %>/goodsAdd.jsp" class="button_atag" style="float: left">添加商品</a>
            <br><br>
            <div class="table_box">
                <table class="table" style="width: 100%">
                    <thead>
                    <th>名称</th>
                    <th>类别</th>
                    <th>图片</th>
                    <th>价格</th>
                    <th>库存</th>
                    <th>简介</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <%
                        String name = request.getParameter("name");
                        String brand = request.getParameter("brand");

                        GoodsService goodsService = new GoodsService();

                        // 查询所有商品
                        List<Goods> goodss = goodsService.getAllGoods(name, brand);

                        request.setAttribute("goodss", goodss);
                    %>
                    <c:forEach var="item" items="${goodss}">
                        <tr>
                            <td>${item.name}</td>
                            <td>${item.brand}</td>
                            <td>
                                <c:if test="${item.fileName != null}">
                                    <img src="<%=request.getContextPath()%>/GetImgServlet?imgPath=${item.fileName }" width="80" height="80">
                                </c:if>
                                <c:if test="${ item.fileName == null }">
                                    暂无图片
                                </c:if>
                            </td>
                            <td>${item.price}</td>
                            <td>${item.stock}</td>
                            <td>${item.remark}</td>
                            <td>${item.createDatetime}</td>
                            <td>${item.updateDatetime}</td>
                            <td>
                                <a href="<%=request.getContextPath() %>/goodsUpdate.jsp?id=${item.id}">更新</a> |
                                <a href="<%=request.getContextPath() %>/GoodsDeleteServlet?id=${item.id}">删除</a>
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
