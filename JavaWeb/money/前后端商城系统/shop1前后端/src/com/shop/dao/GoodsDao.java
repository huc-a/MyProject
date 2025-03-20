package com.shop.dao;

import com.shop.util.JDBCUtils;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import com.shop.entity.Goods;

/**
 * 商品数据库操作类
 */
public class GoodsDao {

    /**
     * 添加商品
     * @param goods
     * @return
     */
    public int add(Goods goods) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "insert into goods(id, name, brand, price, stock, file_name, remark, create_datetime) values(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, goods.getId());
            prepareStatement.setString(2, goods.getName());
            prepareStatement.setString(3, goods.getBrand());
            prepareStatement.setBigDecimal(4, goods.getPrice());
            prepareStatement.setInt(5, goods.getStock());
            prepareStatement.setString(6, goods.getFileName());
            prepareStatement.setString(7, goods.getRemark());
            prepareStatement.setDate(8, new Date(goods.getCreateDatetime().getTime()));
            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 删除商品
     * @param id
     * @return
     */
    public int delete(String id) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "delete from goods where id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, id);

            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 更新商品
     * @param goods
     * @return
     */
    public int update(Goods goods) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "update goods set name = ?,brand = ?,price = ?,stock = ?,file_name = ?,remark = ?,is_delete = ?,update_datetime = ? where id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, goods.getName());
            prepareStatement.setString(2, goods.getBrand());
            prepareStatement.setBigDecimal(3, goods.getPrice());
            prepareStatement.setInt(4, goods.getStock());
            prepareStatement.setString(5, goods.getFileName());
            prepareStatement.setString(6, goods.getRemark());
            prepareStatement.setString(7, goods.getIsDelete());
            prepareStatement.setDate(8, new Date(goods.getUpdateDatetime().getTime()));
            prepareStatement.setString(9, goods.getId());
            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 获取商品
     * @return
     */
    public List<Goods> getAllGoods(String name, String brand) {
        Connection connection = null;
        PreparedStatement prepareStatement = null;
        ResultSet rs = null;
        List<Goods> goodss = new ArrayList<>();
        
        try {
            connection = JDBCUtils.getConnection();
            StringBuilder sql = new StringBuilder("select * from goods where 1=1 and is_delete='0'");
            List<Object> params = new ArrayList<>();
            
            if (name != null && !name.trim().isEmpty()) {
                sql.append(" and name like ?");
                params.add("%" + name + "%");
            }
            if (brand != null && !brand.trim().isEmpty()) {
                sql.append(" and brand like ?");
                params.add("%" + brand + "%");
            }
            
            prepareStatement = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                prepareStatement.setObject(i + 1, params.get(i));
            }
            
            rs = prepareStatement.executeQuery();
            while (rs.next()) {
                Goods goods = new Goods();
                goods.setId(rs.getString("id"));
                goods.setName(rs.getString("name"));
                goods.setBrand(rs.getString("brand"));
                goods.setPrice(rs.getBigDecimal("price"));
                goods.setStock(rs.getInt("stock"));
                goods.setFileName(rs.getString("file_name"));
                goods.setRemark(rs.getString("remark"));
                goods.setIsDelete(rs.getString("is_delete"));
                goods.setCreateDatetime(rs.getDate("create_datetime"));
                goods.setUpdateDatetime(rs.getDate("update_datetime"));
                goodss.add(goods);
            }
            return goodss;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("查询商品列表失败: " + e.getMessage());
        } finally {
            JDBCUtils.closeAll(connection, prepareStatement, rs);
        }
    }

    /**
     * 根据id获取商品详情
     * @param id
     * @return
     */
    public Goods getGoodsById(String id) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from goods where id = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, id);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            Goods goods = null;
            while (rs.next()) {
                goods = new Goods();
                goods.setId(rs.getString("id"));
                goods.setName(rs.getString("name"));
                goods.setBrand(rs.getString("brand"));
                goods.setPrice(rs.getBigDecimal("price"));
                goods.setStock(rs.getInt("stock"));
                goods.setFileName(rs.getString("file_name"));
                goods.setRemark(rs.getString("remark"));
                goods.setIsDelete(rs.getString("is_delete"));
                goods.setCreateDatetime(rs.getDate("create_datetime"));
                goods.setUpdateDatetime(rs.getDate("update_datetime"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return goods;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}
