package com.tuling.dao.impl;

import com.tuling.dao.FruitDao;
import com.tuling.domain.Fruit;
import com.tuling.util.DBUtils;
import com.tuling.util.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class FruitDaoImpl implements FruitDao {
    //传递一个数据源对象
    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
    @Override
    public Fruit findByFid(int fid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Fruit fruit = null;
        String sql = "SELECT fid, fname,spec,up,t1,t2,inum FROM fruits where fid=?";
        try {
            conn = DBUtils.getConnection();
            pstmt = conn.prepareStatement(sql);
            //设置参数
            pstmt.setInt(1,fid);
            //执行查询
            rs = pstmt.executeQuery();
            if(rs.next()){
                fruit = new Fruit();
                fruit.setFid(rs.getInt("fid"));
                fruit.setFname(rs.getString("fname"));
                fruit.setSpec(rs.getString("spec"));
                fruit.setUp(rs.getDouble("up"));
                fruit.setT1(rs.getString("t1"));
                fruit.setT2(rs.getString("t2"));
                fruit.setInum(rs.getInt("inum"));
            }
            return fruit;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtils.closeAll(conn,pstmt,rs);
        }
        return null;
    }

    @Override
    public List<Fruit> findHot() {
        String sql = "SELECT t2.* FROM hotfruits t1,fruits t2 WHERE t1.`fid` = t2.`fid`";
        try {
            List<Fruit> fruitList = queryRunner.query(sql, new BeanListHandler<Fruit>(Fruit.class));
            return fruitList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Fruit> findAll() {
        String sql = "SELECT * FROM fruits";
        try {
            List<Fruit> fruitList = queryRunner.query(sql, new BeanListHandler<Fruit>(Fruit.class));
            return fruitList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int add(Fruit fruit) {
        String sql = "insert into fruits(fname,spec,up,t1,t2,inum)values(?,?,?,?,?,?)";
        Object[] params = {fruit.getFname(),fruit.getSpec(),fruit.getUp(),fruit.getT1(),fruit.getT2(),fruit.getInum()};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int del(int fid) {
        String sql = "delete from fruit where fid=?";
        Object[] params = {fid};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(Fruit fruit) {
        String sql = "UPDATE fruits SET fname=? ,spec=? ,up=?,t1=?,t2=?,inum=? WHERE fid=?";
        Object[] params = {fruit.getFname(),fruit.getSpec(),fruit.getUp(),fruit.getT1(),fruit.getT2(),fruit.getInum(),fruit.getFid()};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
