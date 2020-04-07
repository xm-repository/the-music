package com.nf.dao;


import com.nf.entity.Singer;
import com.nf.dto.SingerDTO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class SingerDaoTest {
    @Autowired
    private SingerDao singerDao;
    @Test
    public void getAllSinger() {
        List<Singer> allSinger = singerDao.getAllSinger(1, 15,new SingerDTO());
        for (Singer singer : allSinger) {
            System.out.println(singer);
        }
    }
    @Test
    public void updateSinger() {
        Singer singer = new Singer(14,"jj","男","中国",new Date(),"新加坡",120,170,"A型","天蝎座","歌手","1.jpg",120,"J",100,200,300);
        singerDao.updateSinger(singer);
    }
}