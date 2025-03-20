<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.util.DatabaseUtil" %>
<%@ page import="com.example.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String email = "";
    
    if (currentUser != null) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT email FROM t_user WHERE id = ?")) {
            
            pstmt.setInt(1, currentUser.getId());
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<html>
<head>
    <title>个人信息 - 旅游景点推荐系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f7fa;
        }

        .main-content {
            margin-top: 80px;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        .page-title {
            text-align: center;
            color: #2c3e50;
            margin: 0 0 30px;
            font-size: 24px;
            position: relative;
        }

        .page-title:after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background: #3498db;
            margin: 10px auto;
            border-radius: 3px;
        }

        .profile-section {
            margin-bottom: 30px;
        }

        .section-title {
            color: #2c3e50;
            font-size: 18px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: #3498db;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            background: #f8f9fa;
            color: #2c3e50;
            cursor: default;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="main-content">
        <div class="container">
            <h1 class="page-title">个人信息</h1>

            <!-- 基本信息 -->
            <div class="profile-section">
                <h2 class="section-title">
                    <i class="fas fa-user"></i>
                    基本信息
                </h2>
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" value="${sessionScope.user.username}" readonly>
                </div>
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="email" value="<%=email%>" readonly>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 