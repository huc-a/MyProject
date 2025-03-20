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
 * 添加管理员用户Servlet
 */
@WebServlet("/AdminUserAddServlet")
public class AdminUserAddServlet extends HttpServlet {
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
        adminUser.setCreateDatetime(new Date());

        // 执行添加操作
        int add = adminUserService.add(adminUser);

        if (add > 0) {  // 成功
            request.setAttribute("successMsg", "添加成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "添加失败");
            request.setAttribute("adminUser", adminUser);
        }
        request.getRequestDispatcher("adminUserAdd.jsp").forward(request, response);

    }

}
