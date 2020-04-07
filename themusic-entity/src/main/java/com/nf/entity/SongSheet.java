package com.nf.entity;

import lombok.Data;

@Data
public class SongSheet {
    private Integer sheetId;
    private String sheetName;
    private Integer userId;
    private String language;
    private String style;
    private String mood;

    //歌单所属用户的用户信息
    private User user;
    //歌单中歌曲数量
    private Integer songNums;
}
