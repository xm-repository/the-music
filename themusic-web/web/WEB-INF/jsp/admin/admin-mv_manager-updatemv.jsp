
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all">
    <script src="/static/js/jquery-3.4.1.min.js" charset="utf-8"></script>
    <script src="/static/layui/layui.js" charset="utf-8"></script>
    <style>
        #mv_img{
            width:190px;
            height:155px;
            background-color:red;
            position:absolute;
            top:0px;
            left:435px;
        }
        #mv_img:hover{
            cursor:pointer;
        }
    </style>
</head>
<body>

<form id="formData" class="layui-form">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">ID</label>
            <div class="layui-input-inline">
                <input type="text" name="mvId" readonly="readonly" value="${mv.mvId}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">MV图片</label>
        </div>
        <div id="mv_img" title="选择图片">
            <img id="pic" name="pic" src="/file/themusic/img/mv/${mv.mvPicture}" style="width:190px;height:155px;" />
            <input id="uploadImg" name="files" type="file" style="display: none;" />
            <input id="pictureSrc" name="mvPicture" value="${mv.mvPicture}" style="display:none" />
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">Mv名字</label>
        <div class="layui-input-inline">
            <input type="text" name="mvName" value="${mv.mvName}" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">歌曲Id</label>
            <div class="layui-input-inline">
                <input type="text" name="songId" value="${mv.songId}" autocomplete="off" class="layui-input">
            </div>
        </div>

    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">播放数</label>
            <div class="layui-input-inline">
                <input type="text" name="mvClick" value="${mv.mvClick}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline" style="width:310px;">
            <label class="layui-form-label">mv文件</label>
            <input type="file" id="uploadSound" name="files" style="display:none;" />
            <div class="layui-input-inline" style="width:80px;">
                <input type="text" id="mvSrc" name="mvSrc" value="${mv.mvSrc}" autocomplete="off" class="layui-input"
                       readonly="readonly" style="width:80px;">
            </div>
            <button type="button" class="layui-btn" id="btnUploadSound" style="width:105px;"><i class="layui-icon"></i>上传音频</button>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">时长</label>
            <!--这个仅仅用于间接读取音频文件的时长-->
            <video id="mvVideo" style="display: none;"></video>
            <!--这个仅仅用于间接读取音频文件的时长-->
            <div class="layui-input-inline">
                <input type="text" id="mvLength" name="mvLength" value="${mv.mvLength}" autocomplete="off" class="layui-input" readonly="readonly">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button id="btnSubmit" type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
</body>
</html>

