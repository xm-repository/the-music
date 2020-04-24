<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ul id="mv_list">
    <c:forEach items="${pageInfo.list}" var="mv">
        <li>
            <div class="mv_img_container" title="${mv.mvName}" mvsrc="${mv.mvSrc}" mvId="${mv.mvId}">
                <img class="mv_img" src="/file/themusic/img/mv/${mv.mvPicture}"/>
                <!--播放按钮特效-->
                <i class="mv_play-img iconfont icon-icon-test"></i>
            </div>
            <h4 style="font-weight: normal;margin-top:10px;"><a href="/song/index?songId=${mv.songId}" target="_blank">${mv.mvName}</a></h4>
            <p style="font-size:10px;margin-top:5px;color:gray;"><a href="/singer/singerIndex?singerId=${mv.singerId}" target="_blank">${mv.singerName}</a></p>
            <p><span>▶</span><span>${mv.mvClick}</span></p>
        </li>
    </c:forEach>
    <!--这个只是用来解决浮动的样式混乱的问题-->
    <nav style="clear:both;"></nav>
    <!--这个只是用来解决浮动的样式混乱的问题-->
</ul>