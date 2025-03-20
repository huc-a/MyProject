package com.shop.util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * 数据库连接工具类
 */
public class JDBCUtils {
	
	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/shop");
			if(ds == null) {
				throw new RuntimeException("数据源获取失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("初始化数据源失败: " + e.getMessage());
		}
	}
	
	/**
	 * 获取数据库连接方法
	 * @return
	 */
	public static Connection getConnection() {
		Connection conn = null;
		try {
			conn = ds.getConnection();
			if(conn == null) {
				throw new RuntimeException("获取数据库连接失败!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("获取数据库连接失败: " + e.getMessage());
		}
		return conn;
	}
	
	/**
	 * 关闭资源方法
	 * @param conn
	 * @param stmt
	 * @param rs
	 */
	public static void closeAll(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
