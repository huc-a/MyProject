<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .header {
        background-color: #ffffff;
        color: #333;
        height: 60px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    .header h1 {
        font-size: 1.5rem;
        color: #333;
    }
    
    .user-info {
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .user-info span {
        color: #666;
    }
    
    .logout-btn {
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        transition: background-color 0.3s;
    }
    
    .logout-btn:hover {
        background-color: #c82333;
    }
</style>

<div class="header">
    <h1>书城管理系统</h1>
    <div class="user-info">
        <span>欢迎，${sessionScope.user.realName}</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
    </div>
</div> 