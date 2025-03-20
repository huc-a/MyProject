<%--
  手机管理页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="importhead.jsp"%>

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
    <link rel="stylesheet" href="../css/hotelmanage.css">

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

<div class="ju"></div>
<div class="gd"><img src="../images/518.jpg"></div>

<!-- 页面主内容 -->

<center>


    <div class="hymc">

        <div class="qymc">

            <h1>企业名称： ${loginuser.companyname}</h1>

        </div>
        <div>

            <div class="l">
                <p>管理员账号： ${loginuser.userid}</p>
                <p>管理员联系电话： ${loginuser.mobile}</p>
            </div>
            <div class="r">
                <p>管理员姓名： ${loginuser.username}</p>
                <p>管理员邮箱： ${loginuser.mail}</p>
            </div>

        </div>
        <div class="clearfix"></div>
        <div class="ju"></div>
        <div class="l">
            <c:if test="${loginuser!=null && loginuser.utid==UserTypeProperties.HOTELADMINTYPE}">
                <a class="button" href="edithotel.do">添加手机</a>
            </c:if>
        </div>


    </div>
    <div class="clearfix"></div>
    <div class="ju"></div>

    <div class="jdgl">

        <img src="../images/sjgl.jpg">
    </div>

    <div class="box">
        <div class="box01">
            <ul>
                <li>手机名称</li>
                <li>内存</li>
                <li>颜色</li>
                <li>操作</li>
            </ul>

        </div>
    </div>


    <c:forEach items="${productlist}" var="obj">
        <div class="inner">
            <div class="box3"><img src="/upload/${obj.productlmage}"></div>
            <div class="box4">
                <ul>

                    <li>
                        <h3>${obj.productname}</h3>
                    </li>
                    <li>
                        <p class="w1">${obj.memory}</p>
                    </li>
                    <li>
                        <p class="w2">${obj.colortype}</p>
                    </li>
                    <li>
                        <c:if test="${loginuser!=null && loginuser.utid==UserTypeProperties.HOTELADMINTYPE}">
                            <p class="w3"><a href="../productbookinginfo.html" class="button">查看订单</a>
                                <a href="productinfo.do?productid=${obj.productid}" class="button">管理手机</a>
                            </p>
                        </c:if>
                    </li>
                </ul>
            </div>
        </div>


        <div class="clearfix"></div>
        <div class="box02">
            <hr>
        </div>
    </c:forEach>
</center>

<!-- 页脚 -->

<iframe style="height:280px" align="center" width="100%" src="footer.jsp" frameborder="no" border="0"
        marginwidth="0" marginheight="0" scrolling="no"></iframe>

</body>

</html>

