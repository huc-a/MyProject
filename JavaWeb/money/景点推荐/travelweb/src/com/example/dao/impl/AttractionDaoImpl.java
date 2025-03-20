package com.example.dao.impl;

import com.example.dao.AttractionDao;
import com.example.model.Attraction;
import com.example.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AttractionDaoImpl implements AttractionDao {

    @Override
    public void addAttraction(Attraction attraction) {
        String sql = "INSERT INTO attractions (name, city, category_id, level, description, ticket_price, opening_hours, suggested_duration) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, attraction.getName());
            pstmt.setString(2, attraction.getCity());
            pstmt.setInt(3, attraction.getCategoryId());
            pstmt.setString(4, attraction.getLevel());
            pstmt.setString(5, attraction.getDescription());
            pstmt.setDouble(6, attraction.getTicketPrice());
            pstmt.setString(7, attraction.getOpeningHours());
            pstmt.setInt(8, attraction.getSuggestedDuration());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("添加景点失败: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Attraction> filterAttractions(Integer categoryId, String city, Double minPrice, Double maxPrice, String level) {
        List<Attraction> attractions = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT a.*, c.name as category_name FROM attractions a " +
            "LEFT JOIN attraction_categories c ON a.category_id = c.id WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        // 添加筛选条件
        if (categoryId != null) {
            sql.append(" AND a.category_id = ?");
            params.add(categoryId);
        }
        if (level != null && !level.isEmpty()) {
            sql.append(" AND a.level = ?");
            params.add(level);
        }
        if (minPrice != null) {
            sql.append(" AND a.ticket_price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND a.ticket_price <= ?");
            params.add(maxPrice);
        }

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            // 设置参数
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Attraction attraction = new Attraction();
                attraction.setId(rs.getInt("id"));
                attraction.setName(rs.getString("name"));
                attraction.setCity(rs.getString("city"));
                attraction.setLevel(rs.getString("level"));
                attraction.setDescription(rs.getString("description"));
                attraction.setTicketPrice(rs.getDouble("ticket_price"));
                attraction.setOpeningHours(rs.getString("opening_hours"));
                attraction.setSuggestedDuration(rs.getInt("suggested_duration"));
                attraction.setCategoryId(rs.getInt("category_id"));
                attraction.setCategoryName(rs.getString("category_name"));
                attractions.add(attraction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attractions;
    }
    // 删除景点


    @Override
    public List<String> getAllCities() {
        // 实现获取所有城市的方法
        return new ArrayList<>();
    }

    @Override
    public List<Map<String, Object>> getAllCategories() {
        // 实现获取所有分类的方法
        return new ArrayList<>();
    }

    @Override
    public List<String> getAllLevels() {
        // 实现获取所有等级的方法
        return new ArrayList<>();
    }

    @Override
    public List<Attraction> getRecommendedAttractions(int userId) {
        List<Attraction> recommendations = new ArrayList<>();

        // 先返回一些测试数据
        String sql = "SELECT a.*, c.name as category_name " +
                     "FROM attractions a " +
                     "LEFT JOIN attraction_categories c ON a.category_id = c.id " +
                     "ORDER BY RAND() " +  // 随机返回几条数据用于测试
                     "LIMIT 6";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Attraction attraction = new Attraction();
                attraction.setId(rs.getInt("id"));
                attraction.setName(rs.getString("name"));
                attraction.setCity(rs.getString("city"));
                attraction.setLevel(rs.getString("level"));
                attraction.setDescription(rs.getString("description"));
                attraction.setTicketPrice(rs.getDouble("ticket_price"));
                attraction.setOpeningHours(rs.getString("opening_hours"));
                attraction.setSuggestedDuration(rs.getInt("suggested_duration"));
                attraction.setCategoryId(rs.getInt("category_id"));
                attraction.setCategoryName(rs.getString("category_name"));
                recommendations.add(attraction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 如果数据库查询失败，返回一些硬编码的测试数据
        if (recommendations.isEmpty()) {
            Attraction testAttraction = new Attraction();
            testAttraction.setId(1);
            testAttraction.setName("富乐山风景区");
            testAttraction.setCity("绵阳");
            testAttraction.setLevel("4A");
            testAttraction.setDescription("富乐山是绵阳市区内的一座山峰，山势雄伟，景色秀丽。");
            testAttraction.setTicketPrice(30.0);
            testAttraction.setOpeningHours("08:00-17:30");
            testAttraction.setSuggestedDuration(3);
            testAttraction.setCategoryId(1);
            testAttraction.setCategoryName("自然风光");
            recommendations.add(testAttraction);

            Attraction testAttraction2 = new Attraction();
            testAttraction2.setId(4);
            testAttraction2.setName("李白故里");
            testAttraction2.setCity("江油");
            testAttraction2.setLevel("4A");
            testAttraction2.setDescription("唐代大诗人李白的出生地和少年时期生活的地方。");
            testAttraction2.setTicketPrice(50.0);
            testAttraction2.setOpeningHours("08:30-17:30");
            testAttraction2.setSuggestedDuration(3);
            testAttraction2.setCategoryId(2);
            testAttraction2.setCategoryName("人文古迹");
            recommendations.add(testAttraction2);

            // 添加更多测试数据
            Attraction testAttraction3 = new Attraction();
            testAttraction3.setId(7);
            testAttraction3.setName("中国(绵阳)科技城");
            testAttraction3.setCity("绵阳");
            testAttraction3.setLevel("5A");
            testAttraction3.setDescription("是中国重要的科研基地和科技旅游目的地。");
            testAttraction3.setTicketPrice(0.0);
            testAttraction3.setOpeningHours("09:00-17:00");
            testAttraction3.setSuggestedDuration(4);
            testAttraction3.setCategoryId(4);
            testAttraction3.setCategoryName("科技文化");
            recommendations.add(testAttraction3);
        }

        return recommendations;
    }

    private Attraction extractAttractionFromResultSet(ResultSet rs) throws SQLException {
        Attraction attraction = new Attraction();
        attraction.setId(rs.getInt("id"));
        attraction.setName(rs.getString("name"));
        attraction.setCity(rs.getString("city"));
        attraction.setLevel(rs.getString("level"));
        attraction.setDescription(rs.getString("description"));
        attraction.setTicketPrice(rs.getDouble("ticket_price"));
        attraction.setOpeningHours(rs.getString("opening_hours"));
        attraction.setSuggestedDuration(rs.getInt("suggested_duration"));
        attraction.setCategoryId(rs.getInt("category_id"));
        attraction.setCategoryName(rs.getString("category_name"));
        return attraction;
    }

    @Override
    public List<Attraction> getAllAttractions() {
        List<Attraction> attractions = new ArrayList<>();
        String sql = "SELECT a.*, c.name as category_name FROM attractions a " +
                    "LEFT JOIN attraction_categories c ON a.category_id = c.id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                attractions.add(extractAttractionFromResultSet(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("获取景点列表失败: " + e.getMessage(), e);
        }
        return attractions;
    }

    @Override
    public boolean deleteAttraction(int id) {
        String sql = "DELETE FROM attractions WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("删除景点失败: " + e.getMessage(), e);
        }
    }

    @Override
    public boolean updateAttraction(Attraction attraction) {
        String sql = "UPDATE attractions SET name=?, city=?, category_id=?, level=?, " +
                     "description=?, ticket_price=?, opening_hours=?, suggested_duration=? " +
                     "WHERE id=?";
                     
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, attraction.getName());
            pstmt.setString(2, attraction.getCity());
            pstmt.setInt(3, attraction.getCategoryId());
            pstmt.setString(4, attraction.getLevel());
            pstmt.setString(5, attraction.getDescription());
            pstmt.setDouble(6, attraction.getTicketPrice());
            pstmt.setString(7, attraction.getOpeningHours());
            pstmt.setInt(8, attraction.getSuggestedDuration());
            pstmt.setInt(9, attraction.getId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            throw new RuntimeException("更新景点失败: " + e.getMessage(), e);
        }
    }
}