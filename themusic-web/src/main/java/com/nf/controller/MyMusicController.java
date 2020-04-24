package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.dto.ResponseDTO;
import com.nf.entity.*;
import com.nf.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequestMapping("/myMusic")
public class MyMusicController {
    @Autowired
    private ILikeService iLikeService;
    @Autowired
    private SongService songService;
    @Autowired
    private SongSheetService songSheetService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private MVService mvService;

    //加载我的音乐页面
    @GetMapping("/index")
    public String iLikeIndex(HttpServletRequest req){
        return "/user/my_music";
    }
    //加载未登录页面
    @GetMapping("/notLogin")
    public String notLogin(){
        return "user/my_music-not-login";
    }
    //加载我喜欢页面
    @GetMapping("/ilike")
    public String ilikePage(){
        return "/user/my_music-ilike";
    }
    //加载我喜欢-单曲页面
    @GetMapping("/ilike/singleSong")
    public ModelAndView list(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/user/my_music-ilike-single_song");
        return modelAndView;
    }
    //查询我喜欢-单曲数量
    @GetMapping("/ilike/singleSongCount")
    @ResponseBody
    public ResponseDTO singleSongCount(HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        Integer count = songService.getSongCountByILikeId(ilikeId);
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }
    //加载我喜欢-单曲列表
    @GetMapping("/ilike/singleSongList")
    public ModelAndView singleSong(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                   @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                   HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询歌曲信息
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        //查询歌曲
        List<Song> songs = songService.getSongByILikeId(pageNum,pageSize,ilikeId);
        PageInfo<Song> pageInfo = new PageInfo(songs);
        modelAndView.setViewName("/user/my_music-ilike-single_song-list");
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }
    //我喜欢-单曲-歌曲下载
    @GetMapping("/ilike/singleSong/download")
    public ResponseEntity<InputStreamSource> download(String filename) throws IOException {
        //在mac系统下pathSeparator值为: ,separator值为: /
        String fullPath = "D:/file/themusic/song" + File.separator + filename;

        File file = new File(fullPath);
        //这个guess方法是依据文件名来得到媒体类型也就是mime类型,
        // 比如常见有image/jpeg,application/json
        String mediaType = URLConnection.guessContentTypeFromName(filename);
        if(mediaType==null) {
            /*识别不了时,统统用这个,一般用来表示下载二进制数据*/
            mediaType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
        }
        System.out.println("-----debug: mediaType = " + mediaType);
        HttpHeaders respHeaders = new HttpHeaders();
        respHeaders.setContentType(MediaType.parseMediaType(mediaType));

        //attachment :附件的意思,表示告诉浏览器弹出一个另存为窗口来下载文件,
        // inline是直接在浏览器中打开下载的文件
        //需要进行URL编码处理,否则另存为对话框不能显示中文
        respHeaders.setContentDispositionFormData("attachment",
                URLEncoder.encode(filename,"UTF-8"));


        InputStreamResource isr = new InputStreamResource(new FileInputStream(file));
        return new ResponseEntity<>(isr, respHeaders, HttpStatus.OK);
    }
    //加载我喜欢-歌单页面
    @GetMapping("/ilike/songSheet")
    public ModelAndView songSheet(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/user/my_music-ilike-song_sheet");
        return modelAndView;
    }
    //查询我喜欢-歌单数量
    @GetMapping("/ilike/songSheetCount")
    @ResponseBody
    public ResponseDTO songSheetCount(HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        Integer count = songSheetService.getSongSheetCountByILikeId(ilikeId);
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }
    //加载我喜欢-歌单列表
    @GetMapping("/ilike/songSheetList")
    public ModelAndView songSheet(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                  @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                  HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询歌曲信息
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        //查询歌单
        List<SongSheet> songSheets = songSheetService.getSongSheetByILikeId(pageNum,pageSize,ilikeId);
        PageInfo<SongSheet> pageInfo = new PageInfo(songSheets);
        modelAndView.setViewName("/user/my_music-ilike-song_sheet-list");
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }

