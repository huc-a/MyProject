package test.junit;

import dao.deliveryDAO;
import dao.deliveryDaolmpl;
import model.Tdelivery;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class deliveryDaolmplTest {
   private deliveryDAO mdao = null;
   @Before
   public void init(){
       mdao = new deliveryDaolmpl();
   }

    @Test
    public void adddelivery() {
        Tdelivery delivery = new Tdelivery();
        delivery.setDeliveryid(12);
        delivery.getUseraccount("112233");
        delivery.setCountry("中国");
        delivery.setProvince("云南");
        delivery.setCity("昆明");
        delivery.setDetailaddr("嵩明");
        delivery.setContactphone1("123456");
        delivery.getContactphone2("123446");
        int key = mdao.adddelivery(delivery);
        System.out.println("key=" +key);
    }

    @Test
    public void updatedelivery() {
        Tdelivery delivery=mdao.getdeliveryById(11);
        delivery.setProvince(delivery.getProvince()+"河南");
        System.out.println(mdao.updatedelivery(delivery));
    }

    @Test
    public void deletedelivery() {
        System.out.println(mdao.getdeliveryById(19));
    }

    @Test
    public void getdeliveryById() {
        System.out.println(mdao.getdeliveryById(16));
    }

    @Test
    public void getAlldelivery() {
        System.out.println(mdao.getAlldelivery());
    }


    @Test
    public void getdeliverysByUseraccount() {
        System.out.println(mdao.getdeliverysByUseraccount("123455"));
    }
}