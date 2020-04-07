package com.nf.dao;

import com.nf.entity.Login;

public interface LoginDao {
    //判断账号密码是否正确
    Integer isLoginSuccess(Login login);

     //查询账号信息
    Login getLoginInfo(Login login);

    //判断登录名是否已经存在
    Integer loginNameIsExit(String loginName);

    //添加一个登录账号
    void addLogin(Login login);

    //修改登录类型
    void updateLogin(Login login);
}
