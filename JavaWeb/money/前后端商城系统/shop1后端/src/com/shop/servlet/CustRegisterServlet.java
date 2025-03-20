package com.shop.servlet;

import com.shop.entity.User;
import com.shop.service.UserService;
import com.shop.util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * 添加用户Servlet
 */
@WebServlet("/CustRegisterServlet")
public class CustRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 实例化service
	private UserService userService = new UserService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 设置请求和响应的编码格式
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		// 在request中获取用户信息
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

		User userIsExist = userService.getUserByPhone(phone);
		if (userIsExist == null) {
			// 执行添加操作
			int add = userService.add(user);
			if (add > 0) {  // 成功
				request.setAttribute("successMsg", "注册成功，去登录吧");
			} else {  // 失败
				request.setAttribute("errorMsg", "注册失败");
			}
		} else {
			request.setAttribute("errorMsg", "用户名重复");
		}
		request.getRequestDispatcher("userRegister.jsp").forward(request, response);
	}
}
