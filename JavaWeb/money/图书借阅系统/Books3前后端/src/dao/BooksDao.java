package dao;

import domain.Book;
import domain.Category;
import util.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;

public class BooksDao {
    // 添加图书
    public boolean insert(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO books(bookname,publish,price,image,category_id) VALUES(?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, book.getBookname());
            pstmt.setString(2, book.getPublish());
            pstmt.setFloat(3, book.getPrice());
            pstmt.setString(4, book.getImage());
            pstmt.setInt(5, book.getCategory_id());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 查询所有图书
    public ArrayList<Book> findAll() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Book> list = new ArrayList<Book>();
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT b.*, c.category_name FROM books b " +
                        "LEFT JOIN categories c ON b.category_id = c.category_id";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                book.setCategory_id(rs.getInt("category_id"));
                book.setCategory_name(rs.getString("category_name"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }

    // 根据ID查询图书
    public Book findById(int bookid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT b.*, c.category_name FROM books b " +
                        "LEFT JOIN categories c ON b.category_id = c.category_id " +
                        "WHERE b.bookid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookid);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                book.setCategory_id(rs.getInt("category_id"));
                book.setCategory_name(rs.getString("category_name"));
                return book;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return null;
    }

    // 更新图书
    public boolean update(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "UPDATE books SET bookname=?, publish=?, price=?, image=?, category_id=? WHERE bookid=?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, book.getBookname());
            pstmt.setString(2, book.getPublish());
            pstmt.setFloat(3, book.getPrice());
            pstmt.setString(4, book.getImage());
            pstmt.setInt(5, book.getCategory_id());
            pstmt.setInt(6, book.getBookid());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 删除图书
    public boolean delete(int bookid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "DELETE FROM books WHERE bookid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookid);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    public ArrayList<Book> search(String keyword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Book> list = new ArrayList<Book>();
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT b.*, c.category_name FROM books b " +
                        "LEFT JOIN categories c ON b.category_id = c.category_id " +
                        "WHERE b.bookname LIKE ? OR b.publish LIKE ?";
            pstmt = conn.prepareStatement(sql);
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                book.setCategory_id(rs.getInt("category_id"));
                book.setCategory_name(rs.getString("category_name"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }

    // 获取所有分类
    public ArrayList<Category> findAllCategories() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Category> list = new ArrayList<Category>();
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM categories ORDER BY category_id";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategory_id(rs.getInt("category_id"));
                category.setCategory_name(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }

    // 添加按分类和关键词查询的方法
    public ArrayList<Book> search(String keyword, String categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Book> list = new ArrayList<Book>();
        try {
            conn = JDBCUtils.getConnection();
            StringBuilder sql = new StringBuilder(
                "SELECT b.*, c.category_name FROM books b " +
                "LEFT JOIN categories c ON b.category_id = c.category_id WHERE 1=1"
            );
            ArrayList<Object> params = new ArrayList<Object>();

            // 添加分类条件
            if (categoryId != null && !categoryId.isEmpty()) {
                sql.append(" AND b.category_id = ?");
                params.add(Integer.parseInt(categoryId));
            }

            // 添加关键词搜索条件
            if (keyword != null && !keyword.isEmpty()) {
                sql.append(" AND (b.bookname LIKE ? OR b.publish LIKE ?)");
                String searchPattern = "%" + keyword + "%";
                params.add(searchPattern);
                params.add(searchPattern);
            }

            pstmt = conn.prepareStatement(sql.toString());
            
            // 设置参数
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                book.setCategory_id(rs.getInt("category_id"));
                book.setCategory_name(rs.getString("category_name"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }

    // 添加分类
    public boolean addCategory(Category category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO categories(category_name, description) VALUES(?, ?)";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, category.getCategory_name());
            pstmt.setString(2, category.getDescription());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 根据ID查询分类
    public Category findCategoryById(int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM categories WHERE category_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Category category = new Category();
                category.setCategory_id(rs.getInt("category_id"));
                category.setCategory_name(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return null;
    }

    // 更新分类
    public boolean updateCategory(Category category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "UPDATE categories SET category_name=?, description=? WHERE category_id=?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, category.getCategory_name());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, category.getCategory_id());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 删除分类
    public boolean deleteCategory(int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            // 先检查是否有图书使用此分类
            String checkSql = "SELECT COUNT(*) FROM books WHERE category_id = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, categoryId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // 如果有图书使用此分类，则不允许删除
            }
            
            // 如果没有图书使用此分类，则可以删除
            String sql = "DELETE FROM categories WHERE category_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }
}
