
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <script type="text/javascript" src="/static/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="/static/js/audio.js"></script>
    <link rel="stylesheet" href="/static/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/css/audio.css">
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <!--登录页面-->
    <link rel="stylesheet" href="/static/css/login.css">
    <script src="/static/layui/layui.js"></script>
    <style>
        *{
            margin:0px;
            padding:0px;
        }
        #song-player-container{
            width:100%;
            height:635px;
            background-color:black;
        }
        /*左边部分*/
        #content-left-container{
            width:800px;
            height:495px;
            float:left;
            margin-top:20px;
            margin-left:50px;
        }
        #button-list{
            width:100%;
            height:40px;
        }
        #button-list li{
            float:left;
            list-style-type:none;
        }
        #button-list li:not(:first-child){
            margin-left:10px;
        }
        #button-list button{
            width:130px;
            background-color:black;
            border-color:#A5A5A5;
            color:#A5A5A5;
        }
        /*右边部分*/
        #content-right-container{
            width: 483px;
            height:495px;
            float:right;

            margin-top:20px;
        }
        /*标题*/
        #song_list-title{
            width:800px;
            height:45px;
            border-bottom:0.5px solid #252525;
            margin-bottom:0px;
            color:#A5A5A5;
        }
        #song_list-title li{
            list-style-type: none;
            float:left;
        }
        /*全选复选框*/
        .song_list-title-checkbox{
            zoom:150%;
        }
        /*歌曲*/
        .song_list-title-name{
            width:335px;
            font-size:18px;
            margin-left:45px;
            margin-top:3px;
        }
        /*歌手*/
        .song_list-title-singer{
            width:250px;
            font-size:18px;
            margin-top:3px;
        }
        /*时长*/
        .song_list-title-time{
            width:140px;
            font-size:18px;
            margin-top:3px;
        }
        /*播放器歌曲列表div*/
        #play-song_list{
            width:800px;
            height:400px;
            overflow: auto;
        }
        /*列表*/
        .song_list{
            height:50px;
            padding-top:5px;
            margin-bottom:0px;
            border:0px;
            border-bottom:0.5px solid #252525;
            position:relative;
            color:#A5A5A5;
        }
        #song_list li{
            list-style-type: none;
            float:left;
        }
        /*复选框*/
        .song_list-checkbox{
            zoom:160%;
        }
        /*序号*/
        .song_list-number{
            width:25px;
            font-size:16px;
            position:absolute;
            left:38px;
            top:10px;
        }
        /*歌曲*/
        .song_list-name{
            width:335px;
            font-size:16px;
            position:absolute;
            left:65px;
            top:10px;
        }
        /*歌手*/
        .song_list-singer{
            width:250px;
            font-size:16px;
            position:absolute;
            left:400px;
            top:10px;
        }
        /*时长*/
        .song_list-time{
            width:130px;
            font-size:16px;
            position:absolute;
            top:10px;
            left:650px;
        }
        /*下拉列表*/
        #slide_down_list{
            background-color:white;
            list-style-type:none;
            text-align: center;
            position: absolute;
            left:0px;
            top:44px;
            display: none;
            z-index: 1;
            border:1px;
        }
        #slide_down_list li{
            height:30px;
            padding-left:10px;
            padding-right:10px;
        }
        #slide_down_list li:hover{
            background-color:#999999;
            cursor:pointer;
        }
        #slide_down_list a{
            display:block;
        }
        #slide_down_list a:hover{
            text-decoration: none;
            color:black;
        }
        /*解决icon-like1颜色问题*/
        .icon-like1{
            color:red;
        }
    </style>
