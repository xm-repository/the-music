package com.nf.entity;

import lombok.Data;

@Data
public class Login {
    private Integer loginId;
    //登录名字
    private String loginName;
    //密码
    private String password;
    private Integer userId;
    private String loginType;

}
