
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>TheMusic后台管理</title>
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/static/layui/css/layui.css"  media="all">
    <!--主页样式-->
    <link rel="stylesheet" href="/static/css/admin/admin-index.css"/>
    <!--歌曲管理-->
    <link rel="stylesheet" href="/static/css/admin/admin-song_manager.css"/>
    <script src="/static/js/jquery-3.4.1.min.js"></script>
    <script src="/static/layui/layui.js" charset="utf-8"></script>
    <style type="text/css">
        .layui-nav-tree{
            width:187px;
            height:635px;
        }
        #left-ul{
            padding-top:60px;
        }
        #admin-index-container{
            width:1180px;
            height:635px;
            position: absolute;
            right:0px;
            top:0px;
        }
        #container-title{
            width:960px;
            height:60px;
            font-size:30px;
            position:absolute;
            right:195px;
            top:0px;
            z-index:1;
            text-align:center;
            padding-top:10px;
        }
    </style>
</head>
<body>
<!--左边部分导航栏-->
<ul id="left-ul" class="layui-nav layui-nav-tree layui-bg-cyan layui-inline" lay-filter="demo">
    <li class="layui-nav-item layui-nav-itemed">
        <a id="songManager" href="javascript:;">歌曲管理</a>
    </li>
    <li class="layui-nav-item">
        <a id="mvManager" href="javascript:;">MV管理</a>

    </li>
    <li class="layui-nav-item">
        <a id="singerManager" href="javascript:;">歌手管理</a>

    </li>
    <li class="layui-nav-item">
        <a id="userManager" href="javascript:;">用户权限管理</a>
    </li>
</ul>

<!--右边部分容器-->
<div id="admin-index-container">
    <div id="container-title">
        TheMusic后台管理
    </div>
    <ul class="layui-nav" style="width:1180px;height:60px;">
    <li class="layui-nav-item" lay-unselect="" style="position:absolute;right:50px;top:0px;">
        <a href="javascript:;"><img src="/file/themusic/img/headPicture/user/${user.userPicture}" class="layui-nav-img">${user.userName}</a>
        <dl class="layui-nav-child">
            <dd><a href="javascript:;">修改信息</a></dd>
            <dd><a href="javascript:;" id="loginOff" >退了</a></dd>
        </dl>
    </li>
    </ul>

    <!--显示内容-->
    <div id="content">

    </div>
</div>



