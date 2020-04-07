package com.nf.dao;

import com.nf.vo.CommentVO;
import com.nf.entity.Comment;
import com.nf.entity.LikeComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentDao {
    //查询一首歌的所有热门评论
    List<Comment> getAllGoodCommentsBySongId(@Param("pageNum") int pageNum,
                                               @Param("pageSize") int pageSize,
                                               Integer songId);
    //查询一首歌的所有最新评论
    List<Comment> getAllRecentlyCommentsBySongId(@Param("pageNum") int pageNum,
                                             @Param("pageSize") int pageSize,
                                             Integer songId);
    //查询被回复的评论的用户名字
    String getRecommentUserName(Comment comment);
    //查询评论是否被某一个用户点赞
    Integer commentIsLikeByUser(Comment comment,Integer userId);
    //查询一个评论的评论数
    Integer getReplayCountByCommentId(Integer commentId);

    //添加评论
    void addComment(Comment comment);


    //评论点赞(添加点赞记录)
    void addLikeComment(LikeComment likeComment);
    //点赞后点赞数+1
    void addScommentClick(LikeComment likeComment);
    //评论取消点赞(删除点赞记录)
    void dropLikeComment(LikeComment likeComment);
    //取消点赞后点赞数-1
    void reduceScommentClick(LikeComment likeComment);

    //根据评论id删除点赞表
    void deleteLikeCommentByCommentId(List<Integer> commentIds);
    //根据歌曲id查询评论id
    List<Integer> getCommentIdBySongId(List<Integer> songIds);
    //根据歌曲id删除评论
    void deleteCommentBySongId(List<Integer> songIds);
}
