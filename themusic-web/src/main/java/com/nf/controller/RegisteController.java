package com.nf.controller;

import com.nf.dto.LoginDTO;
import com.nf.dto.ResponseDTO;
import com.nf.entity.Login;
import com.nf.entity.User;
import com.nf.service.LoginService;
import com.nf.service.UserService;
import com.nf.util.SendSmsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@CrossOrigin(value = {"http://127.0.0.1:8848"},
        methods = {RequestMethod.GET,RequestMethod.POST,RequestMethod.OPTIONS},
        allowCredentials = "false")
@RequestMapping("/registe")
public class RegisteController {

    @Autowired
    private LoginService loginService;
    @Autowired
    private UserService userService;

    private static String code;

    @GetMapping("/index")
    public String index(){
        return "user/registe";
    }

    @GetMapping("/code")
    @ResponseBody
    //发送短信验证码
    public ResponseDTO sendCode(String phoneNumber){
        code = SendSmsUtil.sendSms(phoneNumber);
        ResponseDTO responseDTO = new ResponseDTO("200","发送短信成功!",null);
        return responseDTO;
    }

    @PostMapping("/checkCode")
    @ResponseBody
    //验证短信验证码,并注册
    public ResponseDTO checkCode(@RequestBody LoginDTO loginDTO){
        ResponseDTO responseDTO;
        if(loginDTO.getCode().equals(code)){
            //判断该登录名是否存在
            Integer count = loginService.loginNameIsExit(loginDTO.getLoginName());
            if(0!=count){
                responseDTO = new ResponseDTO("500","该用户名已存在",null);
            }else{
                //注册
                //添加用户信息
                User user = new User();
                user.setUserPhone(loginDTO.getPhone());
                //默认选择一张头像
                user.setUserPicture("default.jpg");
                //默认男
                user.setUserSex("男");
                userService.addUser(user);
                //添加登陆信息
                Login login = new Login();
                login.setLoginName(loginDTO.getLoginName());
                login.setPassword(loginDTO.getPassword());
                login.setUserId(userService.selectLastUserId());
                login.setLoginType("用户");
                loginService.addLogin(login);
                responseDTO = new ResponseDTO("200","用户注册成功",null);
            }
        }else{
            responseDTO = new ResponseDTO("500","验证码错误",null);
        }
        return responseDTO;
    }
}
