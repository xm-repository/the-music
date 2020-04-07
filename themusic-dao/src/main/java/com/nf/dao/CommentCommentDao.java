package com.nf.dao;


import java.util.List;

public interface CommentCommentDao {
    //根据id删除回复评论
    void deleteCCommentByCommentId(List<Integer> ccommentId);
}
