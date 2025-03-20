<%--
  酒店编辑页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="importhead.jsp"%>
<%--
    VUser loginuser = (VUser)session.getAttribute("loginuser");
    if(loginuser==null || loginuser.getUtid()!=UserTypeProperties.HOTELADMINTYPE){
        DispatcherUtils.openErrWeb("您没有权限访问该页面","index.do",request,response);
        return;
    }
--%>
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
    <link rel="stylesheet" href="../css/edithotel.css">
    <script src="../js/jquery.js"></script>

    <script>
        $(function (){
            $("#choicePhoto").click(function (){
                //alert("选择文件");
                $("#fileToUpload").click(); //出发文件选择器控件的点击事件
            })

            //当文件选择器选中一个文件，且按了确定后,触发以下事件
            $("#fileToUpload").change(function(){
               // alert("您选择了一个文件")
                //获取文件，生成表单数据，返送给servlet实现文件的上传
                var files = $("#fileToUpload")[0].files;  //从选择器中获得选中的第一个文件
                if(files.length<=0){
                    return alert("请选择文件后再上传");
                }

                var formData = new FormData();
                formData.append("file",files[0]);
                alert("请求")
                alert(files[0].name)  //显示以下上传文件的名称
                $.ajax({  //使用ajax异步调用服务器中的url
                    url:"upload.do",
                    data:formData,
                    cache:false,
                    type:"post",
                    datatype:"json",
                    contentType:false, //不设置内容类型
                    processData:false, //不处理数据
                    success:function (data){
                        if(data.code==0) {  //当data.code==0的时候代表上传文件成功
                            alert(data.msg); //显示从服务器中发回来的消息提示
                            $("#photourl").val(data.result); //把上传后存储在服务器中的文件名称回填给文本框
                            $("#upload").attr("src","/upload/"+data.result); //让图片显示在网页中
                        }else{  //失败
                            alert(data.msg);
                        }
                    }
                })
            })
        })
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

<div class="jdgl">

    <!-- <img src="images/hotel-gl.gif"><br> -->

    <h1>编辑</h1>
</div>

<div class="ju"></div>


<!-- 页面主内容 -->

<center>

<form action="saveproduct.do" method="post">
    <div class="edit">
        <div class="edit-left">

            <c:if test="${product.productid!=0}">
                <img id="upload" src="/upload/${product.productlmage}">
            </c:if>
            <c:if test="${product.productid==0}">
                <img id="upload" src="../images/wu.jpg">
            </c:if>

            <div>
                <input type="text" id="photourl" name="productlmage" value="${product.productlmage}" readonly>
                <input class="button" type="button" value="选择图片" id="choicePhoto">
                <!-- 隐藏file标签 -->
                <input id="fileToUpload" style="display:none" type="file" name="upfile" />
            </div>

        </div>
        <div class="edit-right">
            <table>
                <tr>
                    <td>手机编号</td>
                    <td><input type="text" name="productid" value="${product.productid}" readonly></td>
                </tr>
                <tr>
                    <td>手机名称</td>
                    <td><input type="text" name="productname" value="${product.productname}"></td>
                </tr>
                <tr>
                    <td>品牌</td>
                    <td><input type="text" name="brand" value="${product.brand}"></td>
                </tr>
                <tr>
                    <td>内存</td>
                    <td><input type="text" name="memory" value="${product.memory}"></td>
                </tr>
                <tr>
                    <td>颜色</td>
                    <td><input type="text" name="colortype" value="${product.colortype}"></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input class="button" type="submit" value="提交保存">
                        <input class="button" type="reset" value="取消返回">
                    </td>
                </tr>
            </table>
        </div>

    </div>
</form>
</center>

<!-- 页脚 -->

<iframe style="height:280px" align="center" width="100%" src="footer.jsp" frameborder="no" border="0"
        marginwidth="0" marginheight="0" scrolling="no"></iframe>

</body>

</html>