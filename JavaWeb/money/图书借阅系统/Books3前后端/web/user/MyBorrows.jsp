<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>我的借阅</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "Microsoft YaHei", sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,.05);
        }

        .page-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .borrow-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
        }

        .borrow-table th, 
        .borrow-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .borrow-table th {
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            padding: 12px;
            font-weight: 500;
        }

        .borrow-table tr:hover {
            background-color: #f8fafc;
        }

        .btn {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            margin: 0 4px;
        }

        .btn-return {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
            box-shadow: 0 2px 4px rgba(245, 101, 101, 0.2);
        }
        
        .btn-return:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(245, 101, 101, 0.3);
        }

        .back-btn {
            display: inline-block;
            padding: 8px 20px;
            background: linear-gradient(135deg, #4299e1, #3182ce);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(66, 153, 225, 0.2);
        }
        
        .back-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(66, 153, 225, 0.3);
        }

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #718096;
            font-size: 16px;
        }

        .success-msg {
            color: #2f855a;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 8px;
            background-color: #c6f6d5;
            font-size: 14px;
            animation: fadeOut 3s forwards;
        }

        @keyframes fadeOut {
            0% { opacity: 1; }
            70% { opacity: 1; }
            100% { opacity: 0; }
        }

        /* 添加统计信息样式 */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
        }

        .stat-icon {
            font-size: 24px;
            color: #4299e1;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 600;
            color: #2d3748;
            margin: 5px 0;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
        }

        /* 优化表格样式 */
        .borrow-table th {
            white-space: nowrap;
        }

        .borrow-table td {
            vertical-align: middle;
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .book-cover {
            width: 40px;
            height: 56px;
            object-fit: cover;
            border-radius: 4px;
        }

        .book-details {
            flex: 1;
        }

        .book-name {
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 4px;
        }

        .book-meta {
            color: #718096;
            font-size: 13px;
        }

        .date-cell {
            white-space: nowrap;
            color: #4a5568;
        }

        /* 添加标签样式 */
        .status-tag {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-active {
            background-color: #c6f6d5;
            color: #2f855a;
        }

        .status-overdue {
            background-color: #fed7d7;
            color: #c53030;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <h2 class="page-title">我的借阅记录</h2>
            </div>
            <div class="header-right">
                <span class="welcome-text">欢迎，${sessionScope.user.username}</span>
                <a href="/LogoutServlet" class="logout-btn" onclick="return confirm('确定要退出吗？')">
                    <i class="fas fa-sign-out-alt"></i>
                    退出
                </a>
            </div>
        </div>

        <c:if test="${param.success eq 'return'}">
            <div class="success-msg">
                图书归还成功！
            </div>
        </c:if>

        <!-- 统计信息 -->
        <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-book-reader stat-icon"></i>
                <div class="stat-value">${sessionScope.myBorrows.size()}</div>
                <div class="stat-label">当前借阅</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-history stat-icon"></i>
                <div class="stat-value">${totalBorrows}</div>
                <div class="stat-label">历史借阅</div>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock stat-icon"></i>
                <div class="stat-value">${overdueCount}</div>
                <div class="stat-label">即将到期</div>
            </div>
        </div>

        <a href="/IndexBookServletForUser" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            返回借阅
        </a>

        <c:if test="${empty sessionScope.myBorrows}">
            <div class="empty-message">
                <i class="fas fa-book-open"></i>
                暂无借阅记录
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.myBorrows}">
            <table class="borrow-table">
                <tr>
                    <th>借阅编号</th>
                    <th>图书信息</th>
                    <th>借阅时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${sessionScope.myBorrows}" var="borrow">
                    <tr>
                        <td>${borrow.orderid}</td>
                        <td>
                            <div class="book-info">
                                <img src="${borrow.image}" alt="${borrow.bookname}" class="book-cover">
                                <div class="book-details">
                                    <div class="book-name">${borrow.bookname}</div>
                                    <div class="book-meta">出版社：${borrow.publish}</div>
                                </div>
                            </div>
                        </td>
                        <td class="date-cell">
                            <fmt:formatDate value="${borrow.time}" pattern="yyyy-MM-dd"/>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${borrow.overdue}">
                                    <span class="status-tag status-overdue">即将到期</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-tag status-active">借阅中</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="/ReturnBookServlet?orderid=${borrow.orderid}" 
                               class="btn btn-return"
                               onclick="return confirm('确定要归还《${borrow.bookname}》吗？')">
                                <i class="fas fa-undo-alt"></i>
                                归还
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
</body>
</html> 