<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "shop.dao.*" %>
<%@ page import="java.util.*" %>
<%	//로그인 인증 분기
	System.out.println(session.getAttribute("CustomerLogin")+"<==CustomerLogin");
    if(session.getAttribute("CustomerLogin") == null) {
    	   response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    	   return;
    	}
%>
<%
//login session에서 id값,pw값 가져오기
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
	String id = (String)(login.get("id"));
	String pw = (String)(login.get("pw"));
	//넘어온건지 확인 => orderListID확인 완료
		System.out.println("여기는 pwHistory에서 확인하는 " + id);
		System.out.println("여기는 pwHistory에서 확인하는 " + pw);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwHistory</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.header{
		text-align : center;
		background-color: #FF2424;
	}
	.header a{
		font-size: 26px;
		font-family:"Super Mario 256";
		-webkit-text-stroke-width: 2px; /* 테두리 두께 */
 		-webkit-text-stroke-color: black; /* 테두리 색상 */
	}
	a{
		text-decoration: none;
		margin-right: 15px;
		color : gray;
	}
	a:hover{
		color : black;
	}
	.include{
		font-family:"CookieRun";
		float: right;
		margin-right: 30px;
	}
	.container{
	margin-top: 50px;
	text-align: center;
	}
</style>
</head>
<body>
<div class="header">
		<a href="./customerMainPage.jsp">
			<span style="color :#E52521;">S</span><span style="color:#049CD8">U</span><span style="color:#FBD000">P</span><span style="color:#049CD8">E</span><span style="color : #43B047">R</span>
			<br>
			<span style="color:#049CD8">M</span><span style="color : #43B047">A</span><span style="color:#FBD000">R</span><span style="color :#E52521;">I</span><span style="color : #43B047">O</span>
		</a>
</div>
<div class="include">
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include> 
</div>
<div class="container">
    <div class="pw">
        현재 비밀번호 : 
        <input type="password" name="pw" value="<%=pw%>">
        <br><br>
        <form method="post" action="pwHistoryAction.jsp">
        비밀번호를 변경하시겠어요??
            <input type="password" name="newPw">
            <button type="submit" class="btn btn-secondary btn-sm">변경</button>
        </form>
    </div>
</div>
</body>
</html>