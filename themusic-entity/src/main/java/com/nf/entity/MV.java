package com.nf.entity;

import lombok.Data;

@Data
public class MV {
    private Integer mvId;
    private String mvPicture;
    private String mvSrc;
    private Integer mvClick;
    private String mvName;
    private Integer songId;
    private Integer mvLength;

    //歌曲名字
    private String songName;

    //歌手id
    private Integer singerId;
    //歌手名字
    private String singerName;
}
