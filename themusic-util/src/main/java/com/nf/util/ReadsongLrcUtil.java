package com.nf.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

//读取歌词工具类
public class ReadsongLrcUtil {
    public static List<String> readSongLrc(String lrcSrc){
        List<String> lrc = new ArrayList<>();
        File file = new File("D:/file/themusic/lrc/"+lrcSrc);
        try{
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));//构造一个BufferedReader类来读取文件
            String s = null;
            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                lrc.add(s);
            }
            br.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return lrc;
    }

    public static void main(String[] args) {
        readSongLrc("1.lrc");
    }
}
