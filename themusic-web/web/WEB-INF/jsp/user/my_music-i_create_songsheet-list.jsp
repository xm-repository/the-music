<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--按钮-->
<ul id="my_music-i_create_songsheet-buttons" style="margin-left:50px;margin-top:20px;">
    <li><button id="newSongSheet" class="btn btn-default">新建歌单</button></li>
</ul>
<!--歌单列表-->
<table class="layui-table" lay-skin="line" style="width:1299px;margin-left:50px;">
    <colgroup>
        <col width="400">
        <col width="300">
        <col width="300">
        <col width="200">
    </colgroup>
    <thead>
    <tr style="height:60px;">
        <th>歌单</th>
        <th>曲目数</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${songSheets}" var="songSheet">
        <tr style="height:50px;" sheetId="${songSheet.sheetId}">
            <td><a href="/songsheet/index?sheetId=${songSheet.sheetId}">${songSheet.sheetName}</a></td>
            <td>${songSheet.songNums}</td>
            <td><a href="javascript:void(0);"><i title="删除" class="iconfont icon-icon7" style="font-size:25px;"></i></a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

