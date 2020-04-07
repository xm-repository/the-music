<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <style>
        #user_img{
            width:190px;
            height:155px;
            background-color:red;
            position:absolute;
            top:40px;
            left:385px;
        }
        #user_img:hover{
            cursor:pointer;
        }
    </style>
</head>
<body>

<form id="formData" class="layui-form">
    <div class="layui-form-item" style="margin-top:40px;">
        <div class="layui-inline">
            <label class="layui-form-label">ID</label>
            <div class="layui-input-inline">
                <input type="text" name="userId" readonly="readonly" value="${user.userId}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">头像</label>
        </div>
        <div id="user_img" title="选择图片">
            <img id="pic" src="/file/themusic/img/headPicture/user/${user.userPicture}"  style="width:190px;height:155px;" />
            <input id="uploadImg" name="file" type="file"  style="display: none;" />
            <input id="pictureSrc" name="userPicture" value="${user.userPicture}" style="display:none" />
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">昵称</label>
        <div class="layui-input-inline">
            <input type="text" name="userName" value="${user.userName}"  autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <c:choose>
                    <c:when test="${user.userSex == '男'}">
                        <input type="radio" name="userSex" value="男" title="男" checked>
                        <input type="radio" name="userSex" value="女" title="女">
                    </c:when>
                    <c:otherwise>
                        <input type="radio" name="userSex" value="男" title="男">
                        <input type="radio" name="userSex" value="女" title="女" checked>
                    </c:otherwise>
                </c:choose>
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
