package com.shop.servlet.adminUser;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.AdminUser;
import com.shop.service.AdminUserService;
import com.shop.util.DateUtil;

/**
 * 更新管理员用户Servlet
 */
@WebServlet("/AdminUserUpdateServlet")
public class AdminUserUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private AdminUserService adminUserService = new AdminUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取管理员用户信息
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String realName = request.getParameter("realName");
        String sex = request.getParameter("sex");
        Date birthday = DateUtil.parseYYYYMMDDHHMMSS(request.getParameter("birthday"));

        // 创建管理员用户对象
        AdminUser adminUser = new AdminUser();
        // 把信息添加到对象中
        adminUser.setUsername(username);
        adminUser.setPassword(password);
        adminUser.setRealName(realName);
        adminUser.setSex(sex);
        adminUser.setBirthday(birthday);
        adminUser.setUpdateDatetime(new Date());

        // 执行更新操作
        int update = adminUserService.update(adminUser);

        if (update > 0) {  // 成功
            request.setAttribute("successMsg", "更新成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "更新失败");
            request.setAttribute("adminUser", adminUser);
        }
        request.getRequestDispatcher("adminUserUpdate.jsp").forward(request, response);

    }

}
