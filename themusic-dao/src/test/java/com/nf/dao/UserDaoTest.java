package com.nf.dao;

import com.nf.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class UserDaoTest {
    @Autowired
    private UserDao userDao;

    @Test
    public void getAllSong() {
        User user = new User();
        user.setUserPhone("18581280843");
        userDao.addUser(user);
    }
    @Test
    public void selectLstUserId() {
        Integer userId = userDao.selectLastUserId();
        System.out.println(userId);
    }
}
