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
<link rel="icon" href="${pageContext.request.contextPath }/img/tianjia.png" type="image/x-icon" /> 
<link rel="shortcut icon" href="${pageContext.request.contextPath }/img/tianjia.png" type="image/x-icon" />
<title>添加歌曲</title>
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<link rel="stylesheet" href="../jquery-easyui-1.6.5/themes/default/easyui.css" />
<link rel="stylesheet" href="../jquery-easyui-1.6.5/themes/icon.css" />
<script src="../jquery-easyui-1.6.5/jquery.min.js"></script>
<script src="../jquery-easyui-1.6.5/jquery.easyui.min.js"></script>
<script src="../jquery-easyui-1.6.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../jQuery/Concurrent.Thread.js"></script>
<script type="text/javascript" src="../js/add_music.js"></script>
<style>
body{
	background:#000;
	color:#FFF;
}
a:link,a:visited{ 
 text-decoration:none;
} 
a:hover{ 
 text-decoration:underline;
}
#list li {
	float: left;
	width: 45px;
	height: 45px;
	border: solid 1px #cef8af;
	box-sizing: border-box;
	text-align: center;
	line-height: 41px;
	background: #333;
	color: white;
	position: relative;
	list-style-type: none;
}
#list li.active {
	background: #495894;
}
#list li.active:after {
	height:200px;
}
#list li:after {
	content: "";
	position: absolute;
	width: 100%;
	height: 0;
	background: #59feae;
	bottom: 43px;
	left: 0;
	opacity:0.6;
	transition: all 0.1s ease-in-out;
}
::-webkit-scrollbar {
 width: 8px;
 background-color: #000;
}
    /*定义滚动条轨道 内阴影+圆角*/  
::-webkit-scrollbar-track {
 border-radius: 10px;
 -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
 background-color: #111;
}
    /*定义滑块 内阴影+圆角*/  
::-webkit-scrollbar-thumb {
 border-radius: 10px;
 -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
 background-color: #444;
}
.scroll{
	overflow:auto;
}
.calss_name{
	margin:7px;
}
.calss_set{
	margin:7px;
}

		.zhezhao {
		    display: none;           /* 修改这里可以让遮罩层消失*/
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
		   	display: none;        /* 修改这里可以让框消失*/
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
</style>
<script type="text/javascript">
$(function(){
	var flag=false;
	$("#sub").click(function(){
		var title=$("#add_name").val();
		var content=$("#add_text").val();
		var reg=/^[A-Za-z][A-Za-z\s\n]*[A-Za-z]$/;
		var reg1=/^[A-Za-z\s\n][A-Za-z]*[A-Za-z\s\n]$/;
		var reg2=/^[A-Za-z]$/;
		var f=false;
		if(title==null||title==""){
			alert("歌曲名称不能为空！");
			f=true;
		}
		if(content==null||content==""){
			alert("歌曲内容不能为空！");
			f=true;
		}
		if(!reg.test(content)&&!reg1.test(content)&&!reg2.test(content)){
			alert("歌曲内容中的字符只能是字母、空格和换行！");
			f=true;
		}
		if(f){
			return;
		}
		$.ajax({
			url:"addMusic",
			async:false,
			type:"post",
			data:{
			"title":title,
			"content":content
		},
		dataType:"json",
		success:function(res){
			var userName="${USER_LOGIN.userName}";
			if(res=="ok"){
				$("#h").html(userName+",恭喜您：").css("color",'black');
				$("#con").html("您的音乐上传成功！").css("color",'black');
				$('.zhezhao').css('display', 'block');
				$('#result').fadeIn();
				flag=true;
			}else{ 
				$("#h").html(userName+",很抱歉！").css("color",'black');
				$("#con").html("您的音乐上传失败！").css("color",'red');
				$('.zhezhao').css('display', 'block');
				$('#result').fadeIn();
				flag=false;
			}
		}
		});
	});
	$("#sure").click(function(){
		$('.zhezhao').css('display', 'none');
		$('#result').fadeOut();
		if(flag){
			location="welcome";
		}
	});
});
</script>
</head>
<body>
<nav>
	<table width="100%">
		<tr width="70%" align="center">
			<td width="20%"></td>
			<td  align="center" width="60%" style="font-size:36px">
				<b id="name">添加歌曲</b>
			</td>
			<td width="20%" style="color:#FF0">
				<span id="admin">您好，管理员<strong style="color:red;">${USER_LOGIN.userName }</strong></span>&nbsp;
				<a href="logOut" id="logOut" class="easyui-linkbutton">退出登录</a>
			</td>
		</tr>
	</table>
</nav>
<table width="100%" id="major">
	<tr>
		<td width="85%">
			<div class="scroll" style=" background:#999">
				<div class="name_div">
					<div style=" margin-top:15px; width:100%">
						<p style="font-size:26px">请输入歌曲名：<input style="font-size:26px" type="text"  size="20" id="add_name"/>&nbsp;&nbsp;<input class="easyui-linkbutton" type="button" value="重置"  onclick="dle_music()" style="width: 100px;height: 40px;"/></p>
						<div align="center">
							<textarea rows="10"  style="width:99%; font-size:24px" id="add_text"></textarea>
						</div>
					</div>
					<p align="center"><button id="sub" class="easyui-linkbutton">上传歌曲</button></p>
					<div style="background:#666; height:400px; width:100%; overflow:auto" id="add_div"></div>
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
					  	<li><a href="toupdatepass"><span>修改个人信息</span></a></li>
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
