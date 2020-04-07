package com.nf.dao;

import com.nf.entity.Album;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumDao {
    //根据ilikeId查询我喜欢的专辑数量
    Integer getAlbumCountByILikeId(Integer ilikeId);
    //根据ilikeId查询我喜欢的专辑信息
    List<Album> getAlbumByILikeId(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, Integer ilikeId);
    //根据专辑id查询专辑中中歌曲数量
    Integer getSongNumsByAlbumId(Integer albumId);
    //根据专辑名字查询id
    Integer getAlbumIdByAlbumName(String albumName);
    //根据歌手id删除专辑
    void deleteAlbumBySingerId(List<Integer> singerId);
    //根据albumId查询专辑
    Album getAlbumByAlbumId(Integer albumId);
    //根据albumId查询专辑中歌曲数量
    Integer getAlbumSongCountByAlbumId(Integer albumId);
    //取消收藏一个专辑
    void cancelLikeAlbum(Integer albumId,Integer ilikeId);
}
