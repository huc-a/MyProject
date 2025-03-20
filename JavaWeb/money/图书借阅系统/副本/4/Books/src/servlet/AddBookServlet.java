package servlet;

import dao.BooksDao;
import domain.Book;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // 创建Book对象存储数据
        Book book = new Book();
        String uploadPath = getServletContext().getRealPath("/upload");
        
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);
            
            // 处理表单数据
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    
                    // 使用if-else替代switch
                    if ("bookname".equals(fieldName)) {
                        book.setBookname(value);
                    } else if ("publish".equals(fieldName)) {
                        book.setPublish(value);
                    } else if ("price".equals(fieldName)) {
                        book.setPrice(Float.parseFloat(value));
                    }
                } else {
                    // 处理文件上传
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        // 生成唯一文件名
                        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
                        String filePath = "/upload/" + uniqueFileName;
                        
                        // 确保上传目录存在
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        // 保存文件
                        File file = new File(uploadPath, uniqueFileName);
                        item.write(file);
                        
                        // 设置图片路径
                        book.setImage(filePath);
                    }
                }
            }
            
            // 保存图书信息到数据库
            BooksDao booksDao = new BooksDao();
            if (booksDao.insert(book)) {
                response.sendRedirect("/IndexBookServlet");
            } else {
                response.getWriter().write("添加图书失败");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("添加图书失败：" + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}






