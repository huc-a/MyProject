package controller;

import dao.productDAO;
import dao.productDaolmpl;
import model.Tproduct;
import utils.DispatcherUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteProductServlet", value = "/jspviews/delproduct.do")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sProductid=request.getParameter("productid");
        if (sProductid==null || sProductid.trim().equals("")){
            DispatcherUtils.openErrWeb("您没有指定要删除的手机","index.do",
                    request,response);
        }else {
            HttpSession session=request.getSession();
            productDAO hdao=new productDaolmpl();
            Tproduct product= hdao.getproductById(Integer.parseInt(sProductid));

            if(hdao.removeProduct(Integer.parseInt(sProductid))){
                response.sendRedirect("productmanage.do");  //成功则返回到酒店管理页面
                return;
            }else{
                DispatcherUtils.openErrWeb("手机删除失败，请联系管理员","productlinfo.do?productid="+sProductid
                        ,request,response);
                return;
            }
        }
        }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

}
