package utils;

import db.DBConnection;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 数据库访问操作工作类，为业务类提供数据库操作的通用方法
 * @author zjs
 * @version 20240930
 */
public class DataUtil extends DBConnection implements utils.IDataUtil {
    private Connection con = null;
    private PreparedStatement ptmt = null;
    private CallableStatement ctmt= null;
    private ResultSet rs = null;

    @Override
    public void close() {
        if(ptmt!=null)
            this.closeConnection(con,ptmt,rs);//关闭表数据操作后的数据库资源
        else
            this.closeConnection(con,ctmt,rs);//关闭存储过程调用后的数据库资源
    }

    @Override
    public int insert(String sql, Object[] para) {
        int rows = 0,key = 0;//rows代表受影响行数，key为表主键为自动编号时，新纪录的主键id
        try {
            con = this.getConnection();
            ptmt = con.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);//sql命令来资源调用者
            //编写算法设置参数值
            if(para!=null){
                for(int i=0;i<para.length;i++){
                    ptmt.setObject(i+1,para[i]);
                }
            }
            //执行更新操作
            System.out.println(ptmt);
            rows = ptmt.executeUpdate();
            if(rows>0){ //成功插入数据到数据库
                rs = ptmt.getGeneratedKeys();
                if(rs!=null && rs.next())
                    key = rs.getInt(1);//取由系统分配的主键值
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{//不管有没有异常都会执行finally块
            close();//关闭数据库资源
        }
        if(key>0) return key;//有主键生成，就返回主键值
        else
            return rows;

    }

    @Override
    public int update(String sql, Object[] para) {
        int rows = 0;
        try {
            con = this.getConnection();
            ptmt = con.prepareStatement(sql);
            //编写算法设置参数值
            if(para!=null) {
                for (int i = 0; i < para.length; i++) {
                    ptmt.setObject(i + 1, para[i]);
                }
            }
            System.out.println(ptmt);
            rows = ptmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{//不管有没有异常都会执行finally块
            close();//关闭数据库资源
        }
        return rows;
    }

    @Override
    public int delete(String sql, Object[] para) {
        int rows = 0;
        try {
            con = this.getConnection();
            ptmt = con.prepareStatement(sql);
            //编写算法设置参数值
            if(para!=null) {
                for (int i = 0; i < para.length; i++) {
                    ptmt.setObject(i + 1, para[i]);
                }
            }
            System.out.println(ptmt);
            rows = ptmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{//不管有没有异常都会执行finally块
            close();//关闭数据库资源
        }
        return rows;
    }

    @Override
    public ResultSet select(String sql, Object[] para) {
        try {
            con = this.getConnection();
            ptmt = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            //编写算法设置参数值
            if(para!=null) {
                for (int i = 0; i < para.length; i++) {
                    ptmt.setObject(i + 1, para[i]);
                }
            }
            System.out.println(ptmt);
            rs = ptmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        } finally{//不管有没有异常都会执行finally块
            //close();//不能关闭数据库资源
        }
        return rs;
    }

    @Override
    public int selectCount(String sql, Object[] para) {
        int amount = 0;
        try {
            con = this.getConnection();
            ptmt = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,//结果集双向移动
                    ResultSet.CONCUR_READ_ONLY);//只读模式
            //编写算法设置参数值
            if(para!=null) {
                for (int i = 0; i < para.length; i++) {
                    ptmt.setObject(i + 1, para[i]);
                }
            }
            System.out.println(ptmt);
            rs = ptmt.executeQuery();
            rs.last();//滚动到最后一行
            amount = rs.getRow();//去最后一行的行号
        } catch (Exception e) {
            e.printStackTrace();
        } finally{//不管有没有异常都会执行finally块
            close();//关闭数据库资源
        }
        return amount;
    }

    @Override
    public ResultSet callProcedureWithQuery(String procName, Object[] para) {
        try{
            con = this.getConnection();
            ctmt = con.prepareCall("{ call "+ procName +"}");
            if(para!=null) {
                for (int i = 1; i < para.length; i++) {
                    ctmt.setObject(i, para[i - 1]);
                }
            }
            boolean flag = ctmt.execute();//执行存储过程的调用使用execute
            if (flag) { //调用成功
                System.out.println(ctmt);
                rs = ctmt.getResultSet();
            }
        }catch(Exception e)
        {e.printStackTrace();
        }finally {
            //this.close();
        }
        return rs;
    }
}
