<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="singer-container">
    <h1>单曲${singleSongNums}</h1>
    <table id="singer_singer-song-table" class="layui-table" lay-skin="line" style="border:none;">
        <colgroup>
            <col width="300">
            <col width="300">
            <col width="300">
            <col width="300">
        </colgroup>
        <thead>
        <tr style="height:60px;background-color:#F9F9F9;">
            <th>歌曲</th>
            <th>选项</th>
            <th>歌手</th>
            <th>时长</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="song">
            <tr style="height:50px;" songId="${song.songId}">
                <td><a href="/song/index?songId=${song.songId}">${song.songName}</a></td>
                <td>
                    <ul class="single-song_list">
                        <li class="single-song_list_fourth_column">
                            <div class="single-song_play" title="播放歌曲"><a href="javascript:void(0);"><i class="iconfont icon-icon-test"></i></a></div>
                            <div class="single-song_downLoad" title="下载"><a href="/myMusic/ilike/singleSong/download?filename=${song.songSrc}"><i class="iconfont icon-download"></i></a></div>
                        </li>
                    </ul>
                </td>
                <td><a href="/singer/singerIndex?singerId=${song.singerId}">${song.singerName}</a></td>
                <td>${song.songLength}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!--分页-->
    <div id="pagination">
        <nav style="text-align: center">
            <ul id="single-song_list_navigation_page" class="pagination">
                <li><a href="#" pageNum="1">首页</a></li>
                <li><a href="#" pageNum="${pageInfo.prePage}">上一页</a></li>
                <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                    <li><a href="#" pageNum="${num}">${num}</a></li>
                </c:forEach>
                <li><a href="#" pageNum="${pageInfo.nextPage}">下一页</a></li>
                <li><a href="#" pageNum="${pageInfo.pages}">尾页</a></li>
            </ul>
        </nav>
    </div>
</div>
</html>