</head>
<body>
<div id="song-player-container">
    <!--左边部分-->
    <div id="content-left-container">
        <!--按钮-->
        <ul id="button-list">
            <li><button id="likeCheckedSong" class="btn btn-default"><span>收藏</span></button></li>
            <li><button id="btnAddToMySongSheet" class="btn btn-default"><span>添加到</span></button></li>
            <li><button id="removeCheckedSongs" class="btn btn-default"><span>删除</span></button></li>
            <li><button id="removeAllSong" class="btn btn-default"><span>清空列表</span></button></li>
        </ul>
        <!--添加到我的歌单列表菜单-->
        <ul id="slide_down_list">
            <li><a id="ilike" href="javascript:void(0);" style="font-size:20px;">我喜欢</a></li>
            <li><a href="javascript:void(0);" style="font-size:20px;">我的歌单1</a></li>
            <li><a href="javascript:void(0);" style="font-size:20px;">我的歌单2</a></li>
        </ul>
        <!--歌曲列表-->
        <!--标题-->
        <ul id="song_list-title">
            <li class="song_list-title-checkbox"><input id="checkAllSong" type="checkbox"/></li>
            <li class="song_list-title-name"><span>歌曲</span></li>
            <li class="song_list-title-singer"><span>歌手</span></li>
            <li class="song_list-title-time"><span>时长</span></li>
        </ul>
        <!--播放器歌曲列表开始-->
        <div id="play-song_list">
            <!--歌曲列表-->
        </div>
        <!--播放器歌曲列表结束-->
        <!--歌曲列表结束-->
    </div>
    <!--左边部分结束-->
    <!--右边部分-->
    <div id="content-right-container">
    </div>
    <!--右边部分结束-->


    <!--音乐播放器-->
    <div class="audio-box">
        <div class="audio-container">
            <div class="audio-view">
                <div class="audio-cover" ></div>
                <div class="audio-body">
                    <h3 class="audio-title">未知歌曲</h3>
                    <div class="audio-backs">
                        <div class="audio-this-time">00:00</div>
                        <div class="audio-count-time">00:00</div>
                        <div class="audio-setbacks">
                            <i class="audio-this-setbacks">
                                <span class="audio-backs-btn"></span>
                            </i>
                            <span class="audio-cache-setbacks"></span>
                        </div>
                    </div>
                </div>
                <div class="audio-btn">
                    <div class="audio-select">
                        <div ><i id="likeOrCancelLike" class="iconfont icon-like" style="font-size:35px;position:absolute;left:10px;top:42px;" title="喜欢"></i></div>
                        <div><i id="goToComment" class="iconfont icon-pinglun" style="font-size:30px;position:absolute;left:60px;top:42px;" title="评论"></i></div>
                        <div class="audio-prev" style="position:absolute;left:90px;top:45px;"></div>
                        <div class="audio-play" style="position:absolute;left:135px;top:45px;"></div>
                        <div class="audio-next" style="position:absolute;left:185px;top:45px;"></div>
                        <div class="audio-volume" style="position:absolute;left:235px;top:45px;"></div>
                        <div><i id="downloadSong" class="iconfont icon-download" style="font-size:35px;position:absolute;left:300px;top:42px;color:white;" title="下载"></i></div>
                    </div>
                    <div class="audio-set-volume">
                        <div class="volume-box">
                            <i><span></span></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    layui.use('layer',function(){
        var layer = layui.layer;


        var song,audioFn;

        $(function(){
            getSongList();

            /* 向歌单中添加新曲目，第二个参数true为新增后立即播放该曲目，false则不播放 */
            // audioFn.newSong({
            // 	'cover' : 'img/song/1.jpg',
            // 	'src' : 'song/1.mp3',
            // 	'title' : '她说'
            // },false);

            /* 暂停播放 */
            //audioFn.stopAudio();

            /* 开启播放 */
            //audioFn.playAudio();

            /* 选择歌单中索引为3的曲目(索引是从0开始的)，第二个参数true立即播放该曲目，false则不播放 */
            //audioFn.selectMenu(3,true);

            /* 查看歌单中的曲目 */
            //console.log(audioFn.song);

            /* 当前播放曲目的对象 */
            //console.log(audioFn.audio);
        });


        //加载主页面
        function loadSongPlayIndex(){
            //获取当前播放歌曲的id
            var songEq = $(audioFn.audio).attr("songEq");
            var songId = $($("#play-song_list").children()[songEq]).attr("songId");
            likeOrCnacelLikeChange(songId);
        }
        //喜欢(取消喜欢)歌曲
        function likeOrCancleLike(){
            $("#likeOrCancelLike").click(function(e){
                //先判断用户是否登录
                $.ajax({
                    method:"get",
                    url:"/login/isLogin"
                }).done(function(resp){
                    if(resp.code=="200"){
                        //获取当前播放歌曲的id
                        var songIds = new Array();
                        var songEq = $(audioFn.audio).attr("songEq");
                        var songId = $($("#play-song_list").children()[songEq]).attr("songId");
                        songIds[0] = songId;
                        var likeSongDTO = new Object();
                        likeSongDTO.songIds =songIds;
                        //判断是收藏还是取消
                        var className = $(e.target).attr("class");
                        if(className == "iconfont icon-like"){
                            $(e.target).attr("class","iconfont icon-like1").attr("title","取消喜欢");
                            likeSongDTO.likeSong = 1;
                        }else{
                            $(e.target).attr("class","iconfont icon-like").attr("title","喜欢");
                            likeSongDTO.likeSong = 0;
                        }
                        likeSongDTO = JSON.stringify(likeSongDTO);
                        //操作数据库
                        $.ajax({
                            method:"POST",
                            url:"/song/likeOrCancelLikeSong",
                            data:likeSongDTO,
                            contentType:"application/json"
                        }).done(function(resp){
                            if(resp.code="200"){
                                layer.msg('操作成功',{time:1000});
                            }
                        }).fail(function(){
                            alert("发送请求失败");
                        })
                    }else{
                        //没有登陆
                        showLoginForm();
                    }
                })

            })
        }
        //显示播放器歌曲列表、播放最后一首歌
        function getSongList(){
            $.ajax({
                method:"get",
                url:"/player/songList"
            }).done(function(songList){
                //播放列表显示
                song = songList;
                //刷新页面歌曲列表
                var html='<ul class="song_list"><li>暂无歌曲</li></ul>';
                if(song.length!=0){
                    html="";
                    for(var i=0;i<=song.length-1;i++){
                        html +='<ul class="song_list" songId='+song[i].songId+' songSrc='+song[i].songSrc+'><li class="song_list-checkbox"><input type="checkbox"/></li><li class="song_list-number"><span>'+(i+1)+'</span></li> <li class="song_list-name"><span>'+song[i].songName+'</span></li><li class="song_list-singer"><span>'+song[i].singerName+'</span></li><li class="song_list-time"><span>'+song[i].songLength+'</span></li></ul>';
                    }
                }
                $("#play-song_list").html(html);

                if(song.length==0){
                    //播放列表被全部删除就只是暂停播放，并没有刷新播放器歌曲
                    audioFn.stopAudio();
                }else{
                    //没有被全部删除
                    //添加到播放器
                    //改变图片路径和歌曲路径
                    for(var i=0;i<=songList.length-1;i++){
                        song[i].pictureSrc="/file/themusic/img/song/"+song[i].pictureSrc;
                        song[i].songSrc="/file/themusic/song/"+song[i].songSrc;
                    }
                    audioFn = audioPlay({
                        song : song,
                        songIndex: song.length-1,
                        autoPlay : false  //是否立即播放第一首，autoPlay为true且song为空，会alert文本提示并退出
                    });
                    // //播放最后一首歌
                    audioFn.selectMenu(song.length-1,true);



                    loadSongPlayIndex();
                    selectOneSongPlay();
                    goToComment();
                    likeOrCancleLike();
                    changeSongShowLikeOrLike();
                    checkAllOrCancelCheck();
                    likeCheckedSong();
                    clickBtnAddToMySongSheet();
                    removeCheckedSongs();
                    removeAllSong();
                    downLoadSong();
                }
            })
        }

        //点击播放歌曲
        function selectOneSongPlay(){
            $(".song_list").dblclick(function(e){
                var songId;
                if($(e.target).attr("class")=="song_list"){
                    songNum = $(e.target).find(".song_list-number").children().text();
                }else{
                    songNum = $(e.target).parents(".song_list").find(".song_list-number").children().text();
                }
                audioFn.selectMenu(songNum-1,true);
                loadSongPlayIndex();
            })
        }
        //评论
        function goToComment(){
            $("#goToComment").click(function(e){
                //获取当前播放歌曲的id
                var songEq = $(audioFn.audio).attr("songEq");
                var songId = $($("#play-song_list").children()[songEq]).attr("songId");
                window.open("/song/index?songId="+songId,"song_index");
            })
        }
        //”收藏/取消收藏”按钮动态变化
        function likeOrCnacelLikeChange(songId){
            //查询当前用户是否收藏当前播放的歌
            $.ajax({
                method:"GET",
                url:"/player/isLikeSong?songId="+songId
            }).done(function(resp){
                if(resp.data==0){
                    $("#likeOrCancelLike").attr("class","iconfont icon-like").attr("title","喜欢");
                }else{
                    $("#likeOrCancelLike").attr("class","iconfont icon-like1").attr("title","取消喜欢");
                }
            })
        }

        //切歌动态显示“喜欢”  自动切歌显示未实现。
        function changeSongShowLikeOrLike(){
            //前一首,后一首
            $(".audio-select").on("click",".audio-prev,.audio-next",function(){
                loadSongPlayIndex();
            })
        }

        //判断用户是否登录
        function isUserLogin(){
            $.ajax({
                method:"get",
                url:"/login/isLogin"
            }).done(function(resp){
                if(resp.code!="200"){
                    showLoginForm();
                }
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
                    end:function(){
                        //重新显示是否收藏歌曲
                        //先获取歌曲id
                        var songEq = $(audioFn.audio).attr("songEq");
                        var songId = $($("#play-song_list").children()[songEq]).attr("songId");
                        likeOrCnacelLikeChange(songId);
                    },
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
        //全选/取消全选
        function checkAllOrCancelCheck(){
            $("#checkAllSong").click(function(e){
                //判断状态
                var checkAll = $(e.target).prop("checked");
                //获取所有复选框
                var checkBoxs = $(".song_list-checkbox>input");
                if(checkAll == true){
                    for(var i =0;i<=checkBoxs.length-1;i++){
                        $(checkBoxs[i]).prop("checked",true);
                    }
                }else{
                    for(var i =0;i<=checkBoxs.length-1;i++){
                        $(checkBoxs[i]).prop("checked",false);
                    }
                }
            })
        }
        //收藏列表选中歌曲
        function likeCheckedSong(){
            $("#likeCheckedSong").click(function(){
                //先判断用户是否登录
                $.ajax({
                    method:"get",
                    url:"/login/isLogin"
                }).done(function(resp) {
                    if (resp.code == "200") {
                        //获取所有复选框
                        var checkBoxs = $(".song_list-checkbox>input");
                        var songIds = new Array();
                        var count=0;
                        //将选中添加到数组
                        for(var i=0;i<=checkBoxs.length-1;i++){
                            if($(checkBoxs[i]).prop("checked")==true){
                                songIds[count]=$(checkBoxs[i]).parent().parent().attr("songId");
                                count++;
                            }
                        }
                        if(count==0){
                            layer.msg("未选中歌曲！",{icon:2,time:500});
                        }else{
                            //添加歌曲
                            var likeSongDTO = new Object();
                            likeSongDTO.songIds =songIds;
                            likeSongDTO.likeSong=1;
                            likeSongDTO = JSON.stringify(likeSongDTO);
                            //操作数据库
                            $.ajax({
                                method:"POST",
                                url:"/song/likeOrCancelLikeSong",
                                data:likeSongDTO,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code="200"){
                                    layer.msg('操作成功',{time:1000});
                                    //重新显示是否收藏歌曲
                                    //先获取歌曲id
                                    var songEq = $(audioFn.audio).attr("songEq");
                                    var songId = $($("#play-song_list").children()[songEq]).attr("songId");
                                    likeOrCnacelLikeChange(songId);
                                }
                            }).fail(function(){
                                alert("发送请求失败");
                            })
                        }
                    }else{
                        //没有登陆
                        showLoginForm();
                    }
                }).fail(function(){
                    alert("登录验证失败")
                })
            })
        }
        //删除列表选中歌曲
        function removeCheckedSongs(){
            $("#removeCheckedSongs").click(function(){
                //获取所有复选框
                var checkBoxs = $(".song_list-checkbox>input");
                var songIds = new Array();
                var count=0;
                //将选中添加到数组
                for(var i=0;i<=checkBoxs.length-1;i++){
                    if($(checkBoxs[i]).prop("checked")==true){
                        songIds[count]=$(checkBoxs[i]).parent().parent().attr("songId");
                        count++;
                    }
                }
                if(count==0){
                    layer.msg("未选中歌曲！",{icon:2,time:500});
                }else{
                    //删除列表选中歌曲
                    songIds = JSON.stringify(songIds);
                    //后台操作
                    $.ajax({
                        method:"POST",
                        url:"/player/removeSongs",
                        data:songIds,
                        contentType:"application/json"
                    }).done(function(resp){
                        //刷新列表
                        getSongList();
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                }
            })
        }
        //删除列表全部歌曲
        function removeAllSong(){
            $("#removeAllSong").click(function(){
                layer.confirm('确定清空歌曲列表吗？', {icon: 3, title:'提示'}, function(index){
                    //获取所有复选框
                    var checkBoxs = $(".song_list-checkbox>input");
                    var songIds = new Array();
                    //将歌曲id添加到数组
                    for(var i=0;i<=checkBoxs.length-1;i++){
                        songIds[i]=$(checkBoxs[i]).parent().parent().attr("songId");
                    }
                    //删除列表选中歌曲
                    songIds = JSON.stringify(songIds);
                    //后台操作
                    $.ajax({
                        method:"POST",
                        url:"/player/removeSongs",
                        data:songIds,
                        contentType:"application/json"
                    }).done(function(resp){
                        //刷新列表
                        getSongList();
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                    layer.close(index);
                });
            })
        }
        //下载歌曲
        function downLoadSong(){
            $("#downloadSong").click(function(){
                //获取歌曲路径
                var songEq = $(audioFn.audio).attr("songEq");
                var songSrc = $($("#play-song_list").children()[songEq]).attr("songSrc");
                console.log(songSrc);
                window.open("/myMusic/ilike/singleSong/download?filename="+songSrc);
            })
        }
        //添加到我的歌单按钮
        function clickBtnAddToMySongSheet(){
            $("#btnAddToMySongSheet").on("click",function(e){
                //先判断用户是否登录
                $.ajax({
                    method:"get",
                    url:"/login/isLogin"
                }).done(function(resp) {
                    if (resp.code == "200") {
                        //获取所有复选框
                        var checkBoxs = $(".song_list-checkbox>input");
                        var songIds = new Array();
                        var count=0;
                        //将选中添加到数组
                        for(var i=0;i<=checkBoxs.length-1;i++){
                            if($(checkBoxs[i]).prop("checked")==true){
                                songIds[count]=$(checkBoxs[i]).parent().parent().attr("songId");
                                count++;
                            }
                        }
                        if(count==0){
                            layer.msg("未选中歌曲！",{icon:2,time:500});
                        }else{
                            //先清空
                            $("#slide_down_list").empty();
                            //查找该用户的歌单
                            $.ajax({
                                method:"GET",
                                url:"/player/mySongSheet"
                            }).done(function(resp){
                                var songSheets = resp.data;
                                var html='<li><a id="ilike" href="javascript:void(0);" style="font-size:20px;">我喜欢</a></li>';
                                for(var i=0;i<=songSheets.length-1;i++){
                                    html+='<li><a sheetId='+songSheets[i].sheetId+' href="javascript:void(0);" style="font-size:20px;">'+songSheets[i].sheetName+'</a></li>';
                                }
                                $("#slide_down_list").html(html);
                                $("#slide_down_list").css({
                                    "display":"block",
                                    "left":e.screenX+"px",
                                    "top":e.screenY-80+"px"
                                });
                                //点击其他地方列表隐藏,给document绑定一个一次性的click事件，点击关闭菜单
                                $(document).one("click", function(){
                                    $("#slide_down_list").hide();
                                });
                                e.stopPropagation();
                                //显示列表后点击列表取消事件冒泡
                                $("#slide_down_list").on("click",function(e){
                                    e.stopPropagation();
                                })
                                //列表选项点击事件
                                $("#slide_down_list").on("click",'a',function(e){
                                    $("#slide_down_list").hide();
                                    if($(e.target).attr("id")=="ilike"){
                                        //收藏歌曲
                                        var likeSongDTO = new Object();
                                        likeSongDTO.songIds =songIds;
                                        likeSongDTO.likeSong=1;
                                        likeSongDTO = JSON.stringify(likeSongDTO);
                                        //操作数据库
                                        $.ajax({
                                            method:"POST",
                                            url:"/song/likeOrCancelLikeSong",
                                            data:likeSongDTO,
                                            contentType:"application/json"
                                        }).done(function(resp){
                                            if(resp.code=="200"){
                                                layer.msg("操作成功!",{icon:1,time:1000});
                                            }
                                        }).fail(function(){
                                            alert("发送请求失败");
                                        })

                                    }else{
                                        //添加歌曲到歌单
                                        var likeSongDTO = new Object();
                                        likeSongDTO.songIds =songIds;
                                        likeSongDTO.likeSong=1;
                                        var sheetId = $(e.target).attr("sheetId");
                                        likeSongDTO.sheetId = sheetId;
                                        likeSongDTO = JSON.stringify(likeSongDTO);
                                        //操作数据库
                                        $.ajax({
                                            method:"POST",
                                            url:"/song/addSongToMySongSheet",
                                            data:likeSongDTO,
                                            contentType:"application/json"
                                        }).done(function(resp){
                                            if(resp.code=="200"){
                                                layer.msg("操作成功!",{icon:1,time:1000});
                                            }
                                        }).fail(function(){
                                            alert("发送请求失败");
                                        })
                                    }
                                    e.stopPropagation();
                                })
                            }).fail(function(resp){
                                alert("查询用户歌单失败!");
                            })
                        }
                    }else{
                        //没有登陆
                        showLoginForm();
                    }
                }).fail(function(){
                    alert("请求登录验证失败");
                })
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

