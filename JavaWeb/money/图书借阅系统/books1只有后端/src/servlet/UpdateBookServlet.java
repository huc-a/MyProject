package servlet;

import dao.BooksDao;
import domain.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "UpdateBookServlet",urlPatterns = "/UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 设置编码
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
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
            String uploadPath = null;
            
            // 处理表单字段
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    
                    switch (fieldName) {
                        case "bookid":
                            book.setBookid(Integer.parseInt(value));
                            break;
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
                        
                        // 设置新的图片路径
                        uploadPath = "resource/books/" + uniqueFileName;
                    }
                }
            }
            
            // 如果上传了新图片，则更新图片路径
            if (uploadPath != null) {
                book.setImage(uploadPath);
            } else {
                // 如果没有上传新图片，获取原图片路径
                Book oldBook = booksDao.find(book.getBookid());
                book.setImage(oldBook.getImage());
            }
            
            // 更新图书
            boolean success = booksDao.update(book);
            
            if (success) {
                response.getWriter().println("<script>alert('修改成功！'); window.location.href='/IndexBookServlet';</script>");
            } else {
                response.getWriter().println("<script>alert('修改失败！'); history.back();</script>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('修改失败：" + e.getMessage() + "'); history.back();</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 获取图书ID
            int bookid = Integer.parseInt(request.getParameter("id"));
            
            // 查询图书信息
            Book book = booksDao.find(bookid);
            
            if (book != null) {
                // 将图书信息传递给页面
                request.setAttribute("book", book);
                request.getRequestDispatcher("admin/UpdateBook.jsp").forward(request, response);
            } else {
                response.getWriter().println("<script>alert('图书不存在！'); window.location.href='/IndexBookServlet';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("获取图书信息失败：" + e.getMessage());
        }
    }
} 