package com.nf.dao;

import com.nf.entity.Comment;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:dao-config.xml")
public class CommentDaoTest {
    @Autowired
    private CommentDao commentDao;

    @Test
    public void getAllCommentsBySongId() {
        List<Comment> comments = commentDao.getAllGoodCommentsBySongId(1, 10, 1);
        for (Comment comment : comments) {
            System.out.println(comment);
        }
    }

    @Test
    public void getReplayCountByCommentId() {
        System.out.println(commentDao.getReplayCountByCommentId(1));
    }

    @Test
    public void addComment(){
        Comment comment = new Comment();
        comment.setSongId(1);
        comment.setContent("hhahdsahfha");
        comment.setUserId(3);
        comment.setCommentTime(new Date());
        commentDao.addComment(comment);
    }
}