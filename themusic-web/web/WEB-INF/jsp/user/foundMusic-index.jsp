
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<h2 style="text-align: center;font-size: 35px;margin-top:20px;margin-bottom:20px;">新歌首发</h2>
<div class="c-banner">
    <div class="banner">
        <ul>

        </ul>
    </div>
    <div class="jumpBtn">
        <ul>

        </ul>
    </div>
    <div class="preImg">
        <img src="/file/themusic/img/carousel/preImg.png" />
    </div>
    <div class="nexImg">
        <img src="/file/themusic/img/carousel/nexImg.png" />
    </div>
</div>

<h2 style="text-align: center;font-size: 35px;margin-top:20px;margin-bottom:20px;">MV</h2>
<div id="mv-container">

</div>
<script>
    //定时器返回值
    var time=null;
    //记录当前位子
    var nexImg = 0;
    //用于获取轮播图图片个数
    var imgLength = $(".c-banner .banner ul li").length;
    //当时动态数据的时候使用,上面那个删除
    // var imgLength =0;
    //设置底部第一个按钮样式
    $(".c-banner .jumpBtn ul li[jumpImg="+nexImg+"]").css("background-color","black");

    //页面加载
    $(document).ready(function(){
        dynamicData();
        //启动定时器,设置时间为3秒一次
        time =setInterval(intervalImg,3000);
        loadHomeMVList();
    });

    //点击上一张
    $(".preImg").click(function(){
        //清楚定时器
        clearInterval(time);
        var nowImg = nexImg;
        nexImg = nexImg-1;
        console.log(nexImg);
        if(nexImg<0){
            nexImg=imgLength-1;
        }
        //底部按钮样式设置
        $(".c-banner .jumpBtn ul li").css("background-color","white");
        $(".c-banner .jumpBtn ul li[jumpImg="+nexImg+"]").css("background-color","black");

        //将当前图片试用绝对定位,下一张图片试用相对定位
        $(".c-banner .banner ul img").eq(nowImg).css("position","absolute");
        $(".c-banner .banner ul img").eq(nexImg).css("position","relative");

        //轮播淡入淡出
        $(".c-banner .banner ul li").eq(nexImg).css("display","block");
        $(".c-banner .banner ul li").eq(nexImg).stop().animate({"opacity":1},1000);
        $(".c-banner .banner ul li").eq(nowImg).stop().animate({"opacity":0},1000,function(){
            $(".c-banner ul li").eq(nowImg).css("display","none");
        });

        //启动定时器,设置时间为3秒一次
        time =setInterval(intervalImg,3000);
    })

    //点击下一张
    $(".nexImg").click(function(){
        clearInterval(time);
        intervalImg();
        time =setInterval(intervalImg,3000);
    })

    //轮播图
    function intervalImg(){
        if(nexImg<imgLength-1){
            nexImg++;
        }else{
            nexImg=0;
        }

        //将当前图片试用绝对定位,下一张图片试用相对定位
        $(".c-banner .banner ul img").eq(nexImg-1).css("position","absolute");
        $(".c-banner .banner ul img").eq(nexImg).css("position","relative");

        $(".c-banner .banner ul li").eq(nexImg).css("display","block");
        $(".c-banner .banner ul li").eq(nexImg).stop().animate({"opacity":1},1000);
        $(".c-banner .banner ul li").eq(nexImg-1).stop().animate({"opacity":0},1000,function(){
            $(".c-banner .banner ul li").eq(nexImg-1).css("display","none");
        });
        $(".c-banner .jumpBtn ul li").css("background-color","white");
        $(".c-banner .jumpBtn ul li[jumpImg="+nexImg+"]").css("background-color","black");
    }

    //轮播图底下按钮
    //动态数据加载的试用应放在请求成功后执行该代码,否则按钮无法使用
    $(".c-banner .jumpBtn ul li").each(function(){
        //为每个按钮定义点击事件
        $(this).click(function(){
            clearInterval(time);
            $(".c-banner .jumpBtn ul li").css("background-color","white");
            jumpImg = $(this).attr("jumpImg");
            if(jumpImg!=nexImg){
                var after =$(".c-banner .banner ul li").eq(jumpImg);
                var befor =$(".c-banner .banner ul li").eq(nexImg);

                //将当前图片试用绝对定位,下一张图片试用相对定位
                $(".c-banner .banner ul img").eq(nexImg).css("position","absolute");
                $(".c-banner .banner ul img").eq(jumpImg).css("position","relative");

                after.css("display","block");
                after.stop().animate({"opacity":1},1000);
                befor.stop().animate({"opacity":0},1000,function(){
                    befor.css("display","none");
                });
                nexImg=jumpImg;
            }
            $(this).css("background-color","black");
            time =setInterval(intervalImg,3000);
        });
    });

    //动态数据轮播图
    //动态数据加载的时候不要直接点击demo.html运行否则可能请求不到本地json数据
    function dynamicData(){
    	$.ajax({
            method:"GET",
    		url:"/home/carousel"
    	}).done(function(data){
            if(data.code==200){
                var data = data.data;
                $.each(data,function(i){
                    $(".c-banner .banner ul").append('<li><img songId='+this.songId+' src="/file/themusic/img/song/'+this.pictureSrc+'"></li>');
                    $(".c-banner .jumpBtn ul").append('<li jumpImg="'+i+'"></li>')
                })
            }
            //获取图片总数量
            imgLength = $(".c-banner .banner ul li").length;
            //为底部按钮定义单击事件
            $(".c-banner .jumpBtn ul li").each(function(){
                //为每个按钮定义点击事件
                $(this).click(function(){
                    clearInterval(time);
                    $(".c-banner .jumpBtn ul li").css("background-color","white");
                    jumpImg = $(this).attr("jumpImg");
                    if(jumpImg!=nexImg){
                        var after =$(".c-banner .banner ul li").eq(jumpImg);
                        var befor =$(".c-banner .banner ul li").eq(nexImg);

                        //将当前图片试用绝对定位,下一张图片试用相对定位
                        $(".c-banner .banner ul img").eq(nexImg).css("position","absolute");
                        $(".c-banner .banner ul img").eq(jumpImg).css("position","relative");

                        after.css("display","block");
                        after.stop().animate({"opacity":1},1000);
                        befor.stop().animate({"opacity":0},1000,function(){
                            befor.css("display","none");
                        });
                        nexImg=jumpImg;
                    }
                    $(this).css("background-color","black");
                    time =setInterval(intervalImg,3000);
                });
            });
        }).fail(function(){
            alert("动态获取图片失败!");
        })
        clickCarouselImg();
    }

    function clickCarouselImg(){
        $(".banner").on("click","img",function(e){
            var songId = $(e.target).attr("songId");
            console.log(songId);
            //先把歌曲添加到播放器
            var songIds = new Array();
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
                    "left":85+"px",
                    "top":30+"px",
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
                    "top":45+"px",
                    "font-size":70+"px"},
                100).fadeOut(100);
        }).on("click",function(e){
            if($(e.target).prop("tagName")!="DIV"){
                mvId =$(e.target).parent().attr("mvId");
            }else{
                mvId =$(e.target).attr("mvId");
            }
            window.open("/mv/play?mvId="+mvId,"mv_index");
        })
    }
    //加载mv
    function loadHomeMVList(){
        $.ajax({
            method:"GET",
            url:"/home/mv"
        }).done(function(resp){
            $("#mv-container").html(resp);
            mourseEnterMv();
        }).fail(function(){
            alert("查询mv失败");
        })
    }
</script>

