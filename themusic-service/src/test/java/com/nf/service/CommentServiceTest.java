package com.nf.service;

import com.nf.entity.Comment;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:service-config.xml")
public class CommentServiceTest {
    @Autowired
    private CommentService commentService;

    @Test
    public void getAllCommentsBySongId() {
        List<Comment> comments = commentService.getAllGoodCommentsBySongId(1,5,1,null);
        for (Comment comment : comments) {
            System.out.println(comment);
        }
    }
}