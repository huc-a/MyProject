package com.shop.servlet.user;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.User;
import com.shop.service.UserService;
import com.shop.util.DateUtil;

/**
 * 添加用户Servlet
 */
@WebServlet("/UserAddServlet")
public class UserAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取用户信息
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String realName = request.getParameter("realName");
        String sex = request.getParameter("sex");
        Date birthday = DateUtil.parseYYYYMMDDHHMMSS(request.getParameter("birthday"));
        String address = request.getParameter("address");

        // 创建用户对象
        User user = new User();
        // 把信息添加到对象中
        user.setPhone(phone);
        user.setUsername(username);
        user.setPassword(password);
        user.setRealName(realName);
        user.setSex(sex);
        user.setBirthday(birthday);
        user.setAddress(address);
        user.setCreateDatetime(new Date());

        // 执行添加操作
        int add = userService.add(user);

        if (add > 0) {  // 成功
            request.setAttribute("successMsg", "添加成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "添加失败");
            request.setAttribute("user", user);
        }
        request.getRequestDispatcher("userAdd.jsp").forward(request, response);

    }

}
