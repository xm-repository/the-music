<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/static/layui/css/layui.css">

    <link rel="stylesheet" href="/static/iconfont/iconfont.css/">
    <!--主页-->
    <link rel="stylesheet" href="/static/css/singer-index.css"/>
    <!--单曲页面-->
    <link rel="stylesheet" href="/static/css/singer_single-song.css"/>
    <!--mv页面-->
    <link rel="stylesheet" href="/static/css/singer_mv.css"/>
    <!--登录弹窗-->
    <link rel="stylesheet" href="/static/css/login.css">
    <!--用户头像-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css">

    <style>
        #singerInfo p{
            margin-bottom:0px;
            margin-left:20px;
        }
    </style>
</head>
<body>
<!--容器-->
<div id="container">
    <!--标志图片-->
    <img id="foundMusic_logle" src="/file/themusic/img/logle/logle.png"/>
    <!--导航栏-->
    <ul id="navigationbar">
        <li><a href="/home/index">发现音乐</a></li>
        <li><a href="/myMusic/index">我的音乐</a></li>
    </ul>
    <input type="text" id="search" placeholder="搜索歌曲、MV、歌手"/>
    <!--登陆-->
    <div id="login">
        <a id="btnLogin" href="#" style="font-size:20px;position:relative;top:20px;">登陆</a>
    </div>
    <!--分割线-->
    <hr style="width:100%;"/>
    <div id="content_container">
        <!--头部-->
        <div id="content_head">
            <!--歌手头像-->
            <img id="singer_headpicture" src="/file/themusic/img/headPicture/singer/${singer.singerPicture}" />
            <!--歌手信息-->
            <div id="singer_info">
                <!--歌手名字-->
                <h1 style="font-size:35px;font-weight:normal;margin-top:70px;">${singer.singerName}</h1>
                <!--其他信息begin-->
                <p style="margin-top:20px;">
                    <span>国籍：${singer.singerCountry}</span> <span>出生地：${singer.singerArea}</span> <span>生日：<fmt:formatDate value="${singer.singerBirth}" pattern="MM月dd日"/></span> <span>身高：${singer.singerHeight}cm</span> <span>体重：${singer.singerWeight}kg</span> <span>血型：${singer.bloodType}</span>... <a id="showAllSingerInfo">【更多】</a>
                </p>
                <!--其他信息end-->
                <!--其他信息end-->
                <div id="singerInfo" style="width:480px;height:420px;background-color:white;overflow:auto;word-break: break-all;position:absolute;right:320px;top:160px;display:none;z-index: 1;">
                    <p style="margin-top:20px;">国籍：${singer.singerCountry}</p>
                    <p>出生地：${singer.singerArea}</p>
                    <p>生日：<fmt:formatDate value="${singer.singerBirth}" pattern="MM月dd日"/></p>
                    <p>身高：${singer.singerHeight}</p>
                    <p>体重：${singer.singerWeight}</p>
                    <p>血型：${singer.bloodType}</p>
                    <p>星座：${singer.constellation}</p>
                    <p>简介:</p>
                    <p style="margin-bottom:20px;">${singer.synopsis}</p>
                </div>
                <!--歌曲、MV-->
                <ul id="song_mv_ul">
                    <li style="border-right:1px solid #696969;"><a id="song_mv_ul_song">单曲 ${singer.songNums}</a></li>
                    <li style="padding-left:20px;"><a id="song_mv_ul_mv">MV ${singer.mvNums}</a></li>
                </ul>
            </div>
            <!--歌手信息end-->
        </div>
        <!--头部end-->

        <!--内容-->
        <div id="content">

        </div>
    </div>
</div>

