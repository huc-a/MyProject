package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.model.Book;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.io.File;
import java.util.UUID;
import java.util.Arrays;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/book/*")
public class BookManageServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();
    private static final int PAGE_SIZE = 10;
    private static final String UPLOAD_DIRECTORY = "static/images/books";
    private static final int MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final String[] ALLOWED_FILE_TYPES = {".jpg", ".jpeg", ".png", ".gif"};

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if (action == null || "/list".equals(action)) {
            listBooks(req, resp);
        } else if ("/add".equals(action)) {
            showAddForm(req, resp);
        } else if ("/edit".equals(action)) {
            showEditForm(req, resp);
        } else if ("/delete".equals(action)) {
            deleteBook(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if ("/add".equals(action)) {
            addBook(req, resp);
        } else if ("/edit".equals(action)) {
            updateBook(req, resp);
        }
    }

    private void listBooks(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 获取分页参数
        int page = 1;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (NumberFormatException e) {
            // 使用默认值1
        }
        
        // 获取搜索参数
        String search = req.getParameter("search");
        
        // 获取图书总数和总页数
        int totalBooks = bookDAO.getTotalBooks(search);
        int totalPages = (totalBooks + PAGE_SIZE - 1) / PAGE_SIZE;
        
        // 获取当前页的图书列表
        List<Book> books = bookDAO.getBooks(page, PAGE_SIZE, search);
        
        // 设置属性
        req.setAttribute("books", books);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("search", search);
        
        // 转发到列表页面
        req.getRequestDispatcher("/jsp/admin/book-list.jsp").forward(req, resp);
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 转发到添加图书页面
        req.getRequestDispatcher("/jsp/admin/book-add.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 获取图书ID
            int id = Integer.parseInt(req.getParameter("id"));
            // 获取图书信息
            Book book = bookDAO.getBookById(id);
            
            if (book != null) {
                req.setAttribute("book", book);
                req.getRequestDispatcher("/jsp/admin/book-edit.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/book/list");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/book/list");
        }
    }

    private void addBook(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 检查是否是multipart请求
        if (!ServletFileUpload.isMultipartContent(req)) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            // 创建文件上传工厂
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(MAX_FILE_SIZE);
            
            // 解析请求
            List<FileItem> items = upload.parseRequest(req);
            
            // 创建Book对象
            Book book = new Book();
            String fileName = null;
            
            // 处理表单字段
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    
                    switch (fieldName) {
                        case "title":
                            book.setTitle(value);
                            break;
                        case "author":
                            book.setAuthor(value);
                            break;
                        case "publisher":
                            book.setPublisher(value);
                            break;
                        case "price":
                            book.setPrice(Double.parseDouble(value));
                            break;
                        case "stock":
                            book.setStock(Integer.parseInt(value));
                            break;
                        case "description":
                            book.setDescription(value);
                            break;
                        case "status":
                            book.setStatus(Integer.parseInt(value));
                            break;
                    }
                } else {
                    // 处理文件上传
                    String contentType = item.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // 生成唯一文件名
                        String originalFileName = item.getName();
                        String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
                        fileName = UUID.randomUUID().toString() + extension;
                        
                        // 检查文件类型
                        if (!Arrays.asList(ALLOWED_FILE_TYPES).contains(extension.toLowerCase())) {
                            req.setAttribute("error", "不支持的文件类型");
                            req.getRequestDispatcher("/jsp/admin/book-add.jsp").forward(req, resp);
                            return;
                        }
                        
                        // 保存文件
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        File file = new File(uploadPath + File.separator + fileName);
                        item.write(file);
                    }
                }
            }
            
            // 设置图片路径
            if (fileName != null) {
                book.setCoverImage("/" + UPLOAD_DIRECTORY + "/" + fileName);
            }
            
            // 保存图书信息
            if (bookDAO.addBook(book)) {
                resp.sendRedirect(req.getContextPath() + "/book/list");
            } else {
                req.setAttribute("error", "添加图书失败");
                req.setAttribute("book", book);
                req.getRequestDispatcher("/jsp/admin/book-add.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "系统错误：" + e.getMessage());
            req.getRequestDispatcher("/jsp/admin/book-add.jsp").forward(req, resp);
        }
    }

    private void updateBook(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 检查是否是multipart请求
        if (!ServletFileUpload.isMultipartContent(req)) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            // 创建文件上传工厂
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(MAX_FILE_SIZE);
            
            // 解析请求
            List<FileItem> items = upload.parseRequest(req);
            
            // 创建Book对象
            Book book = new Book();
            String fileName = null;
            
            // 处理表单字段
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 处理普通表单字段
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");
                    
                    switch (fieldName) {
                        case "id":
                            book.setId(Integer.parseInt(value));
                            break;
                        case "title":
                            book.setTitle(value);
                            break;
                        case "author":
                            book.setAuthor(value);
                            break;
                        case "publisher":
                            book.setPublisher(value);
                            break;
                        case "price":
                            book.setPrice(Double.parseDouble(value));
                            break;
                        case "stock":
                            book.setStock(Integer.parseInt(value));
                            break;
                        case "description":
                            book.setDescription(value);
                            break;
                        case "status":
                            book.setStatus(Integer.parseInt(value));
                            break;
                    }
                } else {
                    // 处理文件上传
                    String contentType = item.getContentType();
                    if (contentType != null && contentType.startsWith("image/") && item.getSize() > 0) {
                        // 生成唯一文件名
                        String originalFileName = item.getName();
                        String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
                        fileName = UUID.randomUUID().toString() + extension;
                        
                        // 检查文件类型
                        if (!Arrays.asList(ALLOWED_FILE_TYPES).contains(extension.toLowerCase())) {
                            req.setAttribute("error", "不支持的文件类型");
                            req.setAttribute("book", book);
                            req.getRequestDispatcher("/jsp/admin/book-edit.jsp").forward(req, resp);
                            return;
                        }
                        
                        // 保存文件
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        
                        File file = new File(uploadPath + File.separator + fileName);
                        item.write(file);
                    }
                }
            }
            
            // 如果上传了新图片，更新图片路径
            if (fileName != null) {
                book.setCoverImage("/" + UPLOAD_DIRECTORY + "/" + fileName);
            } else {
                // 如果没有上传新图片，获取原图片路径
                Book oldBook = bookDAO.getBookById(book.getId());
                if (oldBook != null) {
                    book.setCoverImage(oldBook.getCoverImage());
                }
            }
            
            // 更新图书信息
            if (bookDAO.updateBook(book)) {
                resp.sendRedirect(req.getContextPath() + "/book/list");
            } else {
                req.setAttribute("error", "更新图书失败");
                req.setAttribute("book", book);
                req.getRequestDispatcher("/jsp/admin/book-edit.jsp").forward(req, resp);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "系统错误：" + e.getMessage());
            req.getRequestDispatcher("/jsp/admin/book-edit.jsp").forward(req, resp);
        }
    }

    private void deleteBook(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            bookDAO.deleteBook(id);
        } catch (NumberFormatException e) {
            // 忽略错误的ID格式
        }
        resp.sendRedirect(req.getContextPath() + "/book/list");
    }
} 