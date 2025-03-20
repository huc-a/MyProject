package test.junit;

import dao.deliveryDAO;
import dao.deliveryDaolmpl;
import dao.userDAO;
import dao.userdaolmpl;
import model.Tdelivery;
import model.Tuser;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class userdaolmplTest {
    private userDAO mdao = null;
    @Before
    public void init(){
        mdao = new userdaolmpl();
    }

    @Test
    public void adduser() {
        Tuser user=new Tuser();
        user.setUseraccount("333444");
        user.setPwd("123456");
        user.setUsername("小雪");
        user.setUtid("会员");
        user.setIdnumber("112233445566778888");
        user.setMobile("11122233344");
        int key = mdao.adduser(user);
        System.out.println("key=" +key);
    }

    @Test
    public void updateuser() {
        Tuser user=mdao.getuserById(777777);
        user.setUsername(user.getUsername()+"小赵");
        System.out.println(mdao.updateuser(user));
    }

    @Test
    public void deleteuser() {
        System.out.println(mdao.getuserById(666666));
    }

    @Test
    public void getuserById() {
        System.out.println(mdao.getuserById(888888));
    }

    @Test
    public void getAlluser() {
    }

    @Test
    public void getouserByTitles() {
        System.out.println(mdao.userLogin("777888", "123456"));
    }
}