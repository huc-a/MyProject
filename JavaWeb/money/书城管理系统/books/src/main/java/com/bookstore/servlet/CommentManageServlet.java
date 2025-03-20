package com.bookstore.servlet;

import com.bookstore.dao.BookCommentDAO;
import com.bookstore.model.BookComment;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/comment/*")
public class CommentManageServlet extends HttpServlet {
    private BookCommentDAO commentDAO = new BookCommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if (action == null || "/list".equals(action)) {
            String search = req.getParameter("search");
            String statusStr = req.getParameter("status");
            Integer status = statusStr != null && !statusStr.isEmpty() ? 
                           Integer.parseInt(statusStr) : null;
            
            List<BookComment> comments = commentDAO.getComments(search, status);
            req.setAttribute("comments", comments);
            req.setAttribute("search", search);
            req.getRequestDispatcher("/jsp/admin/comment-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if ("/status".equals(action)) {
            try {
                Integer id = Integer.parseInt(req.getParameter("id"));
                Integer status = Integer.parseInt(req.getParameter("status"));
                
                if (commentDAO.updateStatus(id, status)) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("error");
                }
            } catch (Exception e) {
                resp.getWriter().write("error");
            }
        } else if ("/reply".equals(action)) {
            try {
                Integer id = Integer.parseInt(req.getParameter("id"));
                String reply = req.getParameter("reply");
                
                if (commentDAO.updateReply(id, reply)) {
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