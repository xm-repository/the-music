package com.nf.service;

import com.nf.entity.Song;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:service-config.xml")
public class SongServiceTest {
    @Autowired
    private SongService songService;

    @Test
    public void deleteSongBySongId() {
        List<Integer> songIds = new ArrayList<>();
        songIds.add(2);
//        songIds.add(3);
//        songIds.add(4);
        songService.deleteSongBySongId(songIds);
    }

    @Test
    public void getSongByILikeId() {
        List<Song> songs = songService.getSongByILikeId(1,5,1);
        for (Song song : songs) {
            System.out.println(song);
        }
    }
}