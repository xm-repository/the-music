package com.nf.dao;

import com.nf.dto.SingerDTO;
import com.nf.entity.Singer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SingerDao {
    //歌手页面查询歌手
    List<Singer> getAllSinger(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize,
                              SingerDTO singerDTO);
    //歌手页面查询歌手数量
    Integer getAllSingerCount(SingerDTO singerDTO);
    //搜索页面查询歌手
    List<Singer> getAllSingerByName(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize,String singerName);
    //根据歌手id查询基本信息
    Singer getSingerBySingerId(Integer singerId);
    //根据歌手id查询专辑数量
    int getAlbumNumsBySingerId(Integer singerId);
    //根据歌手id查询单曲数量
    int getSongNumsBySingerId(Integer singerId);
    //根据id查询MV数量
    int getMVNumsBySingerId(Integer singerId);
    //根据歌手名字查询id
    Integer getSingerIdBySingerName(String singName);

    //管理员部分
    //查询所有歌手的数量
    Integer getAllSingersCount();
    //分页查询歌手
    List<Singer> getAllSingers(@Param("pageNum")int pageNum, @Param("pageSize") int pageSize);

    //根据歌手id删除歌手
    void deleteSingerBySingerId(List<Integer> singerId);

    //修改歌手信息
    void updateSinger(Singer singer);
    //查询最后一个歌手id
    Integer getLastSingerId();
    //添加一个歌手
    void addSinger(Singer singer);
}
