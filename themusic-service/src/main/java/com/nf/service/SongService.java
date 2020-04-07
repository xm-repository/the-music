package com.nf.service;

import com.nf.dao.CommentCommentDao;
import com.nf.dao.CommentDao;
import com.nf.dao.MVDao;
import com.nf.dao.SongDao;
import com.nf.entity.Song;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class SongService {
    @Autowired
    private SongDao songDao;
    @Autowired
    private CommentCommentDao commentCommentDao;
    @Autowired
    private CommentDao commentDao;
    @Autowired
    private MVDao mvDao;

    //查询所有歌
    public List<Song> getAllSong(Integer pageNum,Integer pageSize){
        return songDao.getAllSong(pageNum, pageSize,(pageNum-1)*pageSize);
    }


    //根据歌曲id查出某一首歌曲
    public Song getSongBySongId(Integer songId){
        return songDao.getSongBySongId(songId);
    }

    //根据名字查歌曲
    public List<Song> getSongBySongName(Integer pageNum,Integer pageSize,String songName){
        return songDao.getSongBySongName(pageNum,pageSize,songName);
    }
    //根据歌手id查歌曲
    public List<Song> getSongBySingerId(Integer pageNum,Integer pageSize,Integer singerId){
        return songDao.getSongBySingerId(pageNum,pageSize,singerId);
    }
    //查询歌手的所有歌曲数量
    public Integer getSingerSongCount(Integer singerId){
        return songDao.getSingerSongCount(singerId);
    }
    //根据我喜欢id查询歌曲数量
    public Integer getSongCountByILikeId(Integer iLikeId){
        return songDao.getSongCountByILikeId(iLikeId);
    }
    //根据我喜欢id查询歌曲
    public List<Song> getSongByILikeId(Integer pageNum,Integer pageSize,Integer iLikeId){
        return songDao.getSongByILikeId(pageNum,pageSize,iLikeId);
    }

    //根据歌曲发布时间降序查询歌曲
    public List<Song> getSongByPublishDateDesc(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize){
        return songDao.getSongByPublishDateDesc(0,5);
    }

    //查询所有歌曲的数量
    public Integer getAllSongsCount(){
        return songDao.getAllSongsCount();
    }

    //收藏或者取消收藏歌曲
    public void likeOrCancelLikeSong(List<Integer> songIds,Integer ilikeId,Integer likeSong){
        if(likeSong == 0){
            songDao.cancelLikeSong(songIds, ilikeId);
        }else{
            for (Integer songId : songIds) {
                //判断当前歌曲是否已经收藏
                int count = songDao.isLikeSong(songId,ilikeId);
                if(count ==0){
                    ArrayList<Integer> list = new ArrayList();
                    list.add(songId);
                    songDao.likeSong(list,ilikeId);
                }
            }
        }
    }
    //根据ilikeId查询是否喜欢收藏歌曲
    public Integer isLikeSong(Integer songId,Integer ilikeId){
        return songDao.isLikeSong(songId, ilikeId);
    }
    //根据ilikeId查询是否没收藏当前歌曲


    //管理员查询全部歌曲
    public List<Song> getAllSongs(Integer pageNum,Integer pageSize){
        return songDao.getAllSongs(pageNum,pageSize);
    }

    @Transactional
    //根据songId删除歌曲
    public void deleteSongBySongId(List<Integer> songIds){
        //把这首歌曲的相关数据删除
        //获取这首歌曲的评论
        List<Integer> commentIds = commentDao.getCommentIdBySongId(songIds);
        //删除点赞表
        commentDao.deleteLikeCommentByCommentId(commentIds);
        //删除回复评论
        commentCommentDao.deleteCCommentByCommentId(commentIds);
        //删除评论
        commentDao.deleteCommentBySongId(songIds);
        //删除mv
        mvDao.deleteMvBySongId(songIds);
        //删除关系表
        songDao.deleteSheetSongRelationBySongId(songIds);
        //删除歌曲
        songDao.deleteSongBySongId(songIds);
    }
    //修改歌曲信息
    public void updateSong (Song song){
        songDao.updateSong(song);
    }
    //查询最后一首歌的id
    public Integer getLastSongId(){
        return songDao.getLastSongId();
    }
    //添加一首歌
    public void addSong(Song song){
        songDao.addSong(song);
    }
    //根据歌手id查询歌曲id
    public List<Integer> getSongIdBySingerId(List<Integer> singerId){
        return songDao.getSongIdBySingerId(singerId);
    }
    //根据sheetId分页查询歌曲
    public List<Song> getSongBySheetId(@Param("pageNum")Integer pageNum, @Param("pageSize") Integer pageSize,Integer sheetId){
        return songDao.getSongBySheetId(pageNum, pageSize, sheetId);
    }
    //根据albumId分页查询歌曲
    public List<Song> getSongByAlbumId(@Param("pageNum")Integer pageNum, @Param("pageSize") Integer pageSize,Integer albumId){
        return songDao.getSongByAlbumId(pageNum, pageSize, albumId);
    }
}
