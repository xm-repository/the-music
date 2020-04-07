package com.nf.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Singer {
    private Integer singerId;
    private String singerName;
    private String singerSex;
    private String singerArea;
    private Date singerBirth;
    private String singerCountry;
    private Integer singerHeight;
    private Integer singerWeight;
    private String bloodType;
    private String constellation;
    private String synopsis;
    private String singerPicture;
    private Integer fans;
    private String singerNameInitials;

    //单曲数量
    private Integer songNums;
    //专辑个数
    private Integer albumNums;
    //MV个数
    private Integer mvNums;
}
