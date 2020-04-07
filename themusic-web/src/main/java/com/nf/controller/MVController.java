package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.dto.LikeMvDTO;
import com.nf.dto.ResponseDTO;
import com.nf.entity.Login;
import com.nf.entity.MV;
import com.nf.service.ILikeService;
import com.nf.service.MVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/mv")
public class MVController {
    @Autowired
    private MVService mvService;
    @Autowired
    private ILikeService iLikeService;

    //进入MV页面
    @GetMapping("/list")
    public ModelAndView list(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/foundMusic-mv");
        return modelAndView;
    }
    //查询所有mv数量
    @GetMapping("/mvsCount")
    @ResponseBody
    public ResponseDTO getAllMvsCount(){
        Integer count = mvService.getAllmvsCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }
    //分页查询所有mv
    @GetMapping("/listMv")
    public ModelAndView listMv(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                             @RequestParam(value="pageSize",required=false,defaultValue ="16") int pageSize){
        ModelAndView modelAndView = new ModelAndView();
        List<MV> mvs = mvService.getAllMvs(pageNum,pageSize);
        PageInfo pageInfo = new PageInfo(mvs);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.setViewName("user/foundMusic-mv-list");
        return modelAndView;
    }
    //播放mv
    @GetMapping("/play")
    public ModelAndView play(Integer mvId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/mv-play");
        //查询mv信息
        MV mv = mvService.getMvByMvId(mvId);
        modelAndView.addObject("mv",mv);
        return modelAndView;
    }
    //歌手主页根据singerId查询mv
    @GetMapping("/singer/mvList")
    public ModelAndView getMVBySingerId(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                        @RequestParam(value="pageSize",required=false,defaultValue ="16") int pageSize,
                                        Integer singerId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/singer_mv");
        List<MV> mvs = mvService.getMVBySingerId(pageNum, pageSize, singerId);
        PageInfo pageInfo = new PageInfo(mvs);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.addObject("mvNums",mvs.size());
        return modelAndView;
    }
    //判断当前用户是否收藏当前Mv
    @GetMapping("/isLikeMv")
    @ResponseBody
    public ResponseDTO isLikeMv(Integer mvId, HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId =null;
        ilikeId=login == null?null:iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        int count = mvService.isLikeMv(mvId,ilikeId);
        return new ResponseDTO("200","ok",count);
    }
    //收藏或者取消收藏mv
    @PostMapping("/likeOrCancelLikeMv")
    @ResponseBody
    public ResponseDTO likeOrCancelLikeMv(@RequestBody LikeMvDTO likeMvDTO, HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        //收藏或取消收藏Mv
        mvService.likeOrCancelLikeMv(likeMvDTO.getMvIds(),ilikeId,likeMvDTO.getLikeMv());
        return new ResponseDTO("200","ok",null);
    }
}
