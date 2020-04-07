package com.nf.dto;

import lombok.Data;

@Data
public class SingerDTO {
    //歌手名字首字母
    private String singerNameInitials;
    //歌手地区
    private String singerArea;
    //歌手性别
    private String singerSex;
    //页码
    private Integer pageNum;
    //个数
    private Integer pageSize;
}
