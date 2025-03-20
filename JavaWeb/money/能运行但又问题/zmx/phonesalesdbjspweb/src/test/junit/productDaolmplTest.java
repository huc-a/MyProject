package test.junit;

import dao.deliveryDAO;
import dao.deliveryDaolmpl;
import dao.productDAO;
import dao.productDaolmpl;
import model.Tdelivery;
import model.Tproduct;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class productDaolmplTest {
    private productDAO mdao = null;
    @Before
    public void init(){
        mdao = new productDaolmpl();
    }

    @Test
    public void addproduct() {
        Tproduct product=new Tproduct();
        product.setProductname("iphone16");
        product.setBrand("苹果");
        product.setMemory("128G");
        product.setPrice("5149");
        product.setColortype("白色");
        int key = mdao.addproduct(product);
        System.out.println("key=" +key);
    }

    @Test
    public void updateproduct() {
        Tproduct product=mdao.getproductById(1);
        product.setMemory(product.getMemory()+"128G");
        System.out.println(mdao.updateproduct(product));
    }

    @Test
    public void deleteproduct() {
        System.out.println(mdao.getproductById(5));
    }

    @Test
    public void getproductById() {
        System.out.println(mdao.getproductById(1));
    }

    @Test
    public void getAllproduct() {
        System.out.println(mdao.getAllproduct());
    }

    @Test
    public void getproductsByProductname() {
        System.out.println(mdao.getproductsByProductname(" 小米15 Pro"));
    }
}