package utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 提供简化的请求转发方法
 */
public class DispatcherUtils {

    /**
     * 实现简单的打开一个url地址的网页，实现网页的请求转发功能
     * @param url
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public static void openWeb(String url,
                               HttpServletRequest request,
                               HttpServletResponse response)throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request,response);
    }

    /**
     * 打开errors.jsp页面实现错误信息展示
     * @param errMsg
     * @param backUrl
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public static void openErrWeb(String errMsg,
                                  String backUrl,
                                  HttpServletRequest request,
                                  HttpServletResponse response)throws ServletException, IOException {
        request.setAttribute("errMsg",errMsg);
        request.setAttribute("backUrl",backUrl);
        RequestDispatcher rd = request.getRequestDispatcher("errors.jsp");
        rd.forward(request,response);
    }
}
