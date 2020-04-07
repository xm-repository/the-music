package com.nf.dao;

import com.nf.entity.Song;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SongDao {
    //排行榜页面查出所有歌曲
    List<Song> getAllSong(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize,int rankListStartNum);

    //根据id查出某一首歌曲
    Song getSongBySongId(Integer songId);

    //根据名字查询歌曲
    List<Song> getSongBySongName(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize,String songName);

    //根据歌手id查询歌曲
    List<Song> getSongBySingerId(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize,Integer singerId);

    //查询歌手的所有歌曲数量
    Integer getSingerSongCount(Integer singerId);
    //根据我喜欢id查询歌曲数量
    Integer getSongCountByILikeId(Integer iLikeId);
    //根据我喜欢id查询歌曲
    List<Song> getSongByILikeId(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize,Integer iLikeId);

    //根据歌曲发布时间降序查询歌曲
    List<Song> getSongByPublishDateDesc(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize);

    //收藏歌曲
    void likeSong(List<Integer> songIds,Integer ilikeId);
    //取消收藏歌曲
    void cancelLikeSong(List<Integer> songIds,Integer ilikeId);
    //根据ilikeId查询是否收藏当前歌曲
    Integer isLikeSong(Integer songId,Integer ilikeId);



    //管理员部分

    //查询所有歌曲的数量
    Integer getAllSongsCount();
    //管理员分页查询全部歌曲
    List<Song> getAllSongs(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize);

    //根据songId删除歌曲
    void deleteSongBySongId(List<Integer> songIds);
    //根据songId删除歌单关系表
    void deleteSheetSongRelationBySongId(List<Integer> songIds);
    //修改歌曲信息
    void updateSong (Song song);
    //查询最后一首歌的id
    Integer getLastSongId();
    //添加一首歌
    void addSong(Song song);
    //根据歌手id查询歌曲id
    List<Integer> getSongIdBySingerId(List<Integer> singerId);
    //根据sheetId分页查询歌曲
    List<Song> getSongBySheetId(@Param("pageNum")Integer pageNum, @Param("pageSize") Integer pageSize,Integer sheetId);
    //根据albumId分页查询歌曲
    List<Song> getSongByAlbumId(@Param("pageNum")Integer pageNum, @Param("pageSize") Integer pageSize,Integer albumId);
}
