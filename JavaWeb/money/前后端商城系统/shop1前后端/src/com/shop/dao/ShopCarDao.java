package com.shop.dao;

import com.shop.util.JDBCUtils;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import com.shop.entity.ShopCar;

/**
 * 购物车数据库操作类
 */
public class ShopCarDao {

    /**
     * 添加购物车
     * @param shopCar
     * @return
     */
    public int add(ShopCar shopCar) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "insert into shop_car(goods_id, count, create_user, create_datetime) values(?, ?, ?, ?)";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, shopCar.getGoodsId());
            prepareStatement.setInt(2, shopCar.getCount());
            prepareStatement.setString(3, shopCar.getCreateUser());
            prepareStatement.setDate(4, new Date(shopCar.getCreateDatetime().getTime()));
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
     * 删除购物车
     * @param id
     * @return
     */
    public int delete(Integer id) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "delete from shop_car where id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setInt(1, id);

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
     * 更新购物车
     * @param shopCar
     * @return
     */
    public int update(ShopCar shopCar) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "update shop_car set count = ? where id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setInt(1, shopCar.getCount());
            prepareStatement.setInt(2, shopCar.getId());
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
     * 获取购物车
     * @return
     */
    public List<ShopCar> getAllShopCar(String createUser) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from shop_car where 1=1 and create_user = " + createUser;
        // 拼接模糊查询条件
//        if (fieldName != null && !fieldName.equals("")) {
//            sql += "and column_name like '%" + fieldName + "%'";
//        }


        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            List<ShopCar> shopCars = new ArrayList<ShopCar>();
            while (rs.next()) {
                ShopCar shopCar = new ShopCar();
                shopCar.setId(rs.getInt("id"));
                shopCar.setGoodsId(rs.getString("goods_id"));
                shopCar.setCount(rs.getInt("count"));
                shopCar.setCreateUser(rs.getString("create_user"));
                shopCar.setCreateDatetime(rs.getDate("create_datetime"));
                shopCars.add(shopCar);
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return shopCars;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据id获取购物车详情
     * @param id
     * @return
     */
    public ShopCar getShopCarById(Integer id) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from shop_car where id = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setInt(1, id);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            ShopCar shopCar = null;
            while (rs.next()) {
                shopCar = new ShopCar();
                shopCar.setId(rs.getInt("id"));
                shopCar.setGoodsId(rs.getString("goods_id"));
                shopCar.setCount(rs.getInt("count"));
                shopCar.setCreateUser(rs.getString("create_user"));
                shopCar.setCreateDatetime(rs.getDate("create_datetime"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return shopCar;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据用户和商品查询
     * @param phone
     * @param goodsId
     * @return
     */
    public ShopCar getShopCarByUserAndGoodsId(String phone, String goodsId) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from shop_car where create_user = ? and goods_id = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, phone);
            prepareStatement.setString(2, goodsId);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            ShopCar shopCar = null;
            while (rs.next()) {
                shopCar = new ShopCar();
                shopCar.setId(rs.getInt("id"));
                shopCar.setGoodsId(rs.getString("goods_id"));
                shopCar.setCount(rs.getInt("count"));
                shopCar.setCreateUser(rs.getString("create_user"));
                shopCar.setCreateDatetime(rs.getDate("create_datetime"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return shopCar;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }
}
