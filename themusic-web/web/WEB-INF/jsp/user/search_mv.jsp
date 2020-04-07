<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:choose>
    <c:when test="${fn:length(pageInfo.list) == 0}">
        <div id="mv_container">
            <p style="color:#666;text-align:center;font-size:30px;padding-top:90px;padding-bottom:60px;margin-left:110px;">
                抱歉，暂时没有找到相关条件的MV<br/>
                TheMusic建议您：请检查输入的关键词是否有误或者过长。
            </p>
        </div>
    </c:when>
    <c:otherwise>
        <div id="mv_container">
            <ul id="mv_list">
                <c:forEach items="${pageInfo.list}" var="mv">
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
    </c:otherwise>
</c:choose>


