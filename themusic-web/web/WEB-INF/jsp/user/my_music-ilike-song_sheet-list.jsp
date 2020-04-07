<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--歌单列表-->
<table class="layui-table" lay-skin="line" style="width:1300px;margin-left:45px;">
    <colgroup>
        <col width="400">
        <col width="300">
        <col width="500">
        <col width="200">
    </colgroup>
    <thead>
    <tr style="height:60px;">
        <th>歌单</th>
        <th>曲目数</th>
        <th>创建人</th>
        <th>删除</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageInfo.list}" var="songSheet">
        <tr style="height:50px;" sheetId="${songSheet.sheetId}">
            <td><a href="/songsheet/index?sheetId=${songSheet.sheetId}">${songSheet.sheetName}</a></td>
            <td>${songSheet.songNums}</td>
            <td>${songSheet.user.userName}</td>
            <td><a href="javascript:void(0);"><i id="cancelLikeSongsheet" title="删除"  class="iconfont icon-icon7" style="font-size:25px;"></i></a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
