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
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 创建Book对象存储数据
        Book book = new Book();
        // 获取上传文件的保存路径
        String uploadPath = getServletContext().getRealPath("/upload");
        // 创建临时文件目录
        String tempPath = getServletContext().getRealPath("/WEB-INF/temp");
        File tempDir = new File(tempPath);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        
        try {
            // 配置上传参数
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // 设置临时文件目录
            factory.setRepository(tempDir);
            // 设置缓冲区大小
            factory.setSizeThreshold(1024 * 1024);
            
            ServletFileUpload upload = new ServletFileUpload(factory);
            // 设置最大文件上传大小
            upload.setFileSizeMax(1024 * 1024 * 10); // 10MB
            // 设置最大请求大小
            upload.setSizeMax(1024 * 1024 * 50); // 50MB
            // 设置字符编码
            upload.setHeaderEncoding("UTF-8");
            
            // 创建上传目录（如果不存在）
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 解析请求
            List<FileItem> items = upload.parseRequest(request);
            
            // 处理表单数据
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");

                    if ("bookname".equals(fieldName)) {
                        book.setBookname(value);
                    } else if ("publish".equals(fieldName)) {
                        book.setPublish(value);
                    } else if ("price".equals(fieldName)) {
                        book.setPrice(Float.parseFloat(value));
                    } else if ("category_id".equals(fieldName)) {
                        book.setCategory_id(Integer.parseInt(value));
                    }
                } else {
                    // 处理文件上传
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        // 获取文件扩展名
                        String fileExt = fileName.substring(fileName.lastIndexOf("."));
                        // 生成唯一文件名
                        String uniqueFileName = UUID.randomUUID().toString() + fileExt;
                        String filePath = "/upload/" + uniqueFileName;
                        
                        // 保存文件
                        File file = new File(uploadPath, uniqueFileName);
                        item.write(file);
                        
                        // 设置图片路径
                        book.setImage(filePath);
                    }
                }
            }
            
            // 保存图书信息到数据库
            if (booksDao.insert(book)) {
                response.sendRedirect("/IndexBookServlet");
            } else {
                response.getWriter().write("添加图书失败");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("添加图书失败：" + e.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}






