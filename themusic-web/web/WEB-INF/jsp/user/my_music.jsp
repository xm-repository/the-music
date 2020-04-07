
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/static/layui/css/layui.css"/>
    <link rel="stylesheet" href="/static/iconfont/iconfont.css"/>
    <!--主页样式-->
    <link rel="stylesheet" href="/static/css/my_music.css"/>
    <!--登录页面-->
    <link rel="stylesheet" href="/static/css/login.css">
    <!--已登录部分样式-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css"/>
    <!--我喜欢页面-->
    <link rel="stylesheet" href="/static/css/my_music-ilike.css"/>
    <!--我喜欢-单曲页面-->
    <link rel="stylesheet" href="/static/css/my_music-ilike-single_song.css"/>
    <!--我喜欢-mv页面-->
    <link rel="stylesheet" href="/static/css/my_music-ilike-mv.css"/>
    <!--我创建的歌单-新建歌单样式-->
    <link rel="stylesheet" href="/static/css/my_music-i_create-new_songsheet.css"/>
    <!--调整laypage大小-->
    <link rel="stylesheet" href="/static/css/solute/laypage-solute.css"/>
    <script src="/static/layui/layui.js"></script>
</head>
<body>
<!--容器-->
<div id="container">
    <!--标志图片-->
    <img id="foundMusic_logle" src="/file/themusic/img/logle/logle.png"/>
    <!--导航栏-->
    <ul id="navigationbar">
        <li style="margin-left:30px;"><a href="/home/index">发现音乐</a></li>
        <li style="background-color:green;"><a href="/myMusic/index">我的音乐</a></li>
    </ul>

    <input type="text" id="search" placeholder="搜索歌曲、MV、歌手"/>
    <!--登陆-->
    <div id="login">
        <a id="btnLogin" href="#" style="font-size:20px;position:relative;top:20px;">登陆</a>
    </div>
    <hr style="width:100%;margin-bottom:0px;"/>

    <!--头部-->
    <div id="my_music_head">
        <img id="background_img" src="/file/themusic/img/my_music/background_img.jpeg" />
        <!--用户头像-->
        <img id="user_head_picture" src="/file/themusic/img/headPicture/user/default.jpg"/>
        <!--用户名字-->
        <h1 id="user_name">未知</h1>
        <!--导航栏-->
        <ul id="my_music_navigationbar">
            <li><a href="javascript:void(0);" style="color:green;">我喜欢</a></li>
            <li><a href="javascript:void(0);">我创建的歌单</a></li>
        </ul>
    </div>
    <!--头部结束-->
    <!--内容-->
    <div id="content_container">

    </div>
</div>

