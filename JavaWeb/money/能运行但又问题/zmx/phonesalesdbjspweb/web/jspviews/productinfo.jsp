
<%--
  酒店信息页面（含房间信息）
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="importhead.jsp"%>

<!--原酒店信息页面的静态网页内容-->
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
    <link rel="stylesheet" href="../css/hotelinfo.css">

    <script type="text/javascript">
        //定义一个js的函数，函数通过一个确认对话框来实现对servlet的选择调用
        function deleteHotel(hotelid){
            var a = confirm("您确定要和删除当前页面中的手机及其所有手机信息吗？");  //该对话框有2个按钮ok,cancel
            if(a==true){  //当用户按下确认的时候
                document.location.href="delproduct.do?productid="+productid;
            }
        }
    </script>
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

<!-- 页面主内容 -->

<center>


    <!--酒店信息-->
    <div style="clear:both"></div>
    <div style="width:1160px;height:40px; margin-top:10px;">
        <%--  以下的三个功能按钮只能是管理员（自己）可以看到和操作
        --%>
        <c:if test="${loginuser!=null && loginuser.utid==UserTypeProperties.HOTELADMINTYPE
            && loginuser.userid==product.userid}">
            <a class="button4" style="display: block;" href="javascript:deleteProduct(${product.productid})">删除手机信息</a>
            <a class="button2" style="display: block;" href="editproduct.do?productid=${product.productid}">编辑手机信息</a>
            <a class="button3" style="width:130px; display: block;" href="../productorderinfo.html">查看手机订单信息</a>
        </c:if>
    </div>
    <div class="clearfix"></div>
    <div class="hotel-tj-title">
        <img src="../images/rmtj.jpg">
    </div>
    <!--酒店信息详情-->
    <div class="hotel-tj">
        <div class="hotel-tj-left"><img src="/upload/${product.productlmage}"></div>
        <div class="hotel-tj-right">

            <h1>手机名称：${product.productname}</h1>
            <p>内存：${product.memory}</p>
            <p>品牌：${product.brand}</p>
            <p>颜色：${product.colortype}</p>
            <p style="margin-top:10px">手机价格：${product.price}</p>
        </div>
    </div>

    <div class="clearfix"></div>

    <div class="hotel-bz">

        <img src="../images/85.png" alt="">
    </div>



    <div class="fyxx-title">

        <img src="../images/gmsj.jpg">


    </div>
    <div class="fyxx">
        <div class="nav">
            <ul>
                <li>手机名称</li>
                <li>品牌</li>
                <li>内存</li>
                <li>价格</li>
                <li>颜色</li>
                <li><a href="" class="button">添加手机</a></li>
            </ul>
        </div>

        <div class="fyjg">

            <div class="inner">
                <c:forEach items="${productList}" var="product"> <%--循环开始--%>
                    <div class="box1">
                        <img src="/upload/${product.productlmage}">  <%--输出房型图片--%>
                    </div>
                    <div class="box2">
                        <ul>
                            <li>
                                <p class="title">${product.brand}</p>
                            </li>
                            <li>
                                <p class="w1">${product.memory}</p> <%--输出房型面积--%>
                            </li>
                            <li>
                                <p class="w1">${product.colortype}</p> <%--输出房型中的床型--%>
                            </li>
                            <li>
                                <p class="w1"><strong>￥${product.price}</strong></p>   <%--输出房型的入住价格--%>
                            </li>
                            <li>
                                <p class="w1"><a class="hotel_yt" href="../editorder.html">订购</a></p>
                            </li>
                            <li>
                                <p class="w1"><a class="s5" href="#">编辑</a> | <a class="s5" href="#">删除</a></p>
                            </li>
                        </ul>
                    </div>
                    <div class="clearfix"></div>
                    <hr>    <!--房型信息结束-->
                </c:forEach> <%--循环结束--%>
            </div>
        </div>
    </div>




</center>
<!-- 页脚 -->

<iframe style="height:280px" align="center" width="100%" src="footer.jsp" frameborder="no" border="0"
        marginwidth="0" marginheight="0" scrolling="no"></iframe>

</body>

</html>
