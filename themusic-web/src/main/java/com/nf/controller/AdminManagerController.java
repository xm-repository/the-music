package com.nf.controller;

import com.nf.dto.ResponseDTO;
import com.nf.entity.*;
import com.nf.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminManagerController {
    @Autowired
    private SongService songService;
    @Autowired
    private SingerService singerService;
    @Autowired
    private MVService mvService;
    @Autowired
    private UserService userService;
    @Autowired
    private LoginService loginService;

    //进入管理员首页
    @GetMapping("/index")
    public String index(HttpServletRequest req){
        return "admin/admin-index";
    }

    //进入歌曲管理jsp
    @GetMapping("/songManagerIndex")
    public String songManagerIndex(){
        return "admin/admin-song_manager";
    }

    //查询所有歌曲数量
    @GetMapping("/songsCount")
    @ResponseBody
    public ResponseDTO getAllSongsCount(){
        Integer count = songService.getAllSongsCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //分页查询歌曲
    @GetMapping("/songManager")
    @ResponseBody
    public ResponseDTO songManager(@RequestParam(required = false)Integer pageNum,
                                   @RequestParam(required = false)Integer pageSize){
        List<Song> songs = songService.getAllSongs(pageNum, pageSize);
        ResponseDTO responseDTO = new ResponseDTO("200","ok",songs);
        return responseDTO;
    }
    //删除歌曲
    @PostMapping("/songManager/deleteSong")
    @ResponseBody
    public ResponseDTO deleteSong(@RequestBody List<Integer> songIds){
        songService.deleteSongBySongId(songIds);
        return new ResponseDTO("200","ok",null);
    }
    //进入修改歌曲页面
    @GetMapping("/songManager/updateSong")
    public ModelAndView updateSong(Integer songId){
        //查询歌曲信息
        Song song = songService.getSongBySongId(songId);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("song",song);
        modelAndView.setViewName("admin/admin-song_manager-updatesong");
        return modelAndView;
    }
    //修改歌曲信息
    @PostMapping("/songManager/updateSong")
    @ResponseBody
    public ResponseDTO updateSong(@RequestParam(required = false) MultipartFile[] files,  Song song){
        //上传文件
        for(int i=0;i<=files.length-1;i++){
            if(files[i].getSize() ==0){
                //为选择文件
                continue;
            }
            //文件名
            String fileName = files[i].getOriginalFilename();
            //物理路径
            String diskPath = null;
            if(i==0){
                //歌曲图片
                diskPath="D:\\file\\themusic\\img\\song\\";
            }else{
                //音频文件
                diskPath="D:\\file\\themusic\\song\\";
            }
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                files[i].transferTo(new File(fullPath));
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //修改歌曲信息
        songService.updateSong(song);
        return new ResponseDTO("200","修改成功",null);
    }
    //进入添加曲页面
    @GetMapping("/songManager/addSong")
    public ModelAndView addSong(){
        //查询歌曲信息
        Integer songId = songService.getLastSongId();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("songId",songId+1);
        modelAndView.setViewName("admin/admin-song_manager-addsong");
        return modelAndView;
    }
    //添加歌曲
    @PostMapping("/songManager/addSong")
    @ResponseBody
    public ResponseDTO addSong(@RequestParam(required = false) MultipartFile[] files,  Song song){
        //上传文件
        for(int i=0;i<=files.length-1;i++){
            if(files[i].getSize() ==0){
                //为选择文件
                continue;
            }
            //文件名
            String fileName = files[i].getOriginalFilename();
            //物理路径
            String diskPath = null;
            if(i==0){
                //曲图片
                diskPath="D:\\file\\themusic\\img\\song\\";
            }else{
                //音频文件
                diskPath="D:\\file\\themusic\\song\\";
            }
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                files[i].transferTo(new File(fullPath));
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //添加歌曲
        songService.addSong(song);
        return new ResponseDTO("200","添加成功",null);
    }

    //进入Mv管理jsp
    @GetMapping("/mvManagerIndex")
    public String mvManagerIndex(){
        return "admin/admin-mv_manager";
    }

    //查询所有Mv数量
    @GetMapping("/mvsCount")
    @ResponseBody
    public ResponseDTO getAllMvsCount(){
        Integer count = mvService.getAllmvsCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //分页查询Mv
    @GetMapping("/mvManager")
    @ResponseBody
    public ResponseDTO mvManager(@RequestParam(required = false)Integer pageNum,
                                   @RequestParam(required = false)Integer pageSize){
        List<MV> mvs = mvService.getAllMvs(pageNum,pageSize);
        ResponseDTO responseDTO = new ResponseDTO("200","ok",mvs);
        return responseDTO;
    }
    //删除Mv
    @PostMapping("/mvManager/deleteMv")
    @ResponseBody
    public ResponseDTO deleteMv(@RequestBody List<Integer> mvIds){
        mvService.deleteMvByMvId(mvIds);
        return new ResponseDTO("200","ok",null);
    }
    //进入修改mv页面
    @GetMapping("/mvManager/updateMv")
    public ModelAndView updateMv(Integer mvId){
        //查询Mv信息
        MV mv = mvService.getMvByMvId(mvId);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("mv",mv);
        modelAndView.setViewName("admin/admin-mv_manager-updatemv");
        return modelAndView;
    }
    //修改Mv信息
    @PostMapping("/mvManager/updateMv")
    @ResponseBody
    public ResponseDTO updateMv(@RequestParam(required = false) MultipartFile[] files,  MV mv){
        //上传文件
        for(int i=0;i<=files.length-1;i++){
            if(files[i].getSize() ==0){
                //为选择文件
                continue;
            }
            //文件名
            String fileName = files[i].getOriginalFilename();
            //物理路径
            String diskPath = null;
            if(i==0){
                //mv图片
                diskPath="D:\\file\\themusic\\img\\mv\\";
            }else{
                //音频文件
                diskPath="D:\\file\\themusic\\mv\\";
            }
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                files[i].transferTo(new File(fullPath));
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //修改mv信息
        mvService.updateMv(mv);
        return new ResponseDTO("200","修改成功",null);
    }
    //进入添加Mv页面
    @GetMapping("/mvManager/addMv")
    public ModelAndView addMv(){
        //查询歌曲信息
        Integer mvId = mvService.getLastMvId();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("mvId",mvId+1);
        modelAndView.setViewName("admin/admin-mv_manager-addmv");
        return modelAndView;
    }
    //添加mv
    @PostMapping("/mvManager/addMv")
    @ResponseBody
    public ResponseDTO addSong(@RequestParam(required = false) MultipartFile[] files,  MV mv){
        //上传文件
        for(int i=0;i<=files.length-1;i++){
            if(files[i].getSize() ==0){
                //为选择文件
                continue;
            }
            //文件名
            String fileName = files[i].getOriginalFilename();
            //物理路径
            String diskPath = null;
            if(i==0){
                //mv图片
                diskPath="D:\\file\\themusic\\img\\mv\\";
            }else{
                //音频文件
                diskPath="D:\\file\\themusic\\mv\\";
            }
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                files[i].transferTo(new File(fullPath));
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //添加mv
        mvService.addMv(mv);
        return new ResponseDTO("200","添加",null);
    }

    //歌手管理
    //进入歌手管理jsp
    @GetMapping("/singerManagerIndex")
    public String singerManagerIndex(){
        return "admin/admin-singer_manager";
    }
    //查询所有歌手数量
    @GetMapping("/singersCount")
    @ResponseBody
    public ResponseDTO getAllSingersCount(){
        Integer count = singerService.getAllSingersCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //分页查询歌手
    @GetMapping("/singerManager")
    @ResponseBody
    public ResponseDTO singerManager(@RequestParam(required = false)Integer pageNum,
                                 @RequestParam(required = false)Integer pageSize){
        List<Singer> singers = singerService.getAllSingers(pageNum,pageSize);
        ResponseDTO responseDTO = new ResponseDTO("200","ok",singers);
        return responseDTO;
    }
    //删除歌手
    @PostMapping("/singerManager/deleteSinger")
    @ResponseBody
    public ResponseDTO deleteSinger(@RequestBody List<Integer> singerIds){
        singerService.deleteSingerBySingerId(singerIds);
        return new ResponseDTO("200","ok",null);
    }
    //进入修改歌手页面
    @GetMapping("/singerManager/updateSinger")
    public ModelAndView updateSinger(Integer singerId){
        //查询歌手信息
        Singer singer = singerService.getSingerBySingerId(singerId);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("singer",singer);
        modelAndView.setViewName("admin/admin-singer_manager-updatesinger");
        return modelAndView;
    }
    //修改歌手信息
    @PostMapping("/singerManager/updateSinger")
    @ResponseBody
    public ResponseDTO updateSinger(@RequestParam(required = false) MultipartFile file,  Singer singer){
        //上传文件
        if(file.getSize() !=0){
            //文件名
            String fileName = file.getOriginalFilename();
            //物理路径
            String diskPath = null;
            //歌手图片
            diskPath="D:\\file\\themusic\\img\\headPicture\\singer\\";
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                file.transferTo(new File(fullPath));
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //修改歌手信息
        singerService.updateSinger(singer);
        return new ResponseDTO("200","修改成功",null);
    }
    //进入添加歌手页面
    @GetMapping("/singerManager/addSinger")
    public ModelAndView addSinger(){
        //查询歌曲信息
        Integer singerId = singerService.getLastSingerId();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("singerId",singerId+1);
        modelAndView.setViewName("admin/admin-singer_manager-addsinger");
        return modelAndView;
    }
    //添加歌手
    @PostMapping("/singerManager/addSinger")
    @ResponseBody
    public ResponseDTO addSinger(@RequestParam(required = false) MultipartFile file,  Singer singer){
        //上传文件
        if(file.getSize() !=0){
            //文件名
            String fileName = file.getOriginalFilename();
            //物理路径
            String diskPath = null;
            //歌手图片
            diskPath="D:\\file\\themusic\\img\\headPicture\\singer\\";
            //磁盘路径
            String fullPath=diskPath+fileName;
            try {
                file.transferTo(new File(fullPath));
            } catch (IOException e) {
                throw new RuntimeException("上传文件失败!",e);
            }
        }
        //添加歌手
        singerService.addSinger(singer);
        return new ResponseDTO("200","修改成功",null);
    }


    //用户管理
    //进入用户管理jsp
    @GetMapping("/userManagerIndex")
    public String userManagerIndex(){
        return "admin/admin-user_manager";
    }
    //查询所有用户数量
    @GetMapping("/usersCount")
    @ResponseBody
    public ResponseDTO getAllUsersCount(){
        Integer count = userService.getAllUserCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }

    //分页查询用户
    @GetMapping("/userManager")
    @ResponseBody
    public ResponseDTO userManager(@RequestParam(required = false)Integer pageNum,
                                     @RequestParam(required = false)Integer pageSize){
        List<User> users = userService.getAllUsers(pageNum,pageSize);
        ResponseDTO responseDTO = new ResponseDTO("200","ok",users);
        return responseDTO;
    }
    //修改登录权限身份
    @PostMapping("/userManager/updateLogin")
    @ResponseBody
    public ResponseDTO updateLogin(@RequestBody Login login){
        //修改登录信息
        loginService.updateLogin(login);
        return new ResponseDTO("200","修改成功",null);
    }
}
