<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:choose>
    <c:when test="${fn:length(pageInfo.list) ==0}">
        <p style="color:#666;text-align:center;font-size:30px;padding-top:90px;padding-bottom:60px;">
            抱歉，暂时没有找到相关条件的歌手<br/>
            TheMusic建议您：请检查输入的关键词是否有误或者过长。
        </p>
    </c:when>
    <c:otherwise>
        <ul id="singer_list_ul">
            <c:forEach items="${pageInfo.list}" var="singer">
                <li><img src="/file/themusic/img/headPicture/singer/${singer.singerPicture}" title="${singer.singerName}"/></br><a href="/singer/singerIndex?singerId=${singer.singerId}" title="${singer.singerName}">${singer.singerName}</a></li>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>


