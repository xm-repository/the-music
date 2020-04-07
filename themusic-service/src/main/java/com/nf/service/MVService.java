package com.nf.service;

import com.nf.dao.MVDao;
import com.nf.entity.MV;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MVService {
    @Autowired
    private MVDao mvDao;
    //根据mv名字查询mv
    public List<MV> getAllMV(int pageNum,int pageSize,String mvName){
        return mvDao.getAllMV(pageNum, pageSize,mvName);
    }
    //根据歌手id查询mv
    public List<MV> getMVBySingerId(int pageNum,int pageSize,Integer singerId){
        return mvDao.getMVBySingerId(pageNum,pageSize,singerId);
    }
    //根据ilikeId查询我喜欢的mv数量
    public Integer getMVCountByILikeId(Integer ilikeId){
        return mvDao.getMVCountByILikeId(ilikeId);
    }
    //根据ilikeId查询mv
    public List<MV> getMVByILikeId(int pageNum,int pageSize,Integer iLikeId){
        return mvDao.getMVByILikeId(pageNum, pageSize, iLikeId);
    }
    //根据播放数量倒序查询MV
    public List<MV> getMvByClickDesc(@Param("pageNum")int pageNum, @Param("pageSize")int pageSize){
        return mvDao.getMvByClickDesc(pageNum, pageSize);
    }
    //查询所有mv的数量
    public Integer getAllmvsCount(){
        return mvDao.getAllmvsCount();
    }
    //分页查询MV
    public List<MV> getAllMvs(@Param("pageNum")int pageNum,@Param("pageSize")int pageSize){
        return mvDao.getAllMvs(pageNum, pageSize);
    }
    //根据id删除mv
    public void deleteMvByMvId(List<Integer> mvIds){
        mvDao.deleteMvBySongId(mvIds);
    }
    //根据id查询mv信息
    public MV getMvByMvId(Integer mvId){
        return mvDao.getMvByMvId(mvId);
    }
    //修改mv信息
    public void updateMv(MV mv){
        mvDao.updateMv(mv);
    }
    //查询最后一首Mv的id
    public Integer getLastMvId(){
        return mvDao.getLastMvId();
    }
    //添加mv
    public void addMv(MV mv){
        mvDao.addMv(mv);
    }
    //根据ilikeId查询是否收藏当前mv
    public Integer isLikeMv(Integer mvId,Integer ilikeId){
        return mvDao.isLikeMv(mvId, ilikeId);
    }
    //收藏或者取消收藏Mv
    public void likeOrCancelLikeMv(List<Integer> mvIds,Integer ilikeId,Integer likeMv){
        if(likeMv == 0){
            mvDao.cancelLikeMv(mvIds, ilikeId);
        }else{
            for (Integer mvId : mvIds) {
                //判断当前mv是否已经收藏
                int count = mvDao.isLikeMv(mvId,ilikeId);
                if(count ==0){
                    ArrayList<Integer> list = new ArrayList();
                    list.add(mvId);
                    mvDao.likeMv(list,ilikeId);
                }
            }
        }
    }
}
