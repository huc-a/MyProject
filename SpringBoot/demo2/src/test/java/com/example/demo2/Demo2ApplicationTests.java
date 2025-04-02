package com.example.demo2;


import com.example.demo2.entity.User;
import com.example.demo2.mapper.UserMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class Demo2ApplicationTests {
@Autowired
private UserMapper userMapper;
    @Test
    void contextLoads() {
        userMapper.insert(new User("admin","123456","123456789","123456789@qq.com"));
    }

}
