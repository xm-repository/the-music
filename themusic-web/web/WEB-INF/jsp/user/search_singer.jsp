<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:choose>
    <c:when test="${fn:length(pageInfo.list) == 0}">
        <div id="search_singer_container">
            <p style="color:#666;text-align:center;font-size:30px;padding-top:90px;padding-bottom:60px;margin-left:130px;">
                抱歉，暂时没有找到相关条件的歌手<br/>
                TheMusic建议您：请检查输入的关键词是否有误或者过长。
            </p>
        </div>
    </c:when>
    <c:otherwise>
        <div id="search_singer_container">
            <c:forEach items="${pageInfo.list}" var="singer">
                <ul class="search_singer_list">
                    <li class="search_singer_list_first_column">
                        <!--歌手头像-->
                        <img class="search_singer_list_headpicture" src="/file/themusic/img/headPicture/singer/${singer.singerPicture}" title="${singer.singerName}"/>
                        <a href="/singer/singerIndex?&singerId=${singer.singerId}" title="${singer.singerName}" class="singer_name">${singer.singerName}</a>
                    </li>
                    <li class="search_singer_list_second_column"><span class="singer_sex">${singer.singerSex}</span></li>
                    <li class="search_singer_list_third_column"><span class="singer_album_nums">专辑：${singer.albumNums}</span></li>
                    <li class="search_singer_list_fourth_column"><span class="singer_fans_nums">粉丝：${singer.fans}</span></li>
                </ul>
            </c:forEach>
            <nav style="text-align: center;">
                <ul id="search_singer_navigation_page" class="pagination">
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


