<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%
   // 인증분기    : 세션변수 이름 - loginEmp
   
   // 로그인성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인아이디를 저장
   
   String loginMember = (String)(session.getAttribute("loginMember"));
   // session.getAttribute()는 찾는변수가없으면 null값을 반환한다
   // null이면 로그아웃상태이고, null이아니면 로그인상태
   System.out.println(loginMember + "<<==loginMember");
   
   //loginForm페이지는 로그아웃상태에서만 출력되는 페이지
   if(session.getAttribute("loginMember") != null) {
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
		</style>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col-2"></div>
			<div class="mt-10 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >
				<h1>WELCOME!</h1>
					<form method="post" action="./empLoginAction.jsp">
							<div class="box">
								<table>
									<tr>
										<th>ID</th>
										<td><input type="text" name="empId"></td>
									</tr>
									<tr>
										<th>PW</th>
										<td><input type="password" name="empPw" ></td>
									</tr>
								</table>	
							</div>
						<button type="submit">로그인</button>
					</form>
			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div><!-- row -->
</div><!-- container -->
</body>
</html>