package com.shop.servlet;

import com.shop.entity.User;
import com.shop.service.AdminUserService;
import com.shop.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 登录Servlet
 */
@WebServlet("/CustLoginServlet")
public class CustLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 实例化service
	private UserService userService = new UserService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 在request中获取登录信息
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		
		User loginUser = userService.getUserByPhone(phone);
		
		System.out.println("用户：" + phone + "登录");
		
		if (loginUser != null) {
			// 判断输入的密码和数据库中的密码是否一致，如果密码一致的则登录成功，不一致的则返回错误提示信息
			if (loginUser.getPassword().equals(password)) {
				System.out.println("用户：" + phone + "登录成功");
				Date date = new Date();
				SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
				// 保存本次登录时间
				Cookie loginDate = new Cookie(phone + "-loginDate", sdfDate.format(date));
				Cookie loginTime = new Cookie(phone + "-loginTime", sdfTime.format(date));

				response.addCookie(loginDate);
				response.addCookie(loginTime);

				// 在Cookie中获取上次的登录时间
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if (cookie.getName().equals(phone + "-loginDate")) {
							// 保存上次登录时间
							Cookie lastLoginDate = new Cookie(phone + "-lastLoginDate", cookie.getValue());
							response.addCookie(lastLoginDate);
						}
						if (cookie.getName().equals(phone + "-loginTime")) {
							// 保存上次登录时间
							Cookie lastLoginTime = new Cookie(phone + "-lastLoginTime", cookie.getValue());
							response.addCookie(lastLoginTime);
						}
					}
				}
				// 登录成功将用户信息添加到session中
				request.getSession().setAttribute("loginCust", loginUser);
				// 跳转到首页
				response.sendRedirect("userIndex.jsp");
			} else {
				System.out.println("用户：" + phone + "密码错误");
				request.setAttribute("errorMsg", "密码错误");
				request.getRequestDispatcher("userLogin.jsp").forward(request, response);
			}
		} else {
			System.out.println("用户：" + phone + "用户名不存在");
			request.setAttribute("errorMsg", "用户名不存在");
			request.getRequestDispatcher("userLogin.jsp").forward(request, response);
		}
		
	}

}
