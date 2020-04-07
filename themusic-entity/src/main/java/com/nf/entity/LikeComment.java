package com.nf.entity;

import lombok.Data;

@Data
public class LikeComment {

    private Integer id;
    private Integer userId;
    private Integer scommentId;

    //标识是点赞还是取消点赞
    private Integer addLikeComment;
}
