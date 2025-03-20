package controller;

import dao.orderrecordDAO;
import dao.orderrecordDaolmpl;
import dao.productDAO;
import dao.productDaolmpl;
import model.Torderrecord;
import model.Tproduct;
import utils.DispatcherUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductInfoServlet", value = "/jspviews/productinfo.do")
public class ProductInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sProductid = request.getParameter("productid");
        int productid = 0;
        //将字符串sHotelid转换为int类型
        if(sProductid!=null && !sProductid.equals("")){
            productid = Integer.parseInt(sProductid);
        }
        //创建酒店业务类和房间类型业务类的对象
        productDAO hdao = new productDaolmpl();
        orderrecordDAO rdao = new orderrecordDaolmpl();
        //获得hotelid对应的酒店对象
        Tproduct product= hdao.getproductById(productid);
        //获取hotelid对应的酒店所有房间信息对象
        List<Torderrecord> orderrecordList = rdao.getOderrecordListByProductid(productid);

        request.setAttribute("product",product);
        request.setAttribute("orderrecordList",orderrecordList);

        //打开hotelinfo.jsp实现数据的展示
        DispatcherUtils.openWeb("productinfo.jsp",request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }
}
