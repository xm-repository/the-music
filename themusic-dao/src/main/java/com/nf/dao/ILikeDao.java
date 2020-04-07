package com.nf.dao;

import com.nf.entity.ILike;

public interface ILikeDao {
    //根据userId查询ILike
    ILike getILikeByUserId(Integer UserId);
    //根据sheetId删除其他用户喜欢该歌单的记录
    void deleteILikeSongSheetBySheetId(Integer sheetId);
}
