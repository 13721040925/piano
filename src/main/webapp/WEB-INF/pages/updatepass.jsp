<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="icon" href="${pageContext.request.contextPath }/img/xiugai.png" type="image/x-icon" /> 
<link rel="shortcut icon" href="${pageContext.request.contextPath }/img/xiugai.png" type="image/x-icon" />
<title>修改个人信息</title>
<link rel="stylesheet" href="../css/jigsaw.css"/> 
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<link rel="stylesheet" href="../jquery-easyui-1.6.5/themes/default/easyui.css" />
<link rel="stylesheet" href="../jquery-easyui-1.6.5/themes/icon.css" />
<script src="../jquery-easyui-1.6.5/jquery.min.js"></script>
<script src="../jquery-easyui-1.6.5/jquery.easyui.min.js"></script>
<script src="../jquery-easyui-1.6.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../jQuery/Concurrent.Thread.js"></script>
<script type="text/javascript" src="../js/add_music.js"></script>
<style>
*{
	margin: 0;
	padding: 0;
}
body{
	background:#000;
	color:#FFF;
}
#up{
	margin: 0 auto;
	width: 50%;
}
.fo_up,.sliderContainer,.slider,.sliderMask{
	margin-bottom: 10px;
	padding-top: 30px;
	padding-bottom: 10px;
}
.providerAddBtn{
	margin-bottom: 10px;
	padding-bottom: 10px;
}
label{
	display:inline-block;
	width: 140px;
	text-align: left;
}
.sp{
	display:inline-block;
	width:400px; 
}
.put{
	border-radius: 5px;
	height: 25px;
}
.zhezhao {
		    display: none;
		    position: absolute;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: #000;
		    opacity: 0.7;
		    filter: alpha(opacity=70);
		    overflow: hidden;
		}
		.result{
		   	display: none;
		    width: 400px; 
		    height: 190px;
		    margin: 20% auto;
		    position: absolute;
		    top: 0;
		    left: 0;
		    bottom: 0;
		    right: 0;
		    background: #fff;
		    border-radius: 4px;
		}
		.resultChid{
		    margin-left: -6px;
		}
		.resultChid h2{
			text-align:center;
		    padding-left: 8px;
		    font-size: 14px;
		    line-height: 30px;
		    margin: 4px 8px;
		    border-bottom: 1px solid #99cc33;
		}
		.resultMain{
		    margin-top: 38px;
		    text-align: center;
		    margin-bottom: 30px;
		    border-radius: 4px;
		}
		.resultMain button{
		    padding: 0 20px;
		    display: inline-block;
		    height: 30px;
		    line-height: 30px;
		    border-radius: 4px;
		    border: 1px solid #5e8809;
		    margin-top: 30px;
		    background: #99cc33;
		    color: #fff;
		}
		.resultMain button:hover,.resultMain button:active{
		    background: #679016;
		    cursor: pointer;
		}
		
		
		.container {
	      width: 310px;
	     /*  margin: 0 auto; */
	      height: 250px;
	      padding:0;
	      position: relative;
	      left:0;
	      right: 0;
	      top:0;
	      bottom: 0;
	    }
	    #msg {
	      width: 100%;
	      line-height: 40px;
	      font-size: 14px;
	      text-align: center;
	    }
	    .sliderText{
	    	display: inline-block;
	    	margin: -10px auto;
	    	font-family: "微软雅黑";
	    }
