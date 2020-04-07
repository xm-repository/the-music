package com.nf.controller;

import com.github.pagehelper.PageInfo;
import com.nf.dto.ResponseDTO;
import com.nf.entity.Song;
import com.nf.service.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequestMapping("/ranklist")
public class RankListController {
    @Autowired
    private SongService songService;

    //进入排行榜页面
    @GetMapping("/list")
    public ModelAndView list(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("user/foundMusic-ranklist");
        return modelAndView;
    }
    //查询所有歌曲数量
    @GetMapping("/songsCount")
    @ResponseBody
    public ResponseDTO getAllSongsCount(){
        Integer count = songService.getAllSongsCount();
        ResponseDTO responseDTO =new ResponseDTO("200","",count);
        return responseDTO;
    }
    //查询排行榜列表
    @GetMapping("/listContent")
    public ModelAndView listContent(@RequestParam(value="pageNum",required=false,defaultValue ="1") int pageNum,
                             @RequestParam(value="pageSize",required=false,defaultValue ="15") int pageSize){
        ModelAndView modelAndView = new ModelAndView();
        List<Song> songs = songService.getAllSong(pageNum, pageSize);
        PageInfo<Song> pageInfo = new PageInfo(songs);
        modelAndView.setViewName("user/foundMusic-ranklist-content");
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }

    //下载歌曲
    @GetMapping("/download")
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
}
