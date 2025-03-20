package controller;



import dao.productDAO;
import dao.productDaolmpl;

import model.Tproduct;
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
 * 实现酒店信息保存动作的请求控制器
 */
@WebServlet(name = "SaveHotelServlet", value = "/jspviews/saveproduct.do")
public class SaveProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //（1）接受酒店信息参数
        request.setCharacterEncoding("utf-8");
        String sProductid = request.getParameter("productid");
        String productname= request.getParameter("productname");
        String brand= request.getParameter("brand");
        String memory = request.getParameter("memory");
        String price = request.getParameter("price");
        String colortype = request.getParameter("colortype");
        String productlmage= request.getParameter("productlmage");

        if(productname==null || productname.trim().equals("")){
            DispatcherUtils.openErrWeb("手机名称不能为空","editproduct.do?productid="+sProductid,
                    request,response);
            return;
        }

        HttpSession session = request.getSession();
        Tuser loginuser = (Tuser) session.getAttribute("loginuser");
        productDAO hdao = new productDaolmpl(); //创建一个酒店管理业务类对象

        if(sProductid==null || sProductid.equals("0")){

            Tproduct newProduct = new Tproduct();
            newProduct.setProductname(productname);
            newProduct.setBrand(brand);
            newProduct.setMemory(memory);
            newProduct.setPrice(price);
            newProduct.setColortype(colortype);
            newProduct.setProductlmage(productlmage);
            newProduct.setUserid(loginuser.getUserid());

            if(hdao.addproduct(newProduct)>0){
                response.sendRedirect("productmanage.do");
            }else{ //失败
                DispatcherUtils.openErrWeb("添加手机失败，请联系系统管理员","editproduct.do",request,response);
            }

        }else{

            Tproduct editproduct = hdao.getproductById(Integer.parseInt(sProductid));
            editproduct.setProductname(productname); //将网页获得的酒店信息修改到酒店对象中
            editproduct.setBrand(brand);
            editproduct.setMemory(memory);
            editproduct.setPrice(price);
            editproduct.setColortype(colortype);
            editproduct.setProductlmage(productlmage);

            if(hdao.updateproduct(editproduct)){  //修改成功
                response.sendRedirect("hotelinfo.do?hotelid="+sProductid);
            }else{ //修改失败
                DispatcherUtils.openErrWeb("添加信息修改失败，请联系系统管理员","editproduct.do",request,response);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
