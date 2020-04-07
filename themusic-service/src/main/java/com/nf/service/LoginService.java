package com.nf.service;

import com.nf.dao.LoginDao;
import com.nf.entity.Login;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
    @Autowired
    private LoginDao loginDao;

    //判断账号密码是否正确
    public Integer isLoginSuccess(Login login){
        return loginDao.isLoginSuccess(login);
    }

    //查询账号信息
    public Login getLoginInfo(Login login){
        return loginDao.getLoginInfo(login);
    }

    //判断登录名是否已经存在
    public Integer loginNameIsExit(String loginName){
        return loginDao.loginNameIsExit(loginName);
    }

    //添加一个登录账号
    public void addLogin(Login login){
        loginDao.addLogin(login);
    }

    //修改登录类型
    public void updateLogin(Login login){
        loginDao.updateLogin(login);
    }
}
