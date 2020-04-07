package com.nf.dto;

import lombok.Data;

@Data
public class LoginDTO {
    //登录名
    private String loginName;
    //密码
    private String password;
    //手机号
    private String phone;
    //验证码
    private String code;
}
