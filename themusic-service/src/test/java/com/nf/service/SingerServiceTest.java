package com.nf.service;

import com.nf.entity.Singer;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:service-config.xml")
public class SingerServiceTest {
    @Autowired SingerService singerService;
    @Test
    public void getAllSingerByName() {
        List<Singer> singers = singerService.getAllSingerByName(1,10,"林");
        for (Singer singer : singers) {
            System.out.println(singer);
        }
    }
    @Test
    public void getSingerBySingerId() {
        Singer singer = singerService.getSingerBySingerId(2);
        System.out.println(singer);
    }
    @Test
    public void deleteSingerBySingerId() {
        List<Integer> singerIds = new ArrayList<>();
        singerIds.add(1);
        singerIds.add(2);
        singerService.deleteSingerBySingerId(singerIds);
    }
}