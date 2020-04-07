package com.nf.service;

import com.nf.dao.AlbumDao;
import com.nf.dao.SingerDao;
import com.nf.dto.SingerDTO;
import com.nf.entity.Singer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SingerService {
    @Autowired
    private SingerDao singerDao;
    @Autowired
    private SongService songService;
    @Autowired
    private SingerService singerService;
    @Autowired
    private AlbumService albumService;

    //歌手页面查询所有歌手
    public List<Singer> getAllSinger(int pageNum, int pageSize, SingerDTO singerDTO){
        return singerDao.getAllSinger(pageNum, pageSize, singerDTO);
    }
    //歌手页面查询歌手数量
    public Integer getAllSingerCount(SingerDTO singerDTO){
        return singerDao.getAllSingerCount(singerDTO);
    }
    //查询页面查询歌手基本信息和专辑数量
    public List<Singer> getAllSingerByName(int pageNum,int pageSize, String singerName){
        List<Singer> singers = singerDao.getAllSingerByName(pageNum, pageSize, singerName);
        for (Singer singer : singers) {
            singer.setAlbumNums(singerDao.getAlbumNumsBySingerId(singer.getSingerId()));
        }
        return singers;
    }
    //查询歌手基本信息、单曲数量、MV数量
    public Singer getSingerBySingerId(Integer singerId){
        //查询基本信息
        Singer singer = singerDao.getSingerBySingerId(singerId);
        //单曲数量
        singer.setSongNums(singerDao.getSongNumsBySingerId(singer.getSingerId()));
        //MV数量
        singer.setMvNums(singerDao.getMVNumsBySingerId(singer.getSingerId()));
        return singer;
    }
    //根据歌手名字查询id
    public Integer getSingerIdBySingerName(String singName){
        return singerDao.getSingerIdBySingerName(singName);
    }

    //管理员部分
    //查询所有歌手的数量
    public Integer getAllSingersCount(){
        return singerDao.getAllSingersCount();
    }
    //分页查询歌手
    public List<Singer> getAllSingers(int pageNum,int pageSize){
        return singerDao.getAllSingers(pageNum, pageSize);
    }
    //根据歌手id删除歌手
    public void deleteSingerBySingerId(List<Integer> singerId){
        //先删除歌曲
        //查询歌曲id
        List<Integer> songIds = songService.getSongIdBySingerId(singerId);
        songService.deleteSongBySongId(songIds);
        //删除专辑
        albumService.deleteAlbumBySingerId(singerId);
        //删除歌手
        singerDao.deleteSingerBySingerId(singerId);
    }
    //修改歌手信息
    public void updateSinger(Singer singer){
        singerDao.updateSinger(singer);
    }
    //查询最后一个歌手id
    public Integer getLastSingerId(){
        return singerDao.getLastSingerId();
    }
    //添加一个歌手
    public void addSinger(Singer singer){
        singerDao.addSinger(singer);
    }

}
