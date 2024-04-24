<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "shop.dao.*" %>
<%
//인증분기    : 세션변수 이름 - loginCustomer
// 로그인성공시 세션에 loginCustomer라는 변수를 만들고 값으로 로그인아이디를 저장

/*   String loginCustomer = (String)(session.getAttribute("loginCustomer"));
// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
// null이면 로그아웃상태이고, null이아니면 로그인상태
System.out.println(loginCustomer + "<<==loginCustomer"); */

//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
if(session.getAttribute("CustomerLogin") != null) {
   response.sendRedirect("/shop/customer/customerLoginAction.jsp");
   return;
}
//1. 요청값 분석
   String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
			-webkit-text-stroke-width: 4px; /* 테두리 두께 */
   			 -webkit-text-stroke-color: black; /* 테두리 색상 */
			}
			.welcome span {
			font-size :	60px;
			color:red;
			font-family:"Super Mario 256";
			-webkit-text-stroke-width: 4px; /* 테두리 두께 */
   			 -webkit-text-stroke-color: black; /* 테두리 색상 */
			}
			.loginImg{
			 	height: 380px; width: 770px;
		      	background-image: url(./img/marioCustomer.png);
		      	background-position: center; /* 이미지를 수평 및 수직으로 가운데로 정렬합니다. */
			    background-size: cover; /* 이미지를 화면에 꽉 차도록 조정합니다. */
			    text-align: center; 
			    margin: auto;
			}
			button{
			border: none; /* 테두리 없음 */
            background-color: transparent; /* 배경색 없음 */
            padding: 10px 20px; /* 원하는 패딩값으로 조정 */
            /* 원하는 추가 스타일을 여기에 추가할 수 있습니다. */
            font-family: "Super Mario 256";
            font-size: 25px; color : #2F9D27;
            -webkit-text-stroke-width: 2px; /* 테두리 두께 */
   			 -webkit-text-stroke-color: black; /* 테두리 색상 */
			}
			a{
			text-decoration: none;
			font-family: "Super Mario 256";
			font-size : 15px;
			color:red;
			-webkit-text-stroke-width: 1px; /* 테두리 두께 */
   			-webkit-text-stroke-color: black; /* 테두리 색상 */
			}

</style>
</head>
<body style="background-color: #FF3636;">
<div class="container">
	<div class="row">
		<div class="col-2"></div>
		<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >	
			<div class="loginImg"></div>
				<h2 class = "welcome">
					<span style="color : red;">W</span><span style="color :#4ABFD3;">E</span><span style="color : #EDD200;">L</span><span style="color :#4ABFD3;">C</span><span style="color : green;">O</span><span style="color : #EDD200;">M</span><span>E</span>
				</h2>
					<form method="post" action="./customerLoginAction.jsp">
						<div class="box">
							<table>
								<tr>
									<th>ID</th>
									<td><input type="text" name="id"></td>
								</tr>
								<tr>
									<th>PW</th>
									<td><input type="password" name="pw"></td>
								</tr>
							</table>
						</div><!-- box 클래스 마지막 -->
					<button type="submit">LOGIN</button>
					<a href ="./addCustomerForm.jsp">JOIN</a>
				
					</form>
			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div>
</div><!-- container -->
</body>
</html>