    //加载我喜欢-专辑页面
    @GetMapping("/ilike/album")
    public ModelAndView album(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/user/my_music-ilike-album");
        return modelAndView;
    }
    //查询我喜欢-专辑数量
    @GetMapping("/ilike/albumCount")
    @ResponseBody
    public ResponseDTO albumCount(HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        Integer count = albumService.getAlbumCountByILikeId(ilikeId);
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //加载我喜欢-专辑列表
    @GetMapping("/ilike/albumList")
    public ModelAndView album(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                  @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                  HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询歌曲信息
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        //查询专辑
        List<Album> albums = albumService.getAlbumByILikeId(pageNum,pageSize,ilikeId);
        PageInfo<Album> pageInfo = new PageInfo(albums);
        modelAndView.setViewName("user/my_music-ilike-album-list");
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }

    //加载我喜欢-Mv页面
    @GetMapping("/ilike/mv")
    public ModelAndView mv(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/my_music-ilike-mv");
        return modelAndView;
    }
    //查询我喜欢-mv数量
    @GetMapping("/ilike/mvCount")
    @ResponseBody
    public ResponseDTO mvCount(HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        Integer count = mvService.getMVCountByILikeId(ilikeId);
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //加载我喜欢-MV列表
    @GetMapping("/ilike/mvList")
    public ModelAndView mv(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                           @RequestParam(value="pageSize",required=false,defaultValue ="12") int pageSize,
                           HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //查询歌曲信息
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        //查询Mv
        List<MV> mvs = mvService.getMVByILikeId(pageNum,pageSize,ilikeId);
        PageInfo<Album> pageInfo = new PageInfo(mvs);
        modelAndView.setViewName("user/my_music-ilike-mv-list");
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }


    //取消收藏一个歌单
    @PostMapping("/cancelLikeSongSheet")
    @ResponseBody
    public ResponseDTO cancelLikeSongSheet(Integer songSheetId,HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        songSheetService.cancelLikeSongSheet(songSheetId,ilikeId);
        ResponseDTO responseDTO = new ResponseDTO("200","删除成功",null);
        return responseDTO;
    }

    //取消收藏一个专辑
    @PostMapping("/cancelLikeAlbum")
    @ResponseBody
    public ResponseDTO cancelLikeAlbum(Integer albumId,HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        albumService.cancelLikeAlbum(albumId,ilikeId);
        ResponseDTO responseDTO = new ResponseDTO("200","删除成功",null);
        return responseDTO;
    }


    //加载我创建的歌单页面
    @GetMapping("/icreate/songSheet")
    public ModelAndView icreateSongSheet(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/my_music-i_create_songsheet");
        return modelAndView;
    }
    //查询我创建的歌单数量
    @GetMapping("/icreate/songSheetCount")
    @ResponseBody
    public ResponseDTO icreateSongSheetCount(HttpServletRequest req){
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");
        //查询出ilikeId
        Integer ilikeId = iLikeService.getILikeByUserId(login.getUserId()).getUserId();
        Integer count = songSheetService.getSongSheetCountByUserId(ilikeId);
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //加载我创建的歌单列表
    @GetMapping("/icreate/songSheetList")
    public ModelAndView icreateSongSheetList(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                                @RequestParam(value="pageSize",required=false,defaultValue ="10") int pageSize,
                                HttpServletRequest req){
        ModelAndView modelAndView = new ModelAndView();
        //先获取登录用户的userId
        Login login = (Login)req.getSession().getAttribute("login");

        List<SongSheet> songSheets = songSheetService.getSongSheetByUserId(pageNum,pageSize,login.getUserId());
        modelAndView.addObject("songSheets",songSheets);
        modelAndView.setViewName("user/my_music-i_create_songsheet-list");
        return  modelAndView;
    }

    //显示新建歌单页面
    @GetMapping("/newSongSheet")
    public String newSongSheet(){
        return "user/my_music-i_create-new_songsheet";
    }

    //添加一个歌单
    @PostMapping("/addSongSheet")
    @ResponseBody
    public ResponseDTO addSongSheet(HttpServletRequest req,String songSheetName){
        //获取登录用户id
        Integer userId = ((User)(req.getSession().getAttribute("user"))).getUserId();
        SongSheet songSheet = new SongSheet();
        songSheet.setUserId(userId);
        songSheet.setSheetName(songSheetName);
        songSheetService.addSongSheet(songSheet);
        ResponseDTO responseDTO = new ResponseDTO("200","添加成功",null);
        return responseDTO;
    }

    //删除一个歌单(我创建的歌单)
    @PostMapping("/deleteSongSheet")
    @ResponseBody
    public ResponseDTO deleteSongSheet(Integer songSheetId){
        songSheetService.deleteSheetBySheetId(songSheetId);
        ResponseDTO responseDTO = new ResponseDTO("200","删除",null);
        return responseDTO;
    }
}
