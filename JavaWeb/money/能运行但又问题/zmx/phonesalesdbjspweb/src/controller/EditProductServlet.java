package controller;

import dao.productDAO;
import dao.productDaolmpl;
import model.Tproduct;
import utils.DispatcherUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EditProductServlet", value = "/jspviews/editproduct.do")
public class EditProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sProductid = request.getParameter("productid"); //获得要编辑酒店的id
        Tproduct product = null;
        if(sProductid==null ||sProductid .trim().equals("")){

            product = new Tproduct();
        }else{

            int productid = Integer.parseInt(sProductid);
            productDAO hdao = new productDaolmpl();
            product = hdao.getproductById(productid);
        }
        request.setAttribute("product",product);
        DispatcherUtils.openWeb("editproduct.jsp",request,response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }
}
