package controller;


import dao.productDAO;
import dao.productDaolmpl;
import model.Tproduct;
import utils.DispatcherUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 主页数据处理的请求控制器
 */
@WebServlet(name = "IndexServlet", value = "/jspviews/index.do")
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String colortype = request.getParameter("colortype");
        String  productname= request.getParameter("productname");
        productDAO hdao = new productDaolmpl();

        List<Tproduct> productList = hdao.getproductsByProductname(productname);

        request.setAttribute("productList",productList);
        DispatcherUtils.openWeb("index.jsp",request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
