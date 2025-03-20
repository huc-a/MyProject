package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Tuser {
    private String useraccount;
    private String username;
    private String utid;
    private String mobile;
    private String idnumber;
    private String pwd;

    public Tuser() {
    }

    public Tuser(String useraccount, String pwd, String username, String utid, String idnumber, String mobile) {
        this.useraccount = useraccount;
        this.pwd = pwd;
        this.username = username;
        this.utid= utid;
        this.idnumber = idnumber;
        this.mobile = mobile;
    }

    public String getUseraccount() {
        return useraccount;
    }

    public void setUseraccount(String useraccount) {
        this.useraccount = useraccount;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUtid() {
        return utid;
    }

    public void setUtid(String utid) {
        this.utid = utid;
    }

    public String getIdnumber() {
        return idnumber;
    }

    public void setIdnumber(String idnumber) {
        this.idnumber = idnumber;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Override
    public String toString() {
        return "Tuser{" +
                "useraccount='" + useraccount + '\'' +
                ", pwd='" + pwd + '\'' +
                ", username='" + username + '\'' +
                ", utid='" + utid + '\'' +
                ", idnumber='" + idnumber + '\'' +
                ", mobile='" + mobile + '\'' +
                '}';
    }

    public Tuser(ResultSet rs) {
        try {
            if (rs != null && rs.next()) {
                this.useraccount = rs.getString("useraccount");
                this.pwd = rs.getString("pwd");
                this.username = rs.getString("username");
                this.utid = rs.getString("utid");
                this.idnumber = rs.getString("idnumber");
                this.mobile = rs.getString("mobile");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
        public static List<Tuser> tranlist(ResultSet rs){
            List<Tuser> list = new ArrayList<Tuser>();
            try {
                while (rs!=null && rs.next()){
                    Tuser obj = new Tuser();
                    obj.useraccount = rs.getString("useraccount");
                    obj.pwd = rs.getString("pwd");
                    obj.username = rs.getString("username");
                    obj.utid = rs.getString("utid");
                    obj.idnumber = rs.getString("idnumber");
                    obj.mobile = rs.getString("mobile");
                    obj.add(obj);
                }
            }catch (Exception e){
                e.printStackTrace();
            }
            return list;
        }

    private void add(Tuser obj) {
    }

    public Object getUserid() {
        return 0;
    }
}
