package com.mall.utils;

import com.alibaba.druid.pool.DruidDataSource;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static DruidDataSource dataSource;

    static {
        try {
            // 创建连接池
            dataSource = new DruidDataSource();
            
            // 基本配置
            dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
            dataSource.setUrl("jdbc:mysql://localhost:3306/mall_admin?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=utf8");
            dataSource.setUsername("root");
            dataSource.setPassword("123456");
            
            // 连接池配置
            dataSource.setInitialSize(5);
            dataSource.setMinIdle(5);
            dataSource.setMaxActive(20);
            dataSource.setMaxWait(60000);
            dataSource.setTimeBetweenEvictionRunsMillis(60000);
            dataSource.setMinEvictableIdleTimeMillis(300000);
            dataSource.setValidationQuery("SELECT 1");
            dataSource.setTestWhileIdle(true);
            dataSource.setTestOnBorrow(true);
            dataSource.setTestOnReturn(false);
            
            // 初始化连接池
            dataSource.init();
            
            // 测试连接
            try (Connection conn = dataSource.getConnection()) {
                if (conn != null) {
                    System.out.println("数据库连接池初始化成功!");
                } else {
                    throw new SQLException("无法获取数据库连接");
                }
            }
        } catch (Exception e) {
            System.err.println("数据库连接池初始化失败: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("数据库连接池初始化失败", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("数据源未初始化");
        }
        try {
            Connection conn = dataSource.getConnection();
            if (conn == null) {
                throw new SQLException("无法获取数据库连接");
            }
            return conn;
        } catch (SQLException e) {
            System.err.println("获取数据库连接失败: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // 关闭连接池
    public static void closeDataSource() {
        if (dataSource != null) {
            dataSource.close();
        }
    }
} 