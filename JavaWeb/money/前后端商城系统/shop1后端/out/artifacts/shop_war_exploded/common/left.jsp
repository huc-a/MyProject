<%@ page import="com.shop.entity.AdminUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .head {
            width: 100%;
            height: 60px;
            /*text-align: right;*/
            line-height: 60px;
            box-sizing: border-box;
            background-color: #fff;
            border-bottom: 1px solid #e3e3e3;
        }
        .head div:first-child {
            float: left;
            width: 50%;
            margin: 0 auto;
            height: 60px;
            text-align: left;
            line-height: 58px;
        }
        .head div:first-child .title{
            float: left;
            width: 20%;
            height: 60px;
        }
        .head div:first-child .title span {
            width: 100%;
            display: inline-block;
            font-size: 25px;
            font-weight: bold;
            text-align: center;
            background-color: #1970b8;
            color: white;
        }

        .head div:first-child div{
            float: left;
            width: 10%;
        }
        .head div:first-child .item {
            height: 60px;
            line-height: 60px;
            text-align: center;
            font-size: 15px;
            border-right: 1px solid#bebebe;
        }
        .head div:first-child .item{

            cursor: pointer;
        }
        .head div:first-child .item:hover {
            background-color: #f2f2f2;
        }

        .head .username{
            float: right;
            width: 5%;
            margin: 0 auto;
            height: 60px;
            text-align: center;
            line-height: 58px;
            background-color: #fda412;
            color: white;
            font-size: 15px;
        }
    </style>
</head>
<body>
</body>
</html>
