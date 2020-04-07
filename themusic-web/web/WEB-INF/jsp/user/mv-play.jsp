
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>${mv.mvName}</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/layui/layui.js"></script>

    <link rel="stylesheet" href="/static/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="/static/layui/css/layui.css"/>
    <!--主页样式-->
    <link rel="stylesheet" href="/static/css/foundMusic.css"/>
    <!--登陆页面-->
    <link rel="stylesheet" href="/static/css/login.css"/>
    <!--已登录部分样式-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css"/>
    <!--mv播放主页-->
    <link rel="stylesheet" href="/static/css/mv-play.css"/>

    <script src="/static/layui/layui.js"></script>
</head>
<body>
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

    <div id="mv-play_container" mvId="${mv.mvId}">
        <div id="mv-play_player_container">
            <video src="/file/themusic/mv/${mv.mvSrc}" autoplay="autoplay" controls="controls"></video>
            <span style="font-size:25px;position:absolute;left:82px;top:670px;color:white;">${mv.mvName} - ${mv.singerName}<span style="margin-left:25px;font-size:16px;color:#999;">播放量:${mv.mvClick}</span></span>
            <i id="likeOrCancelLike" class="iconfont icon-like" style="font-size:35px;position:absolute;right:90px;top:670px;" title="收藏mv"></i>
        </div>
    </div>
</div>


<script>
    layui.use(['layer','form'],function(){
        var layer = layui.layer;
        var form = layui.form;
        $(document).ready(function(){

            isUserLogin();
            clickLogin();
            loadMvPlayIndex();
            likeOrCancleLike();
            search();

            //加载当前用户是否收藏mv
            function loadMvPlayIndex(){
                //先判断是否登录
                $.ajax({
                    method:"get",
                    url:"/login/isLogin"
                }).done(function(resp){
                    if(resp.code == "200"){
                        //获取当前播放mv的id
                        var mvId = $("#mv-play_container").attr("mvId");
                        likeOrCnacelLikeChange(mvId);
                    }
                })
            }

            //”收藏/取消收藏”按钮动态变化
            function likeOrCnacelLikeChange(mvId){
                //查询当前用户是否收藏当前播放的MV
                $.ajax({
                    method:"GET",
                    url:"/mv/isLikeMv?mvId="+mvId
                }).done(function(resp){
                    if(resp.data==0){
                        $("#likeOrCancelLike").attr("class","iconfont icon-like").attr("title","收藏mv");
                    }else{
                        $("#likeOrCancelLike").attr("class","iconfont icon-like1").attr("title","取消收藏");
                    }
                })
            }
            //喜欢(取消喜欢)mv
            function likeOrCancleLike(){
                $("#likeOrCancelLike").click(function(e){
                    //先判断用户是否登录
                    $.ajax({
                        method:"get",
                        url:"/login/isLogin"
                    }).done(function(resp){
                        if(resp.code=="200"){
                            //获取当前播放mv的id
                            var mvIds = new Array();
                            //获取当前播放mv的id
                            var mvId = $("#mv-play_container").attr("mvId");
                            mvIds[0] = mvId;
                            var likeMvDTO = new Object();
                            likeMvDTO.mvIds =mvIds;
                            //判断是收藏还是取消
                            var className = $(e.target).attr("class");
                            if(className == "iconfont icon-like"){
                                $(e.target).attr("class","iconfont icon-like1").attr("title","取消收藏");
                                likeMvDTO.likeMv = 1;
                            }else{
                                $(e.target).attr("class","iconfont icon-like").attr("title","收藏mv");
                                likeMvDTO.likeMv = 0;
                            }
                            likeMvDTO = JSON.stringify(likeMvDTO);
                            //操作数据库
                            $.ajax({
                                method:"POST",
                                url:"/mv/likeOrCancelLikeMv",
                                data:likeMvDTO,
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
                            loadMvPlayIndex();
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
                            scrollbar:false
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

        })

    })



</script>
</body>
</html>
