<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .nav-container {
        background-color: #ffffff;
        padding: 0 20px;
        height: 50px;
        position: fixed;
        width: 100%;
        top: 60px;
        z-index: 999;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        display: flex;
        align-items: center;
    }
    
    .menu {
        list-style: none;
        display: flex;
        gap: 2rem;
        height: 100%;
        align-items: center;
        margin: 0;
        padding: 0;
    }
    
    .menu li a {
        color: #333;
        text-decoration: none;
        padding: 0.5rem 1rem;
        border-radius: 4px;
        transition: all 0.3s ease;
        font-weight: 500;
    }
    
    .menu li a:hover {
        background-color: #f8f9fa;
        color: #007bff;
    }
    
    .menu li a.active {
        background-color: #007bff;
        color: white;
    }
</style>

<div class="nav-container">
    <ul class="menu">
        <li><a href="${pageContext.request.contextPath}/jsp/admin/index.jsp" class="${pageContext.request.servletPath == '/jsp/admin/index.jsp' ? 'active' : ''}">控制台</a></li>
        <li><a href="${pageContext.request.contextPath}/book/list" class="${pageContext.request.servletPath == '/jsp/admin/book-list.jsp' ? 'active' : ''}">图书管理</a></li>
        <li><a href="${pageContext.request.contextPath}/order/list" class="${pageContext.request.servletPath == '/jsp/admin/order-list.jsp' ? 'active' : ''}">订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/user/list" class="${pageContext.request.servletPath == '/jsp/admin/user-list.jsp' ? 'active' : ''}">用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/comment/list" class="${pageContext.request.servletPath == '/jsp/admin/comment-list.jsp' ? 'active' : ''}">评论管理</a></li>
        <li><a href="${pageContext.request.contextPath}/feedback/list" class="${pageContext.request.servletPath == '/jsp/admin/feedback-list.jsp' ? 'active' : ''}">反馈管理</a></li>
    </ul>
</div> 