package com.tuling.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class BaseServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        //1,获取请求参数标识符
        String methodStr = req.getParameter("method");
        //2,如果method没有获取到值，我们就跳转到首页
        if(methodStr==null||methodStr.equals("")){
            methodStr = "index";
        }
        //3,反射调用对应的方法
        Class clazz = this.getClass();
        try {
            Method method = clazz.getMethod(methodStr, HttpServletRequest.class, HttpServletResponse.class);
            Object result = method.invoke(this,req,resp);
            //4,集中处理返回值响应
            if(result!=null){
                //转发，重定向，返回字符串
                String str = (String) result;
                if(str.startsWith("forward:")){
                    //转发
                    String path  = str.substring(str.indexOf(":")+1);
                    req.getRequestDispatcher(path).forward(req,resp);

                }else if(str.startsWith("redirect:")){
                    //重定向
                    String path = str.substring(str.indexOf(":") + 1);
                    resp.sendRedirect(req.getContextPath()+path);
                }else{
                    resp.getWriter().println(str);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 当method没有标识符的时候，我们默认赋值index,访问每个controller的index方法
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String index(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        return "forward:/index.jsp";
    }

}
