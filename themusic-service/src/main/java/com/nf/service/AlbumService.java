package com.nf.service;

import com.nf.dao.AlbumDao;
import com.nf.entity.Album;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlbumService {
    @Autowired
    private AlbumDao albumDao;

    //根据ilikeId查询我喜欢的专辑数量
    public Integer getAlbumCountByILikeId(Integer ilikeId){
        return albumDao.getAlbumCountByILikeId(ilikeId);
    }
    //根据ilikeId查询我喜欢的专辑信息
    public List<Album> getAlbumByILikeId(Integer pageNum,Integer pageSize,Integer iLikeId){
        //先查询基本信息
        List<Album> albums = albumDao.getAlbumByILikeId(pageNum, pageSize, iLikeId);
        for (Album album : albums) {
            album.setSongNums(albumDao.getSongNumsByAlbumId(album.getAlbumId()));
        }
        return albums;
    }
    //根据专辑名字查询id
    public Integer getAlbumIdByAlbumName(String albumName){
        return albumDao.getAlbumIdByAlbumName(albumName);
    }
    //根据歌手id删除专辑
    public void deleteAlbumBySingerId(List<Integer> singerId){
        albumDao.deleteAlbumBySingerId(singerId);
    }
    //根据albumId查询专辑
    public Album getAlbumByAlbumId(Integer albumId){
        return albumDao.getAlbumByAlbumId(albumId);
    }
    //根据albumId查询专辑中歌曲数量
    public Integer getAlbumSongCountByAlbumId(Integer albumId){
        return albumDao.getAlbumSongCountByAlbumId(albumId);
    }
    //取消收藏一个专辑
    public void cancelLikeAlbum(Integer albumId,Integer ilikeId){
        albumDao.cancelLikeAlbum(albumId, ilikeId);
    }
}
