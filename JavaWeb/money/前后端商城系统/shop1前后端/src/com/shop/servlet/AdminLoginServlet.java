package com.shop.servlet;

import com.shop.entity.AdminUser;
import com.shop.service.AdminUserService;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录Servlet
 */
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 实例化service
	private AdminUserService adminUserService = new AdminUserService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 设置请求和响应的编码格式
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		// 在request中获取登录信息
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		AdminUser loginUser = adminUserService.getAdminUserByUsername(username);
		
		System.out.println("用户：" + username + "登录");
		
		if (loginUser != null) {
			// 判断输入的密码和数据库中的密码是否一致，如果密码一致的则登录成功，不一致的则返回错误提示信息
			if (loginUser.getPassword().equals(password)) {
				Date date = new Date();
				SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
				// 保存本次登录时间
				Cookie loginDate = new Cookie(username + "-loginDate", sdfDate.format(date));
				Cookie loginTime = new Cookie(username + "-loginTime", sdfTime.format(date));

				response.addCookie(loginDate);
				response.addCookie(loginTime);

				// 在Cookie中获取上次的登录时间
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if (cookie.getName().equals(username + "-loginDate")) {
							// 保存上次登录时间
							Cookie lastLoginDate = new Cookie(username + "-lastLoginDate", cookie.getValue());
							response.addCookie(lastLoginDate);
						}
						if (cookie.getName().equals(username + "-loginTime")) {
							// 保存上次登录时间
							Cookie lastLoginTime = new Cookie(username + "-lastLoginTime", cookie.getValue());
							response.addCookie(lastLoginTime);
						}
					}
				}
				System.out.println("用户：" + username + "登录成功");
				// 登录成功将用户信息添加到session中
				request.getSession().setAttribute("loginUser", loginUser);
				// 跳转到首页
				response.sendRedirect("goodsList.jsp");
			} else {
				System.out.println("用户：" + username + "密码错误");
				request.setAttribute("errorMsg", "密码错误");
				request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
			}
		} else {
			System.out.println("用户：" + username + "用户名不存在");
			request.setAttribute("errorMsg", "用户名不存在");
			request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
		}
		
	}

}
