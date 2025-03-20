package com.tuling.dao.impl;

import com.tuling.dao.CartDao;
import com.tuling.domain.Cart;
import com.tuling.util.DBUtils;
import com.tuling.util.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class CartDaoImpl implements CartDao {
    //传递一个数据源对象
    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
    @Override
    public boolean createCart(int uid) {
        Connection conn = null;
        PreparedStatement ps = null;
        String newtable="shop"+uid;
        String sql = "CREATE TABLE "+newtable+""+
                "(\n" +
                "    fid INT NOT NULL,\n" +
                "    isStar BOOLEAN NOT NULL,\n" +
                "    isCart BOOLEAN NOT NULL\n" +
                ");";

        try{
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.executeUpdate();
            return true;
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            DBUtils.closeAll(conn, ps, null);
        }
        return false;
    }

    @Override
    public int del(int uid, int fid) {
        String sql = "delete from shop where fid=? and uid=?";
        Object[] params = {fid,uid};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Cart> show(int uid) {
        String sql = "select * from shop where uid="+uid;
        try {
            List<Cart> cartList = queryRunner.query(sql, new BeanListHandler<Cart>(Cart.class));
            return cartList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int add(int uid, Cart cart) {
        String sql = "insert into shop (uid,fid,isCart,isStar)values(?,?,?,?)";
        Object[] params = {uid,cart.getFid(),cart.isCart(),cart.isStar()};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Cart find(int uid, int fid) {
        String sql  = "select * from shop where fid=? and uid=?";
        Object[] params = {fid,uid};
        try {
            Cart cart = queryRunner.query(sql, new BeanHandler<Cart>(Cart.class),params);
            return cart;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int update(int uid, Cart cart) {
        String sql = "UPDATE shop SET isCart=?,isStar=?  WHERE fid=? and uid=?;";
        Object[] params = {cart.isCart(),cart.isStar(),cart.getFid(),uid};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
