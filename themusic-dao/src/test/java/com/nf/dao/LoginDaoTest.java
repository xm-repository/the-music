package com.nf.dao;

import com.nf.dto.LoginDTO;
import com.nf.entity.Login;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class LoginDaoTest {
    @Autowired
    private LoginDTO loginDTO;

    public void addLogin(){

    }
}
