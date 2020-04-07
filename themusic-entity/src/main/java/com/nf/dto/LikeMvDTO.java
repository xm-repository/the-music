package com.nf.dto;

import lombok.Data;

import java.util.List;

@Data
public class LikeMvDTO {
    //操作的mvid
    private List<Integer> mvIds;
    //操作类型,0是取消，1是收藏
    private Integer likeMv;
}
