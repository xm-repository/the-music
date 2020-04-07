package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.dto.ResponseDTO;
import com.nf.entity.Singer;
import com.nf.service.SingerService;
import com.nf.dto.SingerDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/singer")
public class SingerController {
    @Autowired
    private SingerService singerService;
    //跳转主页的歌手页面
    @GetMapping("/list")
    public String list(){
        ModelAndView modelAndView = new ModelAndView();
        return "user/foundMusic-singer";
    }
    //主页分页查询歌手数量
    @PostMapping("/listSingerCount")
    @ResponseBody
    public ResponseDTO listSingerCount(@RequestBody SingerDTO singerDTO){
        return new ResponseDTO("200","",singerService.getAllSingerCount(singerDTO));
    }
    //主页分页查询歌手
    @PostMapping("/listSinger")
    public ModelAndView listSinger(@RequestBody SingerDTO singerDTO){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/singer-list");
        List<Singer> singers;
        if(singerDTO.getPageNum()==null){
           singers = singerService.getAllSinger(1,15, singerDTO);
        }else{
            singers = singerService.getAllSinger(singerDTO.getPageNum(), singerDTO.getPageSize(), singerDTO);
        }
        PageInfo pageInfo = new PageInfo<Singer>(singers);
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }
    //跳转到单个歌手主页
    @GetMapping("/singerIndex")
    public ModelAndView singerIndex(Integer singerId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/singer-index");
        Singer singer = singerService.getSingerBySingerId(singerId);
        modelAndView.addObject("singer",singer);
        return modelAndView;
    }

    //查询所有歌手数量
    @GetMapping("/singersCount")
    @ResponseBody
    public ResponseDTO getAllSingersCount(){
        Integer count = singerService.getAllSingersCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

}
