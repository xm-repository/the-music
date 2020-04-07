package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.entity.Comment;
import com.nf.entity.LikeComment;
import com.nf.entity.Login;
import com.nf.entity.User;
import com.nf.service.CommentService;
import com.nf.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;
    //加载热门评论
    @GetMapping("/list")
    public ModelAndView loadComments(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                     @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                     Integer songId,HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询评论
        //查出当前登录用户id
        Integer userId = null;
        if(req.getSession().getAttribute("login") !=null){
            userId=((Login)req.getSession().getAttribute("login")).getUserId();
        }
        List<Comment> comments = commentService.getAllGoodCommentsBySongId(pageNum, pageSize, songId,userId);
        PageInfo pageInfo = new PageInfo<Comment>(comments);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.setViewName("user/good-comments");
        return modelAndView;
    }
    //加载最新评论
    @GetMapping("/listRecently")
    public ModelAndView loadRecentlyComments(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                     @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                     Integer songId,HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询评论
        //查出当前登录用户id
        Integer userId = null;
        if(req.getSession().getAttribute("login") !=null){
            userId=((Login)req.getSession().getAttribute("login")).getUserId();
        }
        List<Comment> comments = commentService.getAllRecentlyCommentsBySongId(pageNum, pageSize, songId,userId);
        PageInfo pageInfo = new PageInfo<Comment>(comments);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.setViewName("user/recently-comments");
        return modelAndView;
    }
    //评论
    @PostMapping("/comment")
    @ResponseBody
    public ResponseDTO addComment(@RequestBody Comment comment, HttpServletRequest req){
        //获取当前登录用户
        User user = (User)req.getSession().getAttribute("user");
        comment.setUserId(user.getUserId());
        //获取当前时间
        Date date = new Date();
        comment.setCommentTime(date);
        commentService.addComment(comment);
        return new ResponseDTO("200","0k",null);
    }

    //评论点赞或者取消
    @PostMapping("/likeOrCancelLikeComment")
    @ResponseBody
    public ResponseDTO likeOrCancelLikeComment(@RequestBody LikeComment likeComment){
        if(likeComment.getAddLikeComment() ==1){
            //如果是点赞
            commentService.addLikeComment(likeComment);
        }else{
            //取消点赞
            commentService.dropeLikeComment(likeComment);
        }
        return new ResponseDTO("200","操作成功!",null);
    }
}
