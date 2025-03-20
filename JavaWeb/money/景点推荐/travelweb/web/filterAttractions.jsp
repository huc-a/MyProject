<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.dao.AttractionDao" %>
<%@ page import="com.example.util.DaoFactory" %>
<%@ page import="com.example.model.Attraction" %>
<%@ page import="java.util.List" %>
<%
    AttractionDao attractionDao = DaoFactory.getAttractionDao();
    List<Attraction> attractions = null;

    String categoryId = request.getParameter("category_id");
    String level = request.getParameter("level");
    String minPrice = request.getParameter("min_price");
    String maxPrice = request.getParameter("max_price");

    Integer catId = null;
    Double min = null;
    Double max = null;

    if(categoryId!= null &&!categoryId.isEmpty()) {
        catId = Integer.parseInt(categoryId);
    }
    if(minPrice!= null &&!minPrice.isEmpty()) {
        min = Double.parseDouble(minPrice);
    }
    if(maxPrice!= null &&!maxPrice.isEmpty()) {
        max = Double.parseDouble(maxPrice);
    }

    attractions = attractionDao.filterAttractions(catId, null, min, max, level);
    request.setAttribute("attractions", attractions);
%>
<html>
<head>
    <title>筛选景点 - 旅游景点推荐系统</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }

       .page-title {
            text-align: center;
            color: #2c3e50;
            margin: 20px 0 30px;
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

       .filter-form {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

       .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

       .form-group {
            flex: 1;
            min-width: 200px;
        }

       .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

       .form-group label i {
            color: #3498db;
        }

        select, input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            color: #2c3e50;
            transition: all 0.3s ease;
        }

        select:focus, input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            outline: none;
        }

       .price-inputs {
            display: flex;
            gap: 10px;
            align-items: center;
        }

       .price-inputs input {
            width: 120px;
        }

       .price-inputs span {
            color: #7f8c8d;
        }

        button {
            background: #3498db;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 auto;
        }

        button:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

       .results {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            padding: 20px 0;
        }

       .attraction-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative; /* 添加相对定位，便于伪元素绝对定位 */
        }

       .attraction-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

       .attraction-card:hover::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/8.jpg') no-repeat center center; /* 设置图片路径，可根据实际情况调整 */
            background-size: cover;
            opacity: 0.5; /* 设置透明度，可按需调整 */
            z-index: 1;
        }

       .attraction-card h3 {
            color: #2c3e50;
            margin: 0 0 15px 0;
            font-size: 20px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 8px;
            position: relative; /* 确保标题在图片遮盖之上 */
            z-index: 2;
        }

       .info-group {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin: 15px 0;
            position: relative; /* 确保信息组在图片遮盖之上 */
            z-index: 2;
        }

       .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 14px;
            position: relative; /* 确保单个信息项在图片遮盖之上 */
            z-index: 2;
        }

       .info-item i {
            color: #3498db;
            width: 16px;
        }

       .description {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            position: relative; /* 确保描述在图片遮盖之上 */
            z-index: 2;
        }

        @media (max-width: 768px) {
           .form-row {
                flex-direction: column;
            }
           .form-group {
                width: 100%;
            }
           .results {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="main-content">
        <div class="container">
            <h1 class="page-title">景点筛选</h1>

            <div class="filter-form">
                <form method="get" action="filterAttractions.jsp">
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> 景点分类</label>
                            <select name="category_id">
                                <option value="">全部分类</option>
                                <option value="1" ${categoryId == '1'? 'selected' : ''}>自然风光</option>
                                <option value="2" ${categoryId == '2'? 'selected' : ''}>人文古迹</option>
                                <option value="3" ${categoryId == '3'? 'selected' : ''}>红色文化</option>
                                <option value="4" ${categoryId == '4'? 'selected' : ''}>科技文化</option>
                                <option value="5" ${categoryId == '5'? 'selected' : ''}>宗教寺庙</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-star"></i> 景区等级</label>
                            <select name="level">
                                <option value="">全部等级</option>
                                <option value="5A" ${level == '5A'? 'selected' : ''}>5A级景区</option>
                                <option value="4A" ${level == '4A'? 'selected' : ''}>4A级景区</option>
                                <option value="3A" ${level == '3A'? 'selected' : ''}>3A级景区</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-yen-sign"></i> 门票价格</label>
                            <div class="price-inputs">
                                <input type="number" name="min_price" placeholder="最低价" value="${minPrice}">
                                <span>至</span>
                                <input type="number" name="max_price" placeholder="最高价" value="${maxPrice}">
                            </div>
                        </div>
                    </div>

                    <button type="submit">
                        <i class="fas fa-search"></i>
                        开始筛选
                    </button>
                </form>
            </div>

            <div class="results">
                <c:forEach items="${attractions}" var="attraction">
                    <div class="attraction-card">
                        <h3>${attraction.name}</h3>
                        <div class="info-group">
                            <div class="info-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${attraction.city}</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-star"></i>
                                <span>${attraction.level}</span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-ticket-alt"></i>
                                <span>
                                    <c:choose>
                                        <c:when test="${attraction.ticketPrice == 0}">免费</c:when>
                                        <c:otherwise>￥${attraction.ticketPrice}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-clock"></i>
                                <span>${attraction.openingHours}</span>
                            </div>
                        </div>
                        <div class="description">
                            ${attraction.description}
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>