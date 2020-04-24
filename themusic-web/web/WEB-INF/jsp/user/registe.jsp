
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户注册</title>
    <link rel="SHORTCUT ICON" href="/file/themusic/ico/page.ico"/>
    <link rel="stylesheet" href="/static/css/registe/reset.css" />
    <link rel="stylesheet" href="/static/css/registe/common.css" />
    <link rel="stylesheet" href="/static/css/registe/font-awesome.min.css" />
    <script type="text/javascript" src="/static/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<div class="wrap login_wrap">
    <div class="content">
        <div class="logo"></div>
        <div class="login_box">
            <div class="login_form">
                <div class="login_title">
                    注册
                </div>
                <form>
                    <!--用户名-->
                    <div class="form_text_ipt">
                        <input id="loginName" name="username" type="text" placeholder="用户名(长度<=10)" maxlength="10">
                    </div>
                    <div class="ececk_warning"><span>用户名不能为空</span></div>
                    <!--密码-->
                    <div class="form_text_ipt">
                        <input id="password" name="password" type="password" placeholder="密码(长度<=16)" maxlength="16">
                    </div>
                    <div class="ececk_warning"><span>密码不能为空</span></div>
                    <!--手机号-->
                    <div class="form_text_ipt">
                        <input id="mobile" name="mobile_code" type="text" placeholder="手机号">
                    </div>
                    <div class="ececk_warning"><span>手机号不能为空</span></div>
                    <!--验证码输入框-->
                    <div class="form_text_ipt" style="width:170px;margin-left:28px;display:inline-block;">
                        <input id="mobileCode" name="code" type="text" placeholder="验证码" style="width:165px;">
                    </div>
                    <!--获取验证码-->
                    <div style="width:110px;margin-left:10px;display:inline-block;">
                        <input type="button" class="obtain generate_code" value=" 获取验证码" οnclick="settime(this);" style="background-color:#f5f5f5;border:none;height:40px;width:115px;border-radius:2px;color:#929aab;font-size:18px;">
                    </div>
                    <div class="ececk_warning"><span>验证码不能为空</span></div>
                    <!--协议-->
                    <div style="width:300px;margin-left:28px;margin-top:20px;">
                        <input id="license" type="checkbox"><span style="font-size:15px;margin-left:5px;">我已阅读并同意《TheMusic用户条例》</span></input>
                    </div>

                    <!--注册按钮-->
                    <div class="form_btn">
                        <button id="btnSubmit" type="button">注册</button>
                    </div>
                    <div class="form_reg_btn">
                        <span>已有帐号？</span><a href="index.html">马上登录</a>
                    </div>
                </form>
                <div class="other_login">
                    <div class="left other_left">
                        <span>其它登录方式</span>
                    </div>
                    <div class="right other_right">
                        <a href="#"><i class="fa fa-qq fa-2x"></i></a>
                        <a href="#"><i class="fa fa-weixin fa-2x"></i></a>
                        <a href="#"><i class="fa fa-weibo fa-2x"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div style="text-align:center;">
</div>

<script>
    //倒计时
    var countdown = 0;

    $(document).ready(function(){

        settime($(".generate_code"));
        inputEffect();
        clickCode();
        clickRegiste();

    })

    //输入框特效
    function inputEffect(){
        $('.form_text_ipt input').focus(function(){
            $(this).parent().css({
                'box-shadow':'0 0 3px #bbb',
            });
        });
        $('.form_text_ipt input').blur(function(){
            $(this).parent().css({
                'box-shadow':'none',
            });
        });
    }
    //验证码倒计时
    function settime(val) {
        if (countdown == 0) {
            val.removeAttr("disabled");
            val.val("获取验证码");
            val.css({"background-color":"#1EAFED","color":"white"});
            countdown = 60;
            return false;
        } else {
            val.attr("disabled", true);
            val.val("重新发送(" + countdown + ")");
            val.css({"background-color":"#F5F5F5","color":"#929aab"});
            countdown--;
        }
        setTimeout(function() {
            settime(val);
        }, 1000);
    }
    //点击获取验证码按钮
    function clickCode(){
        $(".generate_code").click(function(){
            //判断手机号是否合法
            var phone = $("#mobile").val();
            var result = checkPhone(phone);
            if(result == true){
                //合法,//发送短信验证码
                $.ajax({
                    method:"GET",
                    url:"/registe/code?phoneNumber="+phone
                }).done(function(resp){
                    if(resp.code=="200"){
                        //短信发送成功
                        alert("短信已发送到手机!");
                        countdown=60;
                    }
                }).fail(function(){
                    alert("发送短信失败");
                })
            }else{
                //不合法
                alert("手机号不合法!");
                countdown=0;
            }
            settime($(".generate_code"));
        })
    }
    //判断手机号是否合法
    function checkPhone(phone){
        var myreg = /^(((13[0-9]{1})|(14[0-9]{1})|(17[0]{1})|(15[0-3]{1})|(15[5-9]{1})|(18[0-9]{1}))+\d{8})$/;
        if(!myreg.test(phone)){
            return false;
        }else{
            return true;
        }
    }
    //点击注册按钮
    function clickRegiste(){
        $("#btnSubmit").on("click",function(){
            //账号
            var loginName = $("#loginName").val();
            //密码
            var password = $("#password").val();
            //验证手机号
            var phone = $("#mobile").val();
            var result = checkPhone(phone);
            //手机验证码
            var code = $("#mobileCode").val();
            //判断是否填写信息完整
            var isComplete = (loginName !="" &&password !="" && phone!="" && code!="");
            if(isComplete ==true){
                //判断协议是否打勾
                var checkLicense = $("#license").prop("checked");
                if(checkLicense == true){
                    // 打勾
                    // 验证短信验证码
                    var loginDTO = new Object();
                    loginDTO.loginName = loginName;
                    loginDTO.password = password;
                    loginDTO.phone = phone;
                    loginDTO.code = code;
                    loginDTO=JSON.stringify(loginDTO);
                    $.ajax({
                    	method:"POST",
                    	url:"/registe/checkCode",
                    	data:loginDTO,
                    	contentType:"application/json"
                    }).done(function(resp){
                    	if(resp.code=="200"){
                    		alert("注册成功，请前往登录!")
                    	}else{
                    		alert(resp.message);
                    	}
                    })
                }else{
                    //提示没有同意协议
                    alert("请先同意协议!")
                }
            }else{
                //提示信息填写不完整
                alert("信息填写不完整!");
            }
        })
    }
</script>
</body>
</html>

