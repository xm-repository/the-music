package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.entity.Song;
import com.nf.entity.SongSheet;
import com.nf.service.SongService;
import com.nf.service.SongSheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/songsheet")
public class SongSheetController {
    @Autowired
    private SongSheetService songSheetService;
    @Autowired
    private SongService songService;

    //进入歌单页面
    @GetMapping("/index")
    public ModelAndView index(Integer sheetId){
        ModelAndView modelAndView = new ModelAndView();
        //查询歌单信息
        SongSheet songSheet = songSheetService.getSongSheetBySheetId(sheetId);
        modelAndView.addObject("songSheet",songSheet);
        modelAndView.setViewName("user/songsheet_index");
        return modelAndView;
    }
    //根据sheetId分页查询单曲
    @GetMapping("/song")
    public ModelAndView getSongs(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                             @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,Integer sheetId){
        ModelAndView modelAndView = new ModelAndView();
        List<Song> songs = songService.getSongBySheetId(pageNum, pageSize,sheetId);
        PageInfo<Song> pageInfo = new PageInfo(songs);
        modelAndView.setViewName("user/singer_single-song");
        modelAndView.addObject("pageInfo",pageInfo);
        //查询出歌单中歌曲数量
        Integer count = songSheetService.getSheetSongCountBySheetId(sheetId);
        modelAndView.addObject("singleSongNums",count);
        return modelAndView;
    }
}
