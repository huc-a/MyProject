
<%--
  酒店预定案例网站的主页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="importhead.jsp"%>
<!--以下是原主页的静态内容-->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>手机电商平台</title>
    <meta name="Keywords" content="一部手机浏览天下">
    <meta name="Description" content="我们有专业的人员，为您提供全方位手机购买服务">
    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/css.css">
    <link rel="stylesheet" href="../css/index.css">


</head>

<body>
<!-- 导航 -->
<iframe style="height:40px" align="center" width="100%" src="nav.jsp" frameborder="no" border="0" marginwidth="0"
        marginheight="0" scrolling="no"></iframe>



<!-- 横幅广告 -->
<section class="banner" id="banner">
    <ul id="carousel_list" class="carousel_list">
        <li>
            <img src="../images/bg1.jpg" alt="">
        </li>
    </ul>

</section>

<!-- 页面搜索框 -->
<div class="header-con">
    <div class="header-center">
        <h1>手机电商平台</h1>
        <form action="index.do" method="get">
            <div class="soso-box">
                <input type="text" placeholder="查询手机" name="productname">
                <a href="">&#xe62d;</a>
            </div>
            <div class="soso-box">
                <input type="text" placeholder="手机品牌" name="brand">
                <button type="submit" class="btn iconfont">&#xe62d;</button>
            </div>
        </form>
    </div>
</div>


<!-- 页面主内容 -->
<div class="mainbox0">
    <img src="../images/sjtj.jpg" width="600px" height="100px">

</div>

<div class="mainbox">
    <c:forEach items="${productList}" var="obj">  <%--遍历集合开始--%>
        <div class="sbox">
            <a href="productinfo.do?productid=${obj.productid}"> <%--打开hotelinfo.jsp，同时传递一个hotelid的参数--%>
                <div class="picbox">
                    <img src="/upload/${obj.productlmage}" alt="">
                </div>
                <div class="wordbox">
                    <h1>${obj.productname}</h1>
                    <p class="wz06">${obj.memory}<br>
                        品牌：${obj.brand}<br>
                        颜色：${obj.colortype}</p>
                    <p style="margin-top: 20px;">
                        <span>￥</span><span class="wz04">${obj.minprice}</span><span class="wz05">起</span>
                    </p>
                </div>
            </a>
        </div>
    </c:forEach>   <%--遍历酒店集合结束--%>
</div>

<c:if test="${empty productList}">
    <div class="no-data">
        <p>暂无产品信息</p >
    </div>
</c:if>

<!-- 页脚 -->

<iframe style="height:280px" align="center" width="100%" src="footer.jsp" frameborder="no" border="0"
        marginwidth="0" marginheight="0" scrolling="no"></iframe>

</body>

</html>

