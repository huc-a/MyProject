package servlet;

import dao.UsersDao;
import domain.User;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GetUserServlet")
public class GetUserServlet extends HttpServlet {
    private UsersDao usersDao = new UsersDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 设置响应类型
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            // 获取用户ID
            int id = Integer.parseInt(request.getParameter("id"));
            
            // 查询用户
            User user = usersDao.find(id);
            
            // 手动构建JSON
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String userJson = String.format(
                "{\"id\":%d," +
                "\"username\":\"%s\"," +
                "\"password\":\"%s\"," +
                "\"email\":\"%s\"," +
                "\"birthday\":\"%s\"," +
                "\"isadmin\":%d}",
                user.getId(),
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                sdf.format(user.getBirthday()),
                user.getIsadmin()
            );
            
            response.getWriter().write(userJson);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"获取用户信息失败：" + e.getMessage() + "\"}");
        }
    }
} 