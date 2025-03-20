<%--
用户产品订购页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="importhead.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" width="device-width, initial-scale=1.0">
    <title>手机电商平台 - 产品订购</title>
    <meta name="Keywords" content="手机订购,电商平台">
    <meta name="Description" content="在我们的平台便捷订购您心仪的手机产品">
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/css.css">
    <script src="../js/jquery.js"></script>
</head>

<body>

<!-- 导航 -->
<iframe style="height:40px" align="center" width="100%" src="nav.jsp" frameborder="no" border="0" marginwidth="0"
        marginheight="0" scrolling="no"></iframe>

<!-- 横幅广告 -->
<section class="banner" id="banner">
    <ul id="carousel_list" class="carousel_list">
        <li>
            <img src="../images/bg2.jpg" alt="">
        </li>
    </ul>

</section>

<div class="jdgl">
    <h1>产品订购</h1>
</div>

<div class="ju"></div>

<!-- 页面主内容 -->
<center>
    <form action="orderproduct.do" method="post">
        <!-- 假设这里通过某种方式已经获取到要订购产品的相关信息展示（比如从请求参数等），此处简化示例只显示名称 -->
        <h2>产品信息</h2>
        <p>手机名称：${product.productname}</p>

        <h3>订购详情</h3>
        <table>
            <tr>
                <td>数量：</td>
                <td><input type="number" name="quantity" min="1" required></td>
            </tr>
            <tr>
                <td>颜色：</td>
                <td>
                    <select name="colortype">
                        <option value="${product.colortype}">${product.colortype}</option>
                        <!-- 这里可以动态从数据库等获取更多颜色选项进行循环添加 -->
                    </select>
                </td>
            </tr>
            <tr>
                <td>内存型号：</td>
                <td>
                    <select name="memory">
                        <option value="${product.memory}">${product.memory}</option>
                        <!-- 同样可从数据库等获取更多内存型号选项循环添加 -->
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input class="button" type="submit" value="提交订购">
                    <input class="button" type="reset" value="重置">
                </td>
            </tr>
        </table>
    </form>
</center>

<!-- 页脚 -->
<iframe style="height:280px" align="center" width="100%" src="footer.jsp" frameborder="no" border="0"
        marginwidth="0" marginheight="0" scrolling="no"></iframe>

</body>

</html>