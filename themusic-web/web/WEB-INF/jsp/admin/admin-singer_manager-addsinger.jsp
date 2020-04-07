

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
        #singer_img{
            width:190px;
            height:155px;
            background-color:red;
            position:absolute;
            top:0px;
            left:435px;
        }
        #singer_img:hover{
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
                <input type="text" name="singerId" readonly="readonly" value="${singerId}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">歌手图片</label>
        </div>
        <div id="singer_img" title="选择图片">
            <img id="pic" src="/file/themusic/img/headPicture/singer/添加歌手.jpg"  style="width:190px;height:155px;" />
            <input id="uploadImg" name="file" type="file"  style="display: none;" />
            <input id="pictureSrc" name="singerPicture"  style="display:none" />
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">歌手名字</label>
        <div class="layui-input-inline">
            <input type="text" name="singerName"  autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <input type="radio" name="singerSex" value="男" title="男" checked>
                <input type="radio" name="singerSex" value="女" title="女">
            </div>
        </div>

    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">首字母(大写)</label>
        <div class="layui-input-inline">
            <select name="singerNameInitials">
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
                <option value="E">E</option>
                <option value="F">F</option>
                <option value="G">G</option>
                <option value="H">H</option>
                <option value="I">I</option>
                <option value="J">J</option>
                <option value="K">K</option>
                <option value="L">L</option>
                <option value="M">M</option>
                <option value="N">N</option>
                <option value="O">O</option>
                <option value="P">P</option>
                <option value="Q">Q</option>
                <option value="R">R</option>
                <option value="S">S</option>
                <option value="T">T</option>
                <option value="U">U</option>
                <option value="V">V</option>
                <option value="W">W</option>
                <option value="X">X</option>
                <option value="Y">Y</option>
                <option value="Z">Z</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">出生地</label>
            <div class="layui-input-inline">
                <input type="text" name="singerArea"   autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-inline">
                <input type="text" name="singerBirth" placeholder="yyyy-MM-dd" id="date" autocomplete="off" class="layui-input">
            </div>
        </div>

    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">国籍</label>
            <div class="layui-input-inline">
                <input type="text" name="singerCountry"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">身高(cm)</label>
            <div class="layui-input-inline">
                <input type="text" name="singerHeight"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">体重(kg)</label>
            <div class="layui-input-inline">
                <input type="text" name="singerWeight"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">血型</label>
            <div class="layui-input-inline">
                <input type="text" name="bloodType"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">星座</label>
            <div class="layui-input-inline">
                <select name="constellation">
                    <option value="白羊座">白羊座</option>
                    <option value="金牛座">金牛座</option>
                    <option value="双子座">双子座</option>
                    <option value="巨蟹座">巨蟹座</option>
                    <option value="狮子座">狮子座</option>
                    <option value="处女座">处女座</option>
                    <option value="天秤座">天秤座</option>
                    <option value="天蝎座">天蝎座</option>
                    <option value="射手座">射手座</option>
                    <option value="摩羯座">摩羯座</option>
                    <option value="水瓶座">水瓶座</option>
                    <option value="双鱼座">双鱼座</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">粉丝数</label>
            <div class="layui-input-inline">
                <input type="text" name="fans"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">简介</label>
            <div class="layui-input-inline">
                <textarea name="synopsis" style="width:515px;"   placeholder="请输入" class="layui-textarea"></textarea>
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

