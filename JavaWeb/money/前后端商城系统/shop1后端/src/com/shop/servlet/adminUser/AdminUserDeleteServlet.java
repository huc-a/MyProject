package com.shop.servlet.adminUser;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.service.AdminUserService;

/**
 * 删除用户Servlet
 */
@WebServlet("/AdminUserDeleteServlet")
public class AdminUserDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private AdminUserService adminUserService = new AdminUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取登录信息
        String username = request.getParameter("username");

        // 删除
        adminUserService.delete(username);

        // 跳转到用户列表页
        response.sendRedirect("adminUserList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
