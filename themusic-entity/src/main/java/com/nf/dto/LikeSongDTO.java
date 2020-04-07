package com.nf.dto;

import lombok.Data;

import java.util.List;

@Data
public class LikeSongDTO {
    //操作的歌曲id
    private List<Integer> songIds;
    //操作类型,0是取消，1是收藏
    private Integer likeSong;
    //歌单的id
    private Integer sheetId;
}
