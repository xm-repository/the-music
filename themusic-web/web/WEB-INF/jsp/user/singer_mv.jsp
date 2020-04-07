<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="mv_container">
    <h1>MV${mvNums}</h1>
    <ul id="mv_list">
        <c:forEach items="${pageInfo.list}" var="mv" varStatus="c">
            <c:choose>
                <c:when test="${c.count%4 ==1}">
                    <li>
                        <div class="mv_img_container" title="${mv.mvName}" mvSrc="${mv.mvSrc}">
                            <img class="mv_img" src="/file/themusic/img/mv/${mv.mvPicture}"/>
                            <!--播放按钮特效-->
                            <i class="mv_play-img iconfont icon-icon-test"></i>
                        </div>
                        <h4 style="font-weight: normal;margin-top:10px;">${mv.mvName}</h4>
                        <p style="font-size:10px;margin-top:5px;color:gray;">${mv.singerName}</p>
                        <p><span>▶</span><span>${mv.mvClick}</span></p>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="right_li">
                        <div class="mv_img_container" title="${mv.mvName}" mvSrc="${mv.mvSrc}">
                            <img class="mv_img" src="/file/themusic/img/mv/${mv.mvPicture}"/>
                            <!--播放按钮特效-->
                            <i class="mv_play-img iconfont icon-icon-test"></i>
                        </div>
                        <h4 style="font-weight: normal;">${mv.mvName}</h4>
                        <p style="font-size:10px;margin-top:5px;color:gray;">${mv.singerName}</p>
                        <p><span>▶</span><span>${mv.mvClick}</span></p>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </ul>
    <nav style="clear:both;"></nav>
    <nav style="text-align: center;">
        <ul id="mv_list_navigation_page" class="pagination">
            <li checked="checked"><a href="#" pageNum="1">首页</a></li>
            <li><a href="#" pageNum="${pageInfo.prePage}">上一页</a></li>
            <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                <li><a href="#" pageNum="${num}">${num}</a></li>
            </c:forEach>
            <li><a href="#" pageNum="${pageInfo.nextPage}">下一页</a></li>
            <li><a href="#" pageNum="${pageInfo.pages}">尾页</a></li>
        </ul>
    </nav>
</div>
