package com.nf.dao;

import com.nf.entity.SongSheet;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class SongSheetDaoTest {
    @Autowired
    private SongSheetDao songSheetDao;

    @Test
    public void addSongSheet() {
        SongSheet songSheet = new SongSheet();
        songSheet.setSheetName("新的测试歌单");
        songSheetDao.addSongSheet(songSheet);
    }
}
