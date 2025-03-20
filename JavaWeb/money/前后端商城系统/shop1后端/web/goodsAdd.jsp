<%@page import="com.shop.entity.Goods"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>添加商品</title>
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
			    <a href="<%=request.getContextPath() %>/goodsList.jsp" class="button_back">＜返回</a>
                <br>
                <br>
                <div style="text-align: center;color: green">${successMsg}</div>
                <div style="text-align: center;color: red">${errorMsg}</div>
                <div class="form_box">
                    <form action="<%=request.getContextPath() %>/GoodsAddServlet" method="post" class="form" enctype="multipart/form-data">
                        <table class="table">
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <h2>添加商品</h2>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label for="name">名称</label>
                                </td>
                                <td>
                                    <input id="name" type="text" name="name" required="required" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="brand">类别</label>
                                </td>
                                <td>
                                    <input id="brand" type="text" name="brand" required="required" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="price">价格</label>
                                </td>
                                <td>
                                    <input id="price" type="number" name="price" required="required" class="input" step="0.1">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="price">图片</label>
                                </td>
                                <td>
                                    <input id="img" name="img" type="file" required class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="stock">库存</label>
                                </td>
                                <td>
                                    <input id="stock" type="number" name="stock" required="required" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="remark">简介</label>
                                </td>
                                <td>
                                    <input id="remark" type="text" name="remark" required="required" class="input">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <button class="button_action">添加</button>
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
