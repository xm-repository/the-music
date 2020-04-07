package com.nf.controller;

import com.nf.entity.Login;
import com.nf.entity.User;
import com.nf.service.LoginService;
import com.nf.service.UserService;
import com.nf.dto.ResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    private LoginService loginService;
    @Autowired
    private UserService userService;

    //显示登陆页面
    @GetMapping("/login")
    public String enterLogin(){
        return "login";
    }

    //登陆验证
    @PostMapping("/login")
    @ResponseBody
    public ResponseDTO login(Login login, HttpServletRequest req){
        Integer loginSucess = loginService.isLoginSuccess(login);
        ResponseDTO responseDTO =null;
        if(loginSucess == 1){
            //登陆成功
            //查询登录信息
            Login loginInfo = loginService.getLoginInfo(login);
            //查询用户信息
            User user = userService.getUserByUserId(loginInfo.getUserId());
            //保存到session
            req.getSession().setAttribute("login",loginInfo);
            req.getSession().setAttribute("user",user);
            //带上登录身份
            responseDTO = new ResponseDTO("200","登陆成功",loginInfo.getLoginType());
        }else{
            responseDTO = new ResponseDTO("500","登陆失败",null);
        }
        return responseDTO;
    }

    //登陆成功替换用户头像
    @GetMapping("/loginSuccess")
    public ModelAndView loginSuccesss(HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询用户信息
        User user = userService.getUserByUserId(((Login)req.getSession().getAttribute("login")).getUserId());
        modelAndView.addObject("user",user);
        modelAndView.setViewName("login-userinfo");
        return modelAndView;
    }
    //注销
    @GetMapping("/loginOff")
    @ResponseBody
    public ResponseDTO loginOff(HttpServletRequest req){
        //移除登录账号
        req.getSession().removeAttribute("login");
        //移除用户信息
        req.getSession().removeAttribute("user");
        return new ResponseDTO("200","ok",null);
    }

    //判断用户是否登陆
    @GetMapping("/isLogin")
    @ResponseBody
    public ResponseDTO isLogin(HttpServletRequest req){
        ResponseDTO responseDTO;
        Object loginObj = req.getSession().getAttribute("login");
        if(loginObj != null){
            responseDTO = new ResponseDTO("200","用户已经登陆",loginObj);
        }else{
            responseDTO = new ResponseDTO("500","用户未登录",null);
        }
            return responseDTO;
    }
}
