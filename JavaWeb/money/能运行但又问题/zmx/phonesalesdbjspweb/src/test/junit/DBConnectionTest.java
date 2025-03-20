package test.junit;

import db.DBConnection;
import org.junit.Test;

import java.sql.Connection;

import static org.junit.Assert.*;

public class DBConnectionTest {

    @Test
    public void getConnection() throws Exception {
        DBConnection dbConnection = new DBConnection();
        Connection con = dbConnection.getConnection();
        System.out.println("数据库环境配置成功，连接参数配置正确，连接建立成功");
        dbConnection.closeConnection(con,null,null);
    }
}