package controller;

import dao.userDAO;
import dao.userdaolmpl;
import model.Tuser;
import utils.DispatcherUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddNorallMemberServlet", value = "/jspviews/addnormalmember.do")
public class AddNorallMemberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String  useraccount= request.getParameter("useraccount");
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String pwd2 = request.getParameter("pwd2");
        String mobile = request.getParameter("mobile");

        if (useraccount==null || useraccount.trim().equals("")){
            DispatcherUtils.openErrWeb("注册用户的账号不能为空","addnormalmember.jsp",request,response);
        }else if(pwd==null || pwd.trim().equals("")){
            DispatcherUtils.openErrWeb("注册用户的登录密码不能为空","addnormalmember.jsp",request,response);
            return;
        }else if(pwd2==null || pwd2.trim().equals("")){
            DispatcherUtils.openErrWeb("注册用户的登录密码确认不能为空","addnormalmember.jsp",request,response);
            return;
        }else if(!pwd.equals(pwd2)){
            DispatcherUtils.openErrWeb("您输入的登录密码和登录密码确认不一致","addnormalmember.jsp",request,response);
            return;
        }else if(username==null || username.trim().equals("")){
            DispatcherUtils.openErrWeb("注册用户的用户姓名不能为空","addnormalmember.jsp",request,response);
            return;
        }

        userDAO udao=new userdaolmpl();
        if (!udao.isUseridValid(useraccount)){
            DispatcherUtils.openErrWeb("您输入的用户账号已存在，因此不可用","addnormalmember.jsp",request,response);
            return;

        }
        Tuser regUser = new Tuser();
        regUser.setUseraccount(useraccount);
        regUser.setUsername(username);
        regUser.setPwd(pwd);
        regUser.setMobile(mobile);
        boolean status=udao.registerUser(regUser);

        if (status){
            response.sendRedirect("index.do");
        }else {
            DispatcherUtils.openErrWeb("会员用户注册失败，系统无法正确进行会员注册，请联系系统管理员",
                    "addnormalmember.jsp",request,response);
        }



    }




    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }
}
