package servlet;
import dao.UsersDao;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "UpdateUserServlet",urlPatterns = "/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private UsersDao usersDao = new UsersDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            // 处理更新操作
            try {
                // 获取表单数据
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String birthdayStr = request.getParameter("birthday");
                int isadmin = Integer.parseInt(request.getParameter("isadmin"));
                
                // 创建User对象并设置值
                User user = new User();
                user.setId(id);
                user.setUsername(username);
                user.setPassword(password);
                user.setEmail(email);
                
                // 转换日期格式
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                user.setBirthday(sdf.parse(birthdayStr));
                user.setIsadmin(isadmin);
                
                // 更新用户
                boolean success = usersDao.update(user);
                
                response.setContentType("text/html;charset=UTF-8");
                if (success) {
                    response.getWriter().println("<script>alert('修改成功！'); window.location.href='/IndexUserServlet';</script>");
                } else {
                    response.getWriter().println("<script>alert('修改失败！'); history.back();</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("<script>alert('修改失败：" + e.getMessage() + "'); history.back();</script>");
            }
        } else {
            // 显示修改表单
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                User user = usersDao.find(id);
                if (user != null) {
                    request.setAttribute("user1", user);
                    request.getRequestDispatcher("admin/UpdateUser.jsp").forward(request, response);
                } else {
                    response.getWriter().println("<script>alert('用户不存在！'); window.location.href='/IndexUserServlet';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("/IndexUserServlet");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
}






