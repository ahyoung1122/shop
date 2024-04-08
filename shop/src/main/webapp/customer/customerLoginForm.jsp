<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%
//인증분기    : 세션변수 이름 - loginCustomer

// 로그인성공시 세션에 loginCustomer라는 변수를 만들고 값으로 로그인아이디를 저장

/*   String loginCustomer = (String)(session.getAttribute("loginCustomer"));
// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
// null이면 로그아웃상태이고, null이아니면 로그인상태
System.out.println(loginCustomer + "<<==loginCustomer"); */

//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
if(session.getAttribute("loginCustomer") != null) {
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
</head>
<body>
<h2>welcome</h2>
	<form method="post" action="./customerLoginAction.jsp">
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
		<input type="submit" value="로그인">
	</form>
</body>
</html>