<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/static/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="/static/layui/css/layui.css">

    <!--主页-->
    <link rel="stylesheet" href="/static/css/foundMusic.css"/>
    <!--歌曲主页-->
    <link rel="stylesheet" href="/static/css/song-index.css"/>
    <!--登录页面-->
    <link rel="stylesheet" href="/static/css/login.css">
    <!--已登录部分样式-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css"/>
    <!--解决插件样式混乱-->
    <link rel="stylesheet" href="/static/css/solute.css"/>
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

    <div id="song-index_container">
        <!--歌曲信息-->
        <div id="song-play_song_info">
            <img src="/file/themusic/img/song/${song.pictureSrc}" id="song-play_song_picture"/>
            <div id="song-play_song_info_details">
                <h1>${song.songName}</h1>
                <div id="song-play-song_info-singer_name">
                    <i class="iconfont icon-user_name"></i>
                    <a href="/singer/singerIndex?singerId=${song.singerId}">${song.singerName}</a>
                </div>
                <ul id="song-play-song_info-singer_data">
                    <li>专辑：${song.albumName}</li>
                    <li>语言：${song.songLanguage}</li>
                    <li>播放次数：${song.songClick}</li>
                    <li>歌曲时长：${song.songLength}</li>
                    <li>发行时间：<fmt:formatDate value="${song.publishDate}" type="date"/></li>
                </ul>
            </div>
        </div>
        <!--歌词-->
        <div id="song-play_lylic">
            <h2 style="margin-top:20px;margin-left:50px;">歌词</h2>
            <div id="lylic-content" style="overflow:hidden;height:405px;">
                <c:forEach items="${lrc}" var="songLrc">
                    <p>${songLrc}</p>
                </c:forEach>
            </div>
            <p><b><a id="showAllLylic">【▼展开】</a></b></p>
        </div>
        <!--评论区-->
        <div id="comment_container">
            <h2 style="margin-top:20px;margin-left:45px;">评论</h2>
            <!--我的评论-->
            <div id="my-comment">
                <textarea id="my-comment_content">这歌真好听</textarea>
                <button id="btnComment" style="width:70px;height:28px;float:right;margin-right:10px;margin-top: 10px;">发表评论</button>
            </div>
            <!--精彩评论区-->
            <div id="good-comment_container">

            </div>
            <!--最近评论区-->
            <div id="recently-comment_container">

            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function(){
        isUserLogin();
        clickLogin();
        search();
        loadGoodComments();
        loadRecentlyComments();
        clickBtnComment();
        likeOrCancleLike();
        likeOrCancelLikeComment();
        showOrHideLylic();
    })

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
                    showOrHideSlideDownList();
                })
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
        $.ajax({
            method:"get",
            url:"/login/loginOff"
        }).done(function(){
            $("#login").html("<a id='btnLogin' href='#' style='font-size:20px;position:relative;top:20px;'>登陆</a>")
            //重新绑定登录事件
            clickLogin();
        })
    }
    //加载热门评论首页
    function loadGoodComments(){
        $.ajax({
            method:"get",
            url:"/comment/list?songId="+${song.songId}
        }).done(function(resp){
            $("#good-comment_container").html(resp);
            goodCommentsPagination();
        }).fail(function () {
            alert("加载热门评论首页失败")
        })
    }
    //热门评论分页
    function goodCommentsPagination(){
        $("#song-play_good-comments_navigation_page").on("click","a",function(e){
            //取消默认事件
            e.preventDefault();
            //获取页数
            var pageNum=$(e.target).attr("pageNum");
            $.ajax({
                method:"get",
                url:"/comment/list?pageNum="+pageNum+"&pageSize=10&songId="+${song.songId}
            }).done(function(resp){
                $("#good-comment_container").html(resp);
                goodCommentsPagination();
                //获取精彩评论标题位置
                var goodCommentTitlePosition = $("#good-comment_container-title").get(0).offsetTop;
                window.scrollTo(0,goodCommentTitlePosition);
            }).fail(function () {
                alert("加载热门评论分页失败")
            })
        })
    }
    //加载最新评论首页
    function loadRecentlyComments(){
        $.ajax({
            method:"get",
            url:"/comment/listRecently?songId="+${song.songId}
        }).done(function(resp){
            $("#recently-comment_container").html(resp);
            recentlyCommentsPagination();
        }).fail(function () {
            alert("加载最新评论首页失败")
        })
    }
    //最新评论分页
    function recentlyCommentsPagination(){
        $("#song-play_recently-comments_navigation_page").on("click","a",function(e){
            //取消默认事件
            e.preventDefault();
            //获取页数
            var pageNum=$(e.target).attr("pageNum");
            $.ajax({
                method:"get",
                url:"/comment/listRecently?pageNum="+pageNum+"&pageSize=10&songId="+${song.songId}
            }).done(function(resp){
                $("#recently-comment_container").html(resp);
                recentlyCommentsPagination();
                //获取最新评论标题位置
                var recentlyCommentTitlePosition = $("#recently-comment_container-title").get(0).offsetTop;
                window.scrollTo(0,recentlyCommentTitlePosition);
            }).fail(function () {
                alert("加载最新评论失败")
            })
        })
    }
    //评论
    function clickBtnComment(){
        $("#btnComment").on("click",function(e){
            //先判断用户是否登陆
            $.ajax({
                method:"get",
                url:"/login/isLogin"
            }).done(function(resp){
                if(resp.code!="200"){
                    //未登录
                    showLoginForm();
                }else{
                    //准备comment对象
                    var comment = new Object();
                    comment.songId=${song.songId};
                    var $commentContent = $("#my-comment_content").val();
                    comment.content=$commentContent;
                    comment = JSON.stringify(comment);
                    $.ajax({
                        method:"post",
                        url:"/comment/comment",
                        data:comment,
                        contentType:"application/json"
                    }).done(function(resp){
                        if(resp.code =="200"){
                            alert("评论成功");
                            //加载最新评论
                            loadRecentlyComments();
                            //加载热门评论
                            loadGoodComments();
                            //获取最新评论标题位置
                            var recentlyCommentTitlePosition = $("#recently-comment_container-title").get(0).offsetTop;
                            window.scrollTo(0,recentlyCommentTitlePosition);
                        }

                    }).fail(function(){

                    })
                }
            })

        })
    }
    //喜欢(取消喜欢)
    function likeOrCancleLike(){
        $("#likeOrCancelLike").click(function(e){
            var className = $(e.target).attr("class");
            if(className == "iconfont icon-like"){
                $(e.target).attr("class","iconfont icon-like1").attr("title","取消喜欢");
            }else{
                $(e.target).attr("class","iconfont icon-like").attr("title","喜欢");
            }
        })
    }
    //评论点赞或取消、显示回复评论区
    function likeOrCancelLikeComment(){
        //点赞、取消点赞，显示回复评论区
        $("#comment_container").on("click","a",function(e){
            e.preventDefault();
            //先判断用户是否登陆
            $.ajax({
                method:"get",
                url:"/login/isLogin"
            }).done(function(resp){
                if(resp.code ==200){
                    //登陆成功
                    var $a = $(e.target).parent("a");
                    var $span = $a.find("span");
                    if($a.attr("class") == "likeOrCancelLikeComment"){
                        //如果点击的是点赞
                        //准备对象
                        var likeComment = new Object();
                        //userId
                        likeComment.userId=resp.data.userId;
                        likeComment.scommentId=$a.parents(".others-comment_container").attr("scommentId");
                        if($a.attr("clicked")== undefined){
                            //没有点赞
                            $a.attr("clicked","clicked");
                            $a.find("i").attr("class","iconfont icon-like-b");
                            likeComment.addLikeComment=1;
                            //数量+1
                            var count=parseFloat($span.text())+1;
                            $span.text(count);
                        }else {
                            //已经点赞
                            $a.removeAttr("clicked", "clicked");
                            $a.find("i").attr("class", "iconfont icon-dianzan");
                            likeComment.addLikeComment = -1;
                            //数量-1
                            var count=parseFloat($span.text())-1;
                            $span.text(count);
                        }
                        //转成json字符串
                        likeComment = JSON.stringify(likeComment);
                        //发送信息
                        $.ajax({
                            method:"post",
                            url:"/comment/likeOrCancelLikeComment",
                            data: likeComment,
                            contentType:"application/json"
                        }).done(function(resp){
                            alert(resp.message);
                        }).fail(function(e){
                            alert(resp.message)
                        })
                    }else if($a.attr("class") == "goToComment"){
                        //如果点击了评论
                        $a.parents(".others-comment_container").find(".reply_comment").css("display","block");
                    }
                }else{
                    //未登录
                    showLoginForm();
                }
            })
        })
        //隐藏回复评论区，回复评论
        $("#good-comment_container,#recently-comment_container").on("click","button",function(e){
            if($(e.target).attr("class") == "btnCancleReplayComment"){
                $(e.target).parent().css("display","none");
            }else{
                //回复评论
                var comment = new Object();
                var songId = ${song.songId};
                var content = $(e.target).prev().prev().val();
                var recommentId = $(e.target).parents(".others-comment_container").attr("scommentId");
                if(content ==""){
                    alert("内容不能为空!");
                }else{
                    comment.songId = songId;
                    comment.content = content;
                    comment.recommentId = recommentId;
                    comment = JSON.stringify(comment);
                    $.ajax({
                        method:"post",
                        url:"/comment/comment",
                        data:comment,
                        contentType:"application/json"
                    }).done(function(resp){
                        if(resp.code=="200"){
                            alert("评论成功！");
                            //加载最新评论
                            loadRecentlyComments();
                            //加载热门评论
                            loadGoodComments();
                            //获取最新评论标题位置
                            var recentlyCommentTitlePosition = $("#recently-comment_container-title").get(0).offsetTop;
                            window.scrollTo(0,recentlyCommentTitlePosition);
                        }
                    }).fail(function(){
                        alert("评论失败");
                    })
                }
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
            });
        })
    }
    //显示/隐藏歌词
    function showOrHideLylic(){
        $("#showAllLylic").on("click",function(e){
            e.preventDefault();
            var height = $("#lylic-content").css("height");
            console.log(height);
            if(height =="405px"){
                $("#lylic-content").css("height","auto");
                $(e.target).text("【▲收起】");
            }else{
                $("#lylic-content").css("height","405px");
                $(e.target).text("【▼展开】");
            }
        })
    }
    //秒转换成时分秒
    function formatSeconds(seconds){
        var minute = Math.floor(seconds/60);
        var second = seconds%60;
        return minute+":"+second;
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

</script>
</body>
</html>