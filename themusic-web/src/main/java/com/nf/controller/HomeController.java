package com.nf.controller;

import com.nf.dto.ResponseDTO;
import com.nf.entity.MV;
import com.nf.entity.Song;
import com.nf.service.MVService;
import com.nf.service.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/home")
public class HomeController {
    @Autowired
    private SongService songService;
    @Autowired
    private MVService mvService;

    //进入发现音乐首页
    @GetMapping("/index")
    public String index(HttpServletRequest req){
        return "user/foundMusic";
    }
    //渲染首页
    @PostMapping("/index")
    public String getIndex(){
        return "user/foundMusic-index";
    }

    //热歌推荐图片轮播
    @GetMapping("/carousel")
    @ResponseBody
    public ResponseDTO carousel(){
        List<Song> songs = songService.getSongByPublishDateDesc(0,5);
        ResponseDTO responseDTO = new ResponseDTO("200","获取图片成功",songs);
        return responseDTO;
    }

    //首页查询mv
    @GetMapping("/mv")
    public ModelAndView mv(){
        ModelAndView modelAndView = new ModelAndView();
        List<MV> mvs = mvService.getMvByClickDesc(0,8);
        modelAndView.addObject("mvs",mvs);
        modelAndView.setViewName("user/foundMusic-index-mv_list");
        return modelAndView;
    }
}
