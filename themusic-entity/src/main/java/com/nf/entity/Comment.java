package com.nf.entity;

import lombok.Data;

import java.util.Date;


@Data
public class Comment {
    //评论Id
    private Integer scommentId;
    //歌曲Id
    private Integer songId;
    //用户Id
    private Integer userId;
    //点赞数
    private Integer scommentClick;
    //评论时间
    private Date commentTime;
    //被回复评论的评论id
    private Integer recommentId;
    //    //评论内容
    private String content;

    //评论数
    private Integer count;


    //该评论的用户信息
    private User user;
    //当前用户是否评论
    private Integer likeCommentUserId;

    //被回复的评论的用户名字
    private String replyUserName;

}
