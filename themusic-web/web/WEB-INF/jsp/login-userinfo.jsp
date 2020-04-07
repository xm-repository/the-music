
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="userinfo" style="margin-top:10px;width:140px;">
    <img id="userinfo-userPicture" src="/file/themusic/img/headPicture/user/${user.userPicture}"/>
    <p>${user.userName}<span>▼</span></p>
    <!--下拉选项列表-->
    <ul id="slide_down_list">
        <li><a id="loginOff" href="javascript:void(0);"  style="font-size:20px;">注销</a></li>
    </ul>
</div>
