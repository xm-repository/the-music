package com.nf.dao;

import com.nf.entity.MV;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class MVDaoTest {
    @Autowired
   private MVDao mvDao;
    @Test
    public void getAllMV() {
        List<MV> mvs = mvDao.getAllMV(1,16,null);
        for (MV mv : mvs) {
            System.out.println(mv);
        }
    }
}