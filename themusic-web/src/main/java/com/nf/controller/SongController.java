package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.dto.LikeSongDTO;
import com.nf.dto.ResponseDTO;
import com.nf.entity.Login;
import com.nf.entity.Song;
import com.nf.entity.SongSheet;
import com.nf.service.ILikeService;
import com.nf.service.SongService;
import com.nf.service.SongSheetService;
import com.nf.util.ReadsongLrcUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/song")
public class SongController {
    @Autowired
    private SongService songService;
    @Autowired
    private ILikeService iLikeService;
    @Autowired
    private SongSheetService songSheetService;

    //进入歌曲主页
    @GetMapping("/index")
    public ModelAndView playMusic(Integer songId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/song-index");
        //查询歌曲信息
        Song song = songService.getSongBySongId(songId);
        //歌词
        List<String> lrc = ReadsongLrcUtil.readSongLrc(song.getLylicSrc());
        modelAndView.addObject("song",song);
        modelAndView.addObject("lrc",lrc);
        return modelAndView;
    }

    //根据歌手id查询歌曲
    @GetMapping("/singer/singleSongList")
    public ModelAndView getSongBySingerId(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                          @RequestParam(value="pageSize",required=false,defaultValue ="12") int pageSize,
                                          Integer singerId){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/singer_single-song");
        List<Song> songs = songService.getSongBySingerId(pageNum, pageSize, singerId);
        PageInfo pageInfo = new PageInfo(songs);
        Integer count = songService.getSingerSongCount(singerId);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.addObject("singleSongNums",count);
        return modelAndView;
    }

    //根据我喜欢id查询歌曲
    @PostMapping("/ilike/singleSongList")
    public ModelAndView getSongByILikeId(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                         @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                         Integer iLikeId){
        ModelAndView modelAndView = new ModelAndView();
        List<Song> songs = songService.getSongByILikeId(pageNum,pageSize,iLikeId);
        PageInfo pageInfo = new PageInfo(songs);
        modelAndView.setViewName("");
        return modelAndView;
    }

    //收藏或者取消收藏歌曲
    @PostMapping("/likeOrCancelLikeSong")
    @ResponseBody
    public ResponseDTO likeOrCancelLikeSong(@RequestBody LikeSongDTO likeSongDTO, HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        //收藏或取消收藏歌曲
        songService.likeOrCancelLikeSong(likeSongDTO.getSongIds(),ilikeId,likeSongDTO.getLikeSong());
        return new ResponseDTO("200","ok",null);
    }

    //添加歌曲到用户自定义歌单
    @PostMapping("/addSongToMySongSheet")
    @ResponseBody
    public ResponseDTO addSongToMySongSheet(@RequestBody LikeSongDTO likeSongDTO){
        //收藏或取消收藏歌曲
        songSheetService.likeOrCancelLikeSong(likeSongDTO.getSongIds(),likeSongDTO.getSheetId(),likeSongDTO.getLikeSong());
        return new ResponseDTO("200","ok",null);
    }
}
