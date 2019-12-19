<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html >
<html>
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<link rel="icon" href="${pageContext.request.contextPath }/img/yh.png" type="image/x-icon" /> 
<link rel="shortcut icon" href="${pageContext.request.contextPath }/img/yh.png" type="image/x-icon" />
<title>冰山管理员登录</title>
<style type="text/css">
* {
    margin: 0;
    padding: 0;
}
.loginHeader {
    padding-top: 102px;
    text-align: center;
    padding-bottom: 30px;
}

.loginHeader h1 {
    color: #fff;
    text-shadow: 2px 2px #000;
}

.loginCont {
    width: 388px;
    height: 284px;
    margin: 0 auto;
}

.formBox {
    position: relative;
}

::-webkit-input-placeholder {
    color: rgb(190, 188, 188);
    /*font-style: italic;*/
}

input:-moz-placeholder,
textarea:-moz-placeholder {
    color: rgb(190, 188, 188);
    font-style: italic;
}

input {
    outline: none;
}

.loginForm {
    background: url("img/formBg.png") 0 0 no-repeat;
    width: 320px;
    height: 140px;
    border-radius: 8px;
    padding: 90px 38px 48px 30px;
}

.loginForm label {
    width: 20%;
    display: inline-block;
}

.inputbox {
    height: 60px;
}

.inputbox input {
    width: 66%;
    padding: 10px 5px 10px 20px;
    border: 1px solid rgb(178, 178, 178);
    border-radius: 3px;
    -webkit-box-shadow: 0px 1px 4px 0px rgba(168, 168, 168, 0.6) inset;
    -moz-box-shadow: 0px 1px 4px 0px rgba(168, 168, 168, 0.6) inset;
    box-shadow: 0px 1px 4px 0px rgba(168, 168, 168, 0.6) inset;

}

.inputbox input:active, .providerAdd input:focus,
.inputbox input:focus {
    border: 1px solid rgba(91, 90, 90, 0.7);
    background: rgba(238, 236, 240, 0.2);
    -webkit-box-shadow: 0px 1px 4px 0px rgba(168, 168, 168, 0.9) inset;
    -moz-box-shadow: 0px 1px 4px 0px rgba(168, 168, 168, 0.9) inset;
    box-shadow: 0px 1px 4px 0px rgba(168, 168, 168, 0.9) inset;
}

.subBtn {
    margin-left: 70px;
}

input[type='submit'], input[type='reset'] {
    width: 30%;
    cursor: pointer;
    background: #54a4d7;
    padding: 6px 18px;
    font-family: '微软雅黑';
    color: #fff;
    font-size: 18px;
    border: 1px solid #4682be;
    margin-bottom: 10px;
    margin-right: 22px;
    text-shadow: 0 1px 1px rgba(0, 0, 0, 0.5);
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    -webkit-box-shadow: 0px 1px 4px 4px rgba(0, 0, 0, 0.07) inset,
    0px 0px 0px 3px rgb(254, 254, 254),
    0px 5px 3px 3px rgb(210, 210, 210);
    -moz-box-shadow: 0px 1px 4px 4px rgba(0, 0, 0, 0.07) inset,
    0px 0px 0px 3px rgb(254, 254, 254),
    0px 5px 3px 3px rgb(210, 210, 210);
    box-shadow: 0px 1px 4px 4px rgba(0, 0, 0, 0.07) inset,
    0px 0px 0px 3px rgb(254, 254, 254),
    0px 5px 3px 3px rgb(210, 210, 210);

}

input[type='submit']:hover, input[type='reset']:hover {
    background: rgb(74, 179, 198);
}

input[type='submit']:active, input[type='submit']:focus,
input[type='reset']:active, input[type='reset']:focus, .providerView a:hover, .providerView a:active {
    background: #2a5989;
    border: 1px solid rgb(12, 76, 87);
    -webkit-box-shadow: 0px 1px 6px 4px rgba(0, 0, 0, 0.2) inset;
    -moz-box-shadow: 0px 1px 6px 4px rgba(0, 0, 0, 0.2) inset;
    box-shadow: 0px 1px 6px 4px rgba(0, 0, 0, 0.2) inset;
}

#box{
	position:absolute;
	top:50%;
	left:50%;
	margin:-350px 0 0 -200px;
} 
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/loginStyle.css" />
<script src="${pageContext.request.contextPath }/jquery-easyui-1.6.5/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/vector.js"></script>
<script type="text/javascript">
	$(function(){
		$("#user").blur(function(){
			var sp = $(this).next();
			sp.empty();
			var v = $(this).val();
			$.ajax({
				url:"music/checkUser",
				type:"post",
				data:{
				"userName":v
			},
			dataType:"json",
			success:function(res){
				if(res=="ok"){
					sp.html("&radic;").css("color","green");
				}else{ 
					sp.html("用户名不存在！").css("color","red");
				}
			}
			});
		})
		
		//获得页面的错误信息
		var error = $("#error");
		var msg = "${ERROR}";
		if(msg.length>0){
			error.html(msg).css("color","red");
		}
	});
</script>

</head>
<body id="container">
	<section id="output">
		<div id="box">
			<header class="loginHeader">
			<h1>冰山管理员登录</h1>
		</header>
		<section class="loginCont">
			<form class="loginForm" action="music/doLogin" method ="post">
				<div class="inputbox">
					<label for="user">用户名：</label>
					<input id="user" type="text" name="userName" placeholder="请输入用户名" required />
					<span></span>
				</div>
				<div class="inputbox">
					<label for="mima">密&nbsp;&nbsp;&nbsp;码：</label>
					<input id="mima" type="password" name="passWord" placeholder="请输入密码" required />
					<span></span>
				</div>
				<div class="subBtn">
					<input type="submit" value="登录" />
					<input type="reset" value="重置" />
				</div>
			</form>
			<span id="error"></span>
			<!-- 在输出错误信息之后，清除session中的指定key的属性  -->
			<c:remove var="ERROR" scope="session" />
		</section>
		</div>
		
	</section>
	
	
	<script type="text/javascript">
	    $(function(){
	        Victor("container", "output");   //登陆背景函数
	    });
	</script>
</body>
</html>