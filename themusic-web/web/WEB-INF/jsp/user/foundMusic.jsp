
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <title>The Music-千万曲库新歌热歌天天畅听的高品质音乐平台！</title>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/iconfont/iconfont.css">
    <!--登录-->
    <link rel="stylesheet" href="/static/layui/css/layui.css"/>
    <script src="/static/layui/layui.js"></script>
    <!--主页样式-->
    <link rel="stylesheet" href="/static/css/foundMusic.css"/>
    <!--首页样式-->
    <link rel="stylesheet" href="/static/css/style.css" />
    <!--歌手页面-->
    <link rel="stylesheet" href="/static/css/foundMusic-singer.css"/>
    <!--排行榜页面-->
    <link rel="stylesheet" href="/static/css/foundMusic-ranklist.css"/>
    <!--mv列表页面-->
    <link rel="stylesheet" href="/static/css/mv-list.css"/>
    <!--登录页面-->
    <link rel="stylesheet" href="/static/css/login.css">
    <!--已登录部分样式-->
    <link rel="stylesheet" href="/static/css/login-userinfo.css"/>
    <!--覆盖laypage太小的样式-->
    <link rel="stylesheet" href="/static/css/solute/laypage-solute.css"/>
</head>
<body>
<!--容器-->
<div id="container">
    <!--标志图片-->
    <img id="foundMusic_logle" src="/file/themusic/img/logle/logle.png"/>
    <!--导航栏-->
    <ul id="navigationbar">
        <li style="background-color:green;"><a href="/home/index">发现音乐</a></li>
        <li><a href="/myMusic/index">我的音乐</a></li>
    </ul>

    <input type="text" id="search" placeholder="搜索歌曲、MV、歌手"/>
    <!--登陆-->
    <div id="login" style="color:black;">
        <a id="btnLogin" href="#" style="font-size:20px;position:relative;top:20px;">登陆</a>
    </div>
    <!--导航栏2-->
    <ul id="navigationbar2">
        <li style="margin-left:430px;"><a href="#" id="navigationbar2_index">首页</a></li>
        <li><a href="#" id="navigationbar2_singer">歌手</a></li>
        <li><a href="#" id="navigationbar2_rankList">排行榜</a></li>
        <li><a href="#" id="navigationbar2_mv">MV</a></li>
    </ul>
    <div id="content">

    </div>
