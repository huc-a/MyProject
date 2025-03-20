<%@page import="com.shop.entity.Goods" %>
<%@page import="com.shop.service.GoodsService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品详情</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/form.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/button.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/input.css">
    <style>
        .info_title{
            width: 100%;
            height: auto;
            text-align: center;
            font-weight: bolder;
            font-size: 30px;
        }
        .info_img {
            width: 50%;
            height: auto;
            float: left;
            margin-top: 20px;
        }
        .info_img img {
            width: 500px;
            height: 500px;
            float: right;
        }
        .info_content {
            width: 50%;
            height:auto;
            float: left;
            padding-top: 50px;
        }
        .info_content h1{
            margin-bottom: 25px;
        }
        .info_content_item {
            width: 70%;
            margin: 0 auto;
        }
        .info_content_item_name tr {
            width: 100%;
        }
        .info_content_item_name{
            width: 30%;
            height: 50px;
            line-height: 50px;
        }
        .info_content_item_content {
            width: 70%;
            height: 50px;
            line-height: 50px;
        }
    </style>
</head>
<body>
<iframe src="<%=request.getContextPath()%>/common/top.jsp" class="top"></iframe>
<iframe src="<%=request.getContextPath()%>/common/left.jsp" class="left"></iframe>
<div class="main">
    <div class="content">
        <div class="form_div">
            <a href="<%=request.getContextPath() %>/userIndex.jsp" class="button_back">＜返回</a>
            <br>
            <br>
            <div style="text-align: center;color: green">${successMsg}</div>
            <div style="text-align: center;color: red">${errorMsg}</div>
            <%
                // 在request中获取出需要修改的商品的id
                String goodsId = request.getParameter("goodsId");

                // 根据id查询商品详情
                GoodsService goodsService = new GoodsService();
                Goods goods = goodsService.getGoodsById(goodsId);
                request.setAttribute("goods", goods);
            %>
            <div class="form_box">
                <div class="info_title">
                    商品详情
                </div>
                <div class="info_img">
                    <c:if test="${goods.fileName != null}">
                        <img src="<%=request.getContextPath()%>/GetImgServlet?imgPath=${goods.fileName }" width="80" height="80">
                    </c:if>
                    <c:if test="${ goods.fileName == null }">
                        暂无图片
                    </c:if>
                </div>
                <div class="info_content">
                    <h1>${ goods.name }</h1>
                    <table class="info_content_item">
                        <tr>
                            <td class="info_content_item_name">类别：</td>
                            <td class="info_content_item_content">${ goods.brand }</td>
                        </tr>
                        <tr>
                            <td class="info_content_item_name">库存：</td>
                            <td class="info_content_item_content">${ goods.stock }</td>
                        </tr>
                        <tr>
                            <td class="info_content_item_name">备注：</td>
                            <td class="info_content_item_content">${ goods.remark }</td>
                        </tr>
                        <tr>
                            <td class="info_content_item_name">价格：</td>
                            <td class="info_content_item_content" style="color: red">${ goods.price }</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <c:if test="${item.stock != 0}">
                                   <a href="<%=request.getContextPath() %>/ShopCarAddServlet?goodsId=${goods.id}" class="button_atag">加入购物车</a>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
