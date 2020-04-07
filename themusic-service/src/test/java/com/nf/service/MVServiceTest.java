package com.nf.service;

import com.nf.entity.MV;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:service-config.xml")
public class MVServiceTest {

    @Autowired
    private MVService mvService;
    @Test
    public void getMVByILikeId() {
        List<MV> mvs = mvService.getMVByILikeId(1,10,1);
        System.out.println(mvs.size());
    }
}