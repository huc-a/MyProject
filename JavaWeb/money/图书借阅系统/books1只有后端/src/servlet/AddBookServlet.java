package servlet;
import dao.BooksDao;
import dao.UsersDao;
import domain.Book;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "AddBookServlet",urlPatterns = "/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 设置编码
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html");
            
            // 检查是否是文件上传请求
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (!isMultipart) {
                response.getWriter().println("错误：不是文件上传请求！");
                return;
            }
            
            // 创建文件上传处理器
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            
            // 解析请求
            List<FileItem> items = upload.parseRequest(request);
            
            // 创建Book对象
            Book book = new Book();
            String uploadPath = "";
            
            // 处理表单字段
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    
                    switch (fieldName) {
                        case "bookname":
                            book.setBookname(value);
                            break;
                        case "publish":
                            book.setPublish(value);
                            break;
                        case "price":
                            book.setPrice(Float.parseFloat(value));
                            break;
                    }
                } else {
                    // 处理文件上传
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        // 生成唯一的文件名
                        String uniqueFileName = UUID.randomUUID().toString() + 
                                             fileName.substring(fileName.lastIndexOf("."));
                        
                        // 设置上传路径
                        String uploadDir = getServletContext().getRealPath("/resource/books");
                        File dir = new File(uploadDir);
                        if (!dir.exists()) {
                            dir.mkdirs();
                        }
                        
                        // 保存文件
                        File uploadedFile = new File(dir, uniqueFileName);
                        item.write(uploadedFile);
                        
                        // 设置图片路径
                        uploadPath = "resource/books/" + uniqueFileName;
                        book.setImage(uploadPath);
                    }
                }
            }
            
            // 添加图书
            BooksDao booksDao = new BooksDao();
            boolean flag = booksDao.insert(book);
            
            if(flag) {
                response.getWriter().println("<script>alert('添加成功！'); window.location.href='/IndexBookServlet';</script>");
            } else {
                response.getWriter().println("<script>alert('添加失败！'); history.back();</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('添加失败：" + e.getMessage() + "'); history.back();</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
}






