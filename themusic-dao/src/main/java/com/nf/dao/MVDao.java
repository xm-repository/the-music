package com.nf.dao;

import com.nf.entity.MV;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MVDao {
    //查询mv名字查询mv
    List<MV> getAllMV(@Param("pageNum")int pageNum,@Param("pageSize")int pageSize,String mvName);

    //根据歌手id查询mv
    List<MV> getMVBySingerId(@Param("pageNum")int pageNum,@Param("pageSize")int pageSize,Integer singerId);

    //根据ilikeId查询我喜欢的mv数量
    Integer getMVCountByILikeId(Integer ilikeId);

    //根据ILikeId分页查询我喜欢的mv信息
    List<MV> getMVByILikeId(@Param("pageNum")int pageNum,@Param("pageSize")int pageSize,Integer iLikeId);

    //根据播放数量倒序查询MV
    List<MV> getMvByClickDesc(@Param("pageNum")int pageNum,@Param("pageSize")int pageSize);

    //根据歌曲id删除mv
    void deleteMvBySongId(List<Integer> songIds);



    //查询所有mv的数量
    Integer getAllmvsCount();

    //分页查询MV
    List<MV> getAllMvs(@Param("pageNum")int pageNum,@Param("pageSize")int pageSize);

    //根据id删除mv
    void deleteMvByMvId(List<Integer> mvIds);

    //根据id查询mv信息
    MV getMvByMvId(Integer mvId);

    //修改mv信息
    void updateMv(MV mv);

    //查询最后一首Mv的id
    Integer getLastMvId();

    //添加mv
    void addMv(MV mv);

    //根据ilikeId查询是否收藏当前mv
    Integer isLikeMv(Integer mvId,Integer ilikeId);

    //收藏Mv
    void likeMv(List<Integer> mvIds,Integer ilikeId);
    //取消收藏mv
    void cancelLikeMv(List<Integer> mvIds,Integer ilikeId);
}