</style>
<script type="text/javascript">
var result="${result}";
var code="";
var fl=false;
$(function(){
	formSubmit();
	$("#reset").click(function(){
		window.location.reload();
	});
	$("#userName").blur(function(){
		checkUserName();
	});
	$("#userName").focus(function(){
		var sp=$(this).next();
		sp.empty();
	});
	$("#passWord").blur(function(){
		checkPassWord();
	});
	$("#passWord").focus(function(){
		var sp=$(this).next();
		sp.empty();
	});
	$("#userRemi").blur(function(){
		checkUserRemi();
	});
	$("#userRemi").focus(function(){
		var sp=$(this).next();
		sp.empty();
	});
	$("#phone").blur(function(){
		checkPhone();
	});
	$("#phone").focus(function(){
		var sp=$(this).next();
		sp.empty();
	});
	$("#codeValue").blur(function(){
		checkCodeValue();
	});
	$("#codeValue").focus(function(){
		var sp=$(this).next().next();
		sp.empty();
	});
	getResult();
	$("#sure").click(function(){
		$('.zhezhao').css('display', 'none');
		$('#result').fadeOut();
		if(result=="修改成功!"){
			location="upSuccess";
		}
	});
});
function checkUserName(){
	var userName=$("#userName");
	var sp=userName.next();
	var v=userName.val();
	sp.empty();
	var st="";
	var reg=/^[a-zA-Z0-9_]{6,20}$/;
	if(!reg.test(v)){
		st="用户名必须是字母、数字、下划线组成的6~20个字符！";
		sp.html(st).css("color","red");
		return false;
	}
	var flag=false;
	$.ajaxSettings.async = false;
	$.post("checkUser",{
		"userName":v
	},function(res){
		if(res=="no"){
			flag=true;
		}
	},"json");
	$.ajaxSettings.async = true;
	if(!flag){
		st="用户名已被占用！";
		sp.html(st).css("color","red");
		return false;
	}
	sp.html("&radic;").css("color","green");
	return true;
}
function checkPassWord(){
	var passWord=$("#passWord");
	var sp=passWord.next();
	var v=passWord.val();
	sp.empty();
	var st="";
	var reg=/^[a-zA-Z0-9_]{6,20}$/;
	if(!reg.test(v)){
		st="密码必须是字母、数字、下划线组成的6~20个字符！";
		sp.html(st).css("color","red");
		return false;
	}
	sp.html("&radic;").css("color","green");
	return true;
}
function checkUserRemi(){
	var userRemi=$("#userRemi");
	var sp=userRemi.next();
	var v=userRemi.val();
	var v1=$("#passWord").val();
	sp.empty();
	var st="";
	var reg=/^[a-zA-Z0-9_]{6,20}$/;
	if(!reg.test(v)){
		st="密码必须是字母、数字、下划线组成的6~20个字符！";
		sp.html(st).css("color","red");
		return false;
	}
	if(v!=v1){
		st="两次输入的密码不一致！";
		sp.html(st).css("color","red");
		return false;
	}
	sp.html("&radic;").css("color","green");
	return true;
}
function checkPhone(){
	var phone=$("#phone");
	var sp=phone.next();
	var v=phone.val();
	sp.empty();
	var st="";
	var reg=/^[1][3,4,5,7,8][0-9]{9}$/;
	if(!reg.test(v)){
		st="手机号格式不正确！";
		sp.html(st).css("color","red");
		return false;
	}
	sp.html("&radic;").css("color","green");
	return true;
}
function checkCodeValue(){
	var codeValue=$("#codeValue");
	var sp=codeValue.next().next();
	var v=codeValue.val();
	sp.empty();
	var st="";
	if(v.length<=0){
		st="验证码不能为空！";
		sp.html(st).css("color","red");
		return false;
	}
	if(v!=code){
		st="验证码不正确！";
		sp.html(st).css("color","red");
		return false;
	}
	sp.html("&radic;").css("color","green");
	return true;
}
function formSubmit(){
	$("#up").submit(function(){
		var flag=checkUserName()&checkPassWord()&checkUserRemi()&checkPhone()&checkCodeValue()&fl;
		if(flag==0){
			if(!fl){
				$("#h").html("").css("color",'black');
		    	$("#con").html("请验证滑块验证码！").css("color",'black');
		    	$('.zhezhao').css('display', 'block');
		    	$('#result').fadeIn();
			}
			return false;
		}
		return true;
	});
}
function getResult(){
	if(result=="修改成功!"){
		$("#h").html("恭喜您：").css("color",'black');
		$("#con").html("您的信息"+result).css("color",'black');
		$('.zhezhao').css('display', 'block');
		$('#result').fadeIn();
	}
	if(result=="修改失败!"){
		$("#h").html("很抱歉！").css("color",'black');
		$("#con").html("您的信息"+result).css("color",'red');
		$('.zhezhao').css('display', 'block');
		$('#result').fadeIn();
	}
}
$(function(){
	$("#send").on("click", function(){
		var phone=$("#phone").val();
		var userName="${USER_LOGIN.userName}";
	    $.ajax({
	        url: "sendSms",
	        async : true, 
	        type: "post",  
	        dataType: "json", 
	        data: {"phone":phone},  
	        //请求成功后的回调函数 
	        success: function (res) {  
	            code=JSON.stringify(res);//json转化为字符串
	            code=code.substring(15,21);//截取字符串
	            if(checkPhone()){
	            	$("#h").html(userName+"您好：").css("color",'black');
		    		$("#con").html("您的短信验证码已发送成功，请您注意查收！").css("color",'black');
		    		$('.zhezhao').css('display', 'block');
		    		$('#result').fadeIn();
	            }else{
	            	$("#h").html(userName+"您好：").css("color",'black');
	        	    $("#con").html("您的手机号格式不正确 不能发送短信验证码！").css("color",'black');
	        	    $('.zhezhao').css('display', 'block');
	        	    $('#result').fadeIn();
	            }
	        },  
			error:function(res){
				$("#h").html(userName+"很抱歉！").css("color",'black');
	    		$("#con").html("您的短信验证码发送失败，请您重新获取验证码！").css("color",'red');
	    		$('.zhezhao').css('display', 'block');
	    		$('#result').fadeIn();  
			}
	    });
	});
});
var countdown=60;
function settime(ph) {
	var flag=checkPhone(); 
	var userName="${USER_LOGIN.userName}";
	 if(!flag){
		$("#h").html(userName+"您好：").css("color",'black');
	    $("#con").html("您的手机号格式不正确 不能发送短信验证码！").css("color",'black');
	    $('.zhezhao').css('display', 'block');
	    $('#result').fadeIn();
        return false;  
	 }else{
		 if (countdown == 0) {
	    	  ph.removeAttribute("disabled");//删除disabled属性
	    	  $("#send").text("重新获取"); 
	    	  $("#send").css("width","110px");   
	            countdown = 60;
	            return false; 
	      }else {
	    	  ph.setAttribute("disabled", true);// 添加属性参数1 属性 参数2 赋值。不能单机
	    	  $("#send").text("重新获取(" + countdown + ")"); 
	    	  $("#send").css("width","110px");  
	          countdown--; 
	      }
	      setTimeout(function() { 
	            settime(ph); 
	      },1000);
	 }
}
</script>
</head>
<body style="height:100%;">
<nav>
	<table width="100%">
		<tr width="70%" align="center">
			<td width="20%"></td>
			<td  align="center" width="60%" style="font-size:36px">
				<b id="name">修改个人信息</b>
			</td>
			<td width="20%" style="color:#FF0">
				<span id="admin">您好，管理员<strong style="color:red;">${USER_LOGIN.userName }</strong></span>&nbsp;
				<a href="logOut" id="logOut" class="easyui-linkbutton">退出登录</a>
			</td>
		</tr>
	</table>
