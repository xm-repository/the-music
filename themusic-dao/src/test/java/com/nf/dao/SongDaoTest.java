package com.nf.dao;

import com.fasterxml.jackson.core.JsonToken;
import com.nf.entity.Song;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class SongDaoTest {
    @Autowired
    private SongDao songDao;

    @Test
    public void getAllSong() {
        List<Song> songs = songDao.getAllSong(1,15,0);
        for (Song song : songs) {
            System.out.println(song);
        }
    }
    @Test
    public void getSongBySongId() {
        Song song = songDao.getSongBySongId(1);
        System.out.println(song);
    }
    @Test
    public void getSongBySongName() {
        List<Song> songs = songDao.getSongBySongName(1,10,"空城");
        for (Song song : songs) {
            System.out.println(song);
        }
    }

    @Test
    public void deleteSongBySongId() {
        List<Integer> songIds = new ArrayList<>();
        songIds.add(1);
        songIds.add(3);
        songDao.deleteSongBySongId(songIds);
    }

}