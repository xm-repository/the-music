package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.entity.MV;
import com.nf.entity.Singer;
import com.nf.entity.Song;
import com.nf.service.MVService;
import com.nf.service.SingerService;
import com.nf.service.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/search")
public class SearchController {
    @Autowired
    private SongService songService;
    @Autowired
    private MVService mvService;
    @Autowired
    private SingerService singerService;

    //进入搜索主页
    @GetMapping("/index")
    public ModelAndView index(String content){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/search");
        modelAndView.addObject("content",content);
        return modelAndView;
    }
    //显示单曲查询页面
    @GetMapping("/singleSong")
    public ModelAndView singleSong(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                   @RequestParam(value="pageSize",required=false,defaultValue ="15") int pageSize,
                                   String songName){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/search_single-song");
        List<Song> songList = songService.getSongBySongName(pageNum, pageSize, songName);
        PageInfo pageInfo = new PageInfo(songList);
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }
    //查询mv
    @GetMapping("/mv")
    public ModelAndView mv(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                             @RequestParam(value="pageSize",required=false,defaultValue ="16") int pageSize,
                             @RequestParam(value="mvName",required=false)String mvName){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/search_mv");
        List<MV> mvs= mvService.getAllMV(pageNum, pageSize,mvName);
        PageInfo pageInfo = new PageInfo(mvs);
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }
    //查询歌手
    @GetMapping("/singer")
    public ModelAndView singer(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                             @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                             @RequestParam(value="singerName",required=false)String singerName){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/search_singer");
        List<Singer> mvs= singerService.getAllSingerByName(pageNum, pageSize,singerName);
        PageInfo pageInfo = new PageInfo(mvs);
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }
}
