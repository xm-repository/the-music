<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ul id="my_music-ilike-single_song-buttons">
    <li><button id="playAllSong" class="btn btn-default">播放全部</button></li>
    <%--    <li><button class="btn btn-default">添加到</button></li>--%>
    <%--    <li><button class="btn btn-default">下载</button></li>--%>
    <%--    <li><button class="btn btn-default">批量操作</button></li>--%>
</ul>
<!--单曲列表-->
<table id="mymusic-ilike-singersong-table" class="layui-table" lay-skin="line" style="margin-left:47px;margin-top:30px;width:1300px;border-color:white;">
    <colgroup>
        <col width="300">
        <col width="300">
        <col width="200">
        <col width="100">
        <col width="100">
    </colgroup>
    <thead>
    <tr style="height:60px;">
        <th>歌曲</th>
        <th>选项</th>
        <th>歌手</th>
        <th>时长</th>
        <th>删除</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageInfo.list}" var="song">
        <tr style="height:50px;" songId="${song.songId}">
            <td><a href="/song/index?songId=${song.songId}" target="_blank">${song.songName}</a></td>
            <td>
                <ul class="ilike-single_song-control">
                    <li>
                        <div class="ilike-single_song-control_play" title="播放歌曲"><a href="#"><i class="iconfont icon-icon-test"></i></a></div>
                        <div class="ilike-single_song-control_downLoad" title="下载"><a href="/myMusic/ilike/singleSong/download?filename=${song.songSrc}"><i class="iconfont icon-download"></i></a></div>
                    </li>
                </ul>
            </td>
            <td><a href="/singer/singerIndex?singerId=${song.singerId}" target="_blank">${song.singerName}</a></td>
            <td>${song.songLength}</td>
            <td><a href="javascript:void(0);"><i id="cancelLikeSong" title="删除"  class="iconfont icon-icon7" style="font-size:25px;"></i></a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