<script>
    layui.use(['element','table','layer','form', 'layedit', 'laydate'], function() {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var count;//记录总记录条数
        var layedit = layui.layedit;
        var laydate = layui.laydate;

        $(document).ready(function(e){
            isLogin();
            loadSingleSongList();
            clickSingleSong();
            clickMV();
            showOrHideSingerInfo();
        })




        //判断是否登录并显示用户信息
        function isLogin(){
            $.ajax({
                method:"get",
                url:"/login/isLogin"
            }).done(function(isLogin){
                if(isLogin.code == 200){
                    //替换登录成用户头像
                    $.ajax({
                        method:"get",
                        url:"/login/loginSuccess"
                    }).done(function (resp) {
                        $("#login").html(resp);
                        goToUpdateUserInfo();
                        loginOff();
                        showOrHideSlideDownList();
                    })
                }else{
                    clickLogin();
                }
            })
        }
        //点击登陆页面
        function clickLogin(){
            $("#btnLogin").click(function(e){
                e.preventDefault();
                showLoginForm();
            })
        }
        //显示(隐藏)下拉列表
        function showOrHideSlideDownList(){
            $("#userinfo").on("mouseenter",function(e){
                $("#slide_down_list").slideDown(100);
                //改变箭头方向
                $("#userinfo").find("span").text("▲");
            }).on("mouseleave",function(e){
                $("#slide_down_list").slideUp(100);
                //改变箭头方向
                $("#userinfo").find("span").text("▼");
            })
        }
        //注销
        function loginOff(){
            $("#loginOff").click(function(){
                $.ajax({
                    method:"get",
                    url:"/login/loginOff"
                }).done(function(){
                    $("#login").html("<a id='btnLogin' href='#' style='font-size:20px;position:relative;top:20px;'>登陆</a>")
                    //重新绑定登录事件
                    clickLogin();
                })
            })
        }
        //显示登陆页面
        function showLoginForm(){
            //请求登录页面
            $.ajax({
                method:"get",
                url:"/login/login"
            }).done(function(resp){
                //显示登陆页面
                var index = layer.open({
                    type:1,
                    title:'用户登录',
                    content:resp,
                    area:['480px','520px'],
                    skin:'layui-layer-molv',
                    scrollbar:false,
                    success:function(index,layero){
                        $(":focus").blur();
                    }
                })
                //登录验证
                $("button").click(function(){
                    var formData = $("#loginInfo").serialize();
                    $.ajax({
                        method:"post",
                        url:"/login/login",
                        data:formData
                    }).done(function(resp){
                        if(resp.code=="200"){
                            layer.msg("登录成功",{
                                icon:1,
                                time:1000
                            },function(){
                                layer.close(index);
                                //替换登录成用户头像
                                $.ajax({
                                    method:"get",
                                    url:"/login/loginSuccess"
                                }).done(function (resp) {
                                    $("#login").html(resp);
                                    goToUpdateUserInfo();
                                    loginOff();
                                    showOrHideSlideDownList();
                                })
                            });

                        }else{
                            layer.msg("用户名或密码错误!",{
                                icon:2,
                                time:1000
                            })
                        }
                    })
                })
                //回车登录
                keydownToLogin();
            })
        }

        //主页
        //展示/隐藏歌手全部信息
        function showOrHideSingerInfo(){
            $("#showAllSingerInfo").on("click",function(e){
                e.preventDefault();
                var displayAttr = $("#singerInfo").css("display");
                console.log(displayAttr);
                if(displayAttr =="none"){
                    $("#singerInfo").css("display","block");
                }else{
                    $("#singerInfo").css("display","none");
                }
            })
        }
        //点击单曲
        function clickSingleSong(){
            $("#song_mv_ul_song").click(function(e){
                e.preventDefault();
                loadSingleSongList();
            })
        }
        //点击mv
        function clickMV(){
            $("#song_mv_ul_mv").click(function(e){
                e.preventDefault();
                loadMVList();
            })
        }
        //单曲页面
        //加载单曲列表首页
        function loadSingleSongList(){
            $.ajax({
                method:"get",
                url:"/song/singer/singleSongList?singerId=${singer.singerId}"
            }).done(function(resp){
                $("#content").html(resp);
                clickSingleSongPageNums();
                playAddLikeDownLoadMusic();
            }).fail(function(){
                alert("加载单曲首页失败!")
            })
        }
        //单曲分页
        function clickSingleSongPageNums(){
            $("#single-song_list_navigation_page").on("click",function(e){
                //取消默认事件
                e.preventDefault();
                //获取页数
                var pageNum=$(e.target).attr("pageNum");
                $.ajax({
                    method:"get",
                    url:"/song/singer/singleSongList?pageNum="+pageNum+"&pageSize=12&singerId=${singer.singerId}"
                }).done(function(resp){
                    $("#content").html(resp);
                    clickSingleSongPageNums();
                    playAddLikeDownLoadMusic();
                })
            })
        }
        //播放,下载
        function playAddLikeDownLoadMusic() {
            //播放一首歌
            $("#singer_singer-song-table").on("click", ".single-song_play>a", function(e) {
                e.preventDefault();
                //先把歌曲添加到播放器
                var songIds = new Array();
                var songId = $($(e.target).parents("tr")[0]).attr("songId");
                songIds[0] = songId;
                //转成json格式
                songIds= JSON.stringify(songIds);
                $.ajax({
                    method:"POST",
                    url:"/player/addSong",
                    data:songIds,
                    contentType:"application/json"
                }).done(function(resp){
                    if(resp.code == "200"){
                        //添加成功，打开播放页面
                        window.open("/player/index","player_index");
                    }
                }).fail(function(){
                    alert("添加歌曲到播放器失败")
                })
            })
        }
        //mv页面
        //加载mv列表
        function loadMVList(){
            $.ajax({
                method:"get",
                url:"/mv/singer/mvList?singerId=${singer.singerId}"
            }).done(function(resp){
                $("#content").html(resp);
                clickMVListPageNums();
                mourseEnterMv();
            }).fail(function(){
                alert("加载mv首页失败！")
            })
        }
        //鼠标进入、移出、点击mv
        function mourseEnterMv(){
            $("#mv_list").find("div").on("mouseenter",function(e){
                //视频图片
                var img = $(e.target).parent().find("img").get(0);
                var widthImg = $(img).width();
                var heightImg = $(img).height();
                $(img).animate({
                        "width":320+"px",
                        "height":220+"px",
                        "left":-20+"px",
                        "top":-20+"px"},
                    100);
                //播放图片
                //播放图片
                var imgPlay = $(e.target).parent().find("i").get(0);
                $(imgPlay).show().animate({
                        "left":55+"px",
                        "top":26+"px",
                        "font-size":90+"px"},
                    100);
            }).on("mouseleave",function(e){
                //视频图片
                var img = $(e.target).parent().find("img").get(0);
                $(img).animate({
                    "width":280+"px",
                    "height":180+"px",
                    "left":0+"px",
                    "top":0+"px"
                },100);
                //播放图片
                var imgPlay = $(e.target).parent().find("i").get(0);
                $(imgPlay).animate({
                        "left":95+"px",
                        "top":55+"px",
                        "font-size":70+"px"},
                    100).fadeOut(100);
            }).on("click",function(e){
                var mvSrc,mvName;
                if($(e.target).prop("tagName")!="DIV"){
                    mvSrc =$(e.target).parent().attr("mvSrc");
                    mvName =$(e.target).parent().attr("title");
                }else{
                    mvSrc =$(e.target).attr("mvSrc");
                    mvName =$(e.target).attr("title");
                }
                window.open("/mv/play?mvSrc="+mvSrc+"&mvName="+mvName,"mv_index");
            })
        }
        //mv分页
        function clickMVListPageNums(){
            $("#mv_list_navigation_page").on("click",function(e){
                //取消默认事件
                e.preventDefault();
                //获取页数
                var pageNum=$(e.target).attr("pageNum");
                $.ajax({
                    method:"get",
                    url:"/mv/singer/mvList?pageNum="+pageNum+"&pageSize=16&singerId=${singer.singerId}"
                }).done(function(resp){
                    $("#content").html(resp);
                    clickMVListPageNums();
                    mourseEnterMv();
                    window.scrollTo(0,0);
                })
            })
        }
        //点击头像修改个人信息
        function goToUpdateUserInfo(){
            $("#userinfo-userPicture").on("click",function(e){
                //弹窗显示
                $.ajax({
                    method:"GET",
                    url:"/user/updateUserInfo"
                }).done(function(resp){
                    var index = layer.open({
                        type:1,
                        title:'修改用户信息',
                        content:resp,
                        area:['650px','460px'],
                        skin:'layui-layer-molv',
                        scrollbar:false
                        // cancel:function(){
                        //     clickLogin();
                        // }
                    })
                    clickUserImg();
                    cancleSubmit();
                    form.render();
                    $("#btnSubmit").on("click",function(){
                        //提交表单
                        var formData = new FormData($("#formData").get(0));
                        $.ajax({
                            method:"POST",
                            url:"/user/updateUserInfo",
                            data:formData,
                            processData:false,
                            contentType:false
                        }).done(function(resp){
                            if(resp.code=="200"){
                                layer.msg('修改成功',{icon:1,time:1000},function(){
                                    layer.close(index);
                                    isLogin();
                                });
                            }
                        }).fail(function(){
                            alert("修改失败");
                        })
                    })
                })
            })
        }

        //修改用户信息页面
        //点击图片、预览图片
        function clickUserImg(){
            $("#user_img").on("click",function(){
                $("#uploadImg").get(0).click();
            })
            //预览图片
            $("#uploadImg").on("change",function(e){
                var file=e.target.files[0];
                $("#pictureSrc").val(file.name);
                var reader=new FileReader();
                reader.readAsDataURL(file);
                reader.onload=function(e){
                    $("img[id='pic']").get(0).src=e.target.result;
                }
            })
        }
        //取消表单提交
        function cancleSubmit(){
            $("#formData").on("submit",function(e){
                e.preventDefault();
            })
        }
        //回车登录
        function keydownToLogin(){
            $("#username").on("keydown",function(e){
                if(e.keyCode==13){
                    $("#login-button").click();
                }
            })
            $("#password").on("keydown",function(e){
                if(e.keyCode==13){
                    $("#login-button").click();
                }
            })
        }
    });


</script>
</body>
</html>


