<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%
   // 인증분기    : 세션변수 이름 - loginEmp
   
   // 로그인성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인아이디를 저장
   
 /*   String loginEmp = (String)(session.getAttribute("loginEmp"));
   // session.getAttribute()는 찾는변수가없으면 null값을 반환한다
   // null이면 로그아웃상태이고, null이아니면 로그인상태
   System.out.println(loginEmp + "<<==loginEmp"); */
   
   //loginForm페이지는 로그아웃상태에서만 출력되는 페이지
   if(session.getAttribute("loginEmp") != null) {
      response.sendRedirect("/shop/emp/empLoginAction.jsp");
      return;
   }
   //1. 요청값 분석
      String errMsg = request.getParameter("errMsg");
%>
<%

   

%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
   <title></title>
   <style>
   			*{
   			font-family: "CookieRun" 
   			
   			}
			body{
			text-align: center;
			}
			.container {
			border: 1px
			}
			.box{
			 	display: flex;
			 	text-align: center;
			 	justify-content: center;
			}
			.welcome {
			font-size :	60px;
			color:red;
			font-family:"Super Mario 256";
			}
			.loginImg{
			 	height: 380px; width: 770px;
		      	background-image: url(./img/marioAll3.png);
		      	background-position: center; /* 이미지를 수평 및 수직으로 가운데로 정렬합니다. */
			    background-size: cover; /* 이미지를 화면에 꽉 차도록 조정합니다. */
			    text-align: center; 
			}
		</style>
</head>
<body style="background-color: #FF3636;">
<div class="container">
	<div class="row">
			<div class="col-2"></div>
			<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >	
				<div class="loginImg"></div>			
						<form method="post" action="./empLoginAction.jsp">
								<h1 class = "welcome">WELCOME!</h1>
								<div class="box">
									<table>
										<tr>
											<th>ID</th>
											<td><input type="text" name="empId" value="admin"></td>
										</tr>
										<tr>
											<th>PW</th>
											<td><input type="password" name="empPw" value="1234" ></td>
										</tr>
									</table>	
								</div>
							<input type="submit" value="로그인" style="background-color: red; color: white; border: none; ">
						</form>
					<a href="../customer/addCustomerForm.jsp" style="text-decoration: none; color : white;
					background-color: #2F9D27;">회원가입</a>
			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div>
</div><!-- container -->
</body>
</html>