</div>
<script>
    layui.use(['element','table','layer','form', 'layedit', 'laydate','laypage'], function() {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        var table = layui.table;
        var layer = layui.layer;//弹出层
        var form = layui.form;//表单元素渲染
        var laypage = layui.laypage;//分页
        var layedit = layui.layedit;
        var laydate = layui.laydate;//日期选择框渲染

        $(document).ready(function(){
            isUserLogin();
            loadIndex();
            clickNavigation2();
            clickSingerList();
            clickRankList();
            clickMVList();
            search();
            clickIndex();
            clickLogin();
        })


        //主页
        //加载首页
        function loadIndex(){
            $("#navigationbar2_index").css("color","green");
            $.ajax({
                method:"post",
                url:"/home/index"
            }).done(function(resp){
                $("#content").html(resp);
            }).fail(function(){
                alert("加载首页失败!");
            })
        }
        //点击首页
        function clickIndex(){
            $("#navigationbar2_index").click(function(e){
                e.preventDefault();
                loadIndex();
            })
        }
        //发现音乐选项卡点击效果
        function clickNavigation2(){
            $("#navigationbar2").on("click","a",function(e){
                //先把所有颜色去掉
                var $as = $(e.target).parents("#navigationbar2").find("a");
                $as.css("color","black");
                var $a = $(e.target);
                $a.css("color","green");
            })
        }
        //点击歌手
        function clickSingerList(){
            $("#navigationbar2_singer").click(function(e){
                e.preventDefault();
                $.ajax({
                    method:"get",
                    url:"/singer/list"
                }).done(function(resp){
                    $("#content").html(resp);
                    clickNameNavigation();
                    clickAreaNavigation();
                    clickGenderNavigation();
                    loadSinger();
                }).fail(function(){
                    alert("查询歌手失败");
                })
            })
        }
        //点击排行榜
        function clickRankList(){
            $("#navigationbar2_rankList").click(function(e){
                e.preventDefault();
                $.ajax({
                    method:"get",
                    url:"/ranklist/list"
                }).done(function(resp){
                    $("#content").html(resp);
                    loadRankList();
                }).fail(function(){
                    alert("显示排行榜失败");
                })
            })
        }
        //点击mv
        function clickMVList(){
            $("#navigationbar2_mv").click(function(e){
                e.preventDefault();
                $.ajax({
                    method:"get",
                    url:"/mv/list"
                }).done(function(resp){
                    $("#content").html(resp);
                    loadMvList();
                }).fail(function(){
                    alert("显示排行榜失败");
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
        //歌手页面
        //点击名字导航栏
        function clickNameNavigation(){
            $("#singer_navigation_name").on("click","a",function(e){
                //取消跳转
                e.preventDefault();
                //去掉所有li颜色和checked属性
                $("#singer_navigation_name").find("li").css("background-color","white").removeAttr("checked");
                //改变点击的li颜色
                var $a = $(e.target);
                $a.parent().css("background-color","green").attr("checked","checked");
                loadSinger();
            })
        }
        //点击地区导航栏
        function clickAreaNavigation(){
            $("#singer_navigation_area").on("click","a",function(e){
                //取消跳转
                e.preventDefault();
                //去掉所有li颜色和checked属性
                $("#singer_navigation_area").find("li").css("background-color","white").removeAttr("checked");
                //改变点击的li颜色和增加checked属性
                var $a = $(e.target);
                $a.parent().css("background-color","green").attr("checked","checked");
                loadSinger();
            })
        }
        //点击性别导航栏
        function clickGenderNavigation(){
            $("#singer_navigation_gender").on("click","a",function(e){
                //取消跳转
                e.preventDefault();
                //去掉所有li颜色和checked属性
                $("#singer_navigation_gender").find("li").css("background-color","white").removeAttr("checked");
                //改变点击的li颜色和增加checked属性
                var $a = $(e.target);
                $a.parent().css("background-color","green").attr("checked","checked");
                loadSinger();
            })
        }
        //加载筛选条件歌手
        function loadSinger(){
            //加载歌手
            //获取筛选条件
            var singerDTO =searchSinger();
            singerDTO.pageNum =$("#singer_list_container").attr("pageNum");
            singerDTO.pageSize =$("#singer_list_container").attr("pageSize");
            singerDTO=JSON.stringify(singerDTO);
            $.ajax({
                method:"post",
                url:"/singer/listSinger",
                data:singerDTO,
                contentType:"application/json"
            }).done(function(resp) {
                $("#singer_list_container").html(resp);
                clickSingerImg();
                //获取符合条件的歌手总数
                var singerCount;
                //获取筛选条件
                var singerDTO =searchSinger();
                singerDTO=JSON.stringify(singerDTO);
                $.ajax({
                    method:"post",
                    url:"/singer/listSingerCount",
                    data:singerDTO,
                    contentType:"application/json"
                }).done(function(resp) {
                    singerCount = resp.data;
                    //分页渲染
                    //渲染分页
                    laypage.render({
                        elem:"singer_list_navigation_page",
                        count:singerCount,
                        limit:$("#singer_list_container").attr("pageSize"),
                        curr:$("#singer_list_container").attr("pageNum"),
                        layout:['prev', 'page', 'next','count'],
                        prev:"上一页",
                        next:"下一页",
                        first:"首页",
                        last:"尾页",
                        jump:function(obj,first){
                            //无论是否是第一次，都需要判断是否隐藏分页栏
                            if(singerCount<=obj.limit){
                                $(".layui-laypage").css("visibility","hidden");
                            }else{
                                $(".layui-laypage").css("visibility","visible");
                            }
                            //页码变化
                            //首次不执行
                            if(!first){
                                $("#singer_list_container").attr("pageNum",obj.curr);
                                $("#singer_list_container").attr("pageSize",obj.limit);
                                loadSinger();
                            }
                            return false;
                        }
                    })
                })

            })

        }
        //获取歌手搜索条件
        function searchSinger(){
            var singerDTO = new Object();
            //名字首字母
            var $nameLis =$("#singer_navigation_name").children();
            for(var i=0;i<=$nameLis.length-1;i++){
                if($($nameLis.get(i)).attr("checked") !=undefined) {
                    var singerNameInitials = $($nameLis.get(i)).children().text();
                    singerDTO.singerNameInitials = singerNameInitials;
                }
            }
            //地区
            var $areaLis =$("#singer_navigation_area").children();
            for(var i=0;i<=$areaLis.length-1;i++){
                if($($areaLis.get(i)).attr("checked") !=undefined){
                    var singerArea = $($areaLis.get(i)).children().text();
                    singerDTO.singerArea=singerArea;
                }
            }
            //性别
            var $sexLis =$("#singer_navigation_gender").children();
            for(var i=0;i<=$sexLis.length-1;i++){
                if($($sexLis.get(i)).attr("checked") !=undefined) {
                    var singerSex = $($sexLis.get(i)).children().text();
                    singerDTO.singerSex = singerSex;
                }
            }
            return singerDTO;
        }
        //点击歌手图片
        function clickSingerImg(){
            $("#singer_list_ul").on("click","img",function(e){
                window.location=$(e.target).next().next().attr("href");
            })
        }

        //排行榜页面

        //播放,添加到歌单,收藏歌曲,下载
        function playAddLikeDownLoadMusic() {
            //播放
            $("#Rank_list_content").on("click", ".Rank_list_play>a", function(e) {
                e.preventDefault();
                //先把歌曲添加到播放器
                var songIds = new Array();
                var songId = $(e.target).parents(".songTr").attr("songId");
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
        //加载排行榜列表
        function  loadRankList(){
            //显示排行榜列表
            var pageNum = $("#Rank_list_container").attr("pageNum");
            var pageSize = $("#Rank_list_container").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/ranklist/listContent?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#Rank_list_content").html(resp);
                playAddLikeDownLoadMusic();
                //渲染分页
                //获取分页总条目数量
                var songCount;
                $.ajax({
                    method:"GET",
                    url:"/ranklist/songsCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    songCount = resp.data;
                    laypage.render({
                        elem:"rank_list_navigation_page",
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
                                $("#Rank_list_container").attr("pageNum",obj.curr);
                                $("#Rank_list_container").attr("pageSize",obj.limit);
                                loadRankList();
                            }
                            return false;
                        }
                    })
                })
            })
        }

        //mv页面
        //mv分页
        function loadMvList(){
            //显示Mv列表
            var pageNum = $("#mv_container").attr("pageNum");
            var pageSize = $("#mv_container").attr("pageSize");
            $.ajax({
                method:"get",
                url:"/mv/listMv?pageNum="+pageNum+"&pageSize="+pageSize
            }).done(function(resp) {
                $("#mv_container").html(resp);
                mourseEnterMv();
                // window.scrollTo(0,0);
                playAddLikeDownLoadMusic();
                //渲染分页
                //获取分页总条目数量
                var mvCount;
                $.ajax({
                    method:"GET",
                    url:"/mv/mvsCount",
                    contentType:"application/json"
                }).done(function(resp) {
                    mvCount = resp.data;
                    laypage.render({
                        elem:"mv_list_navigation_page",
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
                                loadMvList();
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
                        area:['600px','460px'],
                        skin:'layui-layer-molv',
                        scrollbar:false
                        // cancel:function(){
                        //     clickLogin();
                        // }
                    })
                    clickUserImg();
                    cancelSubmit();
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
                console.log(file.name);
                $("#pictureSrc").val(file.name);
                var reader=new FileReader();
                reader.readAsDataURL(file);
                reader.onload=function(e){
                    $("img[id='pic']").get(0).src=e.target.result;
                }
            })
        }
        //取消表单提交
        function cancelSubmit(){
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
