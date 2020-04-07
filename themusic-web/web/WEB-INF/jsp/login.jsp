
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>登陆</title>
    <link rel="stylesheet" href="/static/iconfont/iconfont.css"/>
    <script src="/static/js/jquery-3.4.1.min.js"></script>

</head>
<body>
    <div id="login-container">
        <form id="loginInfo">
            <h1>登录</h1>
            <h4 id="username_title">用户名</h4>
            <input id="username" name=loginName type="text" placeholder="请输入用户名"/>
            <i class="iconfont icon-user_name"></i>
            <h4 id="password_title">密码</h4>
            <input id="password" name="password" type="password" placeholder="请输入密码"/>
            <i class="iconfont icon-password"></i>
            <!--注册-->
            <div style="text-align: right;">
                <a href="/registe/index" target="_blank">没有账号?>></a>
            </div>
        </form>
        <!--登陆按钮-->
        <button id="login-button">登陆</button>
    </div>
<script>
    $(document).ready(function(){
        focusUsername();
        focusPassword();
    })
    //用户名输入框获取、失去焦点
    function focusUsername(){
        $("#username").focus(function(e){
            $(".icon-user_name").css("color","violet");
        }).blur(function(e){
            $(".icon-user_name").css("color","gray");
        })
    }
    //密码输入框获取、失去焦点
    function focusPassword(){
        $("#password").focus(function(e){
            $(".icon-password").css("color","violet");
        }).blur(function(e){
            $(".icon-password").css("color","gray");
        })
    }

</script>
</body>
</html>

