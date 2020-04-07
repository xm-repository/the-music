<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<table class="layui-table" lay-skin="line">
    <colgroup>
        <col width="300">
        <col width="300">
        <col width="300">
        <col width="300">
    </colgroup>
    <thead>
    <tr style="height:60px;">
        <th>序号</th>
        <th>歌曲</th>
        <th>歌手</th>
        <th>选项</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageInfo.list}" var="song">
        <tr style="height:50px;" class="songTr" songId=${song.songId}>
            <td>${song.rownum}</td>
            <td><a href="/song/index?songId=${song.songId}" target="_blank">${song.songName}</a></td>
            <td><a href="/singer/singerIndex?singerId=${song.singerId}">${song.singerName}</a></td>
            <td>
                <ul class="Rank_list">
                    <li>
                        <div class="Rank_list_play" title="播放歌曲"><a href="#"><i class="iconfont icon-icon-test"></i></a></div>
                        <div class="Rank_list_downLoad" title="下载"><a href="/myMusic/ilike/singleSong/download?filename=${song.songSrc}"><i class="iconfont icon-download"></i></a></div>
                    </li>
                </ul>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
