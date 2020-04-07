package com.nf.service;

import com.nf.dao.ILikeDao;
import com.nf.dao.SongSheetDao;
import com.nf.entity.SongSheet;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SongSheetService {
    @Autowired
    private SongSheetDao songSheetDao;
    @Autowired
    private ILikeDao iLikeDao;

    //根据ilikeId查询我喜欢的歌单数量
    public Integer getSongSheetCountByILikeId(Integer ilikeId){
        return songSheetDao.getSongSheetCountByILikeId(ilikeId);
    }
    //根据ilikeId查询我喜欢的歌单信息
    public List<SongSheet> getSongSheetByILikeId(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, Integer ilikeId){
        List<SongSheet> songSheets = songSheetDao.getSongSheetByILikeId(pageNum, pageSize, ilikeId);
        for (SongSheet songSheet : songSheets) {
            songSheet.setSongNums(songSheetDao.getSongNumsBySheetId(songSheet.getSheetId()));
        }
        return songSheets;
    }

    //根据据userId查询歌单数量
    public Integer getSongSheetCountByUserId(Integer userId){
        return songSheetDao.getSongSheetCountByUserId(userId);
    }

    //根据据userId查询歌单
    public List<SongSheet> getSongSheetByUserId(Integer pageNum,Integer pageSize,Integer userId){
        List<SongSheet> songSheets = songSheetDao.getSongSheetByUserId(pageNum, pageSize, userId);
        for (SongSheet songSheet : songSheets) {
            songSheet.setSongNums(songSheetDao.getSongNumsBySheetId(songSheet.getSheetId()));
        }
        return songSheets;
    }

    //创建一个歌单
    public void addSongSheet(SongSheet songSheet){
        songSheetDao.addSongSheet(songSheet);
    }

    //根据sheetId删除一个歌单(我创建的歌单)
    public void deleteSheetBySheetId(Integer sheetId){
        //先删除歌单中的歌曲
        songSheetDao.deleteSheetSongsBySheetId(sheetId);
        //删除歌单-我喜欢的该歌单记录
        iLikeDao.deleteILikeSongSheetBySheetId(sheetId);
        //删除歌单
        songSheetDao.deleteSheetBySheetId(sheetId);
    }

    //取消收藏一个歌单
    public void cancelLikeSongSheet(Integer songSheetId,Integer ilikeId){
        songSheetDao.cancelLikeSongSheet(songSheetId, ilikeId);
    }

    //添加/删除歌曲到我创建的歌单
    public void likeOrCancelLikeSong(List<Integer> songIds,Integer sheetId,Integer likeSong){
        if(likeSong == 0){
            songSheetDao.cancelLikeSong(songIds, sheetId);
        }else{
            for (Integer songId : songIds) {
                //判断当前歌曲是否已经在歌单中
                int count = songSheetDao.isLikeSong(songId,sheetId);
                if(count ==0){
                    ArrayList<Integer> list = new ArrayList();
                    list.add(songId);
                    songSheetDao.likeSong(list,sheetId);
                }
            }
        }
    }

    //根据sheetId查询歌单信息
    public SongSheet getSongSheetBySheetId(Integer sheetId){
        return songSheetDao.getSongSheetBySheetId(sheetId);
    }

    //根据sheetId查询歌单中歌曲数量
    public Integer getSheetSongCountBySheetId(Integer sheetId){
        return songSheetDao.getSheetSongCountBySheetId(sheetId);
    }
}
