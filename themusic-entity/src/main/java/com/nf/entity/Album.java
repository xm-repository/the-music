package com.nf.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Album {
    private Integer albumId;
    private String albumName;
    private Integer singerId;
    private Date publishDate;


    //专辑中歌曲数量
    private Integer songNums;
    //专辑所属歌手信息
    private Singer singer;
}
