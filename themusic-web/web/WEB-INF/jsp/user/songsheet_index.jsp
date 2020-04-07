
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/static/iconfont/iconfont.css" />
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <!--主页-->
    <link rel="stylesheet" href="/static/css/foundMusic.css"/>
    <!--歌曲主页-->
    <link rel="stylesheet" href="/static/css/song-index.css"/>
    <!--登录页面-->
    <link rel="stylesheet" href="/static/css/login.css">
    <!--已登录部分样式-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css"/>
    <!--歌单主页-->
    <link rel="stylesheet" href="/static/css/songsheet_index.css"/>
    <!--单曲页面-->
    <link rel="stylesheet" href="/static/css/singer_single-song.css">
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
    <input type="text" id="search" placeholder="搜索歌曲、MV、歌手"/>
    <!--登陆-->
    <div id="login">
        <a id="btnLogin" href="#" style="font-size:20px;position:relative;top:20px;">登陆</a>
    </div>
    <!--分割线-->
    <hr style="width:100%;margin:0px !important;"/>

    <div id="songsheet_container">
        <!--歌单信息-->
        <div id="songsheet_sheet_info" sheetId="${songSheet.sheetId}">
            <img src="/file/themusic/img/song/1.jpg" id="songsheet_picture"/>
            <div id="songsheet_sheet_info_details">
                <h1>${songSheet.sheetName}</h1>
                <div id="songsheet-sheet_info-sheet_name">
                    <i class="iconfont icon-user_name"></i>
                    <a>${songSheet.user.userName}</a>
                </div>
                <!--标签-->
                <div id="songsheet-sheet_info-label">
                    <p style="display:inline-block;">标签:</p>
                    <ul id="songsheet-sheet_info-label_info">
                        <li>${songSheet.language}</li>
                        <li>${songSheet.style}</li>
                        <li>${songSheet.mood}</li>
                    </ul>
                </div>
            </div>
        </div>
        <!--歌曲列表-->
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

        $(document).ready(function(){
            isUserLogin();
            search();
            clickLogin();
            loadSingleSongList();
        })


        //单曲页面
        //加载单曲列表首页
        function loadSingleSongList(){
            var sheetId = $("#songsheet_sheet_info").attr("sheetId");
            $.ajax({
                method:"get",
                url:"/songsheet/song/?sheetId="+sheetId
            }).done(function(resp){
                $("#content").html(resp);
                // clickSingleSongPageNums();
                playAddLikeDownLoadMusic();
            }).fail(function(){
                alert("加载单曲首页失败!")
            })
        }

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
    });

</script>
</body>
</html>

