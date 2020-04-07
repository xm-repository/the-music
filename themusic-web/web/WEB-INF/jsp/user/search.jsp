<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <!--搜索页面-->
    <link rel="stylesheet" type="text/css" href="/static/css/search.css"/>
    <!--单曲页面-->
    <link rel="stylesheet" type="text/css" href="/static/css/search_single-song.css"/>
    <!--mv页面-->
    <link rel="stylesheet" type="text/css" href="/static/css/search_mv.css"/>
    <!--歌手页面-->
    <link rel="stylesheet" type="text/css" href="/static/css/search_singer.css"/>
    <!--登录页面-->
    <link rel="stylesheet" href="/static/css/login.css">
    <!--已登录部分样式-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css"/>
    <script src="/static/layui/layui.js"></script>
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
    <input type="text" id="search" placeholder="搜索音乐、mv、歌手" value="${content}"/>
    <!--登陆-->
    <div id="login">
        <a id="btnLogin" href="javascript:void(0);" style="font-size:20px;position:relative;top:20px;">登陆</a>
    </div>
    <img id="serarc_background_img" src="/file/themusic/img/search/background_img.jpg"/>
    <!--搜索结果导航栏-->
    <ul id="search_navigationbar">
        <li style="margin-left:10px;"><a id="single_song" href="#">单曲</a></li>
        <li style="margin-left:70px;margin-top:5px;"><a href="#">MV</a></li>
        <li style="margin-left:70px;"><a href="#">歌手</a></li>
    </ul>
    <!--搜索结果-->
    <div id="search_content">

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


        $(document).ready(function(){
            isUserLogin();
            search();
            clickSearchNavigationBar();
            loadSingleSong();
        })



        //主页
        //搜索导航栏点击效果
        function clickSearchNavigationBar(){
            $("#search_navigationbar").on("click","a",function(e){
                e.preventDefault();
                //先将其他颜色去掉
                $("#search_navigationbar").find("a").css("color","black");
                //将点击的颜色变为绿色
                $(e.target).css("color","green");
                if($(e.target).text()=="单曲"){
                    loadSingleSong();
                }else if($(e.target).text()=="MV"){
                    loadMV();
                }else{
                    loadSinger();
                }
            })
        }
        //搜索
        function search(){
            $("#search").on("keydown",function(e){
                if(e.keyCode ==13){
                    //先将其他颜色去掉
                    $("#search_navigationbar").find("a").css("color","black");
                    //点击单曲
                    $("#single_song").css("color","green");
                    loadSingleSong();
                }
            })
        }
        //单曲页面
        //加载单曲页面
        function loadSingleSong(){
            //获取搜索内容
            var content=$("#search").val();
            $.ajax({
                method:"get",
                url:"/search/singleSong?songName="+content
            }).done(function(resp){
                $("#search_content").html(resp);
                clickSingleSongPageNums();
                playAddLikeDownLoadMusic();
            })
        }
        //单曲分页
        function  clickSingleSongPageNums(){
            $("#search_single-song_navigation_page").on("click",function(e){
                //取消默认事件
                e.preventDefault();
                //获取页数
                var pageNum=$(e.target).attr("pageNum");
                //获取搜索内容
                var content=$("#search").val();
                $.ajax({
                    method:"get",
                    url:"/search/singleSong?pageNum="+pageNum+"&pageSize=15&content="+content
                }).done(function(resp){
                    $("#search_content").html(resp);
                    clickSingleSongPageNums();
                    playAddLikeDownLoadMusic();
                })
            })
        }
        //播放,下载
        function playAddLikeDownLoadMusic() {
            //播放一首歌
            $(".single-song_list").on("click", ".single-song_play>a", function(e) {
                e.preventDefault();
                //先把歌曲添加到播放器
                var songIds = new Array();
                var songId = $($(e.target).parents("ul")[0]).attr("songId");
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
        //加载mv
        function loadMV(){
            //获取搜索内容
            var content=$("#search").val();
            $.ajax({
                method:"get",
                url:"/search/mv",
                data:{
                    "mvName":content
                }
            }).done(function(resp){
                $("#search_content").html(resp);
                clickMVListPageNums();
                mourseEnterMv();
            }).fail(function(){
                alert("查询mv失败");
            })
        }
        //mv分页
        function clickMVListPageNums(){
            $("#mv_list_navigation_page").on("click",function(e){
                //取消默认事件
                e.preventDefault();
                //获取页数
                var pageNum=$(e.target).attr("pageNum");
                //获取搜索内容
                var content=$("#search").val();
                $.ajax({
                    method:"get",
                    url:"/search/mv?pageNum="+pageNum+"&pageSize=16&mvName="+content
                }).done(function(resp){
                    $("#search_content").html(resp);
                    clickMVListPageNums();
                    mourseEnterMv();
                    window.scrollTo(0,0);
                })
            })
        }
        //鼠标进入、移出、点击mv
        //鼠标进入mv
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
                var imgPlay = $(e.target).parent().find("i").get(0);
                $(imgPlay).show().animate({
                        "left":75+"px",
                        "top":30+"px",
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
                        "top":45+"px",
                        "font-size":70+"px"},
                    100).fadeOut(100);
            }).on("click",function(e){
                var mvId =$(e.target).parent().attr("mvId");
                window.open("/mv/play?mvId="+mvId,"mv_index");
            })
        }
        //歌手页面
        //加载歌手
        function loadSinger(){
            //获取搜索内容
            var content=$("#search").val();
            $.ajax({
                method:"get",
                url:"/search/singer",
                data:{
                    "singerName":content
                }
            }).done(function(resp){
                $("#search_content").html(resp);
                clickSingerListPageNums();
                clickSingerImg();
            }).fail(function(){
                alert("查询歌手失败");
            })
        }
        //歌手分页
        function clickSingerListPageNums(){
            $("#search_singer_navigation_page").on("click","a",function(e){
                //取消默认事件
                e.preventDefault();
                //获取页数
                var pageNum=$(e.target).attr("pageNum");
                //获取搜索内容
                var content=$("#search").val();
                $.ajax({
                    method:"get",
                    url:"/search/singer?pageNum="+pageNum+"&pageSize=10&singerName="+content
                }).done(function(resp){
                    $("#search_content").html(resp);
                    clickSingerListPageNums();
                    clickSingerImg();
                    window.scrollTo(0,0);
                })
            })
        }
        //点击歌手头像
        function clickSingerImg(){
            $(".search_singer_list_headpicture").on("click",function(e){
                window.location=$(e.target).next().attr("href");
            })
        }
        //判断用户是否登录
        function isUserLogin(){
            $.ajax({
                method:"get",
                url:"/login/isLogin"
            }).done(function(resp){
                if(resp.code=="200"){
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
                        area:['600px','460px'],
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
                                    isUserLogin();
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
        //注销
        function loginOff(){
            $.ajax({
                method:"get",
                url:"/login/loginOff"
            }).done(function(){
                $("#login").html("<a id='btnLogin' href='#' style='font-size:20px;position:relative;top:20px;'>登陆</a>")
                //重新绑定登录事件
                clickLogin();
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
        //点击登陆页面
        function clickLogin(){
            $("#btnLogin").click(function(e){
                e.preventDefault();
                showLoginForm();
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
                $("#login-button").click(function(){
                    var formData = $("#loginInfo").serialize();
                    $.ajax({
                        method:"post",
                        url:"/login/login",
                        data:formData
                    }).done(function(resp){
                        if(resp.code == "200"){
                            layer.msg("登录成功",{
                                icon:1,
                                time:1000
                            },function(){
                                layer.close(index);
                                if(resp.data =="用户"){
                                    //替换登录成用户头像
                                    $.ajax({
                                        method:"get",
                                        url:"/login/loginSuccess"
                                    }).done(function (resp) {
                                        $("#login").html(resp);
                                        showOrHideSlideDownList();
                                    })
                                }else{
                                    //是管理员
                                    window.open("/admin/index");
                                }
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


