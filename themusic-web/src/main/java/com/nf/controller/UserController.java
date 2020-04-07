package com.nf.controller;

import com.nf.dto.ResponseDTO;
import com.nf.entity.Login;
import com.nf.entity.User;
import com.nf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    //进入用户信息页面
    @GetMapping("/updateUserInfo")
    public ModelAndView updateUserInfo(HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询用户信息
        User user = userService.getUserByUserId(((Login)req.getSession().getAttribute("login")).getUserId());
        modelAndView.addObject("user",user);
        modelAndView.setViewName("/user/userinfo-index");
        return modelAndView;
    }

    //获取登录用户的用户信息
    @GetMapping("/userInfo")
    @ResponseBody
    public ResponseDTO userInfo(HttpServletRequest req){
        //查询用户信息
        User user = userService.getUserByUserId(((Login)req.getSession().getAttribute("login")).getUserId());
        return new ResponseDTO("200","ok",user);
    }

    //用户修改个人信息
    @PostMapping("/updateUserInfo")
    @ResponseBody
    public ResponseDTO updateUserInfo(@RequestParam(required = false) MultipartFile file, User user){
        //上传文件
        if(file.getSize() !=0){
            //文件名
            String fileName = file.getOriginalFilename();
            //防止文件名重复，修改文件名
            String uuid = UUID.randomUUID().toString().replace("-","");
            fileName = uuid+fileName;
            //物理路径
            String diskPath="D:\\file\\themusic\\img\\headPicture\\user\\";
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                file.transferTo(new File(fullPath));
                //修改图片路径
                user.setUserPicture(fileName);
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //修改用户信息
        userService.updateUser(user);
        return new ResponseDTO("200","修改成功",null);
    }
}
