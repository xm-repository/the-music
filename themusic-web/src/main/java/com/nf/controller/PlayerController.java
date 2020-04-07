package com.nf.controller;

import com.nf.dto.ResponseDTO;
import com.nf.entity.Login;
import com.nf.entity.Song;
import com.nf.entity.SongPlayer;
import com.nf.entity.SongSheet;
import com.nf.service.ILikeService;
import com.nf.service.SongService;
import com.nf.service.SongSheetService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/player")
public class PlayerController {
    @Autowired
    private SongService songService;
    @Autowired
    private ILikeService iLikeService;
    @Autowired
    private SongSheetService songSheetService;

    //进入到播放器首页
    @GetMapping("/index")
    public ModelAndView index(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/song-play");
        return modelAndView;
    }
    //添加歌曲到播放器中
    @PostMapping("/addSong")
    @ResponseBody
    public ResponseDTO addSong(HttpServletRequest req, @RequestBody List<Integer> songIds){
        //创建播放器
        SongPlayer songPlayer = null;
        if(req.getSession().getAttribute("songPlayer")==null){
            songPlayer = new SongPlayer(new ArrayList());
        }else{
            songPlayer = (SongPlayer)req.getSession().getAttribute("songPlayer");
        }
        //添加到播放器
        for (Integer songId : songIds) {
            Song song = songService.getSongBySongId(songId);
            songPlayer.getSongList().add(song);
        }
        req.getSession().setAttribute("songPlayer",songPlayer);
        ResponseDTO responseDTO = new ResponseDTO("200","添加歌曲成功!",null);
        return responseDTO;
    }
    //获取播放器中的歌曲
    @GetMapping("/songList")
    @ResponseBody
    public List<Song> songList(HttpServletRequest req){
        List<Song> songList = ((SongPlayer)req.getSession().getAttribute("songPlayer")).getSongList();
        return songList;
    }
    //判断当前用户是否收藏当前歌曲
    @GetMapping("/isLikeSong")
    @ResponseBody
    public ResponseDTO isLikeSong(Integer songId,HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId =null;
        ilikeId=login == null?null:iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        int count = songService.isLikeSong(songId,ilikeId);
        return new ResponseDTO("200","ok",count);
    }
    //删除播放器列表中的歌曲
    @PostMapping("/removeSongs")
    @ResponseBody
    public ResponseDTO removeSongs(@RequestBody List<Integer> songIds,HttpServletRequest req){
        SongPlayer songPlayer = (SongPlayer)req.getSession().getAttribute("songPlayer");
        List<Song> songList = songPlayer.getSongList();
        for (Integer songId : songIds) {
            for(int i=0;i<=songList.size()-1;i++){
                if(songList.get(i).getSongId()==songId){
                    //找到了
                    songList.remove(i);
                }
            }
        }
        songPlayer.setSongList(songList);
        req.getSession().setAttribute("songPlayer",songPlayer);
        return new ResponseDTO("200","ok",null);
    }

//    //获取登录用户的所有歌单信息
//    @GetMapping("/mySongSheet")
//    @ResponseBody
//    public ResponseDTO mySongSheet(HttpServletRequest req){
//        //先获取登录用户的userId
//        Login login = (Login)req.getSession().getAttribute("login");
//        Integer userId = login.getUserId();
//        //根据userId查询歌单
//        List<SongSheet> songSheets = songSheetService.getSongSheetByUserId(userId);
//        return new ResponseDTO("200","ok",songSheets);
//    }
}
