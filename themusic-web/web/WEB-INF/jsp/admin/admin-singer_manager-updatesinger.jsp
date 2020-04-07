<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                <input type="text" name="singerId" readonly="readonly" value="${singer.singerId}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">歌手图片</label>
        </div>
        <div id="singer_img" title="选择图片">
            <img id="pic" src="/file/themusic/img/headPicture/singer/${singer.singerPicture}"  style="width:190px;height:155px;" />
            <input id="uploadImg" name="file" type="file"  style="display: none;" />
            <input id="pictureSrc" name="singerPicture" value="${singer.singerPicture}" style="display:none" />
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">歌手名字</label>
        <div class="layui-input-inline">
            <input type="text" name="singerName" value="${singer.singerName}"  autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-inline">
                <c:choose>
                    <c:when test="${singer.singerSex == '男'}">
                        <input type="radio" name="singerSex" value="男" title="男" checked>
                        <input type="radio" name="singerSex" value="女" title="女">
                    </c:when>
                    <c:otherwise>
                        <input type="radio" name="singerSex" value="男" title="男">
                        <input type="radio" name="singerSex" value="女" title="女" checked>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">首字母(大写)</label>
        <div class="layui-input-inline">
            <select name="singerNameInitials">
                <option value="A" <c:if test="${singer.singerNameInitials=='A'}">selected="selected"</c:if>>A</option>
                <option value="B" <c:if test="${singer.singerNameInitials=='B'}">selected="selected"</c:if>>B</option>
                <option value="C" <c:if test="${singer.singerNameInitials=='C'}">selected="selected"</c:if>>C</option>
                <option value="D" <c:if test="${singer.singerNameInitials=='D'}">selected="selected"</c:if>>D</option>
                <option value="E" <c:if test="${singer.singerNameInitials=='E'}">selected="selected"</c:if>>E</option>
                <option value="F" <c:if test="${singer.singerNameInitials=='F'}">selected="selected"</c:if>>F</option>
                <option value="G" <c:if test="${singer.singerNameInitials=='G'}">selected="selected"</c:if>>G</option>
                <option value="H" <c:if test="${singer.singerNameInitials=='H'}">selected="selected"</c:if>>H</option>
                <option value="I" <c:if test="${singer.singerNameInitials=='I'}">selected="selected"</c:if>>I</option>
                <option value="J" <c:if test="${singer.singerNameInitials=='J'}">selected="selected"</c:if>>J</option>
                <option value="K" <c:if test="${singer.singerNameInitials=='K'}">selected="selected"</c:if>>K</option>
                <option value="L" <c:if test="${singer.singerNameInitials=='L'}">selected="selected"</c:if>>L</option>
                <option value="M" <c:if test="${singer.singerNameInitials=='M'}">selected="selected"</c:if>>M</option>
                <option value="N" <c:if test="${singer.singerNameInitials=='N'}">selected="selected"</c:if>>N</option>
                <option value="O" <c:if test="${singer.singerNameInitials=='O'}">selected="selected"</c:if>>O</option>
                <option value="P" <c:if test="${singer.singerNameInitials=='P'}">selected="selected"</c:if>>P</option>
                <option value="Q" <c:if test="${singer.singerNameInitials=='Q'}">selected="selected"</c:if>>Q</option>
                <option value="R" <c:if test="${singer.singerNameInitials=='R'}">selected="selected"</c:if>>R</option>
                <option value="S" <c:if test="${singer.singerNameInitials=='S'}">selected="selected"</c:if>>S</option>
                <option value="T" <c:if test="${singer.singerNameInitials=='T'}">selected="selected"</c:if>>T</option>
                <option value="U" <c:if test="${singer.singerNameInitials=='U'}">selected="selected"</c:if>>U</option>
                <option value="V" <c:if test="${singer.singerNameInitials=='V'}">selected="selected"</c:if>>V</option>
                <option value="W" <c:if test="${singer.singerNameInitials=='W'}">selected="selected"</c:if>>W</option>
                <option value="X" <c:if test="${singer.singerNameInitials=='X'}">selected="selected"</c:if>>X</option>
                <option value="Y" <c:if test="${singer.singerNameInitials=='Y'}">selected="selected"</c:if>>Y</option>
                <option value="Z" <c:if test="${singer.singerNameInitials=='Z'}">selected="selected"</c:if>>Z</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">出生地</label>
            <div class="layui-input-inline">
                <input type="text" name="singerArea" value="${singer.singerArea}"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-inline">
                <input type="text" name="singerBirth" value="<fmt:formatDate value="${singer.singerBirth}" type="date"></fmt:formatDate>" id="date"   placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
            </div>
        </div>

    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">国籍</label>
            <div class="layui-input-inline">
                <input type="text" name="singerCountry" value="${singer.singerCountry}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">身高(cm)</label>
            <div class="layui-input-inline">
                <input type="text" name="singerHeight" value="${singer.singerHeight}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">体重(kg)</label>
            <div class="layui-input-inline">
                <input type="text" name="singerWeight" value="${singer.singerHeight}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">血型</label>
            <div class="layui-input-inline">
                <input type="text" name="bloodType" value="${singer.bloodType}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">星座</label>
            <div class="layui-input-inline">
                <select name="constellation">
                    <option value="白羊座" <c:if test="${singer.constellation=='白羊座'}">selected="selected"</c:if>>白羊座</option>
                    <option value="金牛座" <c:if test="${singer.constellation=='金牛座'}">selected="selected"</c:if>>金牛座</option>
                    <option value="双子座" <c:if test="${singer.constellation=='双子座'}">selected="selected"</c:if>>双子座</option>
                    <option value="巨蟹座" <c:if test="${singer.constellation=='巨蟹座'}">selected="selected"</c:if>>巨蟹座</option>
                    <option value="狮子座" <c:if test="${singer.constellation=='狮子座'}">selected="selected"</c:if>>狮子座</option>
                    <option value="处女座" <c:if test="${singer.constellation=='处女座'}">selected="selected"</c:if>>处女座</option>
                    <option value="天秤座" <c:if test="${singer.constellation=='天秤座'}">selected="selected"</c:if>>天秤座</option>
                    <option value="天蝎座" <c:if test="${singer.constellation=='天蝎座'}">selected="selected"</c:if>>天蝎座</option>
                    <option value="射手座" <c:if test="${singer.constellation=='射手座'}">selected="selected"</c:if>>射手座</option>
                    <option value="摩羯座" <c:if test="${singer.constellation=='摩羯座'}">selected="selected"</c:if>>摩羯座</option>
                    <option value="水瓶座" <c:if test="${singer.constellation=='水瓶座'}">selected="selected"</c:if>>水瓶座</option>
                    <option value="双鱼座" <c:if test="${singer.constellation=='双鱼座'}">selected="selected"</c:if>>双鱼座</option>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">粉丝数</label>
            <div class="layui-input-inline">
                <input type="text" name="fans" value="${singer.fans}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">简介</label>
            <div class="layui-input-inline">
                <textarea name="synopsis" style="width:515px;" value="${singer.synopsis}"  placeholder="请输入" class="layui-textarea">${singer.synopsis}</textarea>
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

