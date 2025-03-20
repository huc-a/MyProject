<%--
  菜单部分的动态页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="importhead.jsp"%>

<!--原菜单静态页面内容-->
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


</head>

<body>

<header class="site-head">

    <nav class="main-nav">
        <div class="center-wrap">


            <ul>
                <li>
                    <a href="/jspviews/index.do" target="_top">首页 |</a>
                </li>
                <c:if test="${loginuser!=null && loginuser.utid==UserTypeProperties.HOTELADMINTYPE}">
                    <%--手机管理员登录--%>
                    <li><img style="vertical-align: middle;" src="../images/酒店.png">您好，平台管理员：${loginuser.username}</li>
                    <li>|</li>
                    <li><img style="vertical-align: middle;" src="../images/人群.png"><span>当前访问人数：50人</span>
                    </li>
                    <li>
                        <a href="productmanage.do" target="_top">我的手机</a>
                    </li>
                    <li>
                        <a href="">手机订单</a>
                    </li>
                    <li>
                        <a href="">我的信息</a>
                    </li>
                    <li>
                        <a href="logout.do" target="_top" style="margin: 0px 15px;color:#e4ef4c">| 退出登录</a>
                    </li>
                </c:if>

                <c:if test="${loginuser!=null && loginuser.utid==UserTypeProperties.MEMBERTYPE}">
                    <%--用户登录--%>
                    <li><img style="vertical-align: middle;" src="../images/人员.png">您好，用户：${loginuser.username}</li>
                    <li>|</li>
                    <li><img style="vertical-align: middle;" src="../images/人群.png"><span>当前访问人数：50人</span>
                    </li>
                    <li>
                        <a href="">我的订单</a>
                    </li>
                    <li>
                        <a href="">我的信息</a>
                    </li>
                    <li>
                        <a href="logout.do" target="_top" style="margin: 0px 15px;color:#e4ef4c">| 退出登录</a>
                    </li>
                </c:if>

                <c:if test="${loginuser==null || loginuser.userid==null}">
                    <%--未登录网站的游客--%>
                    <li><img style="vertical-align: middle;" src="../images/人员.png">您好，顾客：您还没有登录！</li>
                    <li>|</li>
                    <li><img style="vertical-align: middle;" src="../images/人群.png"><span>当前访问人数：50人</span>
                    </li>
                    <li>
                        <a href="addnormalmember.jsp" target="_top">用户注册</a>
                    </li>
                    <li>
                        <a href="addmember.jsp" target="_top">平台管理员注册</a>
                    </li>
                    <li>
                        <a href="login.jsp" target="_top" style="margin: 0px 15px;color:#e4ef4c">| 登录</a>
                    </li>

                </c:if>

            </ul>
        </div>


    </nav>

</header>

</body>

</html>