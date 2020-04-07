package com.nf.service;

import com.nf.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:service-config.xml")
public class UserServiceTest {
    @Autowired
    private UserService userService;

    @Test
    public void getAllUsers() {
        List<User> users = userService.getAllUsers(1,10);
        for (User user : users) {
            System.out.println(user);
        }
    }
}