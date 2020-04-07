package com.nf.service;

import com.nf.dao.ILikeDao;
import com.nf.entity.ILike;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ILikeService {
    @Autowired
    private ILikeDao iLikeDao;

    //根据userId查询iLike
    public ILike getILikeByUserId(Integer userId){
        return iLikeDao.getILikeByUserId(userId);
    }
}

