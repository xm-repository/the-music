<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<h3 id="good-comment_container-title" style="font-weight: normal;">精彩评论</h3>
<hr style="margin-top:20px;visibility: hidden;"/>
<c:choose>
    <c:when test="${fn:length(pageInfo.list)==0}">
        暂无精彩评论，期待您的神评！！!
    </c:when>
    <c:otherwise>
        <!--所有用户评论-->
        <!--第一个用户-->
        <c:forEach items="${pageInfo.list}" var="comment">
            <div class="others-comment_container" userId="${comment.userId}" scommentId="${comment.scommentId}">
                <img src="/file/themusic/img/headPicture/user/${comment.user.userPicture}"/>
                <div class="others-comment_info_container">
                    <h4 style="margin-top:15px;">${comment.user.userName}</h4><c:if test="${comment.replyUserName != null}"><a>@${comment.replyUserName}</a></c:if>
                    <div class="others-comment_content">
                            ${comment.content}
                    </div>
                    <div class="others-comment_click-good_comment">
                        <span style="margin-left:20px;padding-right:480px;color:gray;"><fmt:formatDate value="${comment.commentTime}" type="both"/></span>
                        <c:choose>
                            <c:when test="${comment.likeCommentUserId == null}">
                                <a href="#" class="likeOrCancelLikeComment"><i class="iconfont icon-dianzan" style="font-size:20px;"></i><span>${comment.scommentClick}</span></a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" clicked="clicked" class="likeOrCancelLikeComment" ><i class="iconfont icon-like-b" style="font-size:20px;"></i><span>${comment.scommentClick}</span></a>
                            </c:otherwise>
                        </c:choose>
                        <a href="#" class="goToComment"><i class="iconfont icon-pinglun" style="font-size:20px;"></i><span>${comment.count}</span></a>
                    </div>
                </div>
                <!--回复评论-->
                <div class="reply_comment" style="margin-left:75px;margin-top:20px;margin-bottom:20px;width:700px;height:150px;clear:both;display:none;">
                    <textarea class="replay_comment_content" style="width:700px;height:100px;background-color:#f7f7f7;"></textarea>
                    <button class="btnCancleReplayComment" style="width:70px;height:28px;float:right;margin-right:10px;">取消</button>
                    <button class="btnReplayComment" style="width:70px;height:28px;float:right;margin-right:10px;background-color:#31c27c;">回复</button>
                </div>
                <!--这个只是用来解决浮动的样式混乱的问题-->
                <nav style="clear:both;"></nav>
                <!--这个只是用来解决浮动的样式混乱的问题-->
            </div>
        </c:forEach>
        <nav style="width:800px;font-size:16px;text-align: center">
            <ul id="song-play_good-comments_navigation_page" class="pagination">
                <li><a href="#" pageNum="1">首页</a></li>
                <li><a href="#" pageNum="${pageInfo.prePage}">上一页</a></li>
                <c:forEach items="${pageInfo.navigatepageNums}" var="num">
                    <li><a href="#" pageNum="${num}">${num}</a></li>
                </c:forEach>
                <li><a href="#" pageNum="${pageInfo.nextPage}">下一页</a></li>
                <li><a href="#" pageNum="${pageInfo.pages}">尾页</a></li>
            </ul>
        </nav>
    </c:otherwise>
</c:choose>


