package servlet;

import dao.BooksDao;
import domain.Book;
import domain.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            // 获取图书信息
            Book book = booksDao.findById(Integer.parseInt(id));
            request.setAttribute("book", book);
            
            // 获取分类列表
            ArrayList<Category> categories = booksDao.findAllCategories();
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("admin/UpdateBook.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        Book book = new Book();
        String uploadPath = getServletContext().getRealPath("/upload");
        
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);
            
            String oldImage = null;
            
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    
                    if ("bookid".equals(fieldName)) {
                        book.setBookid(Integer.parseInt(value));
                    } else if ("bookname".equals(fieldName)) {
                        book.setBookname(value);
                    } else if ("publish".equals(fieldName)) {
                        book.setPublish(value);
                    } else if ("price".equals(fieldName)) {
                        book.setPrice(Float.parseFloat(value));
                    } else if ("category_id".equals(fieldName)) {
                        book.setCategory_id(Integer.parseInt(value));
                    } else if ("oldImage".equals(fieldName)) {
                        oldImage = value;
                    }
                } else {
                    String fileName = item.getName();
                    if (fileName != null && !fileName.isEmpty()) {
                        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
                        String filePath = "/upload/" + uniqueFileName;
                        
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        File file = new File(uploadPath, uniqueFileName);
                        item.write(file);
                        
                        book.setImage(filePath);
                        
                        // 删除旧图片
                        if (oldImage != null && !oldImage.isEmpty()) {
                            File oldFile = new File(uploadPath + oldImage);
                            if (oldFile.exists()) {
                                oldFile.delete();
                            }
                        }
                    } else {
                        // 如果没有上传新图片，保留原图片
                        book.setImage(oldImage);
                    }
                }
            }
            
            if (booksDao.update(book)) {
                response.sendRedirect("/IndexBookServlet");
            } else {
                response.getWriter().write("更新图书失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("更新图书失败：" + e.getMessage());
        }
    }
} 