<script>
    $(document).ready(function(){

        layui.use(['element','table','layer','form', 'layedit', 'laydate'], function(){
            var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
            var table = layui.table;
            var layer = layui.layer;
            var form = layui.form;
            var count;//记录总记录条数
            var layedit = layui.layedit;
            var laydate = layui.laydate;

            loginOff();
            clickSongManager();
            clickMvManager();
            clickSingerManager();
            clickUserManager();


            //歌曲管理页面
            //点击歌曲管理
            function clickSongManager(){
                $("#songManager").on("click",function(e){
                    loadSongManagerIndex();
                })
            }
            //进入歌曲管理页面
            function loadSongManagerIndex(){
                $.ajax({
                    method:"GET",
                    url:"/admin/songManagerIndex"
                }).done(function(resp){
                    $("#content").html(resp);
                    rendSongListTable();
                })
            }
            //渲染歌曲管理表格
            function rendSongListTable(){
                //先得到总条数
                $.ajax({
                    method:"GET",
                    url:"/admin/songsCount"
                }).done(function(resp){
                    count = resp.data;
                })
                //分页渲染
                table.render({
                    elem: '#tb',
                    url: '/admin/songManager',
                    parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.message, //解析提示文本
                            "count": count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    },
                    request: {
                        pageName: 'pageNum' //页码的参数名称，默认：page
                        ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                    response: {
                        statusCode: 200 //规定成功的状态码，默认：0
                    },
                    cols: [[
                        {type:'checkbox', fixed: 'left'}
                        ,{field:'songId', title:"ID" , width:60, sort: true}
                        ,{field:'songName', title:"歌曲" ,width:130}
                        ,{field:'singerName', title:"歌手" ,width:80}
                        ,{field:'publishDate', title:"发表日期" ,width:110,sort: true, templet:function (d) {
                                return showTime(d.publishDate);
                            }}
                        ,{field:'albumName', title:"专辑" ,width:140}
                        ,{field:'songClick', title:"播放数" ,width:80,sort: true}
                        ,{field:'songSrc', title:"歌曲路径" ,width:80}
                        ,{field:'songLength', title:"时长" ,width:80, sort:true}
                        ,{field:'songLanguage', title:"语种" ,width:78}
                        ,{field:'pictureSrc', title:"歌曲图片" ,width:114}
                        ,{fixed: 'right', title:"操作" ,width:164, align:'center', toolbar: '#barDemo'}
                    ]],
                    page: true,
                    limits:[10]
                });
                clickAddSong();
                clickDeleteSelectSong();
                clickSongManagerTool();
            }

            //添加一首歌曲按钮
            function clickAddSong(){
                $("#btnAddSong").on('click',function(){
                    //查询歌曲信息
                    $.ajax({
                        method:"GET",
                        url:"/admin/songManager/addSong"
                    }).done(function(resp){
                        //弹窗显示
                        var index = layer.open({
                            type:1,
                            title:'添加歌曲',
                            content:resp,
                            area:['650px','560px'],
                            skin:'layui-layer-molv',
                            scrollbar:false,
                            cancel:function(){
                                clickSongManagerTool();
                            }
                        })
                        clickSongImg();
                        clickUploadSongSound();
                        updateSong();
                        laydate.render({
                            elem: '#date'
                        })
                        $("#btnSubmit").on("click",function(){
                            //校验图片个音频是否选择
                            if($("#pictureSrc").val()==""){
                                layer.msg('歌曲图片未选择!',{icon:2,time:1000});
                            }else if($("#songSrc").val()==""){
                                layer.msg('歌曲文件未选择!',{icon:2,time:1000});
                            }else{
                                //提交表单
                                var formData = new FormData($("#formData").get(0));
                                $.ajax({
                                    method:"POST",
                                    url:"/admin/songManager/addSong",
                                    data:formData,
                                    processData:false,
                                    contentType:false
                                }).done(function(resp){
                                    if(resp.code=="200"){
                                        layer.msg('添加成功',{icon:1,time:1000},function(){
                                            layer.close(index);
                                            loadSongManagerIndex();
                                        });
                                    }
                                }).fail(function(){
                                    alert("添加失败");
                                })
                            }
                        })
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                })
            }
            //删除选中行歌曲按钮
            function clickDeleteSelectSong(){
                $('#btnDeleteSongs').on('click', function(){
                    var checkStatus = table.checkStatus('tb')
                        ,data = checkStatus.data;
                    if(data.length==0){
                        layer.msg("未选中行",{
                            title:"信息",
                            icon:2
                        });
                    }else{
                        layer.confirm('确定删除选中(共'+data.length+'行)么', function(index){
                            //准备数据
                            var songIds = new Array();
                            for(var i=0;i<=data.length-1;i++){
                                songIds[i]=data[i].songId;
                            }
                            //到后台删除歌曲
                            songIds = JSON.stringify(songIds);
                            $.ajax({
                                method:"POST",
                                url:"/admin/songManager/deleteSong",
                                data:songIds,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code =="200"){
                                    layer.msg("删除成功");
                                    layer.close(index);
                                    loadSongManagerIndex();
                                }
                            }).fail(function(){
                                layer.msg("删除失败");
                            })
                        });
                    }
                });
            }
            //监听工具条
            function clickSongManagerTool(){
                table.on('tool(demo)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'del'){
                        layer.confirm('真的删除行么', function(index){
                            //删除选中歌曲
                            var songIds = new Array();
                            songIds[0] = data.songId;
                            songIds = JSON.stringify(songIds);
                            $.ajax({
                                method:"POST",
                                url:"/admin/songManager/deleteSong",
                                data:songIds,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code=="200"){
                                    obj.del();
                                    layer.msg("删除成功",{icon:1,title:"信息"});
                                }else{
                                    layer.msg("删除失败",{icon:2,title:"错误"})
                                }
                                layer.close(index);
                            }).fail(function(){
                                alert("发送请求失败");
                            })
                        });
                    } else if(obj.event === 'edit'){
                        //查询歌曲信息
                        $.ajax({
                            method:"GET",
                            url:"/admin/songManager/updateSong?songId="+data.songId
                        }).done(function(resp){
                            //弹窗显示
                            var index = layer.open({
                                type:1,
                                title:'修改歌曲信息',
                                content:resp,
                                area:['650px','560px'],
                                skin:'layui-layer-molv',
                                scrollbar:false,
                                cancel:function(){
                                    clickSongManagerTool();
                                }
                            })
                            clickSongImg();
                            clickUploadSongSound();
                            updateSong();
                            laydate.render({
                                elem: '#date'
                            })
                            $("#btnSubmit").on("click",function(){
                                //提交表单
                                var formData = new FormData($("#formData").get(0));
                                $.ajax({
                                    method:"POST",
                                    url:"/admin/songManager/updateSong",
                                    data:formData,
                                    processData:false,
                                    contentType:false
                                }).done(function(resp){
                                    if(resp.code=="200"){
                                        layer.msg('修改成功',{icon:1,time:1000},function(){
                                            layer.close(index);
                                            loadSongManagerIndex();
                                        });
                                    }
                                }).fail(function(){
                                    alert("修改失败");
                                })
                            })
                        }).fail(function(){
                            alert("发送请求失败");
                        })
                    }
                });
            }

            //修改歌曲页面
            //点击图片、预览图片
            function clickSongImg(){
                $("#song_img").on("click",function(){
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
            //上传音频
            function clickUploadSongSound(){
                //上传音频按钮
                $("#btnUploadSound").on("click",function(){
                    $("#uploadSound").get(0).click();
                })
                //显示音频名字
                $("#uploadSound").on("change",function(e){
                    var video=e.target.files[0];
                    $("#songSrc").get(0).value=video.name;
                    //获取音频长度
                    var url = URL.createObjectURL(video);
                    $("#songVideo").get(0).src=url;
                    $("#songVideo")[0].addEventListener("loadedmetadata", function() {
                        var tol = this.duration; //获取总时长
                        tol=Math.floor(tol);
                        $("#songLength").val(tol);
                    });
                })
            }

            //取消表单提交
            function updateSong(){
                $("#formData").on("submit",function(e){
                    e.preventDefault();
                })
            }



            //mv管理页面
            //点击歌曲管理
            function clickMvManager(){
                $("#mvManager").on("click",function(e){
                    loadMvManagerIndex();
                })
            }
            //进入歌曲管理页面
            function loadMvManagerIndex(){
                $.ajax({
                    method:"GET",
                    url:"/admin/mvManagerIndex"
                }).done(function(resp){
                    $("#content").html(resp);
                    rendMvListTable();
                })
            }
            //渲染歌曲管理表格
            function rendMvListTable(){
                //先得到总条数
                $.ajax({
                    method:"GET",
                    url:"/admin/mvsCount"
                }).done(function(resp){
                    count = resp.data;
                })
                //分页渲染
                table.render({
                    elem: '#tb',
                    url: '/admin/mvManager',
                    parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.message, //解析提示文本
                            "count": count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    },
                    request: {
                        pageName: 'pageNum' //页码的参数名称，默认：page
                        ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                    response: {
                        statusCode: 200 //规定成功的状态码，默认：0
                    },
                    cols: [[
                        {type:'checkbox', fixed: 'left'}
                        ,{field:'mvId', title:"ID" , width:60, sort: true}
                        ,{field:'mvName', title:"mv" ,width:130}
                        ,{field:'singerName', title:"歌手" ,width:94}
                        ,{field:'mvClick', title:"播放数" ,width:110,sort: true}
                        ,{field:'mvSrc', title:"mv路径" ,width:220}
                        ,{field:'mvLength', title:"时长" ,width:80}
                        ,{field:'mvPicture', title:"mv图片" ,width:260}
                        ,{fixed: 'right', title:"操作" ,width:164, align:'center', toolbar: '#barDemo'}
                    ]],
                    page: true,
                    limits:[10]
                });
                clickAddMv();
                clickDeleteSelectMv();
                clickMvManagerTool();
            }

            //添加一首Mv按钮
            function clickAddMv(){
                $("#btnAddMv").on('click',function(){
                    //查询歌曲信息
                    $.ajax({
                        method:"GET",
                        url:"/admin/mvManager/addMv"
                    }).done(function(resp){
                        //弹窗显示
                        var index = layer.open({
                            type:1,
                            title:'添加Mv',
                            content:resp,
                            area:['650px','560px'],
                            skin:'layui-layer-molv',
                            scrollbar:false,
                            cancel:function(){
                                clickMvManagerTool();
                            }
                        })
                        clickMvImg();
                        clickUploadMvSound();
                        updateMv();
                        laydate.render({
                            elem: '#date'
                        })
                        $("#btnSubmit").on("click",function(){
                            //校验图片个音频是否选择
                            if($("#pictureSrc").val()==""){
                                layer.msg('mv图片未选择!',{icon:2,time:1000});
                            }else if($("#mvSrc").val()==""){
                                layer.msg('歌曲文件未选择!',{icon:2,time:1000});
                            }else{
                                //提交表单
                                var formData = new FormData($("#formData").get(0));
                                $.ajax({
                                    method:"POST",
                                    url:"/admin/mvManager/addMv",
                                    data:formData,
                                    processData:false,
                                    contentType:false
                                }).done(function(resp){
                                    if(resp.code=="200"){
                                        layer.msg('添加成功',{icon:1,time:1000},function(){
                                            layer.close(index);
                                            loadMvManagerIndex();
                                        });
                                    }
                                }).fail(function(){
                                    alert("添加失败");
                                })
                            }
                        })
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                })
            }
            //删除选中行mv按钮
            function clickDeleteSelectMv(){
                $('#btnDeleteMvs').on('click', function(){
                    var checkStatus = table.checkStatus('tb')
                        ,data = checkStatus.data;
                    if(data.length==0){
                        layer.msg("未选中行",{
                            title:"信息",
                            icon:2
                        });
                    }else{
                        layer.confirm('确定删除选中(共'+data.length+'行)么', function(index){
                            //准备数据
                            var mvIds = new Array();
                            for(var i=0;i<=data.length-1;i++){
                                mvIds[i]=data[i].mvId;
                            }
                            //到后台删除Mn
                            mvIds = JSON.stringify(mvIds);
                            $.ajax({
                                method:"POST",
                                url:"/admin/mvManager/deleteMv",
                                data:mvIds,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code =="200"){
                                    layer.msg("删除成功");
                                    layer.close(index);
                                    loadMvManagerIndex();
                                }
                            }).fail(function(){
                                layer.msg("删除失败");
                            })
                        });
                    }
                });
            }
            //监听工具条
            function clickMvManagerTool(){
                table.on('tool(demo)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'del'){
                        layer.confirm('真的删除行么', function(index){
                            //删除选中歌曲
                            var mvIds = new Array();
                            mvIds[0] = data.mvId;
                            mvIds = JSON.stringify(mvIds);
                            $.ajax({
                                method:"POST",
                                url:"/admin/mvManager/deleteMv",
                                data:mvIds,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code=="200"){
                                    obj.del();
                                    layer.msg("删除成功",{icon:1,title:"信息"});
                                }else{
                                    layer.msg("删除失败",{icon:2,title:"错误"})
                                }
                                layer.close(index);
                            }).fail(function(){
                                alert("发送请求失败");
                            })
                        });
                    } else if(obj.event === 'edit'){
                        //查询mv信息
                        $.ajax({
                            method:"GET",
                            url:"/admin/mvManager/updateMv?mvId="+data.mvId
                        }).done(function(resp){
                            //弹窗显示
                            var index = layer.open({
                                type:1,
                                title:'修改歌曲信息',
                                content:resp,
                                area:['650px','560px'],
                                skin:'layui-layer-molv',
                                scrollbar:false,
                                cancel:function(){
                                    clickMvManagerTool();
                                }
                            })
                            clickMvImg();
                            clickUploadMvSound();
                            updateMv();
                            $("#btnSubmit").on("click",function(){
                                //提交表单
                                var formData = new FormData($("#formData").get(0));
                                $.ajax({
                                    method:"POST",
                                    url:"/admin/mvManager/updateMv",
                                    data:formData,
                                    processData:false,
                                    contentType:false
                                }).done(function(resp){
                                    if(resp.code=="200"){
                                        layer.msg('修改成功',{icon:1,time:1000},function(){
                                            layer.close(index);
                                            loadMvManagerIndex();
                                        });
                                    }
                                }).fail(function(){
                                    alert("修改失败");
                                })
                            })
                        }).fail(function(){
                            alert("发送请求失败");
                        })
                    }
                });
            }
            //修改Mv页面
            //点击图片、预览图片
            function clickMvImg(){
                $("#mv_img").on("click",function(){
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
            //上传音频
            function clickUploadMvSound(){
                //上传音频按钮
                $("#btnUploadSound").on("click",function(){
                    $("#uploadSound").get(0).click();
                })
                //显示音频名字
                $("#uploadSound").on("change",function(e){
                    var video=e.target.files[0];
                    $("#mvSrc").get(0).value=video.name;
                    //获取音频长度
                    var url = URL.createObjectURL(video);
                    $("#mvVideo").get(0).src=url;
                    $("#mvVideo")[0].addEventListener("loadedmetadata", function() {
                        var tol = this.duration; //获取总时长
                        tol=Math.floor(tol);
                        $("#mvLength").val(tol);
                    });
                })
            }
            //取消表单提交
            function updateMv(){
                $("#formData").on("submit",function(e){
                    e.preventDefault();
                })
            }



            //歌手管理页面
            //点击歌手管理
            function clickSingerManager(){
                $("#singerManager").on("click",function(e){
                    loadSingerManagerIndex();
                })
            }
            //进入歌曲管理页面
            function loadSingerManagerIndex(){
                $.ajax({
                    method:"GET",
                    url:"/admin/singerManagerIndex"
                }).done(function(resp){
                    $("#content").html(resp);
                    rendSingerListTable();
                })
            }
            //渲染歌手管理表格
            function rendSingerListTable(){
                //先得到总条数
                $.ajax({
                    method:"GET",
                    url:"/admin/singersCount"
                }).done(function(resp){
                    count = resp.data;
                })
                //分页渲染
                table.render({
                    elem: '#tb',
                    url: '/admin/singerManager',
                    parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.message, //解析提示文本
                            "count": count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    },
                    request: {
                        pageName: 'pageNum' //页码的参数名称，默认：page
                        ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                    response: {
                        statusCode: 200 //规定成功的状态码，默认：0
                    },
                    cols: [[
                        {type:'checkbox', fixed: 'left'}
                        ,{field:'singerId', title:"ID" , width:60, sort: true}
                        ,{field:'singerName', title:"歌手名字" ,width:90}
                        ,{field:'singerSex', title:"性别" ,width:60}
                        ,{field:'singerArea', title:"出生地" ,width:76}
                        ,{field:'singerBirth', title:"出生日期" ,width:110,sort: true, templet:function (d) {
                                return showTime(d.singerBirth);
                            }}
                        ,{field:'singerCountry', title:"国籍" ,width:76,}
                        ,{field:'singerHeight', title:"身高" ,width:60}
                        ,{field:'singerWeight', title:"体重" ,width:80, sort:true}
                        ,{field:'bloodType', title:"血型" ,width:60}
                        ,{field:'constellation', title:"星座" ,width:76}
                        ,{field:'synopsis', title:"简介" ,width:60}
                        ,{field:'singerPicture', title:"歌手图片" ,width:90}
                        ,{field:'fans', title:"粉丝数" ,width:100, sort:true}
                        ,{fixed: 'right', title:"操作" ,width:116, align:'center', toolbar: '#barDemo'}
                    ]],
                    page: true,
                    limits:[10]
                });
                clickAddSinger();
                clickDeleteSelectSinger();
                clickSingerManagerTool();
            }
            //添加歌手按钮
            function clickAddSinger(){
                $("#btnAddSinger").on('click',function(){
                    //查询歌曲信息
                    $.ajax({
                        method:"GET",
                        url:"/admin/singerManager/addSinger"
                    }).done(function(resp){
                        //弹窗显示
                        var index = layer.open({
                            type:1,
                            title:'添加歌手',
                            content:resp,
                            area:['650px','560px'],
                            skin:'layui-layer-molv',
                            scrollbar:false,
                            cancel:function(){
                                clickSingerManagerTool();
                            }
                        })
                        clickSingerImg();
                        updateSinger();
                        laydate.render({
                            elem: '#date'
                        })
                        form.render();
                        $("#btnSubmit").on("click",function(){
                            //校验图片个音频是否选择
                            if($("#pictureSrc").val()==""){
                                layer.msg('歌手图片未选择!',{icon:2,time:1000});
                            }else{
                                //提交表单
                                var formData = new FormData($("#formData").get(0));
                                $.ajax({
                                    method:"POST",
                                    url:"/admin/singerManager/addSinger",
                                    data:formData,
                                    processData:false,
                                    contentType:false
                                }).done(function(resp){
                                    if(resp.code=="200"){
                                        layer.msg('添加成功',{icon:1,time:1000},function(){
                                            layer.close(index);
                                            loadSingerManagerIndex();
                                        });
                                    }
                                }).fail(function(){
                                    alert("添加失败");
                                })
                            }
                        })
                    }).fail(function(){
                        alert("发送请求失败");
                    })
                })
            }
            //删除选中歌手按钮
            function clickDeleteSelectSinger(){
                $('#btnDeleteSingers').on('click', function(){
                    var checkStatus = table.checkStatus('tb')
                        ,data = checkStatus.data;
                    if(data.length==0){
                        layer.msg("未选中行",{
                            title:"信息",
                            icon:2
                        });
                    }else{
                        layer.confirm('确定删除选中(共'+data.length+'行)么', function(index){
                            //准备数据
                            var singerIds = new Array();
                            for(var i=0;i<=data.length-1;i++){
                                singerIds[i]=data[i].singerId;
                            }
                            //到后台删除歌手
                            singerIds = JSON.stringify(singerIds);
                            $.ajax({
                                method:"POST",
                                url:"/admin/singerManager/deleteSinger",
                                data:singerIds,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code =="200"){
                                    layer.msg("删除成功");
                                    layer.close(index);
                                    loadSingerManagerIndex();
                                }
                            }).fail(function(){
                                alert("删除失败");
                            })
                        });
                    }
                });
            }
            //监听工具条
            function clickSingerManagerTool(){
                table.on('tool(demo)', function(obj){
                    var data = obj.data;
                    if(obj.event === 'del'){
                        layer.confirm('真的删除行么', function(index){
                            //删除选中歌曲
                            var singerIds = new Array();
                            singerIds[0] = data.singerId;
                            singerIds = JSON.stringify(singerIds);
                            $.ajax({
                                method:"POST",
                                url:"/admin/singerManager/deleteSinger",
                                data:singerIds,
                                contentType:"application/json"
                            }).done(function(resp){
                                if(resp.code=="200"){
                                    obj.del();
                                    layer.msg("删除成功",{icon:1,title:"信息"});
                                }else{
                                    layer.msg("删除失败",{icon:2,title:"错误"})
                                }
                                layer.close(index);
                            }).fail(function(){
                                alert("发送请求失败");
                            })
                        });
                    } else if(obj.event === 'edit'){
                        //查询歌手信息
                        $.ajax({
                            method:"GET",
                            url:"/admin/singerManager/updateSinger?singerId="+data.singerId
                        }).done(function(resp){
                            //弹窗显示
                            var index = layer.open({
                                type:1,
                                title:'修改歌手信息',
                                content:resp,
                                area:['650px','560px'],
                                skin:'layui-layer-molv',
                                scrollbar:false,
                                cancel:function(){
                                    clickSingerManagerTool();
                                }
                            });
                            clickSingerImg();
                            updateSinger();
                            laydate.render({
                                elem: '#date',
                                type: 'date',
                                format: 'yyyy-MM-dd',
                                value:$("#date").val()
                            });
                            form.render();
                            $("#btnSubmit").on("click",function(){
                                //提交表单
                                var formData = new FormData($("#formData").get(0));
                                $.ajax({
                                    method:"POST",
                                    url:"/admin/singerManager/updateSinger",
                                    data:formData,
                                    processData:false,
                                    contentType:false
                                }).done(function(resp){
                                    if(resp.code=="200"){
                                        layer.msg('修改成功',{icon:1,time:1000},function(){
                                            layer.close(index);
                                            loadSingerManagerIndex();
                                        });
                                    }
                                }).fail(function(){
                                    alert("修改失败");
                                })
                            })
                        }).fail(function(){
                            alert("发送请求失败");
                        })
                    }
                });
            }
            //点击图片、预览图片
            function clickSingerImg(){
                $("#singer_img").on("click",function(){
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
            function updateSinger(){
                $("#formData").on("submit",function(e){
                    e.preventDefault();
                })
            }






            //用户管理页面
            //点击用户管理
            function clickUserManager(){
                $("#userManager").on("click",function(e){
                    loadUserManagerIndex();
                })
            }
            //进入用户管理页面
            function loadUserManagerIndex(){
                $.ajax({
                    method:"GET",
                    url:"/admin/userManagerIndex"
                }).done(function(resp){
                    $("#content").html(resp);
                    rendUserListTable();
                })
            }
            //渲染用户管理表格
            function rendUserListTable(){
                //先得到总条数
                $.ajax({
                    method:"GET",
                    url:"/admin/usersCount"
                }).done(function(resp){
                    count = resp.data;
                })
                //分页渲染
                table.render({
                    elem: '#tb',
                    url: '/admin/userManager',
                    parseData: function(res){ //res 即为原始返回的数据
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.message, //解析提示文本
                            "count": count, //解析数据长度
                            "data": res.data //解析数据列表
                        };
                    },
                    request: {
                        pageName: 'pageNum' //页码的参数名称，默认：page
                        ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                    response: {
                        statusCode: 200 //规定成功的状态码，默认：0
                    },
                    cols: [[
                        {field:'userId', title:"ID" , width:88, sort: true}
                        ,{field:'userName', title:"昵称" ,width:204}
                        ,{field:'userSex', title:"性别" ,width:60}
                        ,{field:'userPhone', title:"电话号码" ,width:160}
                        ,{field:'userPicture', title:"用户头像" ,width:140}
                        ,{field:'loginName', title:"登录名" ,width:210,sort: true}
                        ,{field:'password', title:"密码" ,width:186}
                        ,{fixed: 'right', title:"是否为管理员" ,width:120, align:'center',  templet:barDemo}
                    ]],
                    page: true,
                    limits:[10]
                });
                clickUserManagerSwitch();
            }
            //监听开关
            function clickUserManagerSwitch(){
                form.on('switch(switchChange)', function(data){
                    var userId = $($(data.elem).parents("tr").find("div")[0]).text();
                    var loginType = data.elem.checked===true?"管理员":"用户";
                    //修改登录身份
                    var login = new Object();
                    login.userId = userId;
                    login.loginType= loginType;
                    login = JSON.stringify(login);
                    $.ajax({
                        method:"POST",
                        url:"/admin/userManager/updateLogin",
                        data:login,
                        contentType:"application/json"
                    }).done(function(resp){
                        if(resp.code=="200"){
                            layer.msg('修改成功',{time:1000},function(){
                                layer.close(index);
                            });
                        }
                    }).fail(function(){
                        alert("修改失败");
                    })

                });
            }
            //时间转换函数
            function showTime(tempDate){
                var d = new Date(tempDate);
                var year = d.getFullYear();
                var month = d.getMonth();
                month++;
                var day = d.getDate();
                // var hours = d.getHours();
                //
                // var minutes = d.getMinutes();
                // var seconds = d.getSeconds();
                month = month<10 ? "0"+month:month;
                day = day<10 ? "0"+day:day;
                // hours = hours<10 ? "0"+hours:hours;
                // minutes = minutes<10 ? "0"+minutes:minutes;
                // seconds = seconds<10 ? "0"+seconds:seconds;
                var time = year+"-"+month+"-"+day;
                return time;
            }

            //注销
            function loginOff(){
                $("#loginOff").on("click",function(){
                    $.ajax({
                        method:"GET",
                        url:"/login/loginOff"
                    }).done(function(resp){
                        if(resp.code=="200"){
                            window.location = "/home/index";
                        }
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
        });
    })

</script>

</body>
</html>
