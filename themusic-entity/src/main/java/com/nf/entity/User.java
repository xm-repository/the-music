package com.nf.entity;

import lombok.Data;

@Data
public class User {
    private Integer userId;
    private String userName;
    private String userSex;
    private String userPhone;
    private String userPicture;

    private Login login;
    //解决layui数据表格不显示复杂字段的问题
    private String loginName;
    private String password;
    private String loginType;
}
