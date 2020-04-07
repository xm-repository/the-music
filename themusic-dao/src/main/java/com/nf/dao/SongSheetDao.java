package com.nf.dao;

import com.nf.entity.SongSheet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SongSheetDao {
    //根据ilikeId查询我喜欢的歌单数量
    Integer getSongSheetCountByILikeId(Integer ilikeId);
    //根据ilikeId查询我喜欢的歌单信息
    List<SongSheet> getSongSheetByILikeId(@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize,Integer ilikeId);
    //根据歌单id查询歌单中歌曲数量
    Integer getSongNumsBySheetId(Integer sheetId);
    //根据据userId查询歌单数量
    Integer getSongSheetCountByUserId(Integer userId);
    //根据据userId查询歌单
    List<SongSheet> getSongSheetByUserId(@Param("pageNum") Integer pageNum,@Param("pageSize") Integer pageSize,Integer userId);

    //创建一个歌单
    void addSongSheet(SongSheet songSheet);

    //根据sheetId删除歌单表一个歌单
    void deleteSheetBySheetId(Integer sheetId);
    //根据sheetId删除我创建的歌单中的歌曲
    void deleteSheetSongsBySheetId(Integer sheetId);

    //取消收藏一个歌单
    void cancelLikeSongSheet(Integer songSheetId,Integer ilikeId);
    //收藏歌曲到我创建的歌单
    void likeSong(List<Integer> songIds,Integer sheetId);
    //取消收藏歌曲到我的歌单
    void cancelLikeSong(List<Integer> songIds,Integer sheetId);
    //根据sheetId查询是否已存在当前歌曲
    Integer isLikeSong(Integer songId,Integer sheetId);
    //根据sheetId查询歌单信息
    SongSheet getSongSheetBySheetId(Integer sheetId);
    //根据sheetId查询歌单中歌曲数量
    Integer getSheetSongCountBySheetId(Integer sheetId);
}
