package com.nf.service;

import com.nf.dao.CommentDao;
import com.nf.entity.Comment;
import com.nf.entity.LikeComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentDao commentDao;
    //查询一首歌的所有热门评论
    public List<Comment> getAllGoodCommentsBySongId(int pageNum, int pageSize, Integer songId,Integer userId){
        List<Comment> comments = commentDao.getAllGoodCommentsBySongId(pageNum, pageSize, songId);
        for (Comment comment : comments) {
            //查询被评论的评论的用户名字 和该条评论的评论数,当前评论是否被当前用户点赞
            comment.setReplyUserName(commentDao.getRecommentUserName(comment));
            comment.setCount(commentDao.getReplayCountByCommentId(comment.getScommentId()));
            if(userId !=null){
                if(commentDao.commentIsLikeByUser(comment,userId) !=0){
                    comment.setLikeCommentUserId(userId);
                }
            }
        }
        return comments;
    }
    //查询一首歌的所有最新评论
    public List<Comment> getAllRecentlyCommentsBySongId(int pageNum, int pageSize, Integer songId,Integer userId){
        List<Comment> comments = commentDao.getAllRecentlyCommentsBySongId(pageNum, pageSize, songId);
        for (Comment comment : comments) {
            //查询被评论的评论的用户名字 和该条评论的评论数,当前评论是否被当前用户点赞
            comment.setReplyUserName(commentDao.getRecommentUserName(comment));
            comment.setCount(commentDao.getReplayCountByCommentId(comment.getScommentId()));
            if(userId !=null){
                if(commentDao.commentIsLikeByUser(comment,userId) !=0){
                    comment.setLikeCommentUserId(userId);
                }
            }
        }
        return comments;
    }
    //添加评论
    public void addComment(Comment comment){
        commentDao.addComment(comment);
    }

    //评论点赞
    public void addLikeComment(LikeComment likeComment){
        //添加点赞记录
        commentDao.addLikeComment(likeComment);
        //点赞数+1
        commentDao.addScommentClick(likeComment);
    }
    //评论取消点赞
    public void dropeLikeComment(LikeComment likeComment){
        //删除点赞记录
        commentDao.dropLikeComment(likeComment);
        //点赞数-1
        commentDao.reduceScommentClick(likeComment);
    }

}