<script>
    layui.use(['element','table','layer','form', 'layedit', 'laydate'], function() {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        var table = layui.table;
        var laypage = layui.laypage;
        var layer = layui.layer;
        var form = layui.form;
        var count;//记录总记录条数
        var layedit = layui.layedit;
        var laydate = layui.laydate;

        $(document).ready(function(){
            isUserLogin();
            search();
            clickLogin();
            clickMyMusicNavigation();

        })







        //我的音乐页面
        //点击我的音乐导航栏

        //搜索
        function search(){
            $("#search").on("keydown",function(e){
                if(e.keyCode ==13){
                    //获取内容
                    var content = $(e.target).val();
                    window.location="/search/index?content="+content;
                }
            })
        }
        //判断用户是否登录
        function isUserLogin(){
            $.ajax({
                method:"get",
                url:"/login/isLogin"
            }).done(function(resp){
                if(resp.code=="200"){
                    showLoginInfo();
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
                    //默认加载我喜欢-单曲页面
                    loadILikeIndex();
                    loadILikeSingleSongIndex();
                }else{
                    //显示未登陆页面
                    showNotLogin();
                }
            })
        }
        //登录
        function clickLogin(){
            $("#btnLogin").click(function(e){
                e.preventDefault();
                showLoginForm();
            })
        }
        //立即登录按钮
        function clickBtnLoginRightNow(){
            $("#btnLoginRightNow").click(function(){
                showLoginForm();
            })
        }
        //显示未登录页面
        function showNotLogin(){
            //显示未登录页面
            //先清空
            $("#my_music_head").remove();
            $("#content_container").remove();
            $.ajax({
                method:"GET",
                url:"/myMusic/notLogin"
            }).done(function(resp){
                $("#container").append(resp);
                clickBtnLoginRightNow();
            }).fail(function(resp){
                layer.alert(resp, function(index){
                    layer.close(index);
                });
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
                layui.use('layer', function(){
                    var layer = layui.layer;
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
                                        //重新进入页面
                                        window.location=window.location;
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
                });
            })
        }
        //显示已登录的用户信息
        function showLoginInfo(){
            $.ajax({
                method:"GET",
                url:"/user/userInfo"
            }).done(function(resp){
                //显示用户信息
                //头像
                $("#user_head_picture").attr("src","/file/themusic/img/headPicture/user/"+resp.data.userPicture);
                //昵称
                $("#user_name").text(resp.data.userName);
            }).fail(function(resp){
                alert("发送请求失败!")
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
                    //显示未登陆页面
                    showNotLogin();
                })
            })
        }
        //我的音乐页面
        //点击我的音乐导航栏
        function clickMyMusicNavigation(){
            $("#my_music_navigationbar").on("click","a",function(e){
                e.preventDefault();
                //先把所有颜色去掉
                var $as = $(e.target).parents("#my_music_navigationbar").find("a");
                $as.css("color","white");
                var $a = $(e.target);
                $a.css("color","green");
                //显示对应页面
                var targetContent = $a.text();
                if(targetContent == "我喜欢"){
                    loadILikeIndex();
                }else if(targetContent =="我创建的歌单"){
                    loadMyCreateSongSheetIndex();
                }
            })
        }
        //加载我喜欢页面
        function loadILikeIndex(){
            $.ajax({
                method:"get",
                url:"/myMusic/ilike"
            }).done(function(resp){
                $("#content_container").html(resp);
                clickILikeNavigationbar();
                loadILikeSingleSongIndex();
            })
        }
        //加载我创建的歌单页面
        function loadMyCreateSongSheetIndex(){
            $.ajax({
                method:"get",
                url:"/myMusic/icreate/songSheet"
            }).done(function(resp){
                $("#content_container").html(resp);
                loadMyCreateSongSheetList();
            }).fail(function(){
                alert("加载我创建歌单失败");
            })
        }
        //我创建的歌单分页
        function loadMyCreateSongSheetList(){
            //显示个歌单列表
            var pageNum = $("#my_music-i_create-songsheet").attr("pageNum");
            var pageSize = $("#my_music-i_create-songsheet").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/myMusic/icreate/songSheetList?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#my_music-i_create-songsheet").html(resp);
                newSongSheet();
                dropSongSheet();

                //渲染分页
                //获取分页总条目数量
                var songSheetCount;
                $.ajax({
                    method:"GET",
                    url:"/myMusic/icreate/songSheetCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    songSheetCount = resp.data;
                    laypage.render({
                        elem:"my_music-i_create-songsheet-page",
                        count:songSheetCount,
                        curr:pageNum,
                        limit:pageSize,
                        layout:['prev', 'page', 'next','count'],
                        prev:"上一页",
                        next:"下一页",
                        first:"首页",
                        last:"尾页",
                        jump:function(obj,first){
                            //无论是否是第一次，都需要判断是否隐藏分页栏
                            if(songSheetCount<=obj.limit){
                                $(".layui-laypage").css("visibility","hidden");
                            }else{
                                $(".layui-laypage").css("visibility","visible");
                            }
                            //页码变化
                            if(!first){
                                $("#my_music-ilike-song_sheet").attr("pageNum",obj.curr);
                                $("#my_music-ilike-song_sheet").attr("pageSize",obj.limit);
                                loadMyCreateSongSheetList();
                            }
                            return false;
                        }
                    })
                })
            })
        }

        //我喜欢页面
        //点击我喜欢页面导航栏
        function clickILikeNavigationbar(){
            $("#my_music-ilike-navigationbar").on("click","a",function(e){
                e.preventDefault();
                //先把所有颜色去掉
                var $as = $(e.target).parents("#my_music-ilike-navigationbar").find("a");
                $as.css("color","black");
                var $a = $(e.target);
                $a.css("color","green");
                //显示对应页面
                var targetContent = $a.text();
                if(targetContent == "单曲"){
                    loadILikeSingleSongIndex();
                }else if(targetContent == "歌单"){
                    loadILikeSongSheetIndex();
                }else if(targetContent == "专辑"){
                    loadILikeAlbumIndex();
                }else{
                    loadILikeMVIndex();
                }
            })
        }

        //我喜欢-单曲页面
        //加载我喜欢-单曲首页页面
        function loadILikeSingleSongIndex(){
            $.ajax({
                method:"GET",
                url:"/myMusic/ilike/singleSong"
            }).done(function(resp){
                $("#my_music-ilike-container").html(resp);
                loadILikeSingleSongList();
            })
        }

        //取消收藏一首歌曲
        function cancelLikeSong(){
            $("tbody").on("click","#cancelLikeSong",function(e){
                layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
                    //获取当前播放歌曲的id
                    var songIds = new Array();
                    var songId = $($(e.target).parents("tr").get(0)).attr("songId");
                    songIds[0] = songId;
                    var likeSongDTO = new Object();
                    likeSongDTO.songIds =songIds;
                    likeSongDTO.likeSong = 0;
                    likeSongDTO = JSON.stringify(likeSongDTO);
                    //操作数据库
                    $.ajax({
                        method:"POST",
                        url:"/song/likeOrCancelLikeSong",
                        data:likeSongDTO,
                        contentType:"application/json"
                    }).done(function(resp){
                        if(resp.code="200"){
                            layer.close(index);
                            loadILikeSingleSongList();
                            layer.msg('删除成功',{time:500});
                        }
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                });
            })

        }
        //我喜欢-单曲分页
        function loadILikeSingleSongList(){
            //显示Mv列表
            var pageNum = $("#my_music-ilike-single_song").attr("pageNum");
            var pageSize = $("#my_music-ilike-single_song").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/myMusic/ilike/singleSongList?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#my_music-ilike-single_song").html(resp);
                playListSong();
                playAddLikeDownLoadMusic();
                cancelLikeSong();
                //渲染分页
                //获取分页总条目数量
                var songCount;
                $.ajax({
                    method:"GET",
                    url:"/myMusic/ilike/singleSongCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    songCount = resp.data;
                    laypage.render({
                        elem:"my_music-ilike-single_song-page",
                        count:songCount,
                        curr:pageNum,
                        limit:pageSize,
                        layout:['prev', 'page', 'next','count'],
                        prev:"上一页",
                        next:"下一页",
                        first:"首页",
                        last:"尾页",
                        jump:function(obj,first){
                            //无论是否是第一次，都需要判断是否隐藏分页栏
                            if(songCount<=obj.limit){
                                $(".layui-laypage").css("visibility","hidden");
                            }else{
                                $(".layui-laypage").css("visibility","visible");
                            }
                            //页码变化
                            if(!first){
                                $("#my_music-ilike-single_song").attr("pageNum",obj.curr);
                                $("#my_music-ilike-single_song").attr("pageSize",obj.limit);
                                loadILikeSingleSongList();
                            }
                            return false;
                        }
                    })
                })
            })
        }
        //播放,下载
        function playAddLikeDownLoadMusic() {
            //播放一首歌
            $("#mymusic-ilike-singersong-table").on("click", ".ilike-single_song-control_play>a", function(e) {
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
        //播放全部歌曲
        function playListSong(){
            $("#playAllSong").click(function(){
                var $trs = $("tbody").children("tr");
                var songIds = new Array();
                for(var i=0;i<=$trs.length-1;i++){
                    songIds[i]=$($trs[i]).attr("songId");
                }
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
        //加载我喜欢-歌单首页
        function loadILikeSongSheetIndex(){
            $.ajax({
                method:"GET",
                url:"/myMusic/ilike/songSheet"
            }).done(function(resp){
                $("#my_music-ilike-container").html(resp);
                loadILikeSongSheetList();
            })
        }
        //我喜欢-歌单分页
        function loadILikeSongSheetList(){
            //显示个歌单列表
            var pageNum = $("#my_music-ilike-song_sheet").attr("pageNum");
            var pageSize = $("#my_music-ilike-song_sheet").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/myMusic/ilike/songSheetList?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#my_music-ilike-song_sheet").html(resp);
                cancelLikeSongSheet();
                //渲染分页
                //获取分页总条目数量
                var songSheetCount;
                $.ajax({
                    method:"GET",
                    url:"/myMusic/ilike/songSheetCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    songSheetCount = resp.data;
                    laypage.render({
                        elem:"my_music-ilike-song_sheet-page",
                        count:songSheetCount,
                        curr:pageNum,
                        limit:pageSize,
                        layout:['prev', 'page', 'next','count'],
                        prev:"上一页",
                        next:"下一页",
                        first:"首页",
                        last:"尾页",
                        jump:function(obj,first){
                            //无论是否是第一次，都需要判断是否隐藏分页栏
                            if(songSheetCount<=obj.limit){
                                $(".layui-laypage").css("visibility","hidden");
                            }else{
                                $(".layui-laypage").css("visibility","visible");
                            }
                            //页码变化
                            if(!first){
                                $("#my_music-ilike-song_sheet").attr("pageNum",obj.curr);
                                $("#my_music-ilike-song_sheet").attr("pageSize",obj.limit);
                                loadILikeSongSheetList();
                            }
                            return false;
                        }
                    })
                })
            })
        }
        //取消收藏一个歌单
        function cancelLikeSongSheet(){
            $("tbody").on("click","#cancelLikeSongsheet",function(e){
                layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
                    var songSheetId = $($(e.target).parents("tr").get(0)).attr("sheetId");
                    //删除歌单
                    $.ajax({
                        method:"POST",
                        url:"/myMusic/cancelLikeSongSheet?songSheetId="+songSheetId
                    }).done(function(resp){
                        if(resp.code=="200"){
                            layer.close(index);
                            loadILikeSongSheetIndex();
                            layer.msg("删除成功!",{icon:1,time:500});
                        }
                    }).fail(function(){
                        alert("发送请求失败!");
                    })
                });
            })
        }
        //加载我喜欢-专辑首页
        function loadILikeAlbumIndex(){
            $.ajax({
                method:"GET",
                url:"/myMusic/ilike/album"
            }).done(function(resp){
                $("#my_music-ilike-container").html(resp);
                loadILikeAlbumList();
            })
        }
        //我喜欢-专辑分页
        function loadILikeAlbumList(){
            //显示个歌单列表
            var pageNum = $("#my_music-ilike-album").attr("pageNum");
            var pageSize = $("#my_music-ilike-album").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/myMusic/ilike/albumList?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#my_music-ilike-album").html(resp);
                cancelLikeAlbum();
                //渲染分页
                //获取分页总条目数量
                var albumCount;
                $.ajax({
                    method:"GET",
                    url:"/myMusic/ilike/albumCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    albumCount = resp.data;
                    laypage.render({
                        elem:"my_music-ilike-album-page",
                        count:albumCount,
                        curr:pageNum,
                        limit:pageSize,
                        layout:['prev', 'page', 'next','count'],
                        prev:"上一页",
                        next:"下一页",
                        first:"首页",
                        last:"尾页",
                        jump:function(obj,first){
                            //无论是否是第一次，都需要判断是否隐藏分页栏
                            if(albumCount<=obj.limit){
                                $(".layui-laypage").css("visibility","hidden");
                            }else{
                                $(".layui-laypage").css("visibility","visible");
                            }
                            //页码变化
                            if(!first){
                                $("#my_music-ilike-album").attr("pageNum",obj.curr);
                                $("#my_music-ilike-album").attr("pageSize",obj.limit);
                                loadILikeAlbumList();
                            }
                            return false;
                        }
                    })
                })
            })
        }
        //取消收藏一个专辑
        function cancelLikeAlbum(){
            $("tbody").on("click",".icon-icon7",function(e){
                layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
                    var albumId = $($(e.target).parents("tr").get(0)).attr("albumId");
                    //取消收藏专辑
                    $.ajax({
                        method:"POST",
                        url:"/myMusic/cancelLikeAlbum?albumId="+albumId
                    }).done(function(resp){
                        if(resp.code=="200"){
                            layer.close(index);
                            loadILikeAlbumList();
                            layer.msg("删除成功!",{icon:1,time:500});
                        }
                    }).fail(function(){
                        alert("发送请求失败!");
                    })
                });
            })
        }
        //取消收藏一个Mv
        function cancelLikeMv(){
            $("#mv_container").on("click","#cancelLikeMv",function(e){
                layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
                    var mvIds = new Array();
                    //获取当前播放mv的id
                    var mvId = $($(e.target).parents("li").get(0)).attr("mvId");
                    mvIds[0] = mvId;
                    var likeMvDTO = new Object();
                    likeMvDTO.mvIds =mvIds;
                    likeMvDTO.likeMv = 0;
                    likeMvDTO = JSON.stringify(likeMvDTO);
                    //操作数据库
                    $.ajax({
                        method:"POST",
                        url:"/mv/likeOrCancelLikeMv",
                        data:likeMvDTO,
                        contentType:"application/json"
                    }).done(function(resp){
                        if(resp.code="200"){
                            layer.close(index);
                            loadILikeMvList();
                            layer.msg('操作成功',{icon:1,time:500});
                        }
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                });
            })
        }
        //加载我喜欢-MV首页
        function loadILikeMVIndex(){
            $.ajax({
                method:"GET",
                url:"/myMusic/ilike/mv"
            }).done(function(resp){
                $("#my_music-ilike-container").html(resp);
                loadILikeMvList();
            })
        }
        //我喜欢-MV分页
        function loadILikeMvList(){
            //显示个歌单列表
            var pageNum = $("#mv_container").attr("pageNum");
            var pageSize = $("#mv_container").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/myMusic/ilike/mvList?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#mv_container").html(resp);
                mourseEnterMv();
                cancelLikeMv();

                //渲染分页
                //获取分页总条目数量
                var mvCount;
                $.ajax({
                    method:"GET",
                    url:"/myMusic/ilike/mvCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    mvCount = resp.data;
                    laypage.render({
                        elem:"my_music-ilike-mv-page",
                        count:mvCount,
                        curr:pageNum,
                        limit:pageSize,
                        layout:['prev', 'page', 'next','count'],
                        prev:"上一页",
                        next:"下一页",
                        first:"首页",
                        last:"尾页",
                        jump:function(obj,first){
                            //无论是否是第一次，都需要判断是否隐藏分页栏
                            if(mvCount<=obj.limit){
                                $(".layui-laypage").css("visibility","hidden");
                            }else{
                                $(".layui-laypage").css("visibility","visible");
                            }
                            //页码变化
                            if(!first){
                                $("#mv_container").attr("pageNum",obj.curr);
                                $("#mv_container").attr("pageSize",obj.limit);
                                loadILikeMvList();
                            }
                            return false;
                        }
                    })
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
                        "top":40+"px",
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
                var mvId;
                if($(e.target).prop("tagName")!="DIV"){
                    mvId =$(e.target).parent().attr("mvId");
                }else{
                    mvId =$(e.target).attr("mvId");
                }
                window.open("/mv/play?mvId="+mvId,"mv_index");
            })
        }
        //我创建的歌单页面
        //新建歌单
        function newSongSheet() {
            $("#newSongSheet").on("click", function() {
                console.log("newSongSheet");
                //$("tbody").append('<tr style="height:50px;"><td>李四的歌单</td><td>43首</td><td><a href="#" style="color:"><i title="删除" class="iconfont icon-icon7" style="font-size:25px;"></i></a></td></tr>');
                //显示新建歌单页面
                $.ajax({
                    method:"GET",
                    url:"/myMusic/newSongSheet"
                }).done(function(resp){
                    layui.use('layer', function() {
                        var layer = layui.layer;
                        var index = layer.open({
                            type: 1,
                            title: '新建歌单',
                            content: resp,
                            area: ['550px', '250px'],
                            skin: 'layui-layer-molv'
                        })
                        //取消按钮
                        $("#btn_cancel").on("click",function(){
                            layer.close(index);
                        })
                        //确定按钮
                        $("#btn_newSongSheet").on("click",function(){
                            var songSheetName = $("#newSongSheetName").val();
                            console.log(songSheetName);
                            //添加歌单
                            $.ajax({
                                method:"POST",
                                url:"/myMusic/addSongSheet",
                                data:"songSheetName="+songSheetName
                            }).done(function(resp){
                                layer.msg("添加成功",{
                                    icon:1,
                                    time:1000
                                })
                                layer.close(index);
                                loadMyCreateSongSheetIndex();
                            }).fail(function(){
                                layer.msg("添加失败",{
                                    icon:2,
                                    time:1000
                                })
                            })
                        })
                    });
                }).fail(function(){
                    alert("显示新建个单页面失败");
                })

            })
        }
        //移除歌单
        function dropSongSheet() {
            $("tbody").on("click", ".icon-icon7", function(e) {
                e.preventDefault();
                var sheetId = $(e.target).parents("tr").attr("sheetId");
                $.ajax({
                    method:"POST",
                    url:"/myMusic/deleteSongSheet",
                    data:"songSheetId="+sheetId
                }).done(function(resp){
                    if(resp.code=="200"){
                        alert("删除成功!");
                        loadMyCreateSongSheetList();
                    }
                }).fail(function(){
                    alert("删除失败!");
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
                                    showLoginInfo();
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
    })



</script>
</body>
</html>