package test.junit;

import dao.orderrecordDAO;
import dao.orderrecordDaolmpl;
import model.Torderrecord;
import org.junit.Before;
import org.junit.Test;

public class orderrecordDaolmplTest {
    private orderrecordDAO mdao = null;
    @Before
    public void init(){ mdao = new orderrecordDaolmpl(); }

    @Test
    public void addorderrecord() {
        Torderrecord orderrecord = new Torderrecord();
        orderrecord.setSaleid(4);
        orderrecord.setProductid(2);
        orderrecord.setSalequantity(20);
        orderrecord.setSaleamount("129980");
        orderrecord.setSaleid(2024-11-11);
        orderrecord.setUseraccount("123123");
        orderrecord.setRecordstatus("完成");
        int key = mdao.addorderrecord(orderrecord);
        System.out.println("key=" +key);
    }

    @Test
    public void updateorderrecord() {
        Torderrecord orderrecord=mdao.getorderrecordById(1);
        orderrecord.setRecordstatus(orderrecord.getRecordstatus()+"完成");
        System.out.println(mdao.addorderrecord(orderrecord));
    }

    @Test
    public void deleteorderrecord() {
        System.out.println(mdao.getorderrecordById(3));
    }

    @Test
    public void getorderrecordById() {
        System.out.println(mdao.getorderrecordById(1));
    }

    @Test
    public void getAllorderrecord() {
    }


    @Test
    public void getorderrecordsByUseraccount() {
        System.out.println(mdao.getorderrecordsByUseraccount("123333"));
    }
}