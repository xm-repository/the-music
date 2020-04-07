package com.nf.vo;

import lombok.Data;

import java.util.Date;

@Data
public class CommentVO {
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
    //评论内容
    private String content;

    //用户名
    private String userName;
    //评论数
    private Integer count;
    //用户头像
    private String userPicture;
    //登录用户是否对此评论点赞
    private Integer likeCommentUserId;
}