</nav>
<table width="100%" style="height:80%;"  id="major">
	<tr>
		<td width="85%">
			<div class="scroll" style=" background:#999">
				<div class="name_div"> 
					<form action="userUpdate" method="post" id="up">
						<input type="hidden" name="id" value="${USER_LOGIN.id }" />
						<div class="fo_up">
							<label for="userName"><span style="color:red;">*</span>请输入新用户名：</label>
							<input class="put" style="width: 250px;height: 30px;" type="text" name="userName" id="userName" required />
							<span class="sp"></span>
						</div>
						<div class="fo_up">
							<label for="passWord"><span style="color:red;">*</span>请输入新密码：</label>
							<input class="put" style="width: 250px;height: 30px;" type="password" name="passWord" id="passWord" required />
							<span class="sp"></span>
						</div>
						<div class="fo_up">
							<label for="userRemi"><span style="color:red;">*</span>确认密码：</label>
							<input class="put" style="width: 250px;height: 30px;" type="password"  id="userRemi" required />
							<span class="sp"></span>
						</div>
						<div class="fo_up">
							<label for="phone"><span style="color:red;">*</span>请输入手机号：</label>
							<input class="put" style="width: 250px;height: 30px;" type="text" name="phone" id="phone" required  />
							<span class="sp"></span>
						</div>
						<div class="fo_up">
							<label for="codeValue"><span style="color:red;">*</span>手机验证码：</label>
							<input class="put" style="width: 150px;height: 30px;" type="text" id="codeValue" required  />
							<button id="send" style="width: 100px;height: 35px;" class="easyui-linkbutton" onclick="settime(this)">获取验证码</button>
							<span></span>
						</div>
						<div class="container"> 
						  <div id="captcha" style="position: relative;margin-top: 50px;"></div>
						</div>
						<script src="../js/jigsaw.js"></script>
						<script>
						  jigsaw.init(document.getElementById('captcha'), function () {
							  fl=true;
						  })
						</script>
						<div class="providerAddBtn">
							<input type="submit" style="width: 100px;height: 30px;" class="easyui-linkbutton" value="修改" />
							<input type="reset" style="width: 100px;height: 30px;" class="easyui-linkbutton" id="reset" value="重置" />
							<input type="button" style="width: 100px;height: 30px;" class="easyui-linkbutton" value="返回" onclick="history.back(-1)" />
						</div>
					</form>
					<div style="background:#666; height:900px; width:100%; overflow:auto" id="add_div"></div>
			 	</div>
			</div> 
		</td>
		<td width="15%" style="background:#555" id="functionArea">
			<div class="scroll" style="width:100%; height:100%; margin:5px">
				<div style=" margin:10px" class="scroll">
					<div class="nav-main">
				<div class="nav-box">
					<div class="nav">
					  <ul class="nav-ul">
					  	<li><a href="welcome"><span>返回首页</span></a></li>
					  	<li><a href="toAdd"><span>添加歌曲</span></a></li>
					  </ul>
					</div>
				</div>
			</div>
		</td>
	</tr>
</table>
<div class="zhezhao"></div>
<div class="result" id="result">
	<div class="resultChid">
		<h2 id="h"></h2>
		<div class="resultMain">
			<p id="con"></p>
			<button id="sure">确定</button>
		</div>
	</div>
</div>
</body>
</html>
