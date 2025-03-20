package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
* 数据库连接的参数配置工具类，管理数据库的连接
* */
public class DBConnection {
    private String driverName = "com.mysql.jdbc.Driver";
    private String url = "jdbc:mysql://localhost:3306/phonesalesdb?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8mb4";
    private String username = "root";
    private String password = "123456";

    /*
    * 数据率连接方法
    * 返回一个可用的数据库连接对象
    * */
    public Connection getConnection() throws Exception{
        Class.forName(driverName);
        Connection con = DriverManager.getConnection(url,username,password);
        System.out.println("数据库驱动连接成功");
        return con; //返回连接对象
    }

    /**
     * 数据库资源关闭方法，实现数据库对象，结果集对象的关闭操作
     * @param con
     * @param stmt
     * @param rs
     */
    public void closeConnection(Connection con, Statement stmt, ResultSet rs){
        try {
            if(rs != null) rs.close();
            if(stmt!= null) stmt.close();;
            if(con != null) con.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
