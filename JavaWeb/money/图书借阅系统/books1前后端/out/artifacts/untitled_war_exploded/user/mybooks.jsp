<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>书香城 - 我的借阅</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .nav {
            background: #fff;
            padding: 15px 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-links {
            display: flex;
            gap: 20px;
        }
        
        .nav-links a {
            color: #666;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
        }
        
        .nav-links a:hover {
            background-color: #f0f0f0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }
        
        .welcome {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
        }
        
        .borrow-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .borrow-table th,
        .borrow-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .borrow-table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #333;
        }
        
        .borrow-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .book-image {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .return-btn {
            padding: 6px 12px;
            background-color: #7AB87A;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .return-btn:hover {
            background-color: #68a468;
        }
        
        .returned {
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="nav">
        <h2>书香城图书管理系统</h2>
        <div class="nav-links">
            <a href="/BorrowBookServlet">借阅图书</a>
            <a href="/MyBooksServlet">我的借阅</a>
            <a href="/LogoutServlet">退出登录</a>
        </div>
    </div>
    
    <div class="container">
        <h2 class="welcome">我的借阅记录</h2>
        
        <table class="borrow-table">
            <thead>
                <tr>
                    <th>图书封面</th>
                    <th>图书名称</th>
                    <th>借阅时间</th>
                    <th>归还时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td><img src="${order.bookImage}" alt="${order.bookname}" class="book-image"></td>
                        <td>${order.bookname}</td>
                        <td><fmt:formatDate value="${order.time}" pattern="yyyy-MM-dd"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${order.returntime != null}">
                                    <fmt:formatDate value="${order.returntime}" pattern="yyyy-MM-dd"/>
                                </c:when>
                                <c:otherwise>
                                    未归还
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${order.returntime == null}">
                                <a href="/ReturnBookServlet?orderId=${order.orderid}" 
                                   class="return-btn" 
                                   onclick="return confirm('确定要归还这本书吗？')">归还</a>
                            </c:if>
                            <c:if test="${order.returntime != null}">
                                <span class="returned">已归还</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html> 