package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.entity.Album;
import com.nf.entity.Song;
import com.nf.service.AlbumService;
import com.nf.service.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;
    @Autowired
    private SongService songService;

    //进入专辑首页
    @GetMapping("/index")
    public ModelAndView index(Integer albumId){
        ModelAndView modelAndView = new ModelAndView();
        //查询专辑信息
        Album album = albumService.getAlbumByAlbumId(albumId);
        modelAndView.addObject("album",album);
        modelAndView.setViewName("user/album_index");
        return modelAndView;
    }
    //根据albumId分页查询单曲
    @GetMapping("/song")
    public ModelAndView getSongs(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                 @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,Integer albumId){
        ModelAndView modelAndView = new ModelAndView();
        List<Song> songs = songService.getSongByAlbumId(pageNum, pageSize,albumId);
        PageInfo<Song> pageInfo = new PageInfo(songs);
        modelAndView.setViewName("user/singer_single-song");
        modelAndView.addObject("pageInfo",pageInfo);
        //查询出专辑中歌曲数量
        Integer count = albumService.getAlbumSongCountByAlbumId(albumId);
        modelAndView.addObject("singleSongNums",count);
        return modelAndView;
    }
}
