<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:choose>
    <c:when test="${fn:length(pageInfo.list) == 0}">
        <div id="search_single-song_list_container">
            <p style="color:#666;text-align:center;font-size:30px;padding-top:90px;padding-bottom:60px;">
                抱歉，暂时没有找到相关条件的单曲<br/>
                TheMusic建议您：请检查输入的关键词是否有误或者过长。
            </p>
        </div>
    </c:when>
    <c:otherwise>
        <div id="search_single-song_list_container">
            <ul id="search_singer-song_list_content">
                <ul id="single-song_list_title">
                    <li class="single-song_list_title_first_column">歌曲</li>
                    <li class="single-song_list_title_fourth_column">选项</li>
                    <li class="single-song_list_title_second_column">歌手</li>
                    <li class="single-song_list_title_third_column">时长</li>
                </ul>
                <c:forEach items="${pageInfo.list}" var="song">
                    <ul class="single-song_list" songId="${song.songId}">
                        <li class="single-song_list_first_column"><a href="/song/index?songId=${song.songId}">${song.songName}</a></li>
                        <li class="single-song_list_fourth_column">
                            <div class="single-song_play" title="播放歌曲"><a href="#"><i class="iconfont icon-icon-test"></i></a></div>
                            <div class="single-song_downLoad" title="下载"><a href="/myMusic/ilike/singleSong/download?filename=${song.songSrc}"><i class="iconfont icon-download"></i></a></div>
                        </li>
                        <li class="single-song_list_second_column"><a href="/singer/singerIndex?singerId=${song.singerId}">${song.singerName}</a></li>
                        <li class="single-song_list_third_column">${song.songLength}</li>
                    </ul>
                </c:forEach>
            </ul>
            <nav style="text-align: center">
                <ul id="search_single-song_navigation_page" class="pagination">
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
    </c:otherwise>
</c:choose>


