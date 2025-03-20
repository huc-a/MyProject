package com.tuling.controller;

import com.tuling.domain.User;
import com.tuling.service.UserService;
import com.tuling.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/userServlet")
public class UserServlet extends BaseServlet{
    private UserService userService = new UserServiceImpl();

    /**
     * 注册
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email=req.getParameter("email");
        String phone=req.getParameter("phone");
        String pwd=req.getParameter("pwd1");
        User user = new User(email,phone,pwd);
        User loginUser = userService.add(user);
        if(loginUser!=null)
        {
            HttpSession session=req.getSession();
            session.setAttribute("user",user);
            return "forward:/index.jsp";
        }
        else{
            return "forward:/reg.jsp";
        }

    }

    /**
     * 登录
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String str=req.getParameter("str");
        String pwd=req.getParameter("pwd");
        boolean flag = false;
        if(str.indexOf("@")!=-1){
            flag = true;
        }
        User loginUser = userService.login(str,pwd,flag);
        //获取管理员id列表
        List<Integer> rootList = userService.root();
        if(rootList!=null&&rootList.size()>0){
            for (Integer rootId : rootList) {
                if(loginUser.getId()==rootId){
                    return "forward:/BSindex.jsp";
                }
            }
        }
        if(loginUser!=null){
            HttpSession session=req.getSession();
            session.setAttribute("user",loginUser);
            return "forward:/index.jsp";
        }else{
            return "forward:/login.jsp";
        }
    }


}
