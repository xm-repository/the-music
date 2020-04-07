<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<div id="mv_container">
    <ul id="mv_list">
        <c:forEach items="${mvs}" var="mv">
            <li>
                <div class="mv_img_container" title="${mv.mvName}" mvsrc="${mv.mvSrc}" mvId="${mv.mvId}">
                    <img class="mv_img" src="/file/themusic/img/mv/${mv.mvPicture}"/>
                    <!--播放按钮特效-->
                    <i class="mv_play-img iconfont icon-icon-test"></i>
                </div>
                <h4 style="font-weight: normal;margin-top:10px;">${mv.mvName}</h4>
                <p style="font-size:10px;margin-top:5px;color:gray;">${mv.singerName}</p>
                <p><span>▶</span><span>${mv.mvClick}</span></p>
            </li>
        </c:forEach>
        <!--这个只是用来解决浮动的样式混乱的问题-->
        <nav style="clear:both;"></nav>
        <!--这个只是用来解决浮动的样式混乱的问题-->
    </ul>
</div>
