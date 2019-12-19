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
<link rel="icon" href="${pageContext.request.contextPath }/img/logo.jpg" type="image/x-icon" /> 
<link rel="shortcut icon" href="${pageContext.request.contextPath }/img/logo.jpg" type="image/x-icon" />
<title>冰山键盘钢琴</title>
<link rel="stylesheet" type="text/css" href="../css/index.css" />
<link rel="stylesheet" href="../jquery-easyui-1.6.5/themes/default/easyui.css" />
<link rel="stylesheet" href="../jquery-easyui-1.6.5/themes/icon.css" />
<script src="../jquery-easyui-1.6.5/jquery.min.js"></script>
<script src="../jquery-easyui-1.6.5/jquery.easyui.min.js"></script>
<script src="../jquery-easyui-1.6.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../jQuery/Concurrent.Thread.js"></script>
<script type="text/javascript" src="../js/audios.js"></script>
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
#functionArea,#admin,#logOut{
	display: none;
}
#major{
	 width:85%;
}
</style>
<script type="text/javascript">
$(function(){
	show();
});
function show(){
	var user="${USER_LOGIN}";
	if(user!=null&&user!=""){
		$("#major").css("width","70%");
		$("#login").hide();
		$("#functionArea").show();
		$("#admin").show();
		$("#logOut").show();
	}
}
</script>
</head>
<body onload="ready()">
<nav>
	<table width="100%">
		<tr width="100%" align="center">
			<td width="20%"></td>
			<td  align="center" width="60%" style="font-size:36px">
				<b id="name">冰山键盘钢琴</b>
			</td>
			<td width="20%" style="color:#FF0">
				<a href="login" id="login" class="easyui-linkbutton">管理员点此登录</a>
				<span id="admin">您好，管理员<strong style="color:red;">${USER_LOGIN.userName }</strong></span>&nbsp;
				<a href="logOut" id="logOut" class="easyui-linkbutton">退出登录</a>
			</td>
		</tr>
	</table>
</nav>
<table width="100%">
	<tr>
		<td width="15%" style="background:#555">
			<p style="margin-top:50px; margin-left:30px"><b>歌曲名:</b></p>
			<div class="scroll" style="margin:5p;" id="add_musicname">
			</div>
		</td>
		<td id="major">
			<div id="aii" class="scroll" style=" background:#999">
				<div style="display:block" class="name_div">
					<p align="center" style="font-size:60px; color:#000; margin-top:100px">努力-_-拼命加载中。。。</p>
					<p align="center" style="font-size:60px; color:#000; margin-top:100px">请耐心等待几秒钟-_-。。。</p>
				</div>
				<div id="tianjia_div" style="display:none" class="name_div">
					<p align="center">添加歌曲</p>
					<div style=" margin-top:15px; width:100%">
						<p style="font-size:26px">请输入歌曲名：<input style="font-size:26px" type="text"  size="20" id="add_name"/>&nbsp;&nbsp;<input type="button" value="重置"  onclick="dle_music()"/></p>
						<div align="center">
							<textarea rows="10"  style="width:99%; font-size:24px" id="add_text"></textarea>
						</div>
					</div>
					<p align="center"><input type="button" value="测试歌曲"  onclick="ubd_music()"/></p>
					<div style="background:#666; height:400px; width:100%; overflow:auto" id="add_div"></div>
					<p align="center"><input type="button" value="上传歌曲" onclick="add_music()" /></p>
				</div>
			</div>
		</td>
		<td width="15%" style="background:#555" id="functionArea">
			<div class="scroll" style="width:100%; height:100%; margin:5px">
				<div id="daohang" style=" margin:10px" class="scroll">
				<div class="nav-main">
				<div class="nav-box">
					<div class="nav">
					  <ul class="nav-ul">
					  	<li><a href="#" onclick="set_event_kaishi()"><span>重新开始</span></a></li>
					  	<li><a href="toAdd"><span>添加歌曲</span></a></li>
					  	<li><a href="toupdatepass"><span>修改个人信息</span></a></li>
					  	<li><a href="https://www.magicpeng.com"><span>返回网站首页</span></a></li>
					  </ul>
					</div>
				</div>
				</div>
				</div>
			</div>
		</td>
	</tr>
</table>
<div align="center">
	<ul id="list" class=""  style="font-size:36px; margin-top:-34px">
		<li>A</li>
		<li>B</li>
		<li>C</li>
		<li>D</li>
		<li>E</li>
		<li>F</li>
		<li>G</li>
		<li>H</li>
		<li>I</li>
		<li>J</li>
		<li>K</li>
		<li>L</li>
		<li>M</li>
		<li>N</li>
		<li>O</li>
		<li>P</li>
		<li>Q</li>
		<li>R</li>
		<li>S</li>
		<li>T</li>
		<li>U</li>
		<li>V</li>
		<li>W</li>
		<li>X</li>
		<li>Y</li>
		<li>Z</li>
	</ul>
</div>
<audio id="music" src=""></audio>
<div style="display:none">
	<c:forEach items="${list}" var="musicList" varStatus="count" begin="0" step="1">
		<p class="dif_name" id="dif_name${musicList.id}">${musicList.title}</p>
	</c:forEach>
	<c:forEach items="${list}" var="musicList" varStatus="count" begin="0" step="1">
		<p id="dif_name${musicList.id}_text">
			${musicList.content}
		</p>
	</c:forEach>
</div>
</body>
</html>
