package com.nf.service;

import com.nf.dao.UserDao;
import com.nf.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    //查询用户信息
    public User getUserByUserId(Integer userId){
        return userDao.getUserByUserId(userId);
    }

    //添加一个用户
    public void addUser(User user){
        userDao.addUser(user);
    }

    //查询最后一个用户的id
    public Integer selectLastUserId(){
        return userDao.selectLastUserId();
    }

    //修改用户信息
    public void updateUser (User user){
        userDao.updateUser(user);
    }

    //查询所有用户数量
    public Integer getAllUserCount(){
        return userDao.getAllUserCount();
    }
    //管理员分页查询全部用户
    public List<User> getAllUsers(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize){
        return userDao.getAllUsers(pageNum, pageSize);
    }

}
