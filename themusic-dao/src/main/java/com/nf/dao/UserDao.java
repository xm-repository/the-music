package com.nf.dao;

import com.nf.entity.Login;
import com.nf.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    //查询用户信息
    User getUserByUserId(Integer userId);

    //添加一个用户
    void addUser(User user);

    //查询最后一个用户的id
    Integer selectLastUserId();

    //查询所有用户数量
    Integer getAllUserCount();

    //修改用户信息
    void updateUser (User user);

    //管理员分页查询全部用户
    List<User> getAllUsers(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize);
}
