
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div style="margin-bottom: 5px;">

    <ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px" data-ad-client="ca-pub-6111334333458862" data-ad-slot="3820120620"></ins>

</div>

<div class="layui-btn-group demoTable">
    <button id="btnAddMv" class="layui-btn" style="margin-left:10px !important;">添加一个MV</button>
    <button id="btnDeleteMvs" class="layui-btn layui-btn-danger" data-type="getCheckData" style="margin-left:10px !important;">删除选中MV</button>
</div>

<table id="tb"  lay-filter="demo"></table>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


