package com.tuling.controller;

import com.tuling.domain.Fruit;
import com.tuling.domain.User;
import com.tuling.service.FruitService;
import com.tuling.service.UserService;
import com.tuling.service.impl.FruitServiceImpl;
import com.tuling.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/BSServlet")
public class BSServlet extends BaseServlet{
    private FruitService fruitService = new FruitServiceImpl();
    private UserService userService = new UserServiceImpl();

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String toAdmin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        if(user!=null){
            return "forward:/BSindex.jsp";
        }else{
            //跳转到登录页面,提示用户登录
            req.setAttribute("showError",true);
            return "forward:/login.jsp";
        }
    }
    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String alluser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> all = userService.findAll();
        if(all!=null&&all.size()>0){
            req.setAttribute("allusers",all);
            return "forward:/allUser.jsp";
        }
        return null;
    }
    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String deluser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int uid=Integer.parseInt(req.getParameter("uid"));

        User user=new User(uid);
        boolean del = userService.del(user);
        //用户列表页面
        return alluser(req,resp);
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String adduser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uname=req.getParameter("name1");
        String email=req.getParameter("email1");
        String phone=req.getParameter("phone1");
        String pwd=req.getParameter("pwd1");

        User user=new User(email,phone,pwd,uname);
        User resultUser = userService.add(user);
        if(resultUser!=null){
            return alluser(req,resp);//用户列表页面;
        }
        return null;
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String upuser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uname=req.getParameter("name2");
        String email=req.getParameter("email2");
        String phone=req.getParameter("phone2");
        String pwd=req.getParameter("pwd2");
        int uid=Integer.parseInt(req.getParameter("uid"));
        User user=new User(uid,email,phone,pwd,uname);
        boolean result = userService.update(user);
        if(result){
            return alluser(req,resp);//用户列表页面;
        }
        return null;
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String finduser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int uid=Integer.parseInt(req.getParameter("uid"));
        User user = userService.findById(uid);
        if(user!=null){
            req.setAttribute("user",user);
        }
        return "forward:/user.jsp";//用户详情;
    }


    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String allfruit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Fruit> all = fruitService.findAll();
        req.setAttribute("allfruit",all);
        return "forward:/allFruit.jsp";//水果列表，热卖水果列表
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String addfruit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fname=req.getParameter("fname");
        String spec=req.getParameter("spec");
        double price= Double.parseDouble(req.getParameter("price"));
        String t1=req.getParameter("t1");
        String t2=req.getParameter("t2");
        int inum= Integer.parseInt(req.getParameter("inum"));
        //int fid= Integer.parseInt(req.getParameter("fid"));
        Fruit fruit=new Fruit(0,fname,spec,price,t1,t2,inum);
        boolean add = fruitService.add(fruit);
        if(add){
            return allfruit(req,resp);
        }else{
            return "forward:/addFruit.jsp";//添加水果之后报错的页面
        }
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String findfruit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int fid= Integer.parseInt(req.getParameter("fid"));
        Fruit fruit = fruitService.findByFid(fid);
        req.setAttribute("fruit",fruit);

        return "forward:/fruit.jsp";//水果详情
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String delfruit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int fid= Integer.parseInt(req.getParameter("fid"));
        fruitService.del(fid);
        return allfruit(req,resp);
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String hotfruit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Fruit> fruits = fruitService.findHot();
        req.setAttribute("fruits",fruits);
        //热卖水果
        return "forward:/allFruit.jsp";
    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String upfruit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fname=req.getParameter("fname");
        String spec=req.getParameter("spec");
        double up= Double.parseDouble(req.getParameter("up"));
        String t1=req.getParameter("t1");
        String t2=req.getParameter("t2");
        int inum= Integer.parseInt(req.getParameter("inum"));
        int fid= Integer.parseInt(req.getParameter("fid"));
        Fruit fruit=new Fruit(fid,fname,spec,up,t1,t2,inum);
        fruitService.update(fruit);//更新
        //更新之后，展示列表
        return allfruit(req,resp);
    }
}
