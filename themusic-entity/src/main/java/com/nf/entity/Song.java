package com.nf.entity;

import lombok.Data;

import java.util.Date;


@Data
public class Song {
    //song表
    private Integer songId;
    private String songName;
    private Integer singerId;
    private Date publishDate;
    private Integer songClick;
    private String songSrc;
    private Integer songLength;
    private String songLanguage;
    private String pictureSrc;
    private Integer albumId;
    private String lylicSrc;

    //user表
    //歌手名字
    private String singerName;
    //排行榜序号
    private Integer rownum;
    //专辑名字
    private String albumName;
}
