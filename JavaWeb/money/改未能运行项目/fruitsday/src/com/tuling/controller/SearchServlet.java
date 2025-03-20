package com.tuling.controller;

import com.tuling.domain.Fruit;
import com.tuling.service.FruitService;
import com.tuling.service.impl.FruitServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/searchServlet")
public class SearchServlet extends BaseServlet{
    private FruitService fruitService = new FruitServiceImpl();
    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String all(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Fruit> allFruits= fruitService.findAll();

        req.setAttribute("selFruits", allFruits);
        return "forward:/search.jsp";
    }

    /**
     * 进口
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String out(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        return "forward:/search.jsp";
    }

    /**
     * 国产
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String in(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        return "forward:/search.jsp";
    }

    /**
     * 搜索
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String keyword=req.getParameter("keyword");
        List<Fruit> serFruits= fruitService.search(keyword);
        req.setAttribute("selFruits", serFruits);
        return "forward:/search.jsp";
    }

    /**
     * 搜索
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String money(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        String keyword=req.getParameter("keyword");

        List<Fruit> fruits= fruitService.findAll();

        List<Fruit> selfruits=new ArrayList<Fruit>();
        int n=0,m=0;
        if("a".equals(keyword))
        {
            n=0;
            m=100;
        }
        else if("b".equals(keyword))
        {
            n=100;
            m=300;
        }
        else if("c".equals(keyword))
        {
            n=300;
            m=99999999;
        }

        for(Fruit fruit:fruits)
        {
            if(fruit.getUp()>=n&&fruit.getUp()<=m)
                selfruits.add(fruit);
        }
        req.setAttribute("selFruits", selfruits);

        return "forward:/search.jsp";
    }
}
