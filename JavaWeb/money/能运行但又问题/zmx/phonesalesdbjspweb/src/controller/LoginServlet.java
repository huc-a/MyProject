package controller;


import dao.userDAO;
import dao.userdaolmpl;
import model.Tuser;

import utils.DispatcherUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用户登录操作请求控制器（每个serlvet的生命周期都由servlet管理容器）
 */
@WebServlet(name = "LoginServlet", value = "/jspviews/login.do")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //（1）获取参数
        String useraccount = request.getParameter("useraccount");
        String pwd = request.getParameter("pwd");
        //（2）数据校验,如果不通过，则打开errors.jsp错误页面实现错误信息提示
        if (useraccount == null || useraccount.equals("")) {
            DispatcherUtils.openErrWeb("登录用户账号不能为空", "login.jsp", request, response);
            return;
        } else if (pwd == null || pwd.equals("")) {
            DispatcherUtils.openErrWeb("登录用户密码不能为空", "login.jsp", request, response);
            return;
        }
        //（3）身份验证
        userdaolmpl udao = new userdaolmpl(); //借助用户业务类对象
        Tuser loginuser = udao.userLogin(useraccount, pwd);
        //（4）页面跳转
        if (loginuser != null && loginuser.getUseraccount() != null) { //成功获取用户
            HttpSession session = request.getSession(); //获取session对象
            session.setAttribute("loginuser", loginuser);  //把登录用户存入到session中
            response.sendRedirect("index.do");  //返回主页
        } else {
            DispatcherUtils.openErrWeb("您输入的用户账号和密码不正确", "login.jsp", request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
