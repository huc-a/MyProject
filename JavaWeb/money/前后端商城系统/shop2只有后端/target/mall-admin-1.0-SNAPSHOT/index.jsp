<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 检查是否已登录
    if (session.getAttribute("username") != null) {
        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%> 