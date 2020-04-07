<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--专辑列表-->
<table class="layui-table" lay-skin="line" style="width:1300px;margin-left:45px;">
    <colgroup>
        <col width="400">
        <col width="300">
        <col width="500">
        <col width="200">
    </colgroup>
    <thead>
    <tr style="height:60px;">
        <th>专辑</th>
        <th>曲目数</th>
        <th>歌手</th>
        <th>删除</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageInfo.list}" var="album">
        <tr style="height:50px;" albumId="${album.albumId}">
            <td><a href="/album/index?albumId=${album.albumId}">${album.albumName}</a></td>
            <td>${album.songNums}</td>
            <td><a href="/singer/singerIndex?singerId=${album.singer.singerId}">${album.singer.singerName}</a></td>
<%--            <td>--%>
<%--                <fmt:formatDate value="${album.publishDate}" type="Date"/>--%>

<%--            </td>--%>
            <td><a href="javascript:void(0);"><i title="删除"  class="iconfont icon-icon7" style="font-size:25px;"></i></a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

