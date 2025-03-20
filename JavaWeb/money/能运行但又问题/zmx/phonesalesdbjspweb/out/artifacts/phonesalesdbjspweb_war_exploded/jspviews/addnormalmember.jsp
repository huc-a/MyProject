<%--
  用户注册网页
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>手机电商平台</title>
    <meta name="Keywords" content="一部手机浏览天下">
    <meta name="Description" content="我们有专业的人员，为您提供全方位手机购买服务">
    <!-- <link rel="stylesheet" href="css/reset.css"> -->
    <link rel="stylesheet" href="../css/base.css">
    <link rel="stylesheet" href="../css/css.css">
    <link rel="stylesheet" href="../css/addnormalmember.css">
</head>

<body>



<section>

    <div class="login">
        <div>

            <form action="addnormalmember.do" method="post">
                <table style="width: 100%;">
                    <tr>
                        <td colspan="2" style="text-align: center;font-weight: 700;">
                            用户注册
                        </td>
                    </tr>
                    <tr>
                        <td>用户账号</td>
                        <td><input type="text" class="inputstyle" name="useraccount"></td>
                    </tr>
                    <tr>
                        <td>登录密码</td>
                        <td><input type="password" class="inputstyle" name="pwd"></td>
                    </tr>
                    <tr>
                        <td>再次输入密码</td>
                        <td><input type="password" class="inputstyle" name="pwd2"></td>
                    </tr>
                    <tr>
                        <td>用户姓名</td>
                        <td><input type="text" class="inputstyle" name="username"></td>
                    </tr>
                    <tr>
                        <td>联系手机号码</td>
                        <td><input type="text" class="inputstyle" name="mobile"></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <input type="submit" class="orangebuttoncss" name="login" value="注册">
                            <input type="button" class="bluebuttoncss" name="reset" value="取消">
                        </td>
                    </tr>
                </table>
            </form>

        </div>
    </div>
</section>

</body>

</html>