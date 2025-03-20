package com.bookstore.servlet;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/*")
public class UserManageServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if (action == null || "/list".equals(action)) {
            String search = req.getParameter("search");
            List<User> users = userDAO.getUsers(search);
            req.setAttribute("users", users);
            req.setAttribute("search", search);
            req.getRequestDispatcher("/jsp/admin/user-list.jsp").forward(req, resp);
        } else if ("/edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = userDAO.getUserById(id);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/jsp/admin/user-edit.jsp").forward(req, resp);
        } else if ("/add".equals(action)) {
            req.getRequestDispatcher("/jsp/admin/user-add.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if ("/delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                if (userDAO.deleteUser(id)) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("error");
                }
            } catch (NumberFormatException e) {
                resp.getWriter().write("error");
            }
        } else if ("/update".equals(action)) {
            try {
                User user = new User();
                user.setId(Integer.parseInt(req.getParameter("id")));
                user.setUsername(req.getParameter("username"));
                user.setRealName(req.getParameter("realName"));
                user.setPhone(req.getParameter("phone"));
                user.setEmail(req.getParameter("email"));
                
                if (userDAO.updateUser(user)) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("error");
                }
            } catch (Exception e) {
                resp.getWriter().write("error");
            }
        } else if ("/create".equals(action)) {
            try {
                User user = new User();
                user.setUsername(req.getParameter("username"));
                user.setRealName(req.getParameter("realName"));
                user.setPhone(req.getParameter("phone"));
                user.setEmail(req.getParameter("email"));
                
                if (userDAO.createUser(user)) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("error");
                }
            } catch (Exception e) {
                resp.getWriter().write("error");
            }
        }
    }
} 