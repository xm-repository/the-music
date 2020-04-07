<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<ul id="mv_list">
    <c:forEach items="${pageInfo.list}" var="mv" varStatus="c">
        <c:choose>
            <c:when test="${c.count%4 ==1}">
                <li mvId="${mv.mvId}" style="position:relative;" >
                    <div class="mv_img_container" title="${mv.mvName}" mvSrc="${mv.mvSrc}" mvId="${mv.mvId}" >
                        <img class="mv_img" src="/file/themusic/img/mv/${mv.mvPicture}"/>
                        <!--播放按钮特效-->
                        <i class="mv_play-img iconfont icon-icon-test"></i>
                    </div>
                    <h4 style="font-weight: normal;margin-top:10px;">${mv.mvName}</h4>
                    <p style="font-size:10px;margin-top:5px;color:gray;">${mv.singerName}</p>
                    <p><span>▶</span><span>${mv.mvClick}</span></p>
                    <a title="删除" style="position:absolute;left:250px;top:190px;"><i id="cancelLikeMv" class="iconfont icon-icon7" style="font-size:20px;"></i></a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="right_li" mvId="${mv.mvId}" style="position:relative;">
                    <div class="mv_img_container" title="${mv.mvName}" mvSrc="${mv.mvSrc}" mvId="${mv.mvId}">
                        <img class="mv_img" src="/file/themusic/img/mv/${mv.mvPicture}"/>
                        <!--播放按钮特效-->
                        <i class="mv_play-img iconfont icon-icon-test"></i>
                    </div>
                    <h4 style="font-weight: normal;margin-top:10px;">${mv.mvName}</h4>
                    <p style="font-size:10px;margin-top:5px;color:gray;">${mv.singerName}</p>
                    <p><span>▶</span><span>${mv.mvClick}</span></p>
                    <a title="删除" style="position:absolute;left:250px;top:190px;"><i id="cancelLikeMv" class="iconfont icon-icon7" style="font-size:20px;"></i></a>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</ul>

