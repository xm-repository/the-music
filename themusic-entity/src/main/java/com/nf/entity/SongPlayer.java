package com.nf.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;


@Data
@AllArgsConstructor
public class SongPlayer {
    //歌曲列表
    private List<Song> songList;
}
