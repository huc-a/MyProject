<%@ page import="java.util.List" %>
<%@ page import="com.tuling.domain.Fruit" %>
<%@ page import="com.tuling.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>天天果园-水果网购首选品牌，水果，我们只选有来头的！</title>
  <link rel="stylesheet" type="text/css" href="css/main.css"/>
  <link rel="stylesheet" type="text/css" href="css/index.css"/>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script>
    function fimg() {
      var index = this.innerHTML;
      $(".show").removeClass("show");
      $(".non").addClass("non");
      $("#p" + index).addClass("show");
    }
    function simg() {
      var index = this.innerHTML;
      $(".show").removeClass("show");
      $(".non").addClass("non");
      $("#l" + index).addClass("show");
    }
    function getData() {
      window.location.href = "getDataServlet";
    }
  </script>
</head>
<body onload="getData()">
<jsp:include page="/fruitServlet?method=hot"></jsp:include>
<jsp:include page="head/head.jsp"></jsp:include>
<div class="imgs">
  <div class="con">
    <div id="p0" class="show"><a target="_blank" href="http://huodong.fruitday.com/sale/zhongqiu0906/pcsh.html"><img alt="" /></a></div>
    <div id="p1" class="non"><a target="_blank" href="http://huodong.fruitday.com/sale/midautumn/pc.html"><img alt="" /></a></div>
    <div id="p2" class="non"><a target="_blank" href="http://huodong.fruitday.com/sale/912_oh/pc.html"><img alt="" /></a></div>
    <div id="p3" class="non"><a target="_blank" href="http://huodong.fruitday.com/sale/subject/pg/pc.html"><img alt="" /></a></div>
    <div id="p4" class="non"><a target="_blank" href="http://huodong.fruitday.com/sale/Zespri_0901/PC.html"><img alt="" /></a></div>
  </div>
  <div class="ulimg">
    <ul>
      <li id="l0" onclick="fimg()">1</li>
      <li id="l1" onclick="fimg()">2</li>
      <li id="l2" onclick="fimg()">3</li>
      <li id="l3" onclick="fimg()">4</li>
      <li id="l4" onclick="fimg()">5</li>
    </ul>
  </div>
</div>
<div class="fruitboxs">
  <div class="con">
    <div class="fhead">
      <div class="fhr"></div>
      <div class="ser_more">
        <div class="fser">热卖专区</div>
        <div class="fmore"><a href="">更多 ></a></div>
      </div>
    </div>
    <%
      List<Fruit> hotFruits = (List<Fruit>)request.getAttribute("fruits");
      if (hotFruits == null) {
        hotFruits = new ArrayList<>(); // 确保 hotFruits 不为空
      }
      int id = 0;
      if (session.getAttribute("user") != null) {
        User user = (User) session.getAttribute("user");
        id = user.getId();
      }
    %>
    <% for (Fruit fruit : hotFruits) { %>
    <div class="fruit_box">
      <div class="fruit_img">
        <a href="<%= request.getContextPath() %>/fruitServlet?method=info&uid=<%= id %>&fid=<%= fruit.getId() %>"><img src="img/fruits/<%= fruit.getId() %>/(1).jpg" /></a>
      </div>
      <div class="fruit_name">
        <a href="<%= request.getContextPath() %>/fruitServlet?method=info&uid=<%= id %>&fid=<%= fruit.getId() %>"><%= fruit.getName() %></a>
      </div>
      <div class="fruit_num">
        <%= fruit.getSpec() %>
      </div>
      <div class="fruit_mon">
        <%= fruit.getUp() %>
      </div>
    </div>
    <% } %>
  </div>
</div>
<jsp:include page="footer/footer.jsp"></jsp:include>
</body>
</html>
