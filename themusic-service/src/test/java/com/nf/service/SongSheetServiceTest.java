package com.nf.service;

import com.nf.entity.SongSheet;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:service-config.xml")
public class SongSheetServiceTest {

    @Autowired
    private SongSheetService songSheetService;

    @Test
    public void getSongSheetByILikeId() {
        List<SongSheet> songSheets = songSheetService.getSongSheetByILikeId(1,5,2);
        for (SongSheet songSheet : songSheets) {
            System.out.println(songSheet);
        }
